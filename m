Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CDC6FBF
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 00:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722904918; cv=none; b=rB0IVh0kMSRC949ADBeIZw0fJ/U1sCSp4XIgiA0AhpAGjbJiE5yH2YSAl5bXKKBswYjm925aKSuSYNvrdHZGhrAC5HkMv192SEZHUHdxJ2j7hnf2mra7c2tTSjIICz3+QhANEeBZB6lVCx+nBzIkuTCNEHVKfxr3JyECfguQzD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722904918; c=relaxed/simple;
	bh=S1tGwrbeE6Kn2g8YOxES9i4uduzj/iZfP1E1rA6GlpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoixDGqrLnEFm49OkWk8YDGjrI2tdm5w3UR6/R8MZXHgqSKkNpqtSI1I0szvMi9YuXFw3HcyB8eph2OnAFrpj7UVhH3u4e3TYur8Tg1HLdxEogKo2ZsS3TCgd10UArLr+PprM8fyvprvkrZcfxAg097R8ujD/K94MGKM4LZpg/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIFUmsFz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIFUmsFz"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fdd6d81812so307505ad.1
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 17:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722904916; x=1723509716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hHC4GDxVxN0xkKS8nSwW+RwgyJviLjAEVk6OswMWsd4=;
        b=lIFUmsFz6glbw2xd89O3T6C6Yn58TiX4gCkybKqsTyn/VEWGdPOXy90i0KeR4ktp8l
         /IlkeM/RmNMNq95WS9F1zfDg2urlARlrWQRm2GQtLSTa44MCV0wzwHZNQ8Rj6V9wx59y
         6tYMkWYnfpGz1aQZ9pru7eUCEEL7yZNiVIMJfmHQ7qjAPURxyOb6OTUzFxyT9NR5JErB
         eIUIbQ5uVar6D3aEcwi+yNNHKHzDcuBwISH1UFDZE2td7XjY54InJftDwTpT9dYKcPib
         NZSHZ5H/8h2fbwe1WpkUs1rcSdhBR0odu6v5NznEvAgT1cC5xe3Tmq3CnlAgxZuKWIPp
         GRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722904916; x=1723509716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHC4GDxVxN0xkKS8nSwW+RwgyJviLjAEVk6OswMWsd4=;
        b=q85zNgznl9myqarWYVhSK2Ye9iLqaVVJrU4IIsbSKcrNC03XAgabzpsE6Z9N7oxPbb
         ly/5lMafVtSZOSSHolVJghUtdTJRFpgIhpPLLcwHe54+6+uevpUuySsU85rckF4HIt0V
         obJjpIJFB0nw9ULZXutXsQVdhbx3ZOrH3HeM8y202Exv2J/hXpJ+61QSZnvG1iZoTuOR
         t1Tmjn/vLb2FMWDyNwdR3EfJIMJidb6szR2E5dt+KwUMAkZERdDfASdH2o6kLHbmq/i1
         yLtGhhNLS2Uv3c99QPGpYBePOrNxJlUR8WwmyjS6ksdNOMsFuCZ6QqJs2chofdmB6csh
         KuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl3OHRISn+8SrvqHg6sNd3lygXa5Ei6fB2OJ0g5WXMWmqJUtIepx+Cs12+ymwPyyPqmOFtK2zBMecFM3tgMoXzz9xy
X-Gm-Message-State: AOJu0Yy8UX7Wxchugh5wONGYvIKMU/iNZ1zreJKRWcOhFOsMFDZ/EhVd
	z45RUFyOhjSaTJVSge5liSWSLf1d/KI9dQ8NtbMCFF61Y0Po4h6P
X-Google-Smtp-Source: AGHT+IEnARwGP8t4JS9FJ5uEoFChm1wupiSTj5SlY204sYrbrNYihu6+4uuu+4Q2a0qgU0GHPwhUmA==
X-Received: by 2002:a17:902:d4c4:b0:1fc:3daa:52 with SMTP id d9443c01a7336-1ff5722d9c5mr188947365ad.11.1722904916108;
        Mon, 05 Aug 2024 17:41:56 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592ac8f4sm74688335ad.274.2024.08.05.17.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 17:41:55 -0700 (PDT)
Date: Tue, 6 Aug 2024 08:42:23 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v14 09/11] builtin/fsck: add `git-refs verify`
 child process
Message-ID: <ZrFxb1FNRCzu-NuW@ArchLinux>
References: <ZqulmWVBaeyP4blf@ArchLinux>
 <ZqumdJz3-0mqh6Rc@ArchLinux>
 <ZrDMdEJR6DV5HyLD@tanuki>
 <ZrDtVJYoJJZDesB4@ArchLinux>
 <xmqq4j7y3kmt.fsf@gitster.g>
 <ZrEbllB6WjLfWqNZ@ArchLinux>
 <xmqqsevi220s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsevi220s.fsf@gitster.g>

On Mon, Aug 05, 2024 at 12:38:43PM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > I agree with you that it would be strange if we do not expose any
> > interfaces for user who are adventurous. Actually we may simply add an
> > option "--refs-experimental" or simply "--refs" to allow the users check
> > ref consistency by using "git-fsck(1)".
> >
> > I guess the concern that Patrick cares about is that we ONLY make refs
> > optional here, but do not provide options for other checks. It will be
> > strange from this perspective.
> 
> I do not care about strange all that much.  I however care about new
> complexity in the code, complexity that is not taken advantage of
> and is not exercised.  
> 
> You said
> 
> > From the development of this series, we can know the main problem is
> > that fsck error message is highly coupled with the object checks.
> 
> and even if it is true and we have problem in fsck code paths, we
> cannot see if _your_ solution to that problem is a good one without
> having the code that exercises your additional code.
> 
> But if "git refs verify" does exercise all the new code paths (and
> the refactored code that existed before this series, sitting now in
> different places), then I do not have to worry about it.  My question
> was primarily to extract "even though we do not wire this up to fsck,
> we already have another code paths that uses all these changes" out
> of you.
> 

I understand what you mean here. I can say that "git refs verify" only
exercises a part of the new code paths. The main reason why this series
changes a lot of "fsck.[ch]" is that I want to expose the
"fsck_report_ref" interface to report refs-related errors. So I guess
this part should be covered.

At the current implementation, we change the "fsck.[ch]" for the
following three things:

1. Refactor "report" to use "fsck_vreport"
2. Create "fsck_report_ref" for refs check.
3. Do some simple renames to distinguish between refs and objects.

We do cover the second case in "git refs verify". But sadly, the first
case and third case are covered in "git-fsck(1)". So, "git refs verify"
does not exercise the refactored code.

However, I am a little confused. Actually, in the implementation, refs
check and objects check are independent.

I think we should wire up "git refs verify" to "git-fsck(1)". Because we
have no way to exercise the above case 1 and 3. If we do not, we will
bring a lot of complexity here.

> Thanks.
