Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A00D1D5ABA
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030856; cv=pass; b=a2xVte7Do9Wp4NoRM6qqI2ti6Ayf4tRw7BUvp40rBKNtr4wznNcimAKO7rG4JL6HvLdaKeIcBIRZf0EfYcgT8rVU7WxJTVhZLU1Fwq+RTdaZ6t6Zmaoi6GhVkHbxyrbJTCdm4wnVeGaz//vJSV5W4SZrBwGpSndHNOq3y1vwpsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030856; c=relaxed/simple;
	bh=Ehkyfc/K1Wrrs/DPL1eco3j2S2vMHWh/Eoqb1yD8D4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAqFIa4MLObOt0smiK+Ooxhle3uR1HFfThAHz3R3vlIZ9G4TCtZuK/mevcLbfmlUk5Agg6lSE74G+h3RjjFqOPwMZMd3+892GKT1SMOU1cq9ECwLiOyG+jP8IbUSny5u9e5VDcbUsCs67kXwhhFCtQyrefGDdrD9/uM168dw4v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONH0DJlp; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONH0DJlp"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5663601fe8bso3776053e0c.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 03:14:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770030854; cv=none;
        d=google.com; s=arc-20240605;
        b=AfSlfu2ThNS4VUeMKO1K2p0MsDzQZh2nxIFo66JObwP1zUVlwspXHTmYkmnHlCEYcI
         cNnxIHZ+GskCzCsHfUpIGgLp463QZjw6Vya2Mrz4ClvRZiu61FMmasfJF17Gt9bhp334
         cveGHrMcsLl9jn+RhCgl6pU0YNfxKysYD78wXveWbW7KXLHP/ES9f1tbO8ppPz0OOGMd
         j3NZ4/n62708+5lZa/d57+DKkxO3hnZ7vHM4DPgpe0nbd8Fw9iohzcwO3nuelVYrOIpd
         DhQKRRMzjwzaUQ805EeUSlEBJODK0Ltj0CWRiL8enbZ3H1nWegDzF3KxG8L92XRdq533
         oqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3idpWBh7XD7+CFlw8YaqJsBP5ueLXgtM9eKAFJ5h4Fo=;
        fh=shWxNb8qA0DxLN80W7Sz7Tg64EW8RLYpEjyr7bUBFds=;
        b=bmQZ6fvruXMNs/lzqr8jf0LEwUeUvcJneppyab+R6wGRlHHGMnIHYPwZsstmK/S/uA
         CObLt5qAMcCBgk4OhxsVxu8vUxqEeEjC2NlwfNvMgCbhshc3BSPAyZ+dM3hKStVSAU0z
         0cGRcBjR5zRQ8jpahxnx99Ud2wsTbLdjf5fttaK6JEfvd4MGuBsR9qlu+JQ52fOS44yP
         UK165fy7K6GZS+qBAH9oFO8gmK5wJtieP7XafXNBbgVXsAFUyzIURF0RJFrZ2LV/8FBd
         wfbEn4anMI4ppL7m+slSjAoz8YwrewxTdf9ApiuHhLXAV/t8dIrFDfFkBj9moiCwPcfh
         f5sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770030854; x=1770635654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3idpWBh7XD7+CFlw8YaqJsBP5ueLXgtM9eKAFJ5h4Fo=;
        b=ONH0DJlpmtGTo1qoHUgMYcfnhEj3OzBnYFiMkD/0VRT8Asb29qsh7czJZelJCCaI5y
         g3f5C+xN3FwUcmCHsbEHMoMKnmIDXZkE9sF+3BCWNdyi6CRnPvNX0SySqZCJHNlsabe/
         pdDr7sZvbYApU+xI30y5cQ9JbcHajpp5J2dF9RpD4Fg5SF+xL6nAPLp7gCk9OnwD+xMb
         5s3huuheZK02fhIRzb2Be2Q11/bQWooPB+q3Ca0C0QxQxkdiisYtwu8xMIvp+S2NO5Wf
         R8qN86HBBI0qiOlG0pOoLUyv7VaNF92im4Fej+vl3mACJ4p8gN0YgGrhiOyxH3pPtGNw
         xCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770030854; x=1770635654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3idpWBh7XD7+CFlw8YaqJsBP5ueLXgtM9eKAFJ5h4Fo=;
        b=uvT4a4NoAuN2Y8TRxmT+qgRJC+BIU7xAbO1ccgZwrjZcOE4Ww278ITdd/vdFcfwMIr
         BBLF1wM1AssDZ2NfKVByxL2MYeMTRPfSCBQQ6NRm9pmagjGdigXbSFsyKK+6PX09zUw0
         LDbfGS/D6MJrL/2gBJP7ai+hRutfrG0TP/QN5MI1Fm1mvOFK2eUVYTXowMdTrNf99ga4
         OpluFnfQwGMMrMgYmFOqIgtJ2fqF2rupoFEzFlNETclKnEMtCvkelJ6trjq32+6meLhO
         xSpYP8GYiwitglz+AsrpebirNBvX3gOBMAI3XmyUPJLI/0DtAEcAa9nlcomhYmpwsq6Z
         8+Dw==
X-Gm-Message-State: AOJu0Yz67NkpHV8TKb3aRTRiKmtPN9afy7mSJMYUWkOyH/gHczOuTP3B
	MTAqBw/ygfgyTem5sb0Ub4KlF4XPAkFmD1ELEy3HlN7p9/6xXNq21ZQSWNbR+iW8mPnhnckCn4o
	bgGlfoNUAhkTTrXqYZRCioJTUyGLBnTb2ypmgC+uhFA==
X-Gm-Gg: AZuq6aLYES8OLqiQUz+uNUmx9UZ1fTMWmnUa8tOCq+3xIKl4/HSbgC6iKvBAnwq1ggg
	ccASVx1zgmzQ7QCnO6lIORExXhSfa0nhp4aKtHhuAYXgk3cETULo0HEBLwoEAJXofLYxiAySEDT
	feBa4pfdWtDv/Wnik0G3aNPVRtoOjsOz2IxyqHM91ax4OOiGOwQqT/Xi8hSRO9kUGyJpzrA1DBM
	X9IKHMfLtbK7WeGTUKoiVmb7t0yUbQCQuz32nFgRNhQADK8+Gbi5BGd0ivfsAtGiHBe3zbI
X-Received: by 2002:a05:6122:3b16:b0:566:cd52:313d with SMTP id
 71dfb90a1353d-566cd5233f0mr309446e0c.16.1770030854269; Mon, 02 Feb 2026
 03:14:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769522219.git.abrahamadekunle50@gmail.com>
 <9b21cb901ab14397af94b8ed2d09da1a9a6d862b.1769522219.git.abrahamadekunle50@gmail.com>
 <xmqq7bt2g4tl.fsf@gitster.g> <CADYq+fYeWh0tLEepOGVa=1i9tXZfWaGfyi6H+xUB7rbdQ=t5aQ@mail.gmail.com>
 <CADYq+fbt7zHO=gAsRp=b5MTb=2aFfifCjWnW6u+58iv4dk6bMQ@mail.gmail.com> <xmqqqzr54mam.fsf@gitster.g>
In-Reply-To: <xmqqqzr54mam.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Mon, 2 Feb 2026 12:14:16 +0100
X-Gm-Features: AZwV_Qg15vCtI5m57AupmmpbFi31X99PNB-PRKgfYMRR3nn5Ri9rGZCd8QJOZNY
Message-ID: <CADYq+fZFuvCRbFf=-XUR8TJsjW_YtjNdiXMzPv0mjMPbWcLO1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Allow reworking with a file after deciding on all
 its hunks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2026 at 8:25=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Samuel Abraham <abrahamadekunle50@gmail.com> writes:
>
> >> What I observed after adding the '>' and '<' options is that if a user=
 chooses
> >> to use a hunk A in file 1, and then goes to file 2 with '>', comes bac=
k to
> >> file 1 with '<', and decides on hunk A to skip it instead, because
> >> patch_update_file() has
> >> applied the file with the hunk the user initially decided to use
> >> before proceeding to file
> >> 2 with '>', coming back to redecide and say skip does not apply the
> >> latest decision
> >> and when you check the index, the file with the hunks which the user
> >> initially decided to
> >> use but changed to skip is present in the index.
>
> I am not sure if I would like the end result or rather prefer your
> "all-or-none", so please do not take this as "here is a better way
> to implement it" suggestion.
>
> But you should be able to keep the current semantics, if you wanted
> to, even if you apply the chosen hunks when you switch files, like
> the original code has been doing forever since it was written.  You
> know which hunks you applied, so after applying before moving on to
> the next file, you can drop these hunks from the list of hunks to be
> decided for application.  When the user comes back to the current
> file to decide on other hunks, you know that the already used hunks
> would get in the way, so why keep them?

Yes thank you so much for suggesting this approach.

>
> Having said that, I think the all-or-none mode may be handy if one
> makes the current working tree dirty with many little unrelated and
> insignificant changes and the only way to make sense is to see the
> "git diff --cached" output after adding some and leaving others, at
> least in the way some people work.  I usually am very incremental
> when doing "git add -p", in that while using the command in one
> terminal, I run "git diff --cached" to see if I added unwanted
> things by mistake and "git diff" to see if I left out necessary
> things, so I would probably not be using the mode.  But that is just
> my hunch without using the new interface long enough.

Okay I think retaining "git apply" in patch_update_file() and dropping
the hunks the user has already decided on when coming back to the file
makes sense.
By using this approach, we skip files that have been fully decided and appl=
ied,
only showing files that;
i.  have been applied but also have undecided hunks.
ii.  not been applied and still have undecided hunks
when the user navigates with ">" and "<".

This will allow you to still run git diff--cached to see what has been
added while also being able
to see what has not been added, while navigating around files.

Thank you.
Abraham
