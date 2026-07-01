Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC229DB6C
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782928263; cv=pass; b=NyPEDbBGc8jF2eZ79IvggId2V/wKYJ/Nivyia/nXmF7hPWGW8r9P3Egzf2nVSyFf99v4Zm1Yy0J8z/W97+IPnJATdOj6Th1uriPxavvdHh5EhmNx+N0mQqdlFvuMpm/kpgPsMV3KAsqtfgcQhIS8nNRIObz5d3JE+dwL8jiIXq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782928263; c=relaxed/simple;
	bh=mdI00dqXKbnuhWe9G+Em6tlh8QK783V/WOSeoEIH/2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TxNN0I4/RwakIEtER50GzFGx6vNsEucmNHfuUD09Aj2t4VMr/qK5F26aDO2H38SBRMJOTsK+L8xfGAA+wmXK2AjxaeR7mExzCfplxtRViILI8ZNiV2x4qNtrNoeXLcsg4PRzZkJ8AA15nOiHHuY8GYHFQTmIjJKaohdAIHCDlgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkSXibXM; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkSXibXM"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aebbeba529so898627e87.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 10:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782928260; cv=none;
        d=google.com; s=arc-20260327;
        b=Q3O64+LaWA9b5ifJj0NE490iNFW9NdlGcYHMKChmhrVaOxMJNvjYDUJkC3gRsTtzR9
         etUOFq4kP54fHb9RFeBqLM/fg1ytmAcAPfc2i3+mZUG61KfQEhM5dnedUfUlKZWvdpOl
         6OALmUbAxds3GgrpAOFmAYE8OT9TsHmFfZYeqRy3qOKIACheGDYYg6E71KEtgECBaT3S
         y39fYOXU206HD/d0tjW+SHcjMSU2aq6HqxHA8rTZ4z4HVEXq/cH5d9IBHd2iqtl9O+1D
         bYMlzxTxmjSY3Tn43/Gc1nBrO6wmJps+7PxW6poqIwx13mzTbRWNLJJDBN30+ueXrqgT
         MybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=mdI00dqXKbnuhWe9G+Em6tlh8QK783V/WOSeoEIH/2w=;
        fh=DJHZ7itWveYVdfezJsKgr6XLEjDMbfeXEew73fqN9oM=;
        b=GeQGI4iYhjqRRrNfhNDAVbZgONI2VVhLtdBlA3LnbBxU8OGhW8fFZDHJs4Sh4FlxCp
         xGYpn3vmkmeRfjJ4BSZFKPUuboJoxxQZpNAOoHa0MX0hf+b+sxH1dZyDxECW3NkA9JY1
         cI2JC5NyOuABKPMbvKzBOxV/KXQVUotUUrS4J0l5IS6b8g98fNg0kJ2disWRAW0sCjkN
         RH0Jw8A0xkQRpHMd6W7V09U0A5/y50anXbUxtbO7q5omLje485Eo7FyoS3dw1LjUPlV3
         l0aZ+cAdsKeEr+KGl5W6v3ttpEN4XgNO53e0IL2Gx+yxHN2a6VgG/nNY7V0iNU3L3r5W
         q0rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782928260; x=1783533060; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mdI00dqXKbnuhWe9G+Em6tlh8QK783V/WOSeoEIH/2w=;
        b=bkSXibXMx1+P4+gfzyCFitlidcXQCMFGw9t/pIXmnqLI328DFRcWmNnjpHAljcCWnS
         6qKMoKbP0gaFxuxLG1iRtV2v6bLw1EOkX9lLLbX+QTmbBcfP8hHZ0G8qRyWZuQSnqqv7
         7FJqMDxgLMWXDpn5GlF+YW/noRlx/3iwg66pLhvVntCOcl2JCUjt9fwQZ55SMFXS4sqc
         q0allLG+bwVLOsmoMfKwnc/y1xMCiOveXdZGpMf7ZTRck2K6AQX7C6Nbl21NSK18kZMT
         RLFMKA0ta0SBB/Fl7qGh6z4RRPuE2CVqlNK2A5hUCUgzQTmq1rWNLAdw/rDoC42Y6iKE
         2ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782928260; x=1783533060;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdI00dqXKbnuhWe9G+Em6tlh8QK783V/WOSeoEIH/2w=;
        b=oDyQXnuSSfpz89HhZlrVMrhg9rbkUgAkZZqf/k0+QJYm5PFxi0Kasx1a9A6CCPh1Q7
         w3Az6P9nrFmFNfL9K7+E8DywnmTmutlx+kaWZhXoMfVLgNgE2k+054zlR9Qi1HOSOjo+
         HSbfE2oMacrLn75y//IHiWEPFpRKv4RxY8n5Dc+XwfqXHTlHekvjZd8cw433Lzt58PSV
         xB+7TKeeatYWfSVICOChr1r1rSSnTQp6RtaE4rZT5kS3ipEGuMccbzXYQJ2Qi6QOWA5H
         797P3mYKCaAkl9VpugkoSfeSAzJ1CnzkyHFYAAzTWCCOfXWKBne98PTslfFj+R/LAKKU
         qvPA==
X-Gm-Message-State: AOJu0YwDoq5zr9wFugqBW4LBI4UZ/zvAxtix4jhvGVM10CVCuEvVewtw
	FM1PTbYPl87flfhEkqE8Qlf7nZwarhPdNsUjmChf7be/73hjcR7rrGQt9kBoof8y37EzAlNLRCR
	D1SrE4/rEw0GQcDCmR+qjx+XumLk1rKr7WMHG
X-Gm-Gg: AfdE7cmFaHt9XG37j8P45nNczRMzjgsI0F5eNGL+Y9PoWDr+USU2FxmrVV+c3y+Q+Ax
	Wqgkbxfp+qeV3dKVX+5xrDBFAKf0JGuX+cl78ckYZTiudYSEomf+RplIEwbIWr6HeMcO7yQx+Ez
	Y2kUyXYUjh2FTiKApgewcMOMeH3J7ypR1tHH6vg0py/AXDZdx+PCAg7m45Y1eVIdgv40FGcPVGw
	gytfJKgEHsVHmuubxrEv+d4TCIs7PROqkF7dn6qFnmiPnGMdfxyy38qc8PiOkiuOhp6Y/jH1WR9
	GyEUusCBpzk6PgKyUTS4zekwhsCGMV05Ij3O7nONt8kQnmGmw+uWvSX9ltjMV7KpdPmCHU3Idjc
	0Y5YrqUQICl//08c=
X-Received: by 2002:a05:6512:1114:b0:5ae:b629:4517 with SMTP id
 2adb3069b0e04-5aec742fa32mr758802e87.63.1782928259794; Wed, 01 Jul 2026
 10:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLee083Whzi3b9CP3Hxrq_cz58enN67ZQq5r0koczKeU1A@mail.gmail.com>
 <CA+rGoLeNzxaTrq50jE=at=0ecnZ5Diy+Q-0McG-R+XFTQ7oMow@mail.gmail.com>
 <CA+rGoLe+n314hrbKBSU61Hn=uVQN+OqOF5AVt2gPOityUUL_AA@mail.gmail.com> <CA+rGoLdOjybHB7w1Wd0Or0wJUKjTOev7f1pZbj7dhAZRbs-2eg@mail.gmail.com>
In-Reply-To: <CA+rGoLdOjybHB7w1Wd0Or0wJUKjTOev7f1pZbj7dhAZRbs-2eg@mail.gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 1 Jul 2026 23:20:47 +0530
X-Gm-Features: AVVi8CeHcMWrzM4lGlFaBz3B4m-MAEtMpsN1urCiYGLPS_RwMN67I1Lu2svOpZY
Message-ID: <CA+rGoLePg9MHE+OcVtKo5ho8ziNp9NBWAuWc4ZEZ2kevZf5WKg@mail.gmail.com>
Subject: Re: [GSoC] [Blog] week 5: Improving the new git repo command
To: GIT Mailing-list <git@vger.kernel.org>, Justin Tobler <jltobler@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi!

My Week 5 GSoC blog is live!
https://jayatheerth.com/blogs/gsoc/week-5

Feel free to give it a read and share any feedback ; )

Regards,
- K Jayatheerth
