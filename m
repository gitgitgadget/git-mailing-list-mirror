Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38683009F0
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121594; cv=none; b=CMqUtlGeU+k98flXdxbxwLdGvpcXiv1DUZRkWish9LO/IR9bnzu5zDLcSuCb5EGUlUmSO+DS5S/vxmNxZhxJzdsqBCbSuQoTdNGoDzCbFWPf57JOb5jSd/xrG3LWoMTye1q5LmMp9bFcjmc/lss67K2x2AJk5QK9EGd5615BWF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121594; c=relaxed/simple;
	bh=asIAgs4nBl5S/nobGQpSTxTgs1H8Gp3MvyOwl+/a9do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpXDB5ajTVGXLEJDP9ENAVE9xTjhS0hBmrCeyVNfrG1Srf4qBbwIx9kJksuCXKbsTsVvb3Y9KJS4cAhgZNILQJhkQVmKXjIndZzY3VfjopjsVMkYsibWYUg/yyDXfzzWEJYFxhdLiob5LJNQn6NTpFwZUAisbbrWyZaDDBr5dnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70a928158a8so714366d6.1
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 14:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755121590; x=1755726390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asIAgs4nBl5S/nobGQpSTxTgs1H8Gp3MvyOwl+/a9do=;
        b=hgwhevUC60JzTdvrX5VhyDGzpY1kusrhuHjws0I0BwcQ9/2xE4fGbjcnwucGIFJiGi
         XqbpBGqh5AUDyRfaLbV1kEiVLfoUOeydchkOqP/jubTbTc8iBRiKJoOESRTjmpwt4aa0
         7laMTGT0aE2sZl5arinqT1Hj5a2NWkEvW5YNTDxAmgn2E5z5ElkA8McwKKNCAhktSkal
         cKHpmKyqhmdJofmL/4g7jytPq8oN/KAzc9ZHn31vtaS77udGhchA897X6Wh75unGbXGS
         e/y0hKXZy6lBT282Wr8HBjisv0daAPv4qB9sVhkRf922Zviu5rsFjDoy7nmtdo1RTT7e
         7X2A==
X-Forwarded-Encrypted: i=1; AJvYcCX40Oaaqt3cvyQZfFAwCN1enbtbnfZo8lWIk8QF4C9rDsF8JG80wN2SHfyn+iU7dGAsR9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaUeUKbrEpGDgRhMfslSY18kaCmGySVZPk35wmjT2wjLN91ak5
	8HWxp79ntr8r5igMgEzb9de7JIMWVGC0wQIal3MQvgMKViaUe39u6wN6k2VS6dKyTAAQ8w2RRDW
	LR7keadTeMlhlhMH37ax4lys1mOjrDyY=
X-Gm-Gg: ASbGncu+xUroJ0//hTbjWdeTcXNF0dQP5LDU1RMwu7WSGy7NRG73rBabr2RjZVLcCOa
	bh2OaKgAGTTW3bHxNHv59c4nE7WdN/rNgky0LsVbIAPmeyu26hBj7rCW2r0G90V7uBJcaV70aHF
	fDqxtWCXoAe4q7d3HQTcSnZHzByxyJ8V/FeNaSeWiSajiq/4ft1+hOivpO4hxPbw+kRYnEdPW2R
	1L/94QBRtCUFE3fKH6VedCmuRzdx+A6061x6jM=
X-Google-Smtp-Source: AGHT+IEaua41YaSwh5s97XNM/jWOjS1AsbIYczeEjO/9lTjExiCTiMlUwk3qX8REnTET4chDWuhmWhzcwy8Q8RSZhvI=
X-Received: by 2002:a05:6214:62e:b0:709:8842:56f5 with SMTP id
 6a1803df08f44-70ae7011913mr6158496d6.3.1755121589542; Wed, 13 Aug 2025
 14:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com> <20250807150239.6987-3-lucasseikioshiro@gmail.com>
 <f97b712f-95a4-480b-8ed0-174e4f45ff81@gmail.com> <8A30D2A7-3290-4E7C-BBF5-A51AE5AD19F0@gmail.com>
In-Reply-To: <8A30D2A7-3290-4E7C-BBF5-A51AE5AD19F0@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 13 Aug 2025 17:46:15 -0400
X-Gm-Features: Ac12FXwMIl8_IwMq_M3Y9yzqzpRnyo_vYIfksxB3Zlq4gQwWnVQkvT7ACPWrKDk
Message-ID: <CAPig+cQUuXxz2gMMA200D39dqWi6wpu6z43Wkr_trbCwuvTKSA@mail.gmail.com>
Subject: Re: [GSoC PATCH v9 2/5] repo: add the field references.format
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, oswald.buddenhagen@gmx.de, 
	ps@pks.im, karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	jltobler@gmail.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:18=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
> > What's the reason for this?
>
> Basically, filter out duplicated keys. This is also helpful for not
> repeating the same "key not found" multiple times, as suggested by
> Eric [1].

The suggestion you cite has relevance only as long as deduplication is
the chosen implementation scheme, however, Phillip is arguing that the
deduplication and key reordering logic should be dropped, hence, the
cited reference isn't relevant in light of Phillip's suggestion.

> > If I query three keys from a script then it is much easier to parse
> > the output if I know the keys are going to appear in the same order
> > that they were on the command line.
>
> This assumption would be a little bit broken as one can ask an invalid
> key. In this case, this command will print the error to stderr, and
> proceed to the next value.

Yes and no. While it's true that a caller might ask for an invalid
key, the primary (and useful) purpose of this command is to facilitate
scripting. Once the script author has "debugged" the call to `git
repo`, then the output will be predictable. Hence, although you make a
fair point, it's not a strong argument against Phillip's
recommendation to drop the deduplication and key re-ordering logic.

> > If the command re-orders them my script now has to check the value of
> > each key which results in a bunch of unnecessary string comparisons
> > because it cannot determine the key from the position in the output.
>
> In cases where the client don't want to compare strings, it is still
> possible to ask one key at time, just like other Git commands (e.g.
> git var, git config). Since this command won't return too many values,
> it would be ok even if the user requests all the possible keys.

Generally speaking, process creation is slow. Process creation on
Microsoft Windows is especially slow, excruciatingly so. Authors of
tooling around Git often pay close attention to such matters because
they don't want the functionality provided by their tooling to be
slow, so we ought to be weary of a counterargument (such as the one
above) which suggests simply running the command multiple times, once
for each item.

> > While we were producing json output there was a need to de-duplicate
> > the keys when that output format was selected. However, we no-longer
> > produce json and in any case de-duplication could have been achieved
> > without sorting the input keys by using a hash table, or, as there is
> > a small fixed number of keys, an array that records the keys we've
> > already seen.
>
> I still think that it would over-engineer this command.

I don't think that Phillip was suggesting dropping only the reordering
while keeping the deduplication; he was merely giving an example of an
alternative implementation which would accomplish the deduplication
goal, so he wasn't asking to over-engineer. Instead, (according to my
reading), he is suggesting dropping both deduplication and reordering.

> If I follow
> this path of returning the values in the same order they were in the
> command line, I think it would be better to just allow duplicated keys
> and multiple "key not found" errors for the same unknown key instead
> of increasing the complexity of this command.
>
> What do you think?

I think that's exactly what Phillip was suggesting: present output in
order requested, no deduplication

I had suggested the same back in [*], but I also said that I could
formulate arguments in favor of either behavior, so I didn't have a
strong opinion. However, Phillip has presented a good reason to prefer
"output in order requested, no deduplication", and I do find his
argument compelling.

[*]: https://lore.kernel.org/git/CAPig+cTuiUy=3D+2Jf1Lrp1gaM03_zPf8EFMVSKmS=
hqU05t-3aWQ@mail.gmail.com/
