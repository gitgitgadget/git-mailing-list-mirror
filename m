Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF40A3E3176
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773249218; cv=pass; b=VyWhinGxa7Fsz1uf+EamJjG8PafwwKSt/DdzkP3bT/agmQzzWeXRvkZxsEO+mEZSbq562CisRK0kSYRRZyBxQ0hx+HvgC7loYDTo33QJiIpk6BJ2vPBLJanDqkDl/LhM1P7oEJxzgas0+6GkBPOnrqBk4P5LCXTzOCVrC9YwUco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773249218; c=relaxed/simple;
	bh=HBnoV0e6Nf1fme0nJ/njpVv9SZMOz7oecCTsgYyVi6k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bx7QZeJrB7qNHx2yQo+qtqxP8J2VWO2ng2NuYxzpBPEx41yJiiks/rwmRWuf63zqdrQf8H/LVScEMuG5gwO9fzHV6tbP2d3rHvf/Z+v+bTfZ5d5hBSkk6JrsqjbZbsQcREL1eDs2eW1ciO7zCYOAFE+G1nat/XixnpYFM21XAk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4dpOyBC; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4dpOyBC"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7985ce90542so1023257b3.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773249215; cv=none;
        d=google.com; s=arc-20240605;
        b=EykLOeoNapREupdEDk+pMX345hwu1nx0yq0nmOTNGsof7wwYyxEXBHY4DuqVMRJSpq
         pqKZ+QSIOldelm/lqjTltR+MsFpQtpbZKW6oMyD3Soe4oJ84lSKF+BPz0a2TyUEyiJ8x
         ChzLYN3tshdfedcQOrrs/SxsV2Y1GkyhtX/9ONydyN559lIqC9RiIjc7HoHHexpV8esK
         nDZvTaAyFxMfUw7ksHU8Fn+0ozEL1V4klWrr7yEekT0obJA7XESuDBzMuCuAt8X6fJqw
         +4a4CLvAaspOYfcPlCulLvadMIu8sPpYinhfHI2aSX/otGAk9JfD1XHh+rFsOTPK0vq1
         TqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=fht9Hzi54HmvTI1eImS5sw0mHlLxiKaKt88YdnZtr6k=;
        fh=1CJ/aI/drbvzIs9bbfUod9Bb/qt44Dpsr+bC8reB/yI=;
        b=Fc0aUA3afOy1fhsISQSpWhMVGATxyyZjqux6/MjCn/a5bIbD18aXnLQFAQfcSHUs4j
         apRlssZsLDiR1WpVLaz+rGRK77m+N9QEAjALBqLsZmlC9bzk0AZNGv22I+qRccijjeEl
         n2q1aO2lbTw9D2VQ+9ziMamEQs3r3CsiwH4I5gRmm8yaSklNssOOqSPdnN1m2wFJYyBk
         ksNJdcDazFhR3uFsFaTXz2QovgErMIaToBhnWt01CtX1nwtGrxhbLKL/8Is1XgDg2F2+
         Qf40aXzNQZqfJXo/Nx5UEPwHl8GX+O+XtZlijrFqtLbHFWNrGqsvQ4PnqMkMT+Q/LbUZ
         6a9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773249215; x=1773854015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fht9Hzi54HmvTI1eImS5sw0mHlLxiKaKt88YdnZtr6k=;
        b=T4dpOyBCBlsL3eBd5VPn/MqSA50216FdQcGnU8wNHvwyEWmIhS4FjkdxjBvt0yOtT4
         c/rRGLI/l+ZSAZihrC/tdr8IidWvcu7FevnbMxmMv6XGb1zkyqqZF0bgViLGcalZpmXZ
         HJdHV6gX5IvKL630FIcdJbzpoqAwKBiV3spvAYGb18twDRtIq0v2qrc6QoRFp/esfRHG
         zMVvEqE5GP1QB2waTCJwI7HQ3kkdPMa/DthXj8LxTyzQgCpO+3EeHZZvWCMWSHSg4cny
         DJCVfqIs7OE/khc56V8syIHzMyrXaxdGNV3OU4PXAXCxPGiexJJNjv7CkfPlrEaBMrYL
         zghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773249215; x=1773854015;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fht9Hzi54HmvTI1eImS5sw0mHlLxiKaKt88YdnZtr6k=;
        b=MiX1iBFXYaOl+lavudK3/pIr+EFBdTbxbgTprdaRoVzpCXWxvTWX3ugdpg5bopzItt
         9NCW5x4UybNAUf9WgzTJ4UI8DEI18xQY7GNXpqMW7cF74Wm6/TK8d0RLzHdSR9ifStyX
         F+K163VAa1hw+NYczyK73nOAQTta/qOA6wngwDKt2kwqi/ke9513IdkQiBWEbqEPvVCC
         PLe3bsmkTU0w2GzyiIrLEjirFGrDCJiYZ15fE4x9g293FmmhZcnULoxISRubS0Uh7yEd
         BCKEnOsSpGvjIr8nc/t4qefrZ7cex3g5yeoQ0ZZ6IcC+GiwTLGzAztYNQY9bHt8e8+Mx
         jyEQ==
X-Gm-Message-State: AOJu0YyeGCO8MtKoMSLDrpfuHjEvU85/XMMfHhncSgdYFW68Xe1DEzu6
	T6QkyApIBOqtnexXU/CfVw2i1IiiHT+VzIilZN3IhYW7jPY+EbTKqWqkGs++b92GL17ugVoH+yc
	G+r7vosS8V6wKXCpnTHPSP52W+/rIAn5IeBMuZuNNwQ==
X-Gm-Gg: ATEYQzzv3ryMGcnATOvyxcfSWqe3OMzDhApBGhaDNERwufTrbzoywYnVbaAgQfQObZK
	YawONCY24RSpQEW4FlVE5OcOPy06Mi6Q0+vfw/js9TXyXYfRhC0fnXsu3+szD4bVT2nK9pq+Qpd
	XmhOC5CnOoIrJmYPl0obTwWVDThGXesoMU3Bh8fAMCnb5Z+sukP5AW3Sd1GvHb4ufyjaVYom+xS
	sCmTDEmnFWxPOxU4L7Qa7TwSS39uaL/lQ8xXaDVj1r+aSm7Nc6jZ+SnZadsdsCbO+71naDjYmen
	d7XV9j+9GyPMSg5XPPb998zF0pgCySUEI+xlE57Om4o1IphGG/YUcHq8eT+DlG1OTKgVbBUBXOh
	oNVYyyHz6WTJYxo4OA2ODVS4=
X-Received: by 2002:a05:690c:d85:b0:798:6401:fd1f with SMTP id
 00721157ae682-79917e96475mr30149087b3.14.1773249215439; Wed, 11 Mar 2026
 10:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pablo <pabloosabaterr@gmail.com>
Date: Wed, 11 Mar 2026 18:13:24 +0100
X-Gm-Features: AaiRm53tftzCiFcMOqrPZkWGZhkrV7bc5Qe60CWX66kWuwzvXZGNSMz3suzClrg
Message-ID: <CAN5EUNSxS_A=XT7cmUiQ9bsS5vtzB_KAb8URCzc3X5AzkQci8w@mail.gmail.com>
Subject: [GSoC] question for an additional objective
To: git@vger.kernel.org
Cc: jltobler@gmail.com, christian.couder@gmail.com, 
	karthik nayak <karthik.188@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi!
I'm working on my proposal for
'Complete and extend the remote-object-info command for git cat-file'

While thinking about what else I could suggest to contribute to the project,
I had an idea I would like to get feedback on:
In a partial clone, someone might want to know what blobs are missing inside
a concrete tree and their size before fetching them.

The idea is to build on top of 'remote-object-info':  given a tree hash,
return the missing blobs (inside that tree) ordered by size.

Is this too ambitious to be on the same project or even a good idea?

Thanks,
Pablo.
