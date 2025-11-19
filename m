Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294CE2D063E
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588939; cv=none; b=XnPWBoFbm1DberMhHv5+cxJ/GjCDuMiwxHRWFiFvIf58rSfAoC2FDahySmlqf2leDKy6K7/q0QvYvUI1tr+eHPJnirXKObb3VTCR+TKTWl1FBF8m7YvrWNTUJoTq7oZGWiwJw3uwJRDoerrRLcMfFzWSvrlTOy9IhVCVDp68ZdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588939; c=relaxed/simple;
	bh=qkJoezRnT3DruMFvNYJPolqs0lfLZQjZetT2cu0KHsw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pfWfCxFjWW0unFT8aCcpJgkq+Cy3vuk06UCdo1vtXo4OcYVHWQDSoqGBK4WRm1zEo7yIhKj6BhvDV+xMk/ev784r6w6+8RBVttYJ6bHiI5MHUG8v8nGqKfX+T/ZMdmfD1fQVSd16sdJQX2f6JjfOUf4A+iV3fwMpYd6AlPEKBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhjeKK1D; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhjeKK1D"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so289858a12.1
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 13:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763588936; x=1764193736; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=khVKi6YtuucTd1JVVMUEJn+bMagdVPbzAbEP9K9fRtU=;
        b=mhjeKK1DWDGpQi2zir9li8u59EeZD2y853LDLDtMygHqKs0An1xxGvnqgE5319eWvT
         F5YRjvk4sdFKJ+xheUte1CEPk2Z1HezIm7Ht5xRJbgZMOem2js2exydAfTY1DuJEXemI
         cZy/OEZcB9xW3qMsCKrJ9W3F4fi2Iua6eePKg1OFN/QNnuTE/MhoYB10Km9t8XbesLO8
         3yGit/UjGe6PsuHg1lyf5hWSHAmPwt5v71hQrXkM3Y/Dfsc3+/npindWSiPlPM3jQLPL
         nQg7mtau/GqXFW30WJgH1YqJ+NAmnd8cibeCZnrPExhHRadX5KbaR9hLEhVPm25Ue8Fk
         jDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763588936; x=1764193736;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khVKi6YtuucTd1JVVMUEJn+bMagdVPbzAbEP9K9fRtU=;
        b=w6obT7UttnbpEDqtpdVc9hGM/cBQ6L3PIeWmmctN5At3bFlYOBGbgCvajuJPDNphJN
         CSpMUiBX4BYzoQJGSoabkS/p1+i28tJhOiSktoKRGoSZam84FqWbnH14FFYUd0uomaFY
         JDIJTnIN9ZeKzaP7nYcu46/Q20cIhVK+V9Qxdud3HgN/l4GAtg+k7/5ORDVCPOaszQEw
         RWUtWDcfe93X/4nHVVYUqJKCnndXaGCoG3gxVwCvCJioV0/x3AUraPj7g1sJgIZGNjdh
         BR1VfextU3HZdcUr89nQxTgGXIkEpn+m4j9mgW7wrLTbGXiBI6TU7CQz78gmLwzgCRZF
         x1Tw==
X-Gm-Message-State: AOJu0Yz8P18UaUAIw9lP65GJZjcLaVBcCoT1UQ8Omxh7kOrBGtBesITz
	iq3eulDWQHb7IOQ1TBZ5LhPYRYgkuH9LQ/AnfZwAru+V/92rUNPrfOb5q13hzw==
X-Gm-Gg: ASbGncuK6Cmxuq42vxIYCNNWBK6akpnofCRDEWpi/yyugqmauYuyQLNkm2VKIYD99+r
	7GiNOPazapFXkZmRUqfsP/WYP3+cLlRD3PuorNGh6i9rpXBPtcjD/J42IuDjkX135NKVJpsxoqA
	F1YuSBrIf5hJaKd8M6TQeq6tEVufz27BAhV+iulWT+mUbh6e04tC9F4LTDAge/jGr0606sj+9Ze
	lvzCIlSrnDdUnIq2Z8L39biep0PzyfeYFqHaNYF39TW57fkGbBs1/IO+JUp6ps2qYMGfziHuNmY
	LgGCXzGKf29/FwyZVNNb3agqJdTH2rLzdeLFwxIBEDN9w5SBzsH/Ihw1FzSUXIpnAPqw0DP0/KL
	3NcNsreXmc4wSHQ9elkYzkX7pnxHgQj9PHsgLVjVtRkskATY6YP8kz221XsWztW20eVjtDyIswD
	ZixBQY+NX27MASKUv9nt4wqcFCeQ==
X-Google-Smtp-Source: AGHT+IGz9BfzMXdDyn96QzmYcF2gC3hKe2Y2Gb8EJGAipm0WTi5CQ8t/aDNfSMmo+lcUjDGZhHhIbw==
X-Received: by 2002:a05:6402:50cf:b0:639:d9f4:165e with SMTP id 4fb4d7f45d1cf-64536450d3bmr742736a12.29.1763588936259;
        Wed, 19 Nov 2025 13:48:56 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:119:a01c:1871:c4bb:6fef:656d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d307sm528090a12.19.2025.11.19.13.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 13:48:55 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/2] refs: allow setting the reference directory
Date: Wed, 19 Nov 2025 22:48:51 +0100
Message-Id: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEM7HmkC/x2MQQqEMBAEvyJz3oEkEhS/suwhmI4OSpSJLIL4d
 4PHoqi6qEAFhYbmIsVfimy5gv00NM4hT2CJlckZ5601npfMYT2gORxgReIoyi1859CP0SBRTfc
 q5Hy33999P8XYBhNmAAAA
X-Change-ID: 20251105-kn-alternate-ref-dir-3e572e8cd0ef
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=qkJoezRnT3DruMFvNYJPolqs0lfLZQjZetT2cu0KHsw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkeO0ZGzhskr96Oyv9rtk8/dqu6fo/SgG7K4
 wavNXqiSu5JIokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpHjtGAAoJED7VnySO
 Rox/e+sL/jdRqOdXEcUrhklp/t0KmFgvCzZlZ5HGGTu4YKEmy4GTGwBG/56JEvQZTbKp6Bbjdpk
 uiro50FO8/xktye95ps2QHyEOhxY29HBnxeA6a7dEml/VqolXFCO3EiyT86LETEXEwGZchaWu3d
 r2EMBUECTfFkznMsPcqQb756sIklUyRNialgrIep7VRmgGsqGvPlFMJNA7HEuv6H1gIfaUXuEPD
 6PwGy1SbKmUhuhLzqd6Jzh7VHS9Bo9PQyurG/p8LhmDVBeVJYcF0eIYnS62IFoMim5ExcpDKe2W
 wRxtMuJMoyUICMnQvovQM/+trzj9W/46aVgyr7aRPPHGGrZonT1rcGuNVwuz+UBilVpa8ouTPVu
 asb4C8QfAGpefdTl1RQhBcJHPy0Kg0L+0mHOrUkGV22XIeD155tmB2xYGs3Ial+Ld6KSPeTvxkA
 cldLf2sXDqfqM2a4mDuNDGCgAygiz/YLBOiGJYBMQiGWn+X4vum7t/wRLzJ6UjCyRynGfEGj294
 qw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

While Git allows users to select different reference backends, unlike
with objects, there is no flexibility in selecting the reference
directory. Currently, the reference format is obtained from the config
of the repository and the reference directory is set to the $GIT_DIR.

This patch series adds a new ENV variable 'GIT_REF_URI' which takes the
reference backend and path in a URI form:

    <reference_backend>://<path>

For e.g. 'reftable:///foo' or 'files://$GIT_DIR/ref_migration.0xBsa0'.

One use case for this is migration between different backends. On the
server side, migrating from the files backend to the newly introduced
reftable backend can be achieved by running 'git refs migrate'. However,
for large repositories with millions of references, this migration can
take from seconds to minutes.

We could make the migration non-blocking by running the migration in the
background and capturing and replaying updates to both backends. This
would require Git to support writing references to different reference
backends and paths.

The first commit adds the required changes to create a 'ref_store' for a
given path. The second commit parses the URI if available when creating
the main ref store.

This is based on top of 9a2fb147f2 (Git 2.52, 2025-11-17).

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git.adoc |   8 ++++
 environment.h          |   1 +
 refs.c                 |  64 +++++++++++++++++++++++++++--
 t/meson.build          |   1 +
 t/t1423-ref-backend.sh | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 180 insertions(+), 3 deletions(-)

Karthik Nayak (2):
      refs: support obtaining ref_store for given dir
      refs: add GIT_REF_URI to specify reference backend and directory



base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
change-id: 20251105-kn-alternate-ref-dir-3e572e8cd0ef

Thanks
- Karthik

