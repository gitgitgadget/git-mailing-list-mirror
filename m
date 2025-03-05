Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60637214215
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171619; cv=none; b=XF7PDuJhD1nVedjFCwyr5wWkNKx6c30atEaoOrgNyB9YQZkxjF/g/l63OK3sg2p4l+GlNlNIVJ0TZg9VeCE2iUcBOVakqaNzcG4A1z7tj/zCTRcB6BOD9HJiGh8Ob2lU/VO/MftpC4EJKUYMFtKTldE71BOop+PvJCV+PX+tYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171619; c=relaxed/simple;
	bh=HMK5oO24L/4L73t5DIDtLI9Xidk5iBEX/+vvEBrhT/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VlUSTl1fJNIcrMv+eNgL8Q/c90NySTP/mTxKepufy8zwOaDqCCUdw+gP+W2yBhXOPOM/W5Yb11dBNeBrTtZGFBNu79Bn3wTOLCTH81o+Ic3+UagPtLmQahoXFx3M3RA12M4Yp0D5omu2d68mm8kLZZ5Bvwv989+L0mT08SE0Pr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJ2f1rjU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ2f1rjU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2232b12cd36so91683335ad.0
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 02:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741171617; x=1741776417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HMK5oO24L/4L73t5DIDtLI9Xidk5iBEX/+vvEBrhT/s=;
        b=OJ2f1rjUzV72MxgpE/J11bPTrQGn1c77RSDhoJ1PG5j3rTGJM1So/7ylCFEM3TSCnc
         2+opdThjsgDVvgl/g1S60rPadBruZidOTT15wnBsoowS9imfu1KXFHUfWhPdt0jxBgR2
         TOcVbA2jz7e9bS9itEjBuN287SLaQN6/73OmJlht+DrfUjxclimUqu28oR1PTb1YU83C
         3GMOQoMlZM8O7/SHUSyEhWN5nncnbymsSKdmKAXJmFJX/Rx2BePbflHdkUJnondJnNZn
         UspCdftq73pvoMRg+jn7fsXTvrQ5Qvv2+WMSDCVHkXSaY+kmUgVFi0L4usr0C3o3CWfb
         wQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741171617; x=1741776417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMK5oO24L/4L73t5DIDtLI9Xidk5iBEX/+vvEBrhT/s=;
        b=acpoMQ48c2TU2BLl3znXn/0A4DZegGY7DQEXXHxFx7B8HKdehQf0SNUM7m4R6EZcRq
         QjXbI5HMYC/Y05h8EzahOluYYpPLFZFrfUWJI08WxYDooNOBDYoP+c/tPQyMuFP1PUbV
         +z1RdyNOgKizDGm0MQ9a76yelfA+NKO3xoEi4Z4VJXK+yer5mukJUeSFHQqylBJjgu1p
         97ZKJZhgt39wh5huQh5GAMr9hIhjKMGTTwwms7ym603/ZUqSsRPEQz1Gbo5Deeb/qnBD
         NQaOshUzAl2bcIuCZrgCDwKkW/qvNvL8ZRzo7tLRBDWey6cVc8NlXYUT96oEU1J1dS9c
         ENag==
X-Gm-Message-State: AOJu0Yxu9Tk7qPU8exUMoN1tEGthAusrO9ao+CeUxREg5klVIQua+TiY
	IGbpgu93MZhB+a8JEmw5U8y6sU7fAFqSta9brWjB1KKwCq1t5JVcXiCR2xemiMA=
X-Gm-Gg: ASbGnctdkpeQ36yl42ONP0Jaw8w7aGDy9RQQYceIv/l0a8F3a4Dbc/fJVjeIzmQHLaK
	heZynC0ITOMXlkjIHM5m1efUgewEHNSBVAdErx0zIu5CyFxNUxrRgDiOSNYeSuSQ3iQ0jIkLmHH
	kCxvEDm9gm7fBJDi7GPKowA2xhfsxTp8XDH7pNbxFPAPM9F6Xsr6auRZpvIMqq2nDFn787ZsQ5O
	3dGey3j7es7JNqgBSo6NULMuWuGhfc5Jbn5oZWkWacudgFMTZRjzr/DUMnR5DgngWIA9SGsyCfZ
	MqT6dHkgn2/97+CcQGRKcPVppG3STOz18T5gSmb5a6EriwlgBnKLmGk711pmUQ==
X-Google-Smtp-Source: AGHT+IFs0uMaZ4Nvx2QFuRxbVWpJ/vAO5w6+70R1GJqKD6tmLyszfOjH/sXbDMYFXNdOfeVjPN6UvQ==
X-Received: by 2002:a17:902:e752:b0:223:3bf6:7e64 with SMTP id d9443c01a7336-223f1c96f97mr48608825ad.24.1741171617443;
        Wed, 05 Mar 2025 02:46:57 -0800 (PST)
Received: from bl4ze-rig.iitr.ac.in ([103.37.201.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504facd3sm109687775ad.192.2025.03.05.02.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:46:57 -0800 (PST)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com
Subject: =?UTF-8?q?Discuss=20GSOC=3A=20Refactoring=20in=20order=20to=20reduce=20Git=E2=80=99s=20global=20state?=
Date: Wed,  5 Mar 2025 16:16:49 +0530
Message-ID: <20250305104650.238392-1-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.48.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,
I have been studying Git's environment as I'm interested in working on the "Refactoring in order to reduce Git’s global state" project for GSOC 2025.
Some basic changes at the top of my mind are removing the 'have_git_dir()' and similar functions or shifting the 'local_repo_env[]' to the repository struct.
I also read through the patches [1] and [2] submitted by Patrick. I can see that we also have to shift core.* into repo settings.

I was planning to submit a small patch moving access to core.attributesfile into repo settings. However, before proceeding, I wanted to confirm if I am on the right track in understanding the project goals.
Could you please suggest some more files I should look into??

Also are these patches ([1] and [2]) an example of how the project should be carried throughout the GSOC timeline?

Thanks,
Ayush

[1] : https://lore.kernel.org/git/20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im/
[2] : https://lore.kernel.org/git/20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im/
