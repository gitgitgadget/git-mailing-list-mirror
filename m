Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD81729C328
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130397; cv=none; b=g144RM5ufRRKJChZ1AuwCUY/BIdqCE90LkFlIQDhwN2gPXW67Y2Bo1nZ0cQM1aP48lyYtGEE7g0tJIkg57uQUIdh3Ki9GWAr4okW10BlsvPEuf2WVaAEYGeoZIdc3esFfERCAv6pB5CYIz+bJFr3mTyzsQQUWRp/mpoVMVx8Mic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130397; c=relaxed/simple;
	bh=kZemlGcn57ITkOydD33/QLR5KzSeuKQpYVbcvOJFQTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIL1xzR2g83RgXtF9tsYmSAkpSnJURp0FEkFqU+GZYWV+Y0z69wuZEjVqqn5UHimbbDsM3YpTSE2QPYb9vEduvF2EcH6uOJBF0YJvOBmCyZ5pShe/a6Rc0XAGj4oc21llgcN8k0WPM0UV6AKl0mUtfksjt9aN7WCIt38TsgfAu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5YDJNLE; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5YDJNLE"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e6f27619e7so5962211a34.2
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 15:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781130396; x=1781735196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kZemlGcn57ITkOydD33/QLR5KzSeuKQpYVbcvOJFQTs=;
        b=O5YDJNLEg7ivLRgPoNg+Z15ctruZz7SixjVk9PlzZwE+sj7OzlRERniCADtA6Z5Skw
         feFvPdEWw5yrHvdXWWCqF3SfKnAufI3tiRL5+sSxcfJRhJpdivqV2ieTIZD9hnfRCSx+
         Yt9UaGAQvG6gsF6Dc9mmp8QJWsFRtgMlskcQtNAtl5mffR5Q0K5+w3k0+DoD7ivDEoTB
         juy2L2Py26odkF4AcwKqPxu6EuuWLjoAcKKMTW06Yaq+f0lr1TC2tGoBsr2Q/78JR+j/
         YkZvxqhs7Wq2MEWu84bBIL9Vr6JQnLKHkv+d2FZXCNW+pCdnWjm4QNXUuCyM1ey6M6+m
         IPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781130396; x=1781735196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZemlGcn57ITkOydD33/QLR5KzSeuKQpYVbcvOJFQTs=;
        b=OIi7zJ2Gdm0IhYheuM6LW+rI/Ew3AmJiUsmQ0flIqg/viXYNFrnHyZURyAnZK53VaY
         37LmcfgaMWftckOYMvKPk+kfyFPGpBBvGeqQMbDLDIcv49DZwp4ORwtWI5/AnzkyDF5N
         +b8JaQU+HNJNh+Uf3hUVdgC3gXAwHtGbZNE8hojzCIf+bmlAR0e9cCUnFlRzR7AIUKso
         kQRu2bjXgcypJaEEyp1N8v1Tm9DfRp9eEF88pX6DVFv05xHjVjsC8JvyTmmQuZI9mEM9
         ZbAzbZHRGX21UkLo7TTrj8xxn0YsZz9HNCdKrLkfEbkuUqFiY1Rv54eteGT0UowSitGW
         Yyog==
X-Gm-Message-State: AOJu0YxRef5W1S9GRCpah2oOgZCp5d3vKNAGllRxiL/+8A2hYxO1Hy2y
	FZJclPU6gUgA639cL116tK3YFuWBCraITeYBBogPVtyfGbB7twNmTYmr7CQhig==
X-Gm-Gg: Acq92OHegx8VXMrm/yswtaP+J9TFZ9SaJvxkl23I2V30h0IZR2PhGB6edFaUg9njyCv
	X+wPOPpPJMgQP9QXlgijaS6IFgWaUnbqzPkBldu9jysuKoz1FiBX8o92qNYUW+VPMzyQzLKw2S6
	WiVmk6uSFwSHUTBCAp3gAKQCtv6EKTujoLosAKC4hfPUM6WusMNrq6Qw1s3yo8qc8lLfDY+a6UK
	P4yOFdUHFM8RTj0i2EqAul0gSYYt1bqWqI/6p+LmxkxDYYBFVb3yJWI8eEbMzlcjz/1PcZVsH/4
	Yew6d2efHeS5gE/UP28LPjnE8lz0In1W3PSxGAomHxzprHU+4NgI676NXKuYX8o9FopIwRUrWgj
	Sb606meGkOPkAwZX7ZjidtWd+kzg9CkrAEjMAdEZGELJ8atbzELM7DKh7vPtNefBs8X6GKe6Bhh
	jguTWOuhJjh+H0NxoCIq2MBXGcn6s=
X-Received: by 2002:a05:6830:620b:b0:7d9:7201:1acf with SMTP id 46e09a7af769-7e77346be19mr103401a34.5.1781130395801;
        Wed, 10 Jun 2026 15:26:35 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e746a50bsm17190082a34.2.2026.06.10.15.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:26:35 -0700 (PDT)
Date: Wed, 10 Jun 2026 17:26:34 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/7] treewide: drop USE_THE_REPOSITORY_VARIABLE
Message-ID: <ainkcrEutDY20duS@denethor>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
 <20260610-b4-pks-setup-drop-global-state-v1-7-5dff3eec8f06@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-b4-pks-setup-drop-global-state-v1-7-5dff3eec8f06@pks.im>

On 26/06/10 08:56AM, Patrick Steinhardt wrote:
> Adapt a couple of trivial callers of `is_bare_repository()` to instead
> use a repository available via the caller's context so that we can drop
> the `USE_THE_REPOSITORY_VARIABLE` macro.

Nice cleanup, this patch looks trivially correct. :)

-Justin
