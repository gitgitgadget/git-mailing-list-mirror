Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F0B76C70
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452370; cv=none; b=fajyJndTuhGpUXjQvRls5z8TjB3gYk2qSN/eppXWVH7Oi5lCc3abM2mXb5a7fDpBcspmCxPZ0U+kDLPOiB14pUwrdR8JbCJcsD/q2mQxwo8nTTeTGOMKKQxjD5EltJZSXA4rN2TU7x7CGf8gBcKs9utCjd2S7RtVkblrNViHk04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452370; c=relaxed/simple;
	bh=fdVQuv9TOvpCrN06+pRua4zPgcZKoVjd3pTWNhzCeYQ=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=Jm6GnI4t0dx6+sBYUaqmrtcVX4+dhJ1V2rGVzeege0AelUVOten1FxDKIaJYmoI6gwqbBgmx8QhAmd3Dj0Ftqa4FXNAYRLtWKLfn1rc4KryzMalrt5nUsLqJ7tTuWILhS3lj0UzvkWXAs6BoyoObEW6gCSbbQ6d4RT91gNT2OEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+VVXVQ3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+VVXVQ3"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41264c364fbso19165475e9.1
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 10:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708452367; x=1709057167; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fdVQuv9TOvpCrN06+pRua4zPgcZKoVjd3pTWNhzCeYQ=;
        b=S+VVXVQ3o+iBtIcpFWFIpzK1YD/4xHnfMHx6xgC9pEV9teoC/wygbxyWt7RcNFdm8X
         ym6lQ+EWztRWoqFMtk3YB6540QvEAPcHxKB68aA89VM9rLOO8fi9nkYQMu8CceLv7LeO
         1S3PdLawTXJsTymF2HX+e5d6sxO1Ys+JqXSf+ipXHss2JB55LPtB7fI4AgeT/jjwvKAN
         mlopELlY4aX+7Nqg8YTLlfAAEhfv7X+cEWkU5ENbk64Y9nnARXRSEcABqrXal4LM0OCe
         su8orCpOYCG2Zd5s9pZwtj819VbjIpASKnMct6VLrvA83TW24bOG3OVyVyD81TzDQbIR
         fhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708452367; x=1709057167;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdVQuv9TOvpCrN06+pRua4zPgcZKoVjd3pTWNhzCeYQ=;
        b=RPJKeSL2QH4Tkga77h1CBzB1vXxfkZs2R3wuIWlmHG9/8mklEuuvTYtds4uN5ippkK
         tMOQchEh980+798ymMAgY/O5+cfsaz1fiFK6FcV90Yl3tFAlWWbl1yueg1o5weoOoAHn
         UblnD7fLDRGQ5YRsEc+rnzO4c6+UvyeatnM5AHzEtJKJXz5VLVCzPZ4+6sMhLbrLDqwB
         ZkQ/oQGurw3JLaMm07I3ei6YyAltJWDex3FUGQZ4h6iIeaQEm2/sX303kH5YB5NisJBu
         hqI5b1vCaFgsNlT0YLLT9n2+X/XaIcdNrABY53Miv3EGa9wj8g/j+1V7SM85SbQldywG
         ha4Q==
X-Gm-Message-State: AOJu0Yz+QfIJEn+5cOs9oN6m07H8CYdfGJHGUg1Q5jmjf/tpIfe6bKn2
	CM13BYDtdL3AAEgK4mFaIjteUMpX78CvIPMTyWINOJitaMmMkEvPDnPJY1ZV
X-Google-Smtp-Source: AGHT+IG5EdGa6jYRDPX/ylSDzaInm+fdHqLA/S4qmdekzBXxOl0TeqCMcvz6tsFCh/zbqrXDWxUkPg==
X-Received: by 2002:a05:600c:524c:b0:412:3d0a:a8d5 with SMTP id fc12-20020a05600c524c00b004123d0aa8d5mr8756001wmb.4.1708452366563;
        Tue, 20 Feb 2024 10:06:06 -0800 (PST)
Received: from DESKTOP-T29D115 ([39.49.142.88])
        by smtp.gmail.com with ESMTPSA id u11-20020a7bc04b000000b0041270be311bsm1808498wmc.0.2024.02.20.10.06.05
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 20 Feb 2024 10:06:06 -0800 (PST)
Message-ID: <65d4ea0e.7b0a0220.2b1f3.7d32@mx.google.com>
Date: Tue, 20 Feb 2024 10:06:06 -0800 (PST)
X-Google-Original-Date: 20 Feb 2024 23:06:07 +0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: jeffreyclassicestimation@gmail.com
To: git@vger.kernel.org
Subject: New Construction Project
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi, =0D=0A=0D=0AI hope you are doing well.=0D=0A=0D=0AWe provide =
estimation & quantities takeoff services. We are providing 98-100=
 percent accuracy in our estimates and take-offs. Please tell us =
if you need any estimating services regarding your projects.=0D=0A=
=0D=0ASend over the plans and mention the exact scope of work and=
 shortly we will get back with a proposal on which our charges an=
d turnaround time will be mentioned=0D=0A=0D=0AYou may ask for sa=
mple estimates and take-offs. Thanks.=0D=0A=0D=0ARegards=0D=0AJef=
frey=0D=0AMarketing Manager=0D=0Aclassic estimation

