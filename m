Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B438423BCF1
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008688; cv=none; b=m+1CFKRm0uu1i6hnuvdDwwZ0DhZ8MJEYY82LJ8xmXfP+cv/80kfqKEE5wBwCmHic+91Y9mgmjiKbav3etof7rj+uoutPc1/hMCWzg8dWcNXQrg7zey8vYYC9XOOOmuonpVvOuj5sf5D8lMn2xGoENTcb6RA571Q3gV7DYrEVEGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008688; c=relaxed/simple;
	bh=LoTSGANjMmGSpLH3pZ+5ej5Bmfb0zYgjmF1WILTEKnU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NvlnSrxtPy6nJ/Z47gUzkSdK8XNFr+lU3kWFAHIexnLcd3dfnRmSjvg2UPu+cac1yxdnFqceOfo0l1edubKuzKAQBGBMnx0hUHd8nhk+cDkoHezGL8eYmantqI2cmn3H8g4waIP444WSG3wC6mUtewMfiMfnbgD1oT9KQSQNJ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUi1UpQ5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUi1UpQ5"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43690d4605dso54266845e9.0
        for <git@vger.kernel.org>; Wed, 30 Apr 2025 03:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746008684; x=1746613484; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiga9WU/t2oOMYL3yxXDjFE5WJ608nt4mLlgvR+HAd4=;
        b=AUi1UpQ5WNJ1rawB7J+AH2yQF+egfE+1QRDjCLXzw+/d383fRWmHLplzq+5Wd7Kn0p
         FYkzZKs/EePMj0H7ZCPynwO1hz48Ur/3NkwVvrfVWXNSJmt/WewOUZk6Qyc4TSot2yei
         jMi1s2cMTZpG+g9TF89EHa9pJLXwYcZD6BQPpbcejAyuBvGTTu/41LYSWwonNIbyJ40B
         CaXrToFFYBJJpLeRqxstCPNcun/8N6JT62x1JS7kB7XPcvY9nzCDvCwb006L2UTSBsgD
         EVLex5vmb4tj+haHg0hV5oD2vNETJNVJ3antdf3cYajR303mjjTuZNA+FmdRcm2z3Haf
         xKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746008684; x=1746613484;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiga9WU/t2oOMYL3yxXDjFE5WJ608nt4mLlgvR+HAd4=;
        b=eEJNj2oapMtt78Ohbglc1WGuMOFduBMn/kMLW/bu7qCO9yupyGBl3WCrNaH30pBSBN
         DULbFQJWQ7Qkj7jAVfQNy9trKsWHajxfyYjajyaNyt0R7MNRD+7mlYZqx47Hn8ovNLrh
         MtuDf8IViqD9Al953WIOZeCMe6kYKjShEXu5Cbd6H/4pwlCQq3DuzqA4UcMSvMYQHvtN
         IsmJ1yQMbJV9Cb+tEqC4EW0D2zXGY3BL7S1XlGNbypkiFwD3J52TH3vHZrvZlOTRpIKn
         st+X1uGYaS+zvbEyJVK652immXuVo888QlHH7gg6WblLN6+pMKLlVw/WCpoiphgGlkp3
         71UA==
X-Gm-Message-State: AOJu0Ywhx9Anpi+oXNmJSgVCpvjRIDLkWIbff1MUInfXKyds4YGxhhhC
	B3WOZ06G8jHTEA/7bUz45GFFqAir8HBxoWKEJ58sa5a9DcbSDuKPfbPYcQ==
X-Gm-Gg: ASbGncsdlrny4UepNc3x5joQ1WsuVI2yqxQf3gaTFTWDcyCRfQd3v6icsmFgJ1B7J5w
	/XnKDo2okJomoHUXCpvYMLbulsQFGBQSkf3OD5IOstxDfLCP4grXvmPYMfTdrQIeRJll4DyeFLd
	k/7ALsePwPJAoFt7MZJPxh9U3h/idk5xsdq7DIuAp9+rbFpm5eV/r7mR/87BivqYv2XZF3uvftu
	gsGepAsyxMl3FoO73jmVPQ3dJBH3s+hWzUWEVb+o01v7xci9uhSnysmjQOTILvXSI7wA3QTu3a8
	DRZUU3wFj0VOkFHzahoVEo5A00NCjdcuz7uwEUNCkw==
X-Google-Smtp-Source: AGHT+IH9d3FTVlU6De1tb90k0VVwp2es3mVIVGPoW3bY4fqVwVLx71QmFI61/X6TwuWftnp5cWN/WQ==
X-Received: by 2002:a05:6000:228a:b0:39e:cbca:7161 with SMTP id ffacd0b85a97d-3a08ff32de6mr1946344f8f.10.1746008683541;
        Wed, 30 Apr 2025 03:24:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073cbe386sm16360254f8f.42.2025.04.30.03.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 03:24:42 -0700 (PDT)
Message-Id: <7ab1914b8305c6d67f70660d1278085c2e370302.1746008680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
References: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 30 Apr 2025 10:24:40 +0000
Subject: [PATCH 2/2] scalar clone: add --no-maintenance option
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When creating a new enlistment via 'scalar clone', the default is to set
up situations that work for most user scenarios. Background maintenance
is one of those highly-recommended options for most users.

However, when using 'scalar clone' to create an enlistment in a
different situation, such as prepping a VM image, it may be valuable to
disable background maintenance so the manual maintenance steps do not
get blocked by concurrent background maintenance activities.

Add a new --no-maintenance option to 'scalar clone'.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/scalar.adoc | 7 ++++++-
 scalar.c                  | 8 +++++---
 t/t9211-scalar-clone.sh   | 6 ++++++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
index b2b244a86499..7753df3b4352 100644
--- a/Documentation/scalar.adoc
+++ b/Documentation/scalar.adoc
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 scalar clone [--single-branch] [--branch <main-branch>] [--full-clone]
-	[--[no-]src] <url> [<enlistment>]
+	[--[no-]src] [--[no-]tags] [--[no-]maintenance] <url> [<enlistment>]
 scalar list
 scalar register [--[no-]maintenance] [<enlistment>]
 scalar unregister [<enlistment>]
@@ -97,6 +97,11 @@ cloning. If the HEAD at the remote did not point at any branch when
 	A sparse-checkout is initialized by default. This behavior can be
 	turned off via `--full-clone`.
 
+--[no-]maintenance::
+	By default, `scalar clone` configures the enlistment to use Git's
+	background maintenance feature. Use the `--no-maintenance` to skip
+	this configuration.
+
 List
 ~~~~
 
diff --git a/scalar.c b/scalar.c
index 2a21fd55f39b..90ea4da11b40 100644
--- a/scalar.c
+++ b/scalar.c
@@ -411,7 +411,7 @@ static int cmd_clone(int argc, const char **argv)
 	const char *branch = NULL;
 	char *branch_to_free = NULL;
 	int full_clone = 0, single_branch = 0, show_progress = isatty(2);
-	int src = 1, tags = 1;
+	int src = 1, tags = 1, maintenance = 1;
 	struct option clone_options[] = {
 		OPT_STRING('b', "branch", &branch, N_("<branch>"),
 			   N_("branch to checkout after clone")),
@@ -424,11 +424,13 @@ static int cmd_clone(int argc, const char **argv)
 			 N_("create repository within 'src' directory")),
 		OPT_BOOL(0, "tags", &tags,
 			 N_("specify if tags should be fetched during clone")),
+		OPT_BOOL(0, "maintenance", &maintenance,
+			 N_("specify if background maintenance should be enabled")),
 		OPT_END(),
 	};
 	const char * const clone_usage[] = {
 		N_("scalar clone [--single-branch] [--branch <main-branch>] [--full-clone]\n"
-		   "\t[--[no-]src] [--[no-]tags] <url> [<enlistment>]"),
+		   "\t[--[no-]src] [--[no-]tags] [--[no-]maintenance] <url> [<enlistment>]"),
 		NULL
 	};
 	const char *url;
@@ -550,7 +552,7 @@ static int cmd_clone(int argc, const char **argv)
 	if (res)
 		goto cleanup;
 
-	res = register_dir(1);
+	res = register_dir(maintenance);
 
 cleanup:
 	free(branch_to_free);
diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
index 01f71910f533..b9c130db6056 100755
--- a/t/t9211-scalar-clone.sh
+++ b/t/t9211-scalar-clone.sh
@@ -180,6 +180,12 @@ test_expect_success 'scalar clone warns when background maintenance fails' '
 	grep "could not turn on maintenance" err
 '
 
+test_expect_success 'scalar clone --no-maintenance' '
+	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
+		scalar clone --no-maintenance "file://$(pwd)/to-clone" no-maint 2>err &&
+	! grep "could not turn on maintenance" err
+'
+
 test_expect_success '`scalar clone --no-src`' '
 	scalar clone --src "file://$(pwd)/to-clone" with-src &&
 	scalar clone --no-src "file://$(pwd)/to-clone" without-src &&
-- 
gitgitgadget
