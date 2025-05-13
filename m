Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817C424C67B
	for <git@vger.kernel.org>; Tue, 13 May 2025 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747138859; cv=none; b=t9vzDY1VgTMzugMfoGx8C1TerPsCz7B+QH4/cYZw6zZxQYBVcB1ySkH5m9aFQrxgtfnIGL5KOdvu9gcX2XtosH34PTFs6gFalP+W8VLTNih+45o54/a2Kw5qiDr9J39Wy52PO3bVPd+TLR0QVQjoufKjcJS+6bO68Z4+7Zh/8po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747138859; c=relaxed/simple;
	bh=FJGPaOIvfMMGFsTt8ATv5Z41jKpXfkVOMsR8g5hqRbM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mmZVhDjd4T+/LjDLMW8l6KVlcfOX9hpYgaT/a0o0sYMzajWWxw9eWnKIVhZwJptJ5fmGHWlwAcd08FI+alJeZIKsCYIa9JYYG+jUDTF+xwp1FCSUaI/CzVMvVpMzTuyyNOfEgYVr9KAUe4WbZsQYRp0j9RpTa+kxK8ShIlZ3Qi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=jIMt7vlt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="jIMt7vlt"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a0ba0b6b76so3928214f8f.1
        for <git@vger.kernel.org>; Tue, 13 May 2025 05:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1747138855; x=1747743655; darn=vger.kernel.org;
        h=user-agent:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p9aMHDGLeFULYaD1g74xtPsGOYdPM8i9QRXXULreWBc=;
        b=jIMt7vltU+OwKskjXIY2bOfvYh0tZzK+wpWC6ZL2KlRPrre6hgSNgzfZNIG8BMgBt4
         nCjKon8XSxB+Hs1169nGWnLqctmls7QlIdjOTv0OM6WwVeSLQCODP3jNAlDEcIVgLYkv
         KpQ0qL4l+2ob+1LoJ3+8rfVm/Ih3pz3L8dJ3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747138855; x=1747743655;
        h=user-agent:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p9aMHDGLeFULYaD1g74xtPsGOYdPM8i9QRXXULreWBc=;
        b=ClsaVGbD58/o9F0dI2X+IIga5vkAq5d9qhfjZLYj2dfsPztTDZbkVlUzVvDgpGVi3u
         0nAEYA58rmz+zhoNkWzidiR9Py5kgYUTGvQMBZvbHYP1S4Q0CvH4Z/QqLHHCdFBEMyEh
         APWWKTyFMsi++WQ34yVKKdECtazC2MaJdsukbMG3eaqkrbGk014Iem90d+R2jhu8RYj4
         IvHBHG3t2hGvVe6NSG3MeVc2Ecg3X8jMmZSyZ2guuYi0NP3SpvmG3fPCEq8FPS6A95M9
         lzZtD2/iuVa7OtXIqoBkTLweArZ4BbcCs32RntLXGR6FuOTHdG6J7wZZX0LKPHyUU7PP
         F9Kw==
X-Gm-Message-State: AOJu0YwtiBsJQaIu++uGotVfHw4zj/feA8p3pNafpeteTtX3Rkt45tQY
	JLpmc3hiHksDO7wD8egM2CDSK0+PvOYLkIoCRsbFq4wnrx5t9Bk1A45PkYwU8z99KGD7YWHYAbG
	C5Eo=
X-Gm-Gg: ASbGncvBl56DjdJLfQ5+XPrsUFQ1ou2fo1qK+EPiizvpL49r/Wpu1K7Ofld7lptkOb+
	buxX3zu+2igT3j8uXEmEojUP+B4p9aAjPv/JuRor05emJhaNvbZ1xNd4EtmpEZvezfx+qonqXjb
	kNa+523wsZmGMCKdZGYxN2vgWwfwPNkqK5ylTeC45v8HPqBtXzbGkynIEtmBRepq5KoboMmFzhI
	mx/MjSJJ6nn9cV7iJI1oCkZRI/E7uZsXPVuO0dkOszcvHcVsWWxWvSjAO2VmHIhLaPcMzHSBpU+
	9w6mH8qjYK4RFMF1lOguOCCDT1g61jrfjedBhzBp9+FhFkcN0lRoMQ==
X-Google-Smtp-Source: AGHT+IEazzLDeLV5mC1cWiXYvu8zOXIzqpmPXSxhCGC7T28/Ti/rfrkNAqaUFF1/mJfk3N6JCHpsqQ==
X-Received: by 2002:a05:6000:2011:b0:3a0:9eb0:7628 with SMTP id ffacd0b85a97d-3a1f64b57b3mr15721310f8f.38.1747138855024;
        Tue, 13 May 2025 05:20:55 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:46a3:bbff:fe27:9a9d])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a1f5a2ca47sm16111283f8f.73.2025.05.13.05.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 05:20:54 -0700 (PDT)
Date: Tue, 13 May 2025 13:20:53 +0100
From: Chris Down <chris@chrisdown.name>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, kernel-team@fb.com
Subject: [PATCH] commit: Add commit.signoff configuration option
Message-ID: <aCM5JY25NVPgyYRP@chrisdown.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.2.14 (516568dc) (2025-02-20)

Introduce a new `commit.signoff` config variable that mirrors the
behavior of the -s/--signoff flag.

We already have prior art in format-patch with `format.signoff`; this
brings parity for those who don’t use a patch-based workflow but still
rely on signoffs.

Right now people who have to do this regularly often alias commit to
`commit --signoff` in their shell, which is less than ideal -- this
config option avoids having to do that.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 Documentation/signoff-option.adoc         |  4 ++++
 builtin/commit.c                          |  4 ++++
 t/t7500-commit-template-squash-signoff.sh | 10 ++++++++++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/signoff-option.adoc b/Documentation/signoff-option.adoc
index cddfb225d1..0055874e84 100644
--- a/Documentation/signoff-option.adoc
+++ b/Documentation/signoff-option.adoc
@@ -13,6 +13,10 @@ endif::git-commit[]
 	Linux kernel and Git projects.)  Consult the documentation or
 	leadership of the project to which you're contributing to
 	understand how the signoffs are used in that project.
+ifdef::git-commit[]
+	The `commit.signoff` configuration variable may also be used to imply
+	`--signoff`.
+endif::git-commit[]
 +
 The `--no-signoff` option can be used to countermand an earlier `--signoff`
 option on the command line.
diff --git a/builtin/commit.c b/builtin/commit.c
index 66bd91fd52..da98895438 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1670,6 +1670,10 @@ static int git_commit_config(const char *k, const char *v,
 							       &is_bool);
 		return 0;
 	}
+	if (!strcmp(k, "commit.signoff")) {
+		signoff = git_config_bool(k, v);
+		return 0;
+	}
 
 	return git_status_config(k, v, ctx, s);
 }
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 4dca8d97a7..03c20dcb1d 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -181,6 +181,16 @@ test_expect_success '--signoff' '
 	test_cmp expect output
 '
 
+test_expect_success 'config commit.signoff implies signoff' '
+	git config commit.signoff true &&
+	echo "871119" >> bar &&
+	git add bar &&
+	echo "zort" | git commit -F - bar &&
+	git cat-file commit HEAD | sed "1,/^\$/d" > output &&
+	test_cmp expect output &&
+	git config --unset commit.signoff
+'
+
 test_expect_success 'commit message from file (1)' '
 	mkdir subdir &&
 	echo "Log in top directory" >log &&
-- 
2.49.0

