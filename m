Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C487134B0
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848523; cv=none; b=FPhua0MYpv8598FRZuL6Q3p7Ho9pPdxiNnkkbIcjav0NSgr+ONo/SmDdtESa5mQMfiZC6iylSjHZtMQ2kGT6XQP4NUotTvtSLU80KQKAEYVRFBxgWLlPc5pABa20LPv3cAFM4+9HAE1w5SjgXRfXqkxY8xseO8P0jJuNbuLzroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848523; c=relaxed/simple;
	bh=tsiXGPsP97OFtXthk7KEBkvm7/23EigXxGcmMsrh2+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGH5G0/B3W7ZeU/UPu+UIi2zEXDzCd6uZccu4I1l6MpjKEMpuo6mwO9TYrig6kf1Jb3abD+atew0htgZ2HNcqqXOG800f0020mGS8xnIP3aGPh+fjchIR8dSht18LoQkf/Mf9kBKKsGPaI2c9XQ6nCaRaFe1ceEn9S3oT/0MrWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSS1VO8H; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSS1VO8H"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ea26ea8c4bso19a34.0
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 08:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712848521; x=1713453321; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GriMm/vnYugH/QabNckwF82JzT52T4h9Ns1YbBIMT9Y=;
        b=GSS1VO8HYmYCTFjEjcHxAimGwKg9Z/B4v3cJOQBmtl7fgM72WqL8Z5zi6P/Fz+29QA
         HEq9i5crg+zn9XfdtKgENOFR07Oy7GkepEKoJCYlD4Jf9qOzhJcxDqfBj4OOQna8WIWL
         IbrjnlWHaq88G2LgYhApzOowhYsWb3lHoiYUnufGFYO1lsuK19A8zzoYINDLo/NpDd0o
         tHNXf/WWWdpr7nyj6GUilEawyzbiVhNTR/sfV7WxzM/YNa/WEfKmCJpq1+835wXGvolT
         hwdOcjyB0VdNnHGo6SbAOLF16fX5+gJNoG7VGKdYJBusmOdIksshRkBPspBGdu0h+BJ9
         LTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712848521; x=1713453321;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GriMm/vnYugH/QabNckwF82JzT52T4h9Ns1YbBIMT9Y=;
        b=HOcj9ltQx+2FRhjQPPAejz/pCGL81LFTyoutGlRE1nHNlqm9y/QEWq0YzfnlZ2Kmq/
         iHYeTts0f8z/L5f8gEzhav+JzX3dcBo2EAzaPiHrnzieKvw0UjvIGolKpI6b8e3co5L4
         et0lyFBjI9GYWDTWUVKESRkVZ+bzH/IZk6QyXg7r4fNiE2khJJc4RbkaOx8OUFlbMIYL
         f4hGWdlWCOshuVqLL+DqYCdwE1mLV/Mt6ZrrsWUAk5bo7SoGdKcszWH/URF7vs9pQsZQ
         h2TEs2UM5T2rjGpcku9glonVwL5fLzyBZDwPH2QWYbid1WZ0+jQ4c2ueUu97XtqA6L+v
         3Hkw==
X-Gm-Message-State: AOJu0YzsB3HaaiH8VgqoCwnFrtQMR78S/whzkiCih6tR7At0ocLAV3qB
	1OLgPmhDZMPu8jsGrPitcuMwncDwNEK0nzxvEmIxyDT2kUUuhvaKShayBA==
X-Google-Smtp-Source: AGHT+IEXsytlSk9g597KKxCs9NUKoFUcG3KuYdgmLpS2Tet6psvITeYyenehksLrYjrBFkmKN+qUqg==
X-Received: by 2002:a05:6870:24a4:b0:22e:161b:7682 with SMTP id s36-20020a05687024a400b0022e161b7682mr6373719oaq.4.1712848520540;
        Thu, 11 Apr 2024 08:15:20 -0700 (PDT)
Received: from [10.37.129.2] ([2601:47:4200:90f5:c26:93f7:d5cb:f070])
        by smtp.gmail.com with ESMTPSA id r8-20020ac87ee8000000b00436440fd8bfsm1026577qtc.3.2024.04.11.08.15.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2024 08:15:19 -0700 (PDT)
From: John Cai <johncai86@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: Re: [ANNOUNCE] Virtual Contributor's Summit 2024
Date: Thu, 11 Apr 2024 11:15:19 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <A7406B15-8DF1-4B3E-80F3-BC56A9AC4D85@gmail.com>
In-Reply-To: <ZhcBJSP4MxX0AMFM@nand.local>
References: <ZhcBJSP4MxX0AMFM@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi everyone,

I'm grateful for the chance to gather virtually like this, and for Taylor's
willingness to host these each time!

I also wanted to throw out the possibility of an __in person__ Git contributor's
summit in the Fall!

GitLab might be able to host this, which would be an awesome chance to get together
in person like we did in Chicago a couple of years ago. That was a valuable time
to talk about cool topics, but an invaluable chance to get to connect with each
other personally.

It will likely be a two day conference in October of 2024. Location is TBD, and
depends on the level of interest and location of those interested. Requirements
for attendance will be the same as for the Virtual Contributor's Summit.

We wanted to first gather interest before determining more details. Please fill
out this form to express your interest: https://forms.gle/hTcsYM4fomEqaKU59

Feel free to also email me off list with any questions

Thanks!
John

On 10 Apr 2024, at 17:14, Taylor Blau wrote:

> Hi everybody,
>
> I've been thinking that it would be a good time to gather informally via
> another Virtual Contributor's Summit.
>
> I had been waiting to see whether GitHub was going to host a Git Merge
> event in person this year, but it looks like the answer to that is
> "probably not" (though I am hopeful for next year[^1]).
>
> In lieu of meeting in person, I think it might make sense to meet
> sometime in either this upcoming May or June (though we could extend
> further depending on folks' availability) in the same style/format as
> our last Summit [2], the details were as follows:
>
>   - We'll host the Contributor's Summit on either Zoom or any other
>     conferencing platform that works for folks. (I spoke with Emily
>     Shaffer off-list and they mentioned that some Google folks were
>     interested in Discord for a few reasons, so we could do that, too).
>
>   - The schedule/duration is not fixed, and there are options to vote on
>     preferred days, length, and timezones in the form(s) below. Last
>     year we did two four-hour days, so we could do that again (or
>     anything else that works better).
>
>   - Like last time, in order to participate, you must be either (a) an
>     active Git contributor, (b) planning on contributing soon, or (c)
>     working on a Git-related project that has interest in Git's
>     internals. If you aren't sure whether or not you are welcome, please
>     ask!
>
> Participants should fill out the following forms:
>
>   - https://forms.gle/VVrJ7RbHVxurxZH99 (participants)
>   - https://forms.gle/iGnfexF4hDuK6MQe9 (topics)
>   - https://www.when2meet.com/?24557185-cHKWv (When2meet)
>
> New this year is the When2meet, since this seems like a more efficient
> way to collect which dates are open for folks within the next couple of
> months.
>
> The participants and topics lists are being recorded in the
> spreadsheet below, and this is also the place to record your vote(s)
> on topic selection.
>
>   https://bit.ly/git-contributors-summit-2024
>
> Please feel free to send any feedback or suggestions you have for this
> year's Contributor's Summit to me on- or off-list. Like last year, my
> hope is to have a small, remote-friendly, diverse, and efficient
> discussion.
>
> As we get closer to the date, we'll finalize the schedule, make sure
> we have volunteers to take notes, etc.
>
> I'm looking forward to seeing everybody (virtually) soon :-).
>
> Thanks,
> Taylor
>
> [^1]: Coinciding with the project's 20th anniversary!
> [2]: https://lore.kernel.org/git/ZMATKIaU1A1D0wJg@nand.local/
