Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BDA156C6E
	for <git@vger.kernel.org>; Mon,  6 May 2024 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027324; cv=none; b=fkmQaAexcKBQscbNQHXoJ72zWa3AJmb+jTFsbtL+db9bIxzcoefg8Ve/IHS4SraoBIZUwsVO4ude2cBv1gH62U/2em/V/QrRclPqaNpAjJRP1B5wAAFFlYDZ08u3G92HLvRXjInnr1okuLF6Qxs1sI7ZQuomytbJH9i5WE/rPWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027324; c=relaxed/simple;
	bh=3WfcM/3dydoOMlQ9wcq+nMZ6fpec4i0ELvqF+mmnhaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEDTp/WvCYrGotlI+eUcETOToOo/QEfaGP7jpnA8Febx3sPZT7Tsxou5sw+UvSQgBiO2VaekCv+xZVJwIXSxh5FhOwzXD9/lBFqhJWwSwJhCPOf/3EoQGRQenuBgqbsTk3zuX9HCcYIl9lg133OOAThqT9IU/Z4OJs7MW91JNyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=EoHIoEez; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EoHIoEez"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-62050e00cfdso14530157b3.3
        for <git@vger.kernel.org>; Mon, 06 May 2024 13:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715027322; x=1715632122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3WfcM/3dydoOMlQ9wcq+nMZ6fpec4i0ELvqF+mmnhaU=;
        b=EoHIoEez9ifLpwoK+ezXtfhVZKwntAQYhda6g25fbu8aSgszlWlX+jVcsxEdW4XN3S
         rvqNEAaNnd5LzuB4I3OQLNBLWbXRfwzj7XmPN98eck0+N4tEDEop1U9zlnHv2EoRyaqq
         Zh5MuBCG3PVT+J4nghwN5Y+UhI2OsS1w/UQ3/hxHsvDWka50UtKNcmVHUXLTnvtQmO+v
         0n+DXsvRibAyS/3ambXCY+ECl9jyNejWjq+e50vFDH9XeIQs5tNgCHwz7Bgvdb9LnhZO
         BZMu8j6Ib8JHMz6kgdA1iNM1SFb1n32VBIHTNpYAoQfFCJD+T20L134QOuqlwOk0rj03
         KlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715027322; x=1715632122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WfcM/3dydoOMlQ9wcq+nMZ6fpec4i0ELvqF+mmnhaU=;
        b=R0hb41vINkw5BSjT72NZvqytvwtZRT17LRi56YkBBg1Au+/v+qCfD4fzsyv6O7Jjfz
         HaxYg67ABdNRdhpAaCfHDBbRlA+Mx8TiQ0CeVUGGAN/Qsw6myiqVqtDEnCS8vB4s6+pG
         dQRU7f15K3/uHlVsBwuL8mtDJY2UzEVG+Q2fSaOpEt1cmkkGyB54yK67nJqohHf7rhiC
         C77jZvVYVg7MbOV3Zs48VX/0hKgTOYu/FWIUoD+drS8UnRCy12u3sOwNmmZUsK6z0lGs
         ahg9CBIeXf8hsOcDl07AjM7U891NgC9KxY2K4S3PaA1n6yEGP37nZzCv6dtpG3yhatGb
         kYaw==
X-Forwarded-Encrypted: i=1; AJvYcCXNEmVXSpxNRNXakQxIYhI7rX9l8rsm/6Za4yF7S/CWWcnX6vRZXmRRnM2Tc24c/k5KPz/nGf76bt0CmbxOrF+VugPg
X-Gm-Message-State: AOJu0YwCcGVbfntiY9FrPKwzTXHr+yPEA5p8LKiJzSuRBH+2eUxvQIuX
	8Xj2dU7hATvSF/VnJY2FcEpinVYzQcm99JY5LEHdzPhIsXMIcLRRGhejt+Qy2fM=
X-Google-Smtp-Source: AGHT+IEMJuOQ+72L4KSjLIdfncT8IRnWAF9YngK4IMIt5809dQQv5Q8FsOE33FBpGQPhz2y7iIrJ2g==
X-Received: by 2002:a0d:eacc:0:b0:61b:df5:7871 with SMTP id t195-20020a0deacc000000b0061b0df57871mr10031434ywe.16.1715027321885;
        Mon, 06 May 2024 13:28:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a129-20020a0dd887000000b0060a16fb9209sm2340877ywe.115.2024.05.06.13.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 13:28:41 -0700 (PDT)
Date: Mon, 6 May 2024 16:28:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Dhruva Krishnamurthy <dhruvakm@gmail.com>
Subject: Re: Re* using tree as attribute source is slow, was Re: Help
 troubleshoot performance regression cloning with depth: git 2.44 vs git 2.42
Message-ID: <Zjk9eH9e4fByGG9Z@nand.local>
References: <20240501220030.GA1442509@coredump.intra.peff.net>
 <ZjLfcCxjLq4o7hpw@nand.local>
 <ZjPOd83r+tkmsv3o@nand.local>
 <xmqqfrv0ds7f.fsf@gitster.g>
 <ZjPTlrMdpI+jXxyW@nand.local>
 <CAOLa=ZRe6eWJ_ZyH+HRq=6Lh0-xZ=1X2Z2f3HW4+EVXNquaDTQ@mail.gmail.com>
 <xmqqbk5ndiqk.fsf@gitster.g>
 <CAKOHPA==xgRBLXmyURkdZ9X4LqQoBHYy=XD0Q_KTQHbK54DOFg@mail.gmail.com>
 <xmqqzft6aozg.fsf_-_@gitster.g>
 <20240503174653.GD3631237@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240503174653.GD3631237@coredump.intra.peff.net>

On Fri, May 03, 2024 at 01:46:53PM -0400, Jeff King wrote:
> On Fri, May 03, 2024 at 08:34:27AM -0700, Junio C Hamano wrote:
>
> > And for folks who had been happy with the pre 2.42 behaviour,
> > we could do something like the attached as the first step to a real fix.
>
> It looks like lots of discussion happened with out me, and everybody
> already posted all of the responses I was going to. Good. :)
>
> In particular...
>
> > ----- >8 --------- >8 --------- >8 --------- >8 -----
> > Subject: [PATCH] stop using HEAD for attributes in bare repository by default
> > [...]
> > The right fix for this is to optimize the code paths that allow
> > accesses to attributes in tree objects, but that is a much more
> > involved change and is left as a longer-term project, outside the
> > scope of this "first step" fix.
>
> ...this was the exact first step I was going to suggest. And your patch
> looks correct to me. I assume you'd target this for 'maint'. The
> regression goes back to v2.43.0, so it's not exactly new, but given the
> severity in some cases it seems like it's worth getting it into a
> release sooner rather than later.

For what it's worth, I am in favor of the patch that Junio proposed
here.

Thanks,
Taylor
