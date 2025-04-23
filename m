Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118FA2918EE
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396142; cv=none; b=b2ltaz7EUKoazbtHKZhobqvW0vaBsr1GbLAKL0I4MSGHPm2IJJ84VFPpw5PKr4eqpYoRxU4BIIPOxyXREt+h5BZcaJCpzVj8Qj2J4S01dhTdbsiRMOQOsuL4i8dA85D3iqPbVHjiX7Y3dpOuV+Y/+3FM8OYTS/EGrqA22HwHrzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396142; c=relaxed/simple;
	bh=uxN3bk2M/NjYM1luzVUtmRA8x6+f12ety2dmlNpmLaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q5K3YJeLSXZYqvipH2Vmuz0xt7PDAYufvfkE4y4tzkOkhOjynO4BAtItIXV7dAhGRiimItFz176/UnWzA9FwjgKP8IWaKhmI03feKYPcbj3gMSTo27eG/ICgmObUv59p963a17z+bA0LvcRrTqS+1SiCy28saOE4l5NH3vCC5tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9QcwhKz; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9QcwhKz"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1033688866b.3
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 01:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745396139; x=1746000939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2v9AhJrIHUcN8jOmJuuFfreQdiXWR6NbIMkIVpTwvk=;
        b=W9QcwhKzds25A9IeEtw49fzBBh/VMnxTIUNMkPsTAkoRTopaMiKKzgf01FUAyYZiic
         Dz2IGcc/qSi93KkqLlk8eG/bMZ4skRSUFt/s99oNGAKEddQdSzy2jhKOa9VmS7ooBNdC
         8F9dw7unfsUvtT+lBkQiRZJXFX0ZbqRfCEExK77BlNFdXdVB24VO+Ztypu4hjfO4BSLy
         gpKvrVBnxnsfdBBuK8zOdST6dqyKw9ZuBVI5ehejV+aiqtU6xbjtTh6mAHkc/FySxhdm
         +vkmJMQUhbkicj5DwQaF2MdYvduEtqkdCULIYMQYnX4CaMWJEod1ij4qjVxVV9veB2NV
         xdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745396139; x=1746000939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2v9AhJrIHUcN8jOmJuuFfreQdiXWR6NbIMkIVpTwvk=;
        b=VTfYegi1MW3S4OqpsLn0K1+vru4ybIu0e5GVt9s+b6sogwpdmYv1Shs7zkgXL/d8Zu
         sXyUFutDqlRUbz+38JXMJB0NxRr29ZyIJR2HIX5n25V+3eRDCOZJiTM6WIQcoB9vU2xZ
         Wi4DNzsumxYBSYw+8HNq7zxlpMFXMGeA5GCta++SZ98nK8n15nl/3j4jSMVANlU7fNF9
         kkqgrKsUqMuuZ2jEsLSSDL+c8eyAQXNEb7uJSu05gWl+mAa5bzwj+XLHnF9D27cqJlXk
         CSBHqiuJ50i+d1BEjr8f6EtkLCAF3EjXYbaepb50LEV68Zm1pSK0lqLs7VCDk4samOag
         oBSA==
X-Gm-Message-State: AOJu0YyDAezFdNR5ytxKntiX6XJHRJ3dwAG6Sca5bhnpyAk6F8lUIK5S
	Pg/eRmBqURtEm95sp+P9IviDs3HSqAYF33D22ai1pZJPMBa+GHOlaIBtdA==
X-Gm-Gg: ASbGncuJox46227jBpPvaQFiQZ6SMHJdH8SKI0DroKwaZuBIpbQ9AXaNLo1rpRVjvQs
	EQ2243ev89aM6pUlTc+mNHvraPor4Zc+NCWoOsQy8uzSQGVH4EZ6crYuwtqKW4VDqt0rlwPhX5n
	l+Wqe6WBpr1ejwJTAbmKJ6w2OVXLQBPetFbT+00NR9J1x0IU1PoEFDegQee81ZHSv49aIKNfg7d
	mY/5d9S50u4Vmf7iSLAhbsxVjFGTesH9hbrnuFB2SijmsB+ipLJjcRHt7oj1xlPN9cPd8eFgfPs
	iPVd84rD2SJgCVvtrtgqBhr1mL6TWNh3K+Gc+uK52VKlJtT2h72lBuGocQ==
X-Google-Smtp-Source: AGHT+IGvpLbMPbe/RHXivBuhdTV0yrX93ZzZoYLBsNqCNnLC0AcNq+1Ru4mn8E7GWRtHpX6Gvl9k1Q==
X-Received: by 2002:a17:907:1b22:b0:ac7:4d45:f13e with SMTP id a640c23a62f3a-acb74b1ce36mr1500860866b.13.1745396139069;
        Wed, 23 Apr 2025 01:15:39 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:8764:66c7:f630:d3a4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec13a5bsm766577266b.27.2025.04.23.01.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:15:38 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 23 Apr 2025 10:15:34 +0200
Subject: [PATCH v5 1/6] ci/github: install git before checking out the
 repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-505-wire-up-sparse-via-meson-v5-1-d1e2be4b2078@gmail.com>
References: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
In-Reply-To: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 gitster@pobox.com, phillip.wood123@gmail.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2423; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=uxN3bk2M/NjYM1luzVUtmRA8x6+f12ety2dmlNpmLaw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgIoahGQ+gUIrjCuBjAILuG0nuxPVoLP8eK9
 Ju2RrBX/FiDpYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoCKGoAAoJED7VnySO
 Rox/dSgL/RbLRCwwjNn4NU7M+uDyONTt+L81yeMYKZjK5B3B34FPQqmnDbT3fnvJ0G8tqrL26uO
 +KJeI46pYkRUIwwpxq5erIzbgED/7jrqcGo7EJrW03JgOvpYBEFlP+LGi/0mgOgxpdScqktj/Fj
 VmlWUgumMEBSXfBdLqwb7PZxTPKuiZ4LEeZWxlEyB1YhjnK2vCmXViX7VfX5kGzxmfK8LFxpfuK
 kZnhVGo/5g7oCIXSlGB6PdRAzA9DfZawCL22g8426HGNrUcHU5VHajeWDlW+lU0g3bucphXMbn+
 LYComoiB/CCyn/F60Ur1PmUG+cjOmaxxhO8s32JdoRFSo0s74RuJjpnCNpRmn016NfylgPIz2Oz
 zqAT9PwEHJpRSDFzCr3RtJLuElH56CiV5JowbGlQj/Qdf+xOd2U90Yml2J5vkF73wYvBGcEGXKr
 3oYPC+PxxrZdbL+WV/bpDN//6Pi4z1yrBESNCqzFT9o6rifDgEK0KSulzS3AWiXP57nmv8ki9e7
 R8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The GitHub's CI workflow uses 'actions/checkout@v4' to checkout the
repository. This action defaults to using the GitHub REST API to obtain
the repository if the `git` executable isn't available.

The step to build Git in the GitHub workflow can be summarized as:

  ...
  - uses: actions/checkout@v4 #1
  - run: ci/install-dependencies.sh #2
  ...
  - run: sudo --preserve-env --set-home --user=builder ci/run-build-and-tests.sh #3
  ...

Step #1, clones the repository, since the `git` executable isn't present
at this step, it uses GitHub's REST API to obtain a tar of the
repository.

Step #2, installs all dependencies, which includes the `git` executable.

Step #3, sets up the build, which includes setting up meson in the meson
job. At this point the `git` executable is present.

This means while the `git` executable is present, the repository doesn't
contain the '.git' folder. To keep both the CI's (GitLab and GitHub)
behavior consistent and to ensure that the build is performed on a
real-world scenario, install `git` before the repository is checked out.
This ensures that 'actions/checkout@v4' will clone the repository
instead of using a tarball. We also update the package cache while
installing `git`, this is because some distros will fail to locate the
package without updating the cache.

Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .github/workflows/main.yml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 37541f3d10..e9112b3a64 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -414,6 +414,20 @@ jobs:
     - name: prepare libc6 for actions
       if: matrix.vector.jobname == 'linux32'
       run: apt -q update && apt -q -y install libc6-amd64 lib64stdc++6
+    - name: install git in container
+      run: |
+        if command -v git
+        then
+          : # nothing to do
+        elif command -v apk
+        then
+          apk add --update git
+        elif command -v dnf
+        then
+          dnf -yq update && dnf -yq install git
+        else
+          apt-get -q update && apt-get -q -y install git
+        fi
     - uses: actions/checkout@v4
     - run: ci/install-dependencies.sh
     - run: useradd builder --create-home

-- 
2.48.1

