Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5F92AF0D
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724306631; cv=none; b=Bk2fK8StxOGcHW2OX1HsVJY2nZAwwjTo1StqdG7kmXfDWqjdZ8fU3AE9mi+SEjs4ctvkSQwgpEWxOFtEZBRwnO6mWjsDvf7/C2pBmqge5ESw3OokLwcD+Ldpyl0XEpCBG0nC7wd/2lJ9YGW8NgSbjfU/yxAZ+9Ega4s7iQRvCU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724306631; c=relaxed/simple;
	bh=/xE0krL6Bu411cwjLE3dPqOgIXiymINISnQIm4qg2HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDbabYbDyad7y6ZD+cBA6MPrp+fA0P9IPIox9sGGBtr8TZbbwUrvW7KK56oDj3E3vpxSEPFJn4lnivNecjv69Th3fiaGN9J+Q0Y4Z5OVKi1PdsMc2SrWKP6OS/5Ee4jwrR4b98J5zroMH9Zk+Tv0psWSE8gNOX31y+obHnWpTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZMCi2mM; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZMCi2mM"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-371941bbfb0so179469f8f.0
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 23:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724306627; x=1724911427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xE0krL6Bu411cwjLE3dPqOgIXiymINISnQIm4qg2HM=;
        b=UZMCi2mMtKn1pLA3CBcfEPgXoCD8NHV7WPmd7LtnuDli0hFMl8zdJsIXgkXW+7sWoj
         D1/1FOwi7yuxZ/rdcyMN4/iIxejsjYesK6n/vENxjCshOmS2ME+PE99YilHSdWt2bYNN
         mBY4gBkZLBKIRnLS4mxxvVZR+5Xdt11NmjUxH9flvCOEiJMtMaetfB5qVfsqkJBXNKe5
         israWscsiLsvRFhwn0d9KNMVGhkNsN6kziSSha3hPkpq93Yj/6PlZ9QqNMUuAEDF/x31
         SKp1Bvd/pkwfxBCgOBSoiqhnWAUpgwljRp448PrsnUgUWfjEpHJHY2jgX6rWgfOuOr5y
         PYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724306627; x=1724911427;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xE0krL6Bu411cwjLE3dPqOgIXiymINISnQIm4qg2HM=;
        b=AVpgfpV6oR7ApqK+hisFmcvE5gF9lDofTT6N4Xo5L/nijRdE6YFtrxEIrPtgaeq/5a
         wuuPHlEc/g9jslyFAUdLN+q/+vxfE4Zz5DH2k4pmI9+ZZSEpE32fd9EyuF1j1n3N0HJy
         ykI7bLEa8ZUNH9NC4YpTkXd5jsmHdKLdCnUQ2ZX0Uccpn9GKiWjTeA6ugCP8BmPPEJhN
         TEWOOm2iCLrweaVcWBuXag/oldNPdBX/zGN3klN6zJL80OMjyYHuRrduEAHcZNelGnmk
         EP4slxvFSPJRMBV+8tqOeE5QHddoEwFU24cVkj9U8UXJy1Y3unShg7sloxuRkknX/eMv
         Yraw==
X-Gm-Message-State: AOJu0Yx6TH7ouAtHlp+rc7cShSVa3h783d9Od82Jr6kEy8mZqlfgy1CD
	NOZtrBEZw+vrklAjLCsPOfye/V/ynwB+TzaDcIb7QGHA2tG3ZAut
X-Google-Smtp-Source: AGHT+IFpOWcM8NxB6TaiPkkliZPlRDVrEbHaZ9Oap/G4/kMEMzdkq1sHd+MKX6s4sNNOu7seinTgtA==
X-Received: by 2002:adf:f24f:0:b0:368:7f59:a9f2 with SMTP id ffacd0b85a97d-372fd57f3c7mr2990409f8f.10.1724306627245;
        Wed, 21 Aug 2024 23:03:47 -0700 (PDT)
Received: from raspi.lan (85-67-102-31.pool.digikabel.hu. [85.67.102.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081457c5sm755106f8f.42.2024.08.21.23.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 23:03:46 -0700 (PDT)
Date: Thu, 22 Aug 2024 08:03:45 +0200
From: Gabor Gombas <gombasgg@gmail.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
	ps@pks.im, james@jamesliu.io, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/7] [RFC] advice: refuse to output if stderr not TTY
Message-ID: <ZsbUwZM0ZPuWIlS7@lan>
Mail-Followup-To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
	ps@pks.im, james@jamesliu.io, Derrick Stolee <stolee@gmail.com>
References: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1776.git.1724238152.gitgitgadget@gmail.com>

Hi,

On Wed, Aug 21, 2024 at 11:02:25AM +0000, Derrick Stolee via GitGitGadget wrote:

> Advice is supposed to be for humans, not machines. Why do we output it when
> stderr is not a terminal? Let's stop doing that.

Really bad idea. "/some/script 2>&1 | tee /some/where | less" is a
common, generic debug construct (with countless variations of the exact
commands in the pipe - this is Unix, after all). If /some/script happens
to run git, then I _do_ want to see all the diagnostic messages it might
produce, both recorded at /some/where, and displayed by "less".

Regards,
Gabor
