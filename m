Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CAA1DE3A3
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402017; cv=none; b=Hnxhfk0N7XDZOmn0subcz0fRqzwc0lutACfFbiLJA43JABf1EwA7rNHD6KFgOZvPBfn66jAk3lileUPuZgdv6HZtwFl+Au+dyWzbmRWgXEBCNjHcKiM4dX5kgOvnySCi8zckdMJyfx4opLkbVZ7wT9oQUhyw5nGb1oA5tMyzl5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402017; c=relaxed/simple;
	bh=7Dhyc3NUtv0QrVTa1FpWqrPWa8Zy5KsDiRYxS27I1L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IP5yQLSRaDK8Ey94Eo70EJ9G/UGj61flpDlQog6TXlrAwiDwHloAX9/gs9UH2cuNQVH0Gsiwm5chf5yhvt+fGmKIAnvP84XTXudT5N9zd+qa6esAS1WSZiT3S8bPQCusqffLOrLY1tQwHp1FfdyvWBAu4KbUQn7yLTMGHmHJQOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih9mqM1B; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih9mqM1B"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so12282038a12.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742402013; x=1743006813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8RNLz0Gcz5ZslsGhdjpSH2+hpo97+ntKNX6HhGf5PI=;
        b=ih9mqM1BW1TBFhgWCmoxlfSEWNnJrv+Q9bNN16Hvx/KoEIa3jJEcRXJXF05Tth3Af8
         ZPyohovTiG2wpf3P5aSsdlKzglDHkoEQ6a3Ju/Ae6hHZ8Xohw6+5Nd5l45zAX5Gndzh9
         WndV9bFS/Hv4qTkFmlu0Ax/4XYuWtGwg+pMW9zjoW+N0TFl1tiI3cilgWOAquILhHAIn
         hmmPAJ+DwUIN62/8OFFu6Bh8FTkD+TLVT8OV5ljJYgojPBMcU9cf5KUHS2YvvQt7r6Yk
         ILDNGZNxgaF4rocUdMHGrW8eGPWfhjuQoKNocD98Es6ysumRPRMuqO5/DTOSZ4l6Sbm6
         bXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742402013; x=1743006813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8RNLz0Gcz5ZslsGhdjpSH2+hpo97+ntKNX6HhGf5PI=;
        b=HZNEGdOhO481vWtZ9ksxch/Svm9p+bahjYtf8xO6Zx+Xj71t2l9UA7IpWqC1fnvnW+
         P8TUCpRzBALE4Hj4QDt44LAi6+yXTGCffk/0aiAtlSWMfj2PaJAOTAnRKOb3HHLz4MC2
         b8rnjb2hoV3iXyISitb8PJUKr1mNUNug5cFwpuDIHWVw5apsMFICDOWMHIMAJjAm/HOV
         ArSQ8QltK0Kk/iuSiL96404QRD5DhcQOhfc/5IhD6lYgQVT2wU1wGjBCkjMWFZd1wkkF
         7b+6HQdE6dG2Uw+JB4DUKyq4dGdwL+ar+dwSyYs97BzGIHZqSAO7fNB9lf/Vwl1GrID+
         0uNA==
X-Gm-Message-State: AOJu0Yz//c5XIpbKcDajphQHjpGQEH8hCV0GR0L5e7qqugrVguhIwksG
	IjQLKrCnp7UUpnwvQ9pKNi5UxCEp8c6GEIwZrkt8seXoOGrrO9lJQf0Tt2jk
X-Gm-Gg: ASbGnctY/JeqMebWN+Tpu/5XqsbisGchWbUVzewY1S/0qxp4SZvF6db4KXiBvxJKJ2/
	Nt+3LdbY2978shyWcIXkvd0eI6mCIJ4YbKfAxdL5q8Kr9Nbz0Vm3TTycT2zA49xIb0/YQE4HYEt
	ZFvQzglfqavvhV9sABuHzP4jAOfZfT/Ti0RZb01tNmXb2qdjSGBYYJO3xOytdJXbtQYbmnjOrE+
	FT3Yw/TeKDLYNqvaNfX9/uQDdMkPrKTILMszwd14FdRTXqkiub2rTLgiEhQRRCOCdN8816X/IYA
	W9o2nF2uZmrYlvO3+XErGX8WJGbh8rPtotNsTGXaA1jh4tPl5eUUMazfIFjBYP1w8xUjjJw/1nc
	rbzE=
X-Google-Smtp-Source: AGHT+IGfykz9Es2EBAO52hmu3Duvxc5DDzaVdYcVDw14r+dMZ3hGTptb0FLcdcOxJyehH2uUyEjByQ==
X-Received: by 2002:a05:6402:40c9:b0:5e5:b3cb:38aa with SMTP id 4fb4d7f45d1cf-5eb80f72b9bmr3312129a12.25.1742402012063;
        Wed, 19 Mar 2025 09:33:32 -0700 (PDT)
Received: from knayak--20220801-595b8.fritz.box ([2a02:2455:8268:bc00:18c8:d9c2:4846:5175])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afe201sm9230977a12.68.2025.03.19.09.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:33:31 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	karthik.188@gmail.com,
	peff@peff.net
Subject: [PATCH] ci/github: add missing 'CI_JOB_IMAGE' env variable
Date: Wed, 19 Mar 2025 17:33:28 +0100
Message-ID: <20250319163328.525284-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <Z9qNNq0p10YJCZYo@pks.im>
References: <Z9qNNq0p10YJCZYo@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CI setups of GitLab and GitHub use a common dependency management
script 'ci/install-dependencies.sh'. The script install the necessary
packages based on a combination of the "$distro" and "$jobname" env
variables.

The "$distro" variable is derived from the "CI_JOB_IMAGE" env variable
set by the CI configs. In the GitHub CI config, some of the jobs are
missing this variable. For the 'Documentation' job which depends on
'meson' being installed, this raises an error since the 'meson'
dependency is never installed.

Fix this by adding the 'CI_JOB_IMAGE' variable to all missing jobs. We
don't add it the windows jobs, since they manager their dependency as
part of the CI config and no further dependency management is needed.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

Junio, not sure if you wanted a patch here, since you already had a fix
yourself. But I'm providing one nonetheless, feel free to drop it.

 .github/workflows/main.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 9959b61ece..37541f3d10 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -349,6 +349,7 @@ jobs:
     if: needs.ci-config.outputs.enabled == 'yes'
     env:
       CC: clang
+      CI_JOB_IMAGE: ubuntu-latest
     runs-on: ubuntu-latest
     steps:
     - uses: actions/checkout@v4
@@ -432,6 +433,7 @@ jobs:
     if: needs.ci-config.outputs.enabled == 'yes'
     env:
       jobname: StaticAnalysis
+      CI_JOB_IMAGE: ubuntu-22.04
     runs-on: ubuntu-22.04
     concurrency:
       group: static-analysis-${{ github.ref }}
@@ -446,6 +448,7 @@ jobs:
     if: needs.ci-config.outputs.enabled == 'yes'
     env:
       jobname: sparse
+      CI_JOB_IMAGE: ubuntu-20.04
     runs-on: ubuntu-20.04
     concurrency:
       group: sparse-${{ github.ref }}
@@ -473,6 +476,7 @@ jobs:
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     env:
       jobname: Documentation
+      CI_JOB_IMAGE: ubuntu-latest
     runs-on: ubuntu-latest
     steps:
     - uses: actions/checkout@v4
-- 
2.48.1

