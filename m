Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085F3033E6
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792132120; cv=pass; b=FRulXWmhio8vlu/iMleRIsTIXZ++sr8/iwh3QTNmDu1xgeOAqZFR7XbxoUB8EQ6sxMcKvGGPbEvIlje/qxIDHVeA3rqbGdU8JsGKI6jNtYf5UtVFhqMjqJlLzcgco213cSVoTrclFgsVWqC115vcMW1GPMQtRnRPUGV4czY3VQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792132120; c=relaxed/simple;
	bh=bn30EvuXia+UHOSaw0k9UhG2LmBeuHtEGP9xxTbPWwI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hv8KjaOEjg7Oo1kmC8zm1rbQxIviHhV5n55qdPt3O6p8M9jTooIzCmlIUOLJdFvfFnBk7J9JbwckPjHo4fW2JQ5ZN0FnNA+2gp0cNtPSoHK9DMQgOpc/xj2xJPC+gCUAugm7hFRQvTtd4eIUorgiR6kmBPGlfcbUwfGj4jq3X7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yd1t5Fo2; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd1t5Fo2"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4f14642adb4so3031634b6e.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 23:28:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792132117; cv=none;
        d=google.com; s=arc-20260327;
        b=lXKs2EOCN/Q/1zMbmEVgwqhmsf8ESbZHd0wRCaC9GztKiBo+cBnp6G0k8V3T5fxghU
         /3mlOqYuEi4CC5bjBqlEYO/3Ztz4xYon2/3s4/ndLeD23tU7jrlk2xJ8MLynyDUw9irY
         bRdx+6Kmfvbg7ipxtf2QoG9S6hxLzdFSlti1chFqYJvpYxhM78Yq57VRQmvAtcUTQ0cW
         3xerpDj2fX7BTmkaZ+x3t1zuOS3ajut+ZO6nCYzsDfpjyNZzOC3CKl+k5ftebB8zepqa
         RZFGbkKKYZbgDwou2ULsoP7YCG46jY5K0UJAu22pmYIozEMgGgvDqEW021/6HSHU5zng
         VSVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=bn30EvuXia+UHOSaw0k9UhG2LmBeuHtEGP9xxTbPWwI=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=OVC5tLmAz4/P3S9P2B053ST13LNXt3NHw5kXKGL3esPRcj3H+3N4b/CBXDZiTj45HB
         bFf/IjkVqtxeuJONQUOoyVKRe7OKUXKGZQ/jgVhcjJHsICkojwPyqzEjwr9rhKzyk9qL
         iW8CzArMsM9BEpDV7LrTaZpjIDqZBlbR53TJlSPbTwSrOeVMzEpzGqssCDgxiNXpmW/R
         rDuE4TUVlkZ9jOCqAHSys6OB3W4CXceAevvTKDZCn0CchN52CV9SDApbzl17fgxauFbp
         IAfb1mqW3Ol1chBh39JhAEQ+CA59hx7gvyCcAe1Nr7MLG+KrFj3mN4JeYXkOfh1nwOd7
         ss3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792132117; x=1792736917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bn30EvuXia+UHOSaw0k9UhG2LmBeuHtEGP9xxTbPWwI=;
        b=Yd1t5Fo2uFAKBfch34QYWOArI53jxM06vpHdSEutR4FeTvzwrHDZw6E3Avx/BFLH+9
         ubN8due+r94t0yZDzymqqw6PoW+md3GdWJzaGptQeW2AC1toijt3Xrrf0zo0QHhHQPAe
         8O30155Qs6+XzwEbqCUwkY121fAaPckSlY/rNXjsREcfP4BQ4KJcVqiWjbuBZZX4WDK5
         KeKuSkz6ijZSZ0ejhwQLiYgeBUlBXUJS+S9E+4/hfPXK3J8AIN2OrLqZ1F1YMqxSqPh2
         fkY6ofk8OJQBgRBG//ONdS3F7AT8gbsA7S5fivyEYxIUtfAtQ7BKcRVcw7rFshgSbMeh
         3L/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792132117; x=1792736917;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bn30EvuXia+UHOSaw0k9UhG2LmBeuHtEGP9xxTbPWwI=;
        b=DxIco9KTpa7iEA1+vGEEbrAEMT/y+vsKCB84vaPV5h0BOopiiBqzWat0lqjkCID73H
         lLEiEQRW4Mfs1T/dWJe7jsVpyWLwifSBOqxZhgxSSUKp0vLTfD0cDArYDFmkZjIf7XFQ
         s72Etx8o/Nb+yQb7JhbatsuxGwNTTCWvBXvjl51xoZf7jyPnrOz4jpgrzwkeSVQOSQQt
         yqF1Jr106CCkw63UW9hklL9cyp0tVLS3/qr8Fhvp+jQnzk3FLXNLDP4rRDocZ4wmR0hY
         isqtBvqmz/gZ3t/Y4mEOuZrFKx60wwy6zmWnkxQ0ifT3aL11BIpxTF8tEDOHKRNz8PwE
         rv6g==
X-Gm-Message-State: AFq9FYLe6zblGN3YcOjiGgMqvMDdTwkJVu0r/Bvg4lkW21X/PmutUkyf
	BOz10mfWKIRtdTUXEtETl3a8eFPi3Var9jIGs+ZdlcMscnYrWbPsR+REmK/vqiP/Vi14BVpGMRP
	5hJPol4JWf29rojJFPWEwmGNxSLkrjIEr4++o
X-Gm-Gg: AYBFou2V16moyzOfbfxIBpERB3/bbB+w1pI0OJDPO1ZXtoiSwPk4HOujWc10J9Em8Kt
	mbY7a5X89Z5ZMofRyAAQXYM4cK1vX39X0I8wUGRJ8xsd0EEs5cpJrpXR4wz3YifrQOOGz8uFzYR
	+VnwMaCkSixRRxrzmvWliGOS+8rUjrlupi9jY8R1SlN6TEDBTsuuFneiW9pSQNc9zx+oNYs0gsJ
	J5mg2gGQNiHh7B12YpwPRz6yUQSsSRLfcZ5VxTe4rkgU7A+XnYM7c236Ru1NlAva3nH/096FMCH
	ITuvJRbBtU2mh151RJUXZkA57BsoswGMK+lodrNlw/pwbzLQJZBhddfvctWIzMCAudJNbd7M1Cr
	wbaBVPPcZ/Q==
X-Received: by 2002:a05:6808:138e:b0:4f7:f874:8cac with SMTP id
 5614622812f47-50c57a6c361mr19337494b6e.66.1792132117588; Thu, 15 Oct 2026
 23:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jane Irungu <irungujane613@gmail.com>
Date: Fri, 16 Oct 2026 09:28:25 +0300
X-Gm-Features: AclHuK_Xb6crVenbRvesgnvghq31AI8SlaH7yyIobPhpR_W1Rj_c5JX_LvBiZ0I
Message-ID: <CAKHXE65c9aLYsj_aYqbbkjW_1=7J6iVGTGAZNAWUhU2QaaD7ow@mail.gmail.com>
Subject: [Outreachy] - Jane Introduction
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

My name is Jane Irungu, a software developer from Nairobi, Kenya, and
I am an Outreachy applicant. I=E2=80=99m interested in the project =E2=80=
=9CReduce
Git=E2=80=99s global state to enable Git=E2=80=99s libification=E2=80=9D an=
d would like to
start contributing.

I have written C in a university project and I am comfortable with the
command line and shell scripting. I am new to Git=E2=80=99s codebase and to
contributing through patches on the mailing list.

So far I have read MyFirstContribution. I would appreciate any advice
on good first steps or a suitable microproject to start with.

Thank you.

Kind regards,
Jane Irungu.
