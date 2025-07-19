Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF574C97
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752955037; cv=none; b=pQBuW+KMlng6e98sBI5qV2SCkPv+BzhCJN4zwYxkB+swUPZoOFuhd+GdGPlqfWLjbz9VuMi3Rer82CAhf+xLcRrZenb2ABMPe3cvofYYQ+MkQ3sxmGxPugpT8eX9JcdsRsqwc6MdyaRl1i5+sROpoLcqd1YRjXC9rSgbrwG7mV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752955037; c=relaxed/simple;
	bh=M9wPOUaxo4oh4cddP0H8iNboLTG+ToqJ4j3LG1Q7Ogg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rgsmeou0BQLJBgRKjre0YaKUoSOOQ1AQOCoWlNzQlT6M/Nl5IjlRgHFqEw4Ny5TLXkne5hJR8WRawG/t6LJvP1J+j12anxcAIsaK6vQRiS4KKVvLDSmdLJBrsabATe3/CjYazNmUIYncowxXbuZFk8WZXjyiR+ttlW76rTQk4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcUt8l1n; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcUt8l1n"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-713fba639f3so26598307b3.1
        for <git@vger.kernel.org>; Sat, 19 Jul 2025 12:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752955034; x=1753559834; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UGG2rSwpsBg1tfyOe1ddbzk8FKW1m3sTqtoBr7o4DeE=;
        b=lcUt8l1nQypjlZVapI8Li926/ReuyAFTMeLTNXMCDXyOmyVXO7vOSj42niOpFByoQK
         wg+qeyBbwcSR53Iw1pTCPhJ+mkCEGwy8WAy9eqqI04unnBYUUMxmIHzDbURJjZeMY8CS
         ClHiD7lKgOAcKRqZRrBOLKb/t8GTVlV8exNdUtgjqlKSg4u/ge2pQ4BhgYrj/XP7rO1h
         nZ6YqIjuFQDCLtAJiNubyzB530REV5W56s4DCqz4wUvsjJjNjB0hQL/K0o+cXvd7HUWG
         FzTqD5q2cHd3H2Awwe71Bl+z+mqcoWmDTfClh6DNsjuLyFYz2gXmUL2OTYkX8Mnd09sq
         dr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752955034; x=1753559834;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGG2rSwpsBg1tfyOe1ddbzk8FKW1m3sTqtoBr7o4DeE=;
        b=lLZy+y694ZzUzRY1x44BvPHGIL4YxY0c2JcKZuXDC3Wr3Q4/kBycSqV20P3URjapQM
         /gPJPXpa+NL954sE+5VjI6CQYzjk4OqSMCAwNIxGkuz33gRQ2B4eTbAlBNRRkMvu+q95
         c5ET8yEk0V5F/eXpka3HPgVQI2n1EeLT9ge+qxQ8mw+xlwC84EY2f9ljT8xE5fYqWff3
         JtMJh0GzL5QbcEXRU9mF/OYHgSQu+cQA7C4zyYI3lRVM6Z5rCip5lYo1SFB02sZrT/NB
         ZtidnwVPlWxACnaDQvTf9kzlAoCmJVb+M5yzgtXkztkW1KGrqjql26KJJAe8i4MbjaRv
         Chsw==
X-Gm-Message-State: AOJu0YxlA0SqxcqGHmlk3S9Rr40+jI27ZreJ6Fskf1EoAcvNlZw6eiQ9
	ony0Gfe5yPulHCMlLUgumOnuhXVa/rdj9ZB+/5mH8VkEjvfope037Zwq+ew8JICM
X-Gm-Gg: ASbGncvh3MPdIW1M+dV4WVUjVy4bEdG38/xMwjcpAipuWOJsA/FZ+C5fGDvFlXp37Hh
	wcc8F5uFRm62WqOc57P0XBXxUyqrtZlYl438RpYaq4rEi0cz3ZFGrK0RgVZi+zYzRUtTa6qLel2
	KfJ8pzvNN6ye8K2TALohsCuNUJBwxZf7u7nJ49yb9JBgvVuafbK3+rgTJ1yiauppc6oHA9l0OlJ
	wMzxnTXwSD+g9EWJXQ358FWmph72bIUrTecCVOgEZdmp3bXmHAaPWNhB0IGrNG0v/3+m8TXKJnG
	YTrWnF5IlzfE5wJviJl+10G6K16IYftwIhznOwc23m4Iv1r2LvMPxJBdigqUWs5v+ZNU/4Jtmac
	GmHjHUmBnP++tfxW9qTUEY8Wj
X-Google-Smtp-Source: AGHT+IHMkzbf9+1FEaHHtTUuqpLWZtu5TEgBGElrFJQy0GIAwlTs94qVp++IwKbGWYhWfeu4v1mBwQ==
X-Received: by 2002:a05:690c:d84:b0:6fb:b1dd:a00d with SMTP id 00721157ae682-718a97cf4d2mr143412677b3.30.1752955034088;
        Sat, 19 Jul 2025 12:57:14 -0700 (PDT)
Received: from localhost ([2600:1702:5e40:2a30::38])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8d7ce934a3sm1298432276.53.2025.07.19.12.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 12:57:13 -0700 (PDT)
From: Eric Frederickson <ericfrederickson68@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: Re: A Question from a Hopeful Future Contributor
In-Reply-To: <xmqqecud145v.fsf@gitster.g>
References: <87y0slp23s.fsf@arch.mail-host-address-is-not-set>
 <xmqqecud145v.fsf@gitster.g>
Date: Sat, 19 Jul 2025 15:57:12 -0400
Message-ID: <87a550osx3.fsf@arch.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Eric Frederickson <ericfrederickson68@gmail.com> writes:
>
>> Looking through the repo for a place to find todo items, I naturally stumbled
>> upon the TODO file in the origin/todo branch,...
>
> Please disregard that file (I should remove it from the repository,
> too).  It is not curated at all, and the last update to it is more
> than 13 years ago.

I see -- sorry for the noise on that.

(Funnily enough, I had checked blame of those lines to (try to) make sure that
they were at least semi-recent, and took a glance at the commit that shipped
them, which I saw was dated from April. Somehow, I had assumed that "April"
meant "April of this year" and forgot to check the actual year... it was, as
you're indicating, from April 2011. (*facepalm*))

> Sorry for wasting your time.

The mistake was all mine. Lesson learned!

> A better sources of inspiration might
> come from list archive searches for the past 3 year or so.
>
> https://lore.kernel.org/git/?q=%22%23leftoverbit%22+d%3A20220718..
>
> But even then, many itches have already been scratched.

I've been enjoying looking through these "leftoverbits", and may take some up
soon.

> As is often said, in open source, the easiest is to start scratching
> your own itch ;-)

Indeed! And I have 2 things to bring up on that subject, which are also in reply to
Ayush's suggestions about trying out a micro-project:

Firstly, I was reading through git-bisect.adoc (on master, 90c0775e97) and
noticed a small error on line 146 (the entire paragraph, lines 146-148, is given
for context):

> To use "old" and "new" instead of "good" and bad, you must run `git
> bisect start` without commits as argument and then run the following
> commands to add the commits:

It seems that the word "bad" should be quoted there, resulting in this revised
version:

> To use "old" and "new" instead of "good" and "bad", you must run `git
> bisect start` without commits as argument and then run the following
> commands to add the commits:

Writing here to ask if a tiny fix like this would be a good thing to submit as a
first patch. (This feels like it would be an embarrassingly small patch, but you
have said prior [1] that "it is rare that anything is too trivial as a
microproject material", so perhaps I'm in-bounds here :)).

Secondly, and more substantially, there's an itch I'm thinking about trying to
scratch, which involves teaching git-diff some options which can enable it to
give more useful outputs when diffing binary files, and, moreover, to diff them
"natively" without converting them to line-oriented plaintext first (as that
behavior is already covered by use of the "textconv" config option).

I'm imagining a way for users to pass some information to git-diff which
specifies a concept of "logical lines", similar in concept to the "--word-diff"
option, but where what's parsed as a "word" / "line" / delimiter can be
specified by the user. A feature like this could enable users to have git do
things like diff an image file pixel by pixel, or diff an audio file second by
second ("second" meaning "1 real-time second in playback"), all without doing
any batch conversions. (Note that I'm not intending to denigrate the very useful
"textconv" option and its associated workflow; just proposing another way of
trying to work towards a similar ideal.)

This itch comes from my use of git repositories to manage audio files that I
publish on my website, and being unsatisfied with the "Binary files differ"
message while also not having anything available as a "textconv" worker program.
I feel like there's a lot of "potential energy" in these kinds of use-cases for
git to provide ways of (re)viewing changes to these files to users who work with
updating binary data.

Writing here to ask if pursuing this line of thought would be a good idea. I've
intentionally been light on concrete detail here, because I'm still working
things out myself and don't want to waste anyone's time with details that aren't
worth reading through. Something as simple as a "Yay" or "Nay" on this idea is
all I'd need to know if I'm walking a useful path here.

Thank you, and best wishes,
--
Eric Frederickson
ericfrederickson68@gmail.com
https://emfred.com
