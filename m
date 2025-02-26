Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C692561D6
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607809; cv=none; b=igPIL0bptYuOwgjoiBkwpy88pCORm+cLHlvza9VZISlUPtyzxYegy5B7lkUubLbiA8AtyBKmnCUbR/wwavsyuhWb/jfCkifoonRMhTQx4xO9BhgPe0+61HJlHYzOXuu7oeq0IH7mBHo8aB+rqKhQWGFNhNpjbBA6NUG0CUeqb1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607809; c=relaxed/simple;
	bh=c0H6j3pR4S6lIgxzQhI5JUzr6AQByaJgxn/KNGV6Zr8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cfdTa95dkfIDDddDymEVajshFM0ufEe1nuA2iHb0Vw25aQM6z5kJJrVdT+IVFlZTGulZ8pG4703rsq02iL8UQ8LSTlaM8RGFnAiGh3BzSKSp7dg84GJWuyd7CYJa2jVGMPsCy3XBoVxGlaK3Cdzz9cWrIC9Rh3Tsqv/higpDvFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nwo/M17h; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nwo/M17h"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22114b800f7so4481465ad.2
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 14:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740607807; x=1741212607; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQl7IIDYYNuHygixdkgRtOKxK13dcTQYxeGQKgPlHkU=;
        b=Nwo/M17hkBZrGxrfYWa9bGBBi/PV4cNx1ve+HYOklpHc1zipoTtnchsSQF9ajWPFQm
         xb10tsq/zvG0M+KRJkPqynXJRm1OaTpSYXqYi5/eZJ/1YgitSQQB0eEXzzQyJ4mcAoKg
         RFUkMpU7S8w+ysU4cHBPVLagIZsOn7A2fg41M/gSOiuqpbUscMZhnCpyB47GlH3+M9v+
         u2DciyZtuFDBCvxhpXVU83WZtgDqcHatNJU9cV+zElYtsn2Hmh1M7Vp8qzqHozCeB9fj
         mM97y3KStQ2+pOFgwQ7gF/8M3uJ9iqBMtPgcDYeItgSZNwdh0bLdJlQicoWlePr3sa2F
         bsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740607807; x=1741212607;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQl7IIDYYNuHygixdkgRtOKxK13dcTQYxeGQKgPlHkU=;
        b=T/svmypyFFaT5KTL72YNHFE2ZJLcp371kK6H+KyGbi9hKdYhHaJYUVKczKJwKS8Vb2
         hsrKk/RxJwXdHK680ja+1r3mWixdmZZono+YOXgCeP5JikUNP0A/K43vCFsQGqpFzCsv
         DPb4JAVDvv7kXhIYPYP8M0yQ5/AxWNwcNBFRYuHQ87mfF0bHpyaSFIVdo7Q5LsJny0s7
         qK4cF8QOIOgv63xvNayBvfLIdCZps6Mn50zcdlEjmAZvzdmlNN7ZzGriJ4SdkamOaV3d
         nTZrpgQqn6+TpmXoyMn7I75CBQVKCRl5CNoBiEukhardBovtm4BfI9wOF//wQFmn7dcM
         bvCw==
X-Gm-Message-State: AOJu0Yyjjn0qKRwH5Sn5Z1rs/XNRUC99xPChOk242zjKivj+EOLDdhxo
	NfuUcb1qFiEpB1Rwrmb/gL7LhimFSVo2j82pm7ONxKV2QxWrKsbN
X-Gm-Gg: ASbGncsbBSXeoWZI8iIPwn7Hazqts84m4spyg0zJkCAt+jPwGwY6CDDaMsvBulIgGPK
	VVUaMO4kVGo6IFP5eO0RZBjc6d4YMsla8cd8rYGMB//cDw4JhN+hvkxpUThKFR/FX+ZX5Zo+VwN
	NRiFkL4WEm+glEvyno2GgXyVgcxI6xXsJJ+2MpBLrtLI9DJPAByGaRhLyufyqhX+SDODwnfRvKS
	WVDDpsKTz832IiRLO/aOaWAh/a9cnVWebf1OE8WnoHHigdrysRn3Dq0AcgnRrr2dyd+x8BJT91k
	yn14xt37xixcbEnMAigMvlkD6ho1AoEN8F1g/8mzTB4hhew3r9OpLaMoxNI=
X-Google-Smtp-Source: AGHT+IFQbza9PhSliTmQVBA5g21/rJvHViY5++jZFmpWRDatjeY/R1VgUJTGGcpOvgWKTiXRyuQcWQ==
X-Received: by 2002:a05:6a20:3d87:b0:1ee:7054:178b with SMTP id adf61e73a8af0-1f10ae2ece6mr7746022637.33.1740607806702;
        Wed, 26 Feb 2025 14:10:06 -0800 (PST)
Received: from smtpclient.apple ([2804:14c:32:8834:3146:eeee:59fe:57ff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0024b98sm40117b3a.108.2025.02.26.14.10.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2025 14:10:06 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [GSoC][PATCH v3] merge-strategies.adoc: detail submodule merge
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqr03lkhwl.fsf@gitster.g>
Date: Wed, 26 Feb 2025 19:09:53 -0300
Cc: git@vger.kernel.org,
 Elijah Newren <newren@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <FD1CBE9F-918A-4056-89D2-832CD07CC73C@gmail.com>
References: <20250225161800.8268-1-lucasseikioshiro@gmail.com>
 <xmqqr03lkhwl.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)


> Should the blank line be added above '+'?  I somehow doubt it.

To be honest, this is my first time using asciidoctor, I 
sincerely don't know. Building a local pdf with
`asciidoctor-pdf` didn't change the generated PDF. But of 
course, this doesn't follow the style of the rest of the
document. I'm sorry, I'll fix it in v4.

> Other than that, looking very good.

Thanks for your help in this patch!

