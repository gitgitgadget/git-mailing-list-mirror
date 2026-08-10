Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CAD30D41E
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388722; cv=pass; b=AAPUQiE+DWV6GV7u/ur9mbFGe+ohdj1bFkh+I2RhiL3+fBT/Ias9h37wyVY00CFElPd05iYDUUDPbnitTR2Ol/Kq+5N/P8vzwLGbi6VyoKtpQJlTVM9aAdqmq5//GpgOvy7r6Az2S53UyMKuCqw29l4gBnrKEZnAmHsB79t/Egc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388722; c=relaxed/simple;
	bh=QtPWeMBbpfR3KHEUzjNxShSgCOhU7uyi9MrhexvkNss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gh7FsQM0zRyosa3h5i+UddJ+N4gp9SpIMi6NSr4k1T5z9lV+4XXDhYh/A3kQB81YowUdsGvcbUuCpfnl/jaz2KpzUhKRB0NaO3lWheFYsatCzJelCylvecYXd5NXIcUFnKWTFmHwQI6xGxqN+1tGL7i+0OFuB7azuHfz01CZ8oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmI1XVMl; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmI1XVMl"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso2189739b3a.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 12:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786388721; cv=none;
        d=google.com; s=arc-20260327;
        b=l2g/smDnke7KhjKp51rIgPFCzDK9f+RjYbdfbGFgi0dzlJjJUrXKvVKR2PmEyIal1k
         oIELDVxxZ8RlbHrNPuV/jRkph+kHH8t9xtG7qDOLez/9CGfTnwNYy5hMdrCfXilNv0sl
         7ZR7p5fSNnOn0qi3Kg9oAXpYQO8pDCwXhl9Rzw3XVvHvRwTMZo9oRjkdyZk8uelmM2JF
         5Apl0AHnqySAIqKoyeJK7n2hALfOwHadryTtBf+Z/q0fEUC/9kmLiif4Lt9XbLQQay4g
         /awl7iZJMqOYg/EkehcUmOEd5S+fPb39D7FfWhbfmRi/SDzqqRD1nig5LKgNmmxypD97
         DDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QtPWeMBbpfR3KHEUzjNxShSgCOhU7uyi9MrhexvkNss=;
        fh=mJp7zD/aNhugTOnrL8dQ02PHrLAVRLvBineKoPiKXAA=;
        b=T0Ikr9LJKycdduuzFsQLJTlmt6C52aL2GVKM2naMTJiIPRleoaPuDlP4wHuRXXq9pg
         zLL6evHmGMATQ8wrMaYw5RvWduj2CJhE2uN5G9xxqk6VdhrGVlywRJKW0WQoP447Qvwi
         1YwwZq4zpNS5DG77VyIXfHZeTmzerXROIrJhzpumajaXnYFsDOF9cMk9ckbVj4xefguz
         jFYptyIyu2a8MQTY+OWfnVGonRG8/104oeOdAy+tcFJ/gkJuTpBkFoqD0hjgeuhpN+DX
         VELEe8g86QwBEyqFn9m9Qdb1Akb07NHxu4UWLnoCQhqTe4ndikwD17aX4WOyzAbFuh8k
         R6qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786388721; x=1786993521; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QtPWeMBbpfR3KHEUzjNxShSgCOhU7uyi9MrhexvkNss=;
        b=GmI1XVMl5f2tQlBzQTZN/iVWXGbfZLkafnW/IrCKSrj2Uj+ixsFlE7h3lIregFrtFM
         KBYuHGJ4LHFTneQNgdpWnVFcJgonS6SDI1oDAYF68FTAa860MDch3Nqq2QKO0SBEUoSW
         IXSUDhs30I0NbA0ZypcTuq06bDLE0ymzCWDHf7K7PeMr0+eIOV14OJ9ntHbcxpNl8h6o
         pSXT5NDREmkUxaJi/etUTOaYD+kBRl3ZvQc5SjNVJ1CMMw+7INuYyz5BpjMirDWpYDmt
         mpmuhn+A/yxjQDpERQqEA/CCriIITg9sbBIkqgKXZLp+kW+ib4OKpUOsEoBs+GX7bTit
         rssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786388721; x=1786993521;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QtPWeMBbpfR3KHEUzjNxShSgCOhU7uyi9MrhexvkNss=;
        b=Nl9IrPwBqCfNKSWht58Cl5Ch5piJTJzz9THmU39GGaUkOwGrkRZxhoXM4LL6hsaIc5
         ReX3k2c+LpsEYZplWhSKrZ88vxHPeBZrlyMR4G7XZlVHunqo4/snjxZhcn8JeE6jH8Du
         VWort4bB57vGJR3FuqVEKDOj1LIZeFS8HCLYRbxTAmDsJ7tbk9Op8F5Y4dO7+MBl5kEG
         WmwdPEhtDOVEmha3hafsqsKSZ4N4U+kUs9fF7wv2osF9KiWPhwSQ8mmCRcYSU0YnAAZa
         fxMsAIvhJvGKaIfKZqwkN9RC6BVLBsRcjtaZBZiAJF/2qeO5ALJZyFSfWVnbj3bB+6l8
         Z/Xw==
X-Gm-Message-State: AOJu0Ywyf9X8fW/xjaYm1J5w8VMDITYwGqPHPcXiNQhj9iQCm8KV/qaq
	XwBz4EU7wrLHxhGwn1YEz85CcAdKAVUP7onXQ9TArRbXVJ+q8YyKCUg5OZptnvDMmBl3KuGW64Y
	65oBQ9ZxFCfHiCa7BoFJw4F8oYDRbUR7h/cIICls=
X-Gm-Gg: AR+sD12ltsAeyJIiHBFjVzlNHAr19KsqaD90h+zkRnNEN9nQDIxlYUH7KiBOBP1iL/z
	uJYYd6RhkOFOWbPThN+kaGUIIUrOki9ctik9CaGSNVYrlNIWIPFirBgsyUD5+dBWlXlwjZTj8OP
	3Yva9uHQFnFJ/j32WgNoNoczAaQ9mnXkig8zD10gCWyl84ehgyA6rao6lh9jrMGsFS46lnSknHW
	BXFKDP+EexlLu0rdZPSg2tpoNX73GjutwBuy4yAl4GuDX+jarCQsnKWJ4Fr1uR/O8RJTVgFdzO6
	P2/kmPXPvkEQwUI2VQDN0GSRx1OkpMHxEpdlSLDMTOvFHHTyaU+I+pI6Dhs7q8GNhnuyTYlLZ31
	E5GnclBs6csu+Vw3vBxLZPgDWwi+oj2uZxjbleiWTSN2c08bmSjEqztg63eozU5AB
X-Received: by 2002:a05:6a00:3996:b0:84a:2fff:ced2 with SMTP id
 d2e1a72fcca58-84f2e0edf21mr43590179b3a.35.1786388720612; Mon, 10 Aug 2026
 12:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGWgyh_WJ2mAgbJ2agp9UQm8iyR=eq0xWjdYT59CC9fZTnAbzA@mail.gmail.com>
 <CAGWgyh-Udy9p9yF_8EDnVgK4bxyG9BsX1gio8oKr0G9b-sdQFA@mail.gmail.com>
 <CAGWgyh9154HAPs-YoMz6G02TfcLe3CCcd93TJjg6e+hQsmZxVQ@mail.gmail.com> <CAGWgyh-fXm2WdAqZDjYeHAuucniWnoathQvsFP+rDsKvxrs+eA@mail.gmail.com>
In-Reply-To: <CAGWgyh-fXm2WdAqZDjYeHAuucniWnoathQvsFP+rDsKvxrs+eA@mail.gmail.com>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Tue, 11 Aug 2026 00:34:43 +0530
X-Gm-Features: AUfX_mxd03eENQH1ljq-kqzd9-1IofZAbBy0V9_q_Uael6tzQOJymYQRDZ1h0TU
Message-ID: <CAGWgyh8ijbA6gUcSgdkrwRtjSAfYbpfU9WitmcnFAr-ObAZ+RA@mail.gmail.com>
Subject: [GSoC Blog] Week 9&10 : Improve Disk Space Recovery for Partial Clones
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

I forgot to send an update to the mailing list earlier,
but my blog post covering weeks 9 and 10 went live
as a combined post on August 3rd:
https://siddharth.shrimali.info/#post/10

Please feel free to review my work and share your feedback.
Always open to discussions! :)

Regards,
Siddharth Shrimali
