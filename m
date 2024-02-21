Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED7F80607
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528792; cv=none; b=nhhjVHzup8sejMXpJLQoZgCLn1NQzGaaqlNSYwxKM+S+X7Bn9ZHm5K8jnwAHjAhqNwQ3wVAeKW10t3z7EqqyCJZgTCyxr1jlMGSMaXo5RvoEfyHEB4Az9z/CTGgEDZoVD4t4KCphT38JZ8BEHAZnDHLYutvk1j1758UtfdTCoqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528792; c=relaxed/simple;
	bh=kfrLfuq760OLssijoNesXZhSE1jHdZIuUcius41ssAc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=asC9EOqWKAacA4jheUzpP6z+rQb/PUzDKTDzAaWDYZP4wTVLslTCFxp7xvs47siOXt8SzmBGoAw7tNL0CkIGCVKYY7mOroP9c6eGXDdrCPilbawJicu94T1jhV2Nor9CEC9+qetAyHAqMo0X4fk4vE/P3G6lHjRb2DFF+sOUYwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHzu5unJ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHzu5unJ"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68f7f097deaso6680716d6.1
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 07:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708528789; x=1709133589; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=kfrLfuq760OLssijoNesXZhSE1jHdZIuUcius41ssAc=;
        b=kHzu5unJvL9U1pypb77ooqA93rQ7xaX3PF6rY+3KWApRtT5ji68KCTYIjwW2yy7K40
         OfpvVZUV8ecH4c/Ox27VyHjfwJH4XEtDUbknhyofqHOAsfr5r8XSMDAZZxM/Of/mttxd
         0zmYf1FJNp5KG4SS6BFiiqF5n5Xw42j+9rv0MjpGgi78L+kGb794ICaO1PuLDA8IEwcC
         Q6Cz1HPh2JfWCHjK9FwDdOnBUwX0FSWnRuFkq8qcL5oBt1HxN+U8FIjnLXY3Mv85x6nX
         k34cwFHB65AjFSvKEt1MpnxIY0RkYQJ2XPqsh1xJnS1/2+ilnq9dhH93pceoudSbSraq
         0J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708528789; x=1709133589;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfrLfuq760OLssijoNesXZhSE1jHdZIuUcius41ssAc=;
        b=KVUyGtyJ9TUrkjYhwiEDG2jerUQJEaO4tKL/kbMEH8/JQOiju0vShM25k4IxkoDUXQ
         1bLvfjhtiJux6dHcaYSRCkYvdKO8QL+p3IIjXcfqor1cYmddVP5JG2Hu7BgoRmz5M7mH
         nODEHpnKahgmObtCpwGqnBoU9PVcGAFz8YEoMBBNlQ/2F9qumHoPug7V0RfJTmCns98j
         eHLqgVqXwB/dewyEvJQWI2WvyuIRZHPSvx2JLAkY2qll2k9Ilq6NLfAD+J343oZQe1wd
         qEfckOnEOLMexnJUzztYep8Xhe1Gq196YIHJ2u/bHMVthn4n6UPXdf/INCw9mk4v0sIl
         UwRg==
X-Forwarded-Encrypted: i=1; AJvYcCWJq+1HUi+gGSIC4gnDlZzB9UkUezCfdWLExeVwVNATRQFPIJMersfOh6evWiw1UaT0iTBDEENYrWLJw7tcZ89gshD3
X-Gm-Message-State: AOJu0YyG3plmfYCTqwcD6RYDdSZzSH5WmHNckMpAq2KhHiarLc5/AUKa
	qoC2+TRpnPvfBlpCV7Ceqptigneh4hF5H2C5u4hwgPEyeBQIfteh77mkFb6r
X-Google-Smtp-Source: AGHT+IEl58GSK8QyUBL8fL+9dxS780B5sLojScdY4Wh3gmOH4c+HEtKvL00VXAY/Q8/1khT/r9oFGQ==
X-Received: by 2002:a05:6214:d04:b0:68f:5547:e9f with SMTP id 4-20020a0562140d0400b0068f55470e9fmr13290165qvh.1.1708528788969;
        Wed, 21 Feb 2024 07:19:48 -0800 (PST)
Received: from epic96565.epic.com (pat-verona-h.epic.com. [199.204.56.213])
        by smtp.gmail.com with ESMTPSA id qn4-20020a056214570400b0068fa94bdb1dsm576388qvb.142.2024.02.21.07.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:19:48 -0800 (PST)
References: <CAB=tB2vB0LbP=DznSqTFYHCRxDxd6U=Q+P33yeBzGssq2eK1vA@mail.gmail.com>
 <9c52ea4e-f84e-4c64-977d-14a468236c80@app.fastmail.com>
 <CAB=tB2tgbLjBPvgBQDoNJi7e8+LMzxHSbg6D2jKUSJXPmQFrxA@mail.gmail.com>
 <m04je1dhdx.fsf@epic96565.epic.com>
 <CAB=tB2uZb+8QLmrk_tK5PKJtDE=RmBr=eBBb7U7ygSmkFoXvWg@mail.gmail.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Sean Allred <allred.sean@gmail.com>
To: Maarten Ackermans <maarten.ackermans@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Subject: Re: Breaking change with "git log -n" since 2.43
Date: Wed, 21 Feb 2024 09:17:24 -0600
In-reply-to: <CAB=tB2uZb+8QLmrk_tK5PKJtDE=RmBr=eBBb7U7ygSmkFoXvWg@mail.gmail.com>
Message-ID: <m0zfvtc0a4.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Maarten Ackermans <maarten.ackermans@gmail.com> writes:

> I would suggest displaying a warning in case of invalid input (such as
> this out of range error), and to fall back to output all as if the
> "-n" flag was unspecified.

Was this the prior behavior? It sounds like from the commit you
referenced, atoi() simply would've stopped parsing after a point and
you'd end up with a (large, but finite) value for `-n`. I'm definitely
reading between the lines here, though, and I must admit I've never
provided such bogus input to git-log myself.

--
Sean Allred
