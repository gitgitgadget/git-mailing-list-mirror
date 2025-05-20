Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E35124887F
	for <git@vger.kernel.org>; Tue, 20 May 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750530; cv=none; b=FDmbJK4+GgwWmn5GD6chvUc3U9IBEIJLDisfgRWgxczXAlPa0Hy1UPKWs6fAr4Og1QWVGhcxFjbJaqR8keVZ9yjmPKNEjK35ni8owJmH9VP3S6+Vgn/JTUE5Pv3HsGSNYzlFHUNqNLwSUfyxaCqefIOA9rCkKdl3pCo0P24u9AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750530; c=relaxed/simple;
	bh=a2gzYrNu2n1jYdzNnd14pFFzgBXsnkEKx6MXZGMKZqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lhjtst8abE4GB7vOjzCoh3rJ+hZ5fA12CLdLWkwu1Pzj4pFO0FTEYKBjLwtxlgKZ77zmukqU9ea5bGeK8VookEoksoKKpX5SIac6BeORIkNlZ3kNnN2HHDaY96QVg+HqKWYn2oqa3T1hkKftlF4rwWKHBnuCwRimnHjWe45VyZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUpM1vJv; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUpM1vJv"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-601d10de7e1so3811989a12.1
        for <git@vger.kernel.org>; Tue, 20 May 2025 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747750527; x=1748355327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98b+G4H84ZhMsKhFcH2zNQqj+m4AZjrstwNGPnc3t3o=;
        b=bUpM1vJvcDX0ndwJ0yZy3PsFN3HwNKf6DMvWW1qTda0fK0l77oAC/2slo0+oJ7K2bk
         t6juShEC4RiVWgo0/psIAiBC5x/tcj2t3QsyXDvMwFKiYFETOCqVRXAUbxMLfqv8GvOv
         0tm49eYcHb4IiDw10bMPgebV4jL4NoWgmH6sAE5UNOJuoLMU2YadJwCLSFLrcTeLSHrR
         hWeXLDNGKHIX8atkaPN8/nTYePltl/vL/Hlla/+SK/ethhpU18iqu1I3rRioAMNUNQ+b
         I72i4uHBCzu1yQ+GrkqMeRgCoHaYsIK036f8cqkVqWpHQuNFT9Jh0wu8I95ryChjSsnz
         /rMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747750527; x=1748355327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98b+G4H84ZhMsKhFcH2zNQqj+m4AZjrstwNGPnc3t3o=;
        b=hs4jYpjkK60tCxUS4N7sjdgBAW/4T0LlB+ntyuNe47jZ9Its9ayDXOk7dSw5NtxE5J
         79P+VL+s7jfKz9CyKdc3R3DBlSdBA+nqLjoLJokrLof8e4oB1DgoJooAW3RNPsmavbg/
         +SVgf6lwePFT26WgbnxzMfNXsYBZCYOfpsg3HckG0qzrwAh21N3oVOjZM4Qajr5DbKjn
         Dx0y6PO+15JVUfpcvEh9P6NlrKL0Qv4o35vSS4nv6EtSxks1nD5eu4yU3APgMwGmGu61
         Hi+bId31xRkESLfwie2e6Ca2OANCEHo9hdIIFQRx/uFor5t4ySllR9ep37JBTS8cEyFw
         tTrw==
X-Forwarded-Encrypted: i=1; AJvYcCU/qoUCIGsR1FVsTS/1I1RAqKfo3AcoNIBF/Sj+tTVKd5Kw79OiXhcC78E7ux6URdPuwHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ1tDPhwA6UVynVz/eGsoVxcV5zHKknKuhSSQc6SicvYfExwKM
	xaLv6GfmuoOT7os1H7/dluQwencK6DVkWvGVGTeaikctESg/Joo5N1uuzDk3cybBaKlBk7moho4
	pWqtkYa+8sj50nWMTQXPkPDPlA9TAdTA=
X-Gm-Gg: ASbGncs9HlWJRNpcDX+tyq1SN0oLe0OcwglQ2/0g39CecnkX5XCuAQO5LwMCJUnwGKP
	2nbP5YTrK+jvScrDtLuEH5R9FnPxTnniq1G2lqzsfer2/Uo0KWbxxmB5Mhpos3FtrpQw7D7WGS9
	KcPnyUuqUTY2zWPLUb4TGbKGd7VR2ZRHk5k/J2EKuB8BamdbZr99gsU0gMwGsQK+o/aSGRPGN2y
	DzEoQ==
X-Google-Smtp-Source: AGHT+IGhgjji/Gz7SpHy4icPicLoLovTKqom07DywmagG8D477DUy2XLCwffacIsISXVWaXg7O+hVZKA02EiXY7Vn7M=
X-Received: by 2002:a05:6402:2786:b0:602:29e0:5e05 with SMTP id
 4fb4d7f45d1cf-60229e0615dmr150898a12.14.1747750526898; Tue, 20 May 2025
 07:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
 <xmqqr01si441.fsf@gitster.g> <CA+rGoLfbshrkPvvQorMq4n1RkVnyL8XfJ9UjMFRA-6dG4QKdcw@mail.gmail.com>
 <xmqqtt5ncq87.fsf@gitster.g> <CA+rGoLfcJ2r8S515msG5L-59=0nOBvdOX2TTn+-iaHw8v6Ndtw@mail.gmail.com>
 <CAJoAoZnYOjqgeW8Stuj5T9qcxmUBE=_j_ufO8Hdbn3GV8LmMzA@mail.gmail.com>
 <CA+rGoLf7jf5r3C2mN7X84HNrWqsA9mMueEkCowm7Ftsgcd5EbQ@mail.gmail.com> <xmqqmsbcwn6t.fsf@gitster.g>
In-Reply-To: <xmqqmsbcwn6t.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 20 May 2025 10:15:15 -0400
X-Gm-Features: AX0GCFvetQENlPivpDgHBnNj0mVgv6XKblMPm2mFYcGR9T7USRUEJIqp7w2Kw08
Message-ID: <CALnO6CD7Ao23nzV3QR208P3uvofqXXe6nLQ4v51wJ-WRDoF25g@mail.gmail.com>
Subject: Re: [PATCH 0/4] update MyFirstContribution with current code base
To: Junio C Hamano <gitster@pobox.com>
Cc: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>, 
	Emily Shaffer <nasamuffin@google.com>, git@vger.kernel.org, levraiphilippeblain@gmail.com, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Eric Sunshine <sunshine@sunshineco.com>, 
	Todd Zullinger <tmz@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 12:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:
>
> > On Fri, May 16, 2025 at 4:09=E2=80=AFAM Emily Shaffer <nasamuffin@googl=
e.com> wrote:
> >
> >> Mostly I lurk these days :) I do still keep an eye on the list. Will
> >> happily take a look at your series tomorrow, I'm out of time for
> >> today. But per what I mention below, if you don't hear from me, please
> >> don't feel blocked by the review, as I think the MyFirstContribution
> >> doc is comfortably maintained by the whole project by now.
> >>
> >
> > Understood!! thanks for letting me know
> >
> >> > So for now I will cc Philippe
> >>
> >> For what it's worth, I don't think it is harmful to CC people even if
> >> they will be inactive. CCing someone is not necessarily the same thing
> >> as saying that person needs to approve your code change, right? So I
> >> don't see the harm in CCing with low expectations - in fact, in my
> >> case it would help make the email stand out, so you'd be more likely
> >> to get a review from me (I missed this thread going by initially).
> >>
> >>
> >
> > Oh, ok I will keep that in mind next time.
> >
> >>  - Emily
> >
> > Thank you,
>
> Thanks for a pleasant conversation; others can also learn from this
> exchange, hopefully.  In Documentation/SubmittingPatches we have
> "Choosing your reviewers" section lacks anything more concrete than
> "who are involved in the area you are touching", and those who use
> common sense may say, just like you did, "ah, most of the text I am
> replacing was written N years ago by person X, whom I no longer see
> on the list very often" and decide to omit it.  Perhaps we would
> want to enhance the text there somewhat?  I dunno.
>
> Since there were discussions on contrib/contacts recently (a few of
> the participants there added to CC), I tried it and unfortunately I
> was not very impressed by its output [*].
>
> After applying the four patches on top of 'master', you'd run the
> tool like so:
>
>     $ contrib/contacts/git-contacts master..
>     Jonathan Nieder <jrnieder@gmail.com>
>     Jacob Stopak <jacob@initialcommit.io>
>     Jeff King <peff@peff.net>
>     Jean-No=C3=ABl Avila <jn.avila@free.fr>
>     Emily Shaffer <nasamuffin@google.com>
>     Atharva Raykar <raykar.ath@gmail.com>
>     Junio C Hamano <gitster@pobox.com>
>     Todd Zullinger <tmz@pobox.com>
>     Kyle Lippincott <spectral@google.com>
>
> The tool gave output in a different order every time it was run.  It
> wasn't obvious what the ordering meant.
>
> By looking at its source, I can tell that the names and addresses
> are collected from trailers like reported-by, which are counted with
> the same importance as the authorship, that the reason why the
> output is different each time it is run is due to use of keys %hash
> in a Perl script, etc., but counting sign-off would mean that I'd be
> summoned for each and every change related in this project, which
> would not be very productive use of everybody's time.
>
> And it of course is not clear who are still active in the recent
> past and why the name was in the list (it would not be as productive
> to ask for a review from somebody who was listed for reporting many
> problems in the area affected by the proposed patch than those who
> wrote the original) from this output.  There may want an "explain"
> mode that lets you feed a patch and get observations like:
>
>     The majority of lines you are touching haven't changed much
>     since person X wrote commit W 5 years ago, and the text turned
>     into current shape with contributions by person Y and Z.  Here
>     are the URLs into the lore archive for the discussion that you
>     can see how X, Y, and Z participated in the original before you
>     touched.  You may also want to look at commit V and U as well.
>
>     Last time we saw person X, Y, and Z on the list were ..., here
>     are the URLs into the lore archive.
>
> Perhaps some AI minded folks can write such a service for us ;-)?
>
>
> [Footnote]
>
>  * I didn't try other alternatives which I didn't have, and the
>    other thread there was a mention of "git related" with "seems
>    like rather more work".
>
>    cf. https://lore.kernel.org/git/aBr9bwNQ1J46NNXI@pks.im/
>

I sometimes use another alternative "git overwritten" [1] which counts
blame information instead. I've not tried to modify it to be
compatible with contacts, though.

For example, after applying the initial version of patches (which had
whitespace errors, btw; didn't check the latest version) on 7a1d2bd0a5
(Merge branch 'master' of https://github.com/j6t/gitk, 2025-05-09),
"git overwritten" shows

  10 76644e3268 (documentation: add tutorial for first contribution,
2019-05-17) by Emily Shaffer
   5 a2dc43414c (MyFirstContribution: rephrase contact info,
2020-02-13) by Emily Shaffer
   3 4bb4fd4290 (MyFirstContribution: add avenues for getting help,
2020-01-24) by Emily Shaffer
   2 9a53219f69 (config: drop git_config_get_string_const(),
2020-08-17) by Jeff King
   2 2656fb16dd (doc: add some nit fixes to MyFirstContribution,
2019-05-29) by Emily Shaffer
   1 8b4b41aefb (MyFirstContribution: *.txt -> *.adoc fixes,
2025-03-03) by Todd Zullinger

[1]: https://github.com/benknoble/Dotfiles/blob/master/links/bin/git-overwr=
itten

--=20
D. Ben Knoble
