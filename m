Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAA624679C
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 22:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599740; cv=none; b=s09yo3HUR1qBNUrS0MTbVm3JSMihGrCafJ+7Anjh57wUtq+gNlsRiOnsYTnNI5aVf3/KwjEdUiB3+PggHxonQSFTCvxIxx9TH+m3ncK4BtZfIImo7FPMYCKycOewDQPNVmNRgJyikXG8LzcUWP32j6KlOF9BTADFo7nCPhAG+X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599740; c=relaxed/simple;
	bh=tHbvsi+rlXpN9qi9GqHin3xG7CZlG/pEjjIiIk9d64k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8JRde8xkzlu4oTOyL8Q1reHKwj8YYaZ0GSH8W/zfzdM/thILBqAeqLXrjtUUmu0CF0S3iFgZIaGll0pnQafawBSdo3HQOW/Qf5Ws5XTgu9ACfMI4/yJO5K67mTJGnJM/R0yE3//XsWR4/SURffw4A1WPF3U+vI8u5Nd6xlWKpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4w/UN9n; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4w/UN9n"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-41708f6c3feso3542240fac.3
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775599738; x=1776204538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B8y4mdK/rg8ouJ7lo6SkN3DzulYPxoK5Kw63FZBsuho=;
        b=r4w/UN9nLU4W+idgJjbvB+YXqQkJyYGwUz5oJ4QGi0B2xstetzRX8lqmWow+f6PB7G
         IRN0uX3IyPLekkg+YJQE7ULPxTsmV+rePj7x8m9LoYX/XVdKV1eBKYbzYep0Wbi8dAMU
         sZjvfsRRJaFyIGJaF7+2AF4JSmsBNNRnGUvD9K4bOB/nSMiclQCYiDFXgVmLLLy6J0mF
         Rd9dBWQebLEYTHgT1Eu8byX9T1OC0wO7XuBQxbFXxUIZVgY7eIQ7CNHsf+ITfLnl0yCk
         y+ZF7pROpAV6BG+BvwojeAba9Xutgxp9loxJ5c846ry67vjQu9xoytM+KA61IS0xTdDS
         zvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775599738; x=1776204538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8y4mdK/rg8ouJ7lo6SkN3DzulYPxoK5Kw63FZBsuho=;
        b=nFc8c5u9f1JQtbrBwzW0ZzB4SNO7j+Dl4E1Dk0uqL2EqhyPO+yWRR05IaO9/myENxt
         qAH0l0AvXFEc2/aXCJXIOh/YIKuRaiAWZA+3VGvZQy/PctVX0aD37ZcJ3SmARzIsHWrW
         +fBPjiCo2efFpFrnowHpA8i1ne/qzCzbNbzyw/O6xRuD6VgvTDTdk3AXKr3+AYLg6gWI
         2whWU3ZjAI/S4KPIXYVhTALJrpANowhQp2XjziyNvw1lGfC+Wl4HKhapKtZeIonQaUAR
         Sr38TnEBdT2XfPaoO+wAGCRdA9sRqEdo46ttObTZYce0/5H/mMmVfBbxjVQRWdvkrNgV
         shJw==
X-Gm-Message-State: AOJu0YzTEiyE9sBUohdi252pEFtULf2KZ328Dh5ot30Ou/kIdgd14XcV
	ArG4/oPyoeQzCThOF6MoCJl8klqa8vlgcz92mGAQTsgpC5qJJ4Er/mDm
X-Gm-Gg: AeBDieu8Qi8+dMFCm9W4DWSsBqYZ6v3t03XFIOqDBDAAYF/RyHGMw7QaUN1Vm/IhcBn
	3P4VQ+/GWgn7FvQ3rckzOZ4YVZe+n2shC/VbEXM3xWdFdHhoSeErRaaWhhqWWy1dGA+M3mVg+z8
	f/b52kDJjIn0ZII8IGQwj4w7SSlcK9qN/eM3mOFR8t8Nixeqlz+mCnr/ns8yoZ4RO7ecQQ4Qijm
	5KZWfKCpq6HvwSaEaTEzxH8Wv1gDw7fwQGmFrIBYeYkIal5NZ6ml9ILQ1DWpKRON372kgORxGEi
	WUHaVO6pXQ9IhF9tUJFwhAt0M9npvHR3RDdaqHDNtjOGGkp4OMfyu8jdNWlfnQUBZrc9PmHwmM2
	fAO3YcKj9ykOgGLjZj5koNscEOku9Mwjc0ElwJFPq8wwgvyQ7kvLM1FLQyYRo6uTS6rxX3RpYSe
	ZP1iEf2ZeEA5HVpHje
X-Received: by 2002:a05:6870:7083:b0:417:5eb:3478 with SMTP id 586e51a60fabf-4231007e3cbmr10162329fac.40.1775599737871;
        Tue, 07 Apr 2026 15:08:57 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaf2c7c3sm14545291fac.5.2026.04.07.15.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 15:08:57 -0700 (PDT)
Date: Tue, 7 Apr 2026 17:08:54 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, peff@peff.net, 
	luca.stefani.ge1@gmail.com
Subject: Re: [PATCH] object-file: avoid ODB transaction when not writing
 objects
Message-ID: <adV-NI-t6-jgJK7D@denethor>
References: <20260407201730.2526914-1-jltobler@gmail.com>
 <xmqqo6ju31wx.fsf@gitster.g>
 <xmqqfr563099.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfr563099.fsf@gitster.g>

On 26/04/07 02:53PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I'd appreciate it if you can give your eyeballs to the attached to
> > see if that is how you would fixed the bug in the original context
> > of v2.52 track.  If everything looks OK, then there is no need to
> > spend time backporting on your side.  We have everything necessary.
> 
> Another thing.  Your jt/odb-transaction-write topic (in 'seen')
> already addresses this issue, so we may merge this single patch down
> to 'next' and 'master' first, but the merge that brings in the topic
> can just supersede this patch, perhaps keeping the test added to
> t1517.

That would work :)

> Do I understand correctly?  The t1517 part of the patch, when
> applied to 'seen', does indicate that the problem is not there.

Yes, that is correct. The jt/odb-transaction-write topic indeed already
fixes this issue. The patch here is just a slimmed down version of a
patch from that series.

I can also send a follow up version for the topic built on top of this
patch if that would be preferred. Otherwise, replacing the patch with
the original topic and keeping the test as you suggested would work just
fine.

Thanks,
-Justin
