Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D878A1AA782
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344104; cv=none; b=U7XXHF+9qM1pYNIZgJDSxnPKxp+l5uLYqhzJyjgjHHz8H1v/ybifbXq2ePLsMAJlhZMJlsDCaWjPjDnxd6WGQysUDD2KrHnIqsks8LuUgS0mHaCYB7l72w+azZ32IJueZ3xEnObICaIArP1Pr0vCgxzDzC5Xnqn/k293Ti76T70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344104; c=relaxed/simple;
	bh=LwdB96THQ2wXOEXnZx4kDV3eXPX5LmLj/WnsFBPwPtg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Qwkf5YOcD6OkODYScYs7EyFQW0EN1HCBu3eVcofTHIFTrsAl6xDkNT2tVcZ+83+Im2DdUhb62hEX+maNEnEUYwqc8oH73FEzsNilacI8XxLVp9QjMlp7/hvEsdWm0tngDARyaRi27GJ4hDiUuk93LM7iiYhjWv9kDy5KtNyIj1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UR4EYrEA; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR4EYrEA"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso610456b3a.2
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750344102; x=1750948902; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwdB96THQ2wXOEXnZx4kDV3eXPX5LmLj/WnsFBPwPtg=;
        b=UR4EYrEAgUlR/pqC8H4HXFm26MKqus6PJ+DN8bVIU7+VDsL4WeRO/+cb7Y8RlPEYKf
         P2pmlyJEg6w1UZjW315XgoGcIjsKQ0S9m2EhHDHxQ8QyGLZIcvBmdSlYcPCN1al1FHW1
         XrI1W6WkaKvVfBbjxOgXhIwK53TT0VgaUwZx1vdmFrn6doWY6hGCt8L7hIsOhEl2RAvD
         3mepZIeWSVKxeJmhkvB7agSw1Pj8bNpymn0wFuRry7ZTVegZXrTbOR+/sQZQeVEZW3T6
         EK0SsBSjQ7xFZ4SoX53Sud4CRU8N7XRS1I/CaL+o1KgmqOZUORWXp/s1/emkNYAdRuh8
         ztdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344102; x=1750948902;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwdB96THQ2wXOEXnZx4kDV3eXPX5LmLj/WnsFBPwPtg=;
        b=pGM7zYqLZR4DYguiMmePP/rLRSVXaQ93VQUILNrnDtXLzO2MWGWQMHFVUCOZDFa7OD
         Xx13Ax25ENQu/UkT48/GHnXymDkV/dVmSwoFShH6NOfS9EkpwWyNjkCv1oBXOE2TVN/g
         D61s/+AbUNbugkIxHT4S0qq/b+74l9zyIBjc3JKCNg2sYzim2vA8wTm9ub3dcmEakVde
         Dk2N9kwhsQy+3Ze/2Gn9zaayO2axHAG65rplzTCWZTkvghY+6y6bxmTAb02740D3+kuh
         nCITdA6y+liVUSUGZOtHB0omO647qIgaEarlp+4515NzV8kuMwxxvw8HJqrm0STEZH2B
         6vFg==
X-Forwarded-Encrypted: i=1; AJvYcCVBOtF0dLUvsZYfp8Qr5snZqI81xF4hltVC+aNVJZxVWLMuVOHkgDxQmeGTb7GGpU1Uumw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxANTBxjlmOX3PKu1TrU925RmKukeQo5fzHl8Oo+QCdIXfpsczr
	G8qlGz9WOW+pWzzFYagGSZVT5V01xYdsgt13CVIQ7G5LIss4YFUMeT6L
X-Gm-Gg: ASbGnct5wqeyWYzYG+HWrlU1JV1Boir4FqjcTrbcz+na77cIW3mOOohGRlKXzzEz7lZ
	dmc1IzM5m9glZa+WPwi4YWFLUZ9lLPp9jncRb54J8uKri0KoCa2KKFBHbufAIJTaqTdOCsdxegr
	4EV/DxP00GXJQF2IF3EE4fitUYytVRlgLvBuHuYJ/4EJ4vPq/zRtBfZbtWQ1i5VUO2+R8s4K8DN
	1r21H6CuTRLatU9JXLAO7hA6ebRI134r8vlQZYJmCR0Afa7bCsMhTccp+V6mN+nMH+bdCF0bPh3
	oTsMWTnM8LHjFn2JA10jNEFpMBY/sbjj2ZU3yulfWFxGwMZmOe9NnOPMT0loAe3EvRorHuCrBTn
	lu+Xhms1Z7A08s5r6Mwm3UKObZOwLhp0pxZSoH25+r8mhNxFq1+B+E0Vh8RgaGn8=
X-Google-Smtp-Source: AGHT+IHfagnIk0unYaYIXVq8Jyys3lnS6i8h93W2K9HXqjRMPjsZwqmQPI4Ll49xBaSVORo7SLjXTg==
X-Received: by 2002:a05:6a20:a115:b0:215:f6ab:cf77 with SMTP id adf61e73a8af0-21fbd683f68mr33755418637.23.1750344102006;
        Thu, 19 Jun 2025 07:41:42 -0700 (PDT)
Received: from smtpclient.apple (awork062155.netvigator.com. [203.198.28.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe168ccafsm11059485a12.55.2025.06.19.07.41.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jun 2025 07:41:41 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [RFC PATCH 1/2] fetch-prune: optimize dangling-ref reporting
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <B83B89F8-8129-445C-B4F5-43C86512C114@gmail.com>
Date: Thu, 19 Jun 2025 22:41:28 +0800
Cc: Phil Hord <phil.hord@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A68FFEEC-0406-4280-BC7A-67C932141F41@gmail.com>
References: <20250618211024.2332525-1-phil.hord@gmail.com>
 <20250618211024.2332525-2-phil.hord@gmail.com>
 <20250619040033.GB1801319@coredump.intra.peff.net>
 <B83B89F8-8129-445C-B4F5-43C86512C114@gmail.com>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Lidong Yan <yldhome2d2@gmail.com> writes=EF=BC=9A
>=20
> This patch only adds sorting code to prune_refs(), and as far as I can =
tell,
> prune_refs() is only called once during git fetch. So I was just =
wondering,
> would it be problematic if we moved the string_list_sort() into
> refs_warn_dangling_symref() instead? And if it turns out to be safe, =
could
> we perhaps even use strset in refs_warn_dangling_symref()?

Ah, sorry I make a mistake. We can=E2=80=99t sort string_list in =
refs_warn_dangling_symref().=
