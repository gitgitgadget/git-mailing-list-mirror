Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242021B5EB5
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008685; cv=none; b=Csa3mU3C0/bLOQrBrhd7RXDFxLQfSUlKL36WiOzMpaZoX1ddg8b4ytdtzDvdlcV7o6YfeIgH+2IJr81r83XNJ+yaydeXLoowb+J8hKiaQpipocEj+mR/SxLTZSS8l6Hp2W79I0bnr+ZNimC1C3RxG/XxUv2MHa1CazQv16N+wuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008685; c=relaxed/simple;
	bh=iLkylyuzF0eK9WoA/7n2u7COOsu4/kV4RjpbyYyM4tE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=VjHWW6Dxmvpjr0rcJU/dZU3pHxGJy0Eusziag5r+D6emxbIFJCYlDjMoXd1kySruqKPU4W2J4JrUJFZphLfO1s3CWKwfgWHbPdN58JrsMoQ7xi4fWvUITwptYPaJW0kk4XmehSsfvhbihSM7n7h1uyYsCmIx85p7PvManfBR3cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glGzUMeG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glGzUMeG"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso69633445e9.1
        for <git@vger.kernel.org>; Wed, 30 Apr 2025 03:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746008682; x=1746613482; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lu+bYJVCCp9ECrotOw9FwTvNjr1tc7g0f766V3IuwRA=;
        b=glGzUMeG2dndpADpWRqiyUhTH7SProMaP4maCilURu5wa8Thvp5IoCvB0igd2zRcfy
         +40xJI/IkdSIXTQfpFAyZ/6S3h7bKYda5pBMiA/sBBpX9vZqkb3sjmU9tGDHbQO0wRTt
         efojlGvCf7eaKTh61U9kbPZx8dccSV+tAof4EKYqmdbOuaQrfb7+NIa4UPDWt4YE0QPi
         fwPpu3CGCRixnAUjdhWT9abAp402Rr5Ia7uwqOecz9T3dXFGo2oJPjb4XWYqUM7n3g/E
         DxGh44FcMG0BySSjTQqX84OgxBYATHiLQwhFgDWL/ZPt0cqv2y8P59VdMlpqkgj8Jkg7
         9V/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746008682; x=1746613482;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lu+bYJVCCp9ECrotOw9FwTvNjr1tc7g0f766V3IuwRA=;
        b=xLoIC4j0Kr10gC8f+pNR2xxJKfQaBel+9J/d59y7WQRFVeqTHnVToLpjYIBArHqrMi
         bdyrZnrHJdKVk4ficXdM1UMYz24Bg6qMlXcEYsD14zly78qKp9jU+yVzBKGMQcUodY1o
         RdjTBKqGEzE3HtFU08OS53m3xhZBxzDf7X6xd0SYfSMeOBsRXPtMhsdudrlKidcZFPPY
         pa7JPw7k6iLC++EGGKhTXRkFsh/EQzpXFHUjcohOSH3NPEX1MZ/gH8tw6Uj+evVsrOun
         YfXx8OM//luD5Ju2v1NRdpA5GsUcwPPeo+wbx8eDnOjrf/qhgaNFOn4stEyMPm7HbTXK
         w2+w==
X-Gm-Message-State: AOJu0Ywlra81OUu4oMFABhnDJI4wJ9k+pMLjyqs0wNblUppxlr0OBBsf
	/Ihan2hv3JkEHbb21prSKVpvyKaLmdocj1nw8Tb1+Ehrl2ngK9IfHAMX+Q==
X-Gm-Gg: ASbGncslBmKv4UmGYoNUPYWZkAx2zMzPf1zGruogZcCne/4airPGT1TBkDrIxj6dSzk
	vgVB6EnvQMWYDfU+gXiuBSvJbA6M9BlJUPfK3YT8xYTb5XrG9NcYjPJ4yOFernoS5xzF0Pe81aH
	go7tZzVR0dvIW56u1Q5fyKtl0akTgz7uQxnKVj2d1kmBCA1P1godAtpx4qZ1FNkDkPViBz/7DXZ
	LqfSE7webYHGYtqK/Pjiy5clDSEQTz7x5SBeQ68Nhx5Voa5O9t0hOMzGMf3/JGH/6yc0NcDWFjc
	u/ZnqmSgC9Nr2+Vu7JtftjIWGrDGBm+OotSHcd7GjQ==
X-Google-Smtp-Source: AGHT+IFsrw9D6GrHF1yGJ3t0SQqBgEtygO9KePI7jRwx4cU1/vdQmrzaZKga1DkFvWw85vg6R3fdzQ==
X-Received: by 2002:a05:600c:1d10:b0:440:6a5f:c308 with SMTP id 5b1f17b1804b1-441b263d5b6mr15037815e9.13.1746008681700;
        Wed, 30 Apr 2025 03:24:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b209a4sm19806925e9.30.2025.04.30.03.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 03:24:41 -0700 (PDT)
Message-Id: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 30 Apr 2025 10:24:38 +0000
Subject: [PATCH 0/2] scalar: add --no-maintenance option
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    Derrick Stolee <stolee@gmail.com>

These patches add a new --no-maintenance option to the scalar register and
scalar clone commands. My motivation is based on setting up Scalar clones in
automated environments that set up a repo onto a disk image for use later.
If background maintenance runs during later setup steps, then this
introduces a variable that is unexpected at minimum and disruptive at worst.
The disruption comes in if the automation has steps to run git maintenance
run --task=<X> commands but those commands are blocked due to the
maintenance.lock file.

Functionally, these leave the default behavior as-is but allow disabling the
git maintenance start step when users opt-in to this difference. The idea of
Scalar is to recommend the best practices for a typical user, but allowing
customization for expert users.

Thanks, -Stolee

Derrick Stolee (2):
  scalar register: add --no-maintenance option
  scalar clone: add --no-maintenance option

 Documentation/scalar.adoc | 15 +++++++++++++--
 scalar.c                  | 23 ++++++++++++++---------
 t/t9210-scalar.sh         |  7 +++++++
 t/t9211-scalar-clone.sh   |  6 ++++++
 4 files changed, 40 insertions(+), 11 deletions(-)


base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1913%2Fderrickstolee%2Fscalar-no-maintenance-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1913/derrickstolee/scalar-no-maintenance-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1913
-- 
gitgitgadget
