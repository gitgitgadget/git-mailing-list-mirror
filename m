Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F008C381AF4
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 20:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789331197; cv=none; b=PTZXM5vc3igOJpDyeb35Jp8U296JN9+HL4AxYSQ9rvR56/40o+b+Ku9nwT8sJninoHyxzLpnfcRQAVPfm2PPHQS3DzivX+Q+hpmKHXzGFGLy9ZjWA21IPqKaO0Q/2t4s9BS/tmwyIICo6D9qN92AYKuLs5cfTcCYUI+2o3FN2HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789331197; c=relaxed/simple;
	bh=8Rfnj10QYYe6+JEzrwMp97zehC7lZ9YXhUKaFt2ExNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vCebK9RFPxBdYlN4UWawNdY97yfPLQN3bJKneWnwtaHhfCojhU06Q9HJ/oZjcAWx0hU5kc/mS5eScsRXcCLXYdMANL+i/k0JbJcS7wDS226p60qU2RseksO2LLV7SBxq1dyvyRvJkcfMGpyLIRcL+4iZC+p8G17Cp2I0Hhr2Z58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQeisYJY; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQeisYJY"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdcbso9643857b3.0
        for <git@vger.kernel.org>; Sun, 13 Sep 2026 13:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789331195; x=1789935995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=agIqxkFxd5STp9oXSdS57wfZ3WgZXRTfy9A04gGl1Ug=;
        b=hQeisYJYcj38S26yUzAfXaOfwn4pT1K6ly1hesddCsB2jfHzlr4oPBloLVhpAcIVaj
         oi6wNpS+Y1mkN95521jDnQZqPok6dl0oHRb+BAUpmFAPfCq7Hds0t4OgSz5TyDfP41oi
         9dXkOCXn4xWqqE5N+GiyoJWZ7vpbhGBCjP0R9QZ6HXkdI+yqlMcv3c2a3y9G/da8bqYE
         R/iteTEP7XqJaayGLjQr694+cIEkfz6u8v9jmpPSbFXHoZsb899ufRnMapisb1lwPBzx
         ctbHNbwjIqL73dcXKZ9bkNu5UCY5qjYATXNQw7MbevzkPy+z029k4bNS8bh+jyGojg0a
         NP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789331195; x=1789935995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=agIqxkFxd5STp9oXSdS57wfZ3WgZXRTfy9A04gGl1Ug=;
        b=JSBrb4ugpUBcVMDrzHSOJAgnrMMhXR6gZGluV+VbWARqmjTZy+3/ytIXjVVwiKKc8u
         Zo9ebQh0Xj614soC1PKLosMSeULlXu7ccNuu1Ywm/5oWly5Rd5c9q0MPwkwfvN/2Q13w
         QvHevmKwGVAP8WiPXN9/lCly/ACAx1RvNbxvVV+jyPZNZ076oMjKR9dGBkkG01uZPPH2
         5O5eOw2LkdnTIpGhn3p2PROdz/0F7+KdtTNlINZPrB470rLO7KZFasTjKiZ8sOBPcWm8
         Fe5/YufVSZM+PwWIjEi5HwrDWlr52lzDd4HVCZYkAg9FzBvOscf/VyP8G3DZXJTQUF+W
         Sosg==
X-Gm-Message-State: AFuF++lbJ28n+TV1rrQk2YPYdOyjeceRERDlNIGrRN0yF6P8JGP/zNWo
	s58Nf5P05UeJil2xt1vDcvcciB+PK0uccMps3xOJLapXPoD/LNdeEDgLy91FTD25
X-Gm-Gg: AYBFou355mvFpDrS2yVB0OZjGhoQ6SjI/qf9BYnANtFeJ1xrp8MvSxfZXgHEbEnyR00
	95XaEp/hkB1AZ6ZakYwToKzwuXECKUsy7moocbOxBNruWZ33lLsF1z6Vk0EoWaFPXjueVptSIz1
	Ju3oxsE6XX4lZtfjjVnthuHHzCpQ77Sc14Ydz6ApOb5d4MqudRcm4isoZvdctB2/O6UQa5bceQz
	1cKInH4lKCNf6waaPQygIwsxyYu6/vhSvjooTyUvj0lryVtqVI3hQEBtvI7a3E9wev4kH2Pg5s0
	aWJ6jMkZZRk6NJmDrCFDzZGPi6qbRAlrNrOOBXAuELycSVNAowzf/R0AtyyBhq3ux0g1tnoQTAX
	fiD8AI+EiEaPfB+216G/j4GTt+4AoyD+r6wlrjEZbKRCuUw53lX6Ffv0fvqkZf03QybCQeC+u5q
	f7fFQQUBV0kCcwzhzr2WATjnLY8U44TtO7v8eKn+BuAza9dE8b3T9g/3M+Pgnvh2RlrZqS6YoyT
	1kVRY3Omx+BDtqZ4RVMmxI6PkQTdGZu3kSi5IvWO2XrYWooOq2wYWA=
X-Received: by 2002:a05:690c:6610:b0:888:7a02:2800 with SMTP id 00721157ae682-8887a0228a6mr24916917b3.16.1789331194943;
        Sun, 13 Sep 2026 13:26:34 -0700 (PDT)
Received: from jtobler--20250820-SHC54 ([12.86.123.90])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8847db4476bsm30317047b3.5.2026.09.13.13.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 13:26:34 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/2] object-file: fix packfile flush during transaction commit
Date: Sun, 13 Sep 2026 15:26:20 -0500
Message-ID: <cover.1789328612.git.jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This short series fixes a bug I found related to committing an ODB
transaction that contains both a loose object and "large" blob when also
configured to batch fsync loose objects. The issue can be reproduced
with the following:

	git init
	git config core.fsync loose-object
	git config core.fsyncMethod batch
	git config core.bigFileThreshold 5
	echo foo >1-foo && echo foobar >2-foobar
	git add 1-foo 2-foobar

and produces the following error:

	error: unable to write file .git/objects/pack/pack-2b7c2470289822070687e8d64186093a710eaed3.pack: No such file or directory
	fatal: unable to rename temporary file to '.git/objects/pack/pack-2b7c2470289822070687e8d64186093a710eaed3.pack'

If a "large" blob packfile is written to the transaction temporary
directory, it is unable to be flushed during transaction commit because
the underlying transaction is migrated to the main ODB before the
packfile is finalized. To avoid this, this series ensures any pending
packfile in the transaction is flushed first.

Thanks,
-Justin

Justin Tobler (2):
  object-file: lift ODB reprepare out of packfile flush
  object-file: flush transaction packfile before migrating objects

 object-file.c    | 12 ++++++++----
 t/t1050-large.sh | 16 ++++++++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)


base-commit: 47ce80527c56f462cb97db4ca8125342204d3783
-- 
2.55.0

