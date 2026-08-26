Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83520140E5F
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787728750; cv=none; b=JlfLJsGtgsaKF7ik81ItlOnag262hUdYdrYjGvescrHZm/wpaS+4AO08qXuiUUxwfC9xQwVzJplxWYrTEWvVyuyNMVoXx9iBsIjsUyyogw4D0C0PRSE5DfMP9C9STbytdOatCZ1L5voEEAEB7j0GGgOJNGz+elPWwJ7Vrpc9xg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787728750; c=relaxed/simple;
	bh=dnwbcbaivyXI21lBg7+TSWPDC6+Hz2IO739JzrzzpcE=;
	h=From:Content-Type:Mime-Version:Date:Subject:Message-Id:To; b=UQTa+ZclmwIGtnuN/pSehR1YdyFjOa2fC7ZArqs8ZCkAh2YxIl3j0sLD7dTMTMBxhJDtu00+H6+UmYbOF9xKPFwU+Lga2hCSHHHtrJfvvJehpbbEfOapB7PvkmHF5+s0deS4vI85tmMUOHYveWDNhcmh6IW344K/tbfZ78hi2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDzY52oR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDzY52oR"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15e2dab83eso89503566b.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 00:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787728748; x=1788333548; darn=vger.kernel.org;
        h=to:message-id:subject:date:mime-version:content-transfer-encoding
         :content-type:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dnwbcbaivyXI21lBg7+TSWPDC6+Hz2IO739JzrzzpcE=;
        b=PDzY52oR225tPgnE/S2vBcuXY0crJGEwgPPyF+byy4Uj05oynY0LD59/bi5nW/cA6z
         yOMUOrlmd2PcamRodP2t6qev54qYb2sPLi5aX2HJYGYnINLCLTeCfVhdt4JAHzzqtQNa
         KKOqDp4BOA0qDwFo0IMedkkPCYmCODWJoW9Xi6G7ch6QqWVxddRcex6Obx8Fh8iYUz/K
         pzla2B1tckTTwsv+F5a08Ux8ZSHKg/ph3U4wIDXz1kET5nbfsYYm7yBf4MzdNxXWKdkO
         jaOlBh1dguf/mHaEXJF30tbGpDMfnAlSZjSXAfSnO4Hgu0kXZQhvEcCdVHHFSfUsYtom
         SnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787728748; x=1788333548;
        h=to:message-id:subject:date:mime-version:content-transfer-encoding
         :content-type:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dnwbcbaivyXI21lBg7+TSWPDC6+Hz2IO739JzrzzpcE=;
        b=EJx+L1AwdCE/JNuMY5dCr4lxiXunFGH4t5sgSNJw9dYA+FBboXTLKrzzNDEIGPrE/w
         sYYcEKg2DRmeMe3VzDPv5zb24VtWEM1F3WWHlgpTd/b4zabJTbYbeDg90JXuf6BmPseU
         h7GkRGQ9CJshd7HP4eTD5Onvm39Lz6gNTMEvwTpcB9jUnmFTzIc6dOKFDpLPsLhQUlDQ
         1FFoKlLECgdzSf543C3yjlgvaUHlntIcaBowLzDdRA5pXjRqq4YgCnGce+10I3knPhBR
         h/pIleYAMxDGbEEk2vmPF51HxDnR5Lta8+3GT2dc/7mYP+zJVIDoYFTddzCc2TQsZJ6n
         DHdg==
X-Gm-Message-State: AFuF++nVvfWMXSY21wAPkecM035oG0kL7zB8jrlhdfJUrCDc9MaYN6P6
	O73xO7T+YFAqt9RSSrsv/2fbynFJpXUXsnBBodrYqKxq9/yyXIf36gMzEBRjdw==
X-Gm-Gg: AR+sD1153zs1ywD7BAnibpB29gfxQad4gpEqCxyNE+/JVil8ou5c4CNpUuDtRrcN2qE
	mdexxun0i/ShHxpbgsGOddcGQlaC3hOezFzXl0dAN57inPpPD/nrhw7koXjllGepioiMwtvqQ0X
	/kBWTyo+DTMnWyli48JX4vFtIz3INN1E44VlNyzAeY84BeZqISMdpzMdz7rmpiAra/YfGDpHaEa
	plty3Ckalod/wYMIxKL/4xYlVTolPQgTIixG1Bimzq4xWWtQHaFRcMyUawSXR16aJGHFhPOkiJm
	kUeRN3rKC6HZ8PqSPvA083JLzlp66Aa2MSVofd3PxRdxe1T8J40My437W6phsPgLRP0Q06yfVMb
	SPEBb+ouLpxTVZZTaEYcPW747DRFsFKRZCaQrnoBdzpwPwGILE3gUnjQ19W5dHx3NiAaLyEDM/T
	tA0jByiUy9dzlhHtDwByMbI+BQeAo0tOCnLtWM/KnhuUPsw0onLNcXeIk/LN9+K6yXGnZzSygO/
	I2YlWbUIbkNmbpHhzY=
X-Received: by 2002:a17:906:f5a2:b0:c20:88a6:8210 with SMTP id a640c23a62f3a-c250bc072a2mr512190566b.9.1787728747545;
        Wed, 26 Aug 2026 00:19:07 -0700 (PDT)
Received: from smtpclient.apple ([212.37.18.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a88ad70sm371252166b.38.2026.08.26.00.19.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 00:19:07 -0700 (PDT)
From: edvard.jo@gmail.com
X-Google-Original-From: Edvard.jo@gmail.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Wed, 26 Aug 2026 09:18:54 +0200
Subject: =?utf-8?Q?Whatchanged_=E2=80=94i-still-use-this?=
Message-Id: <3505ADD2-C8D9-497C-B8F3-F7FB46696525@gmail.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (23G71)

Hi!

I was encouraged by git cli to send you an email when using the command =E2=80=
=9Dwhatchanged=E2=80=9D that now needs =E2=80=9D=E2=80=94i-still-use-this=E2=
=80=9D.

For my purposes, I could instead use=20
git log =E2=80=94oneline =E2=80=94name-status=20
Or
git diff =E2=80=94stat main=20

Thanks for developing and maintaining git!

Best regards,
Edvard=
