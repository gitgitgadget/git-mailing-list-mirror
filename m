Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDC1365
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720447436; cv=none; b=PtdpVecIyrq8MJRP8P0jOOuMtdin89qQtcX5SdtU82Gyxnt9EO/gbc5EZfP9qL0GK2USCghPm1JNMLwNQW0GkAL7h66ed/t+5Htl6qvQ8CSZGpWhyeAx4JMTU8niq2ewxSL4/TDB3cDXYqzw5UYXaYkQqRG8l4NvzTnu6ESK7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720447436; c=relaxed/simple;
	bh=N1CxjlagXxBn20oIC3Pjntcn9LAJaLqubbdi7Dwr7hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FzrK1phxo71rzgii2vJyUmyI8Q4qeZiGUAvslAg3v4Q6P82WDl7XEvl03H7upVHVeO/PQ/fJ0nvG7Cuh8U0BwUABV2jf1axQ+yiDvQqI/ApObcFMWvJs/FoHjgheR91odJ9/VuHZo+kB5SCvVdbXibJLD52LdDHBhSXLY45MVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbLwuV1T; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbLwuV1T"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36798e62aeeso2670661f8f.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 07:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720447433; x=1721052233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=abk342ENXmB5pi2uOFmvMNxcY7aZzqJwGtnLhihASG8=;
        b=kbLwuV1TrY66NlHtbtx1E6yMhMQT5wZ5SiuwxH1+TiCOkzn5AtDaJTuhJ1h0PjRwbD
         HF2iWkdTevLdJTbB/1iWIaOsGnMuQd5ZA+nTV1XP54vusPAyXzk6x86jT/z4MxzGnHqA
         xASZ0Pq3hZmwofD9tiOXB6Sk6hk1bNehAcJgRJ3qzbOkG7w/Qlj2aoWkhjHBbz68UaeZ
         6urrFi2BayEHBMxuc6+GkdKUf6ifUaPDNE3e6mKWpnN71HlpHB8/oM9nc4jZzyAIFJiE
         7h5CVt51fNJGmw32xy4yVReNPBPPN+qx7AUDMcD19fUnW8r/PZMQ0CFPj8JUOU+vjATM
         dPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720447433; x=1721052233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abk342ENXmB5pi2uOFmvMNxcY7aZzqJwGtnLhihASG8=;
        b=qS3ykdg5b98i0kt39qz97Fs0wNz9eXP1sedRMpUiCCOA1eLL0awSsJ5dZWloRSj7L3
         DSREZ+WCp3gWPppPqmKhqA+/UcpC0fKmo3am6Gtwc1p/uCz7ljiYroldDijyhqVGJEfi
         v7YMV9Ns03l3btVwZcw4n3j/B9b1F3kQiGPtdVeRYrJG8xtuZUBiJZTzCVXbo0KoHHH3
         /02Dva0pbKnyAmJ5RFkeXlPInyRiqMqimr4eITDPErH5NUI5oNbMB5Zeiyvh2cdQumAX
         o86iu74woaks5IsAf70x6kVReL9KYOHpx9FLUWMmXFY14hAb1Pv4fWfONu5kjL4gsX4L
         iuNw==
X-Gm-Message-State: AOJu0YwIOrEFQk1IcjQow0dcQ2QifL5mh28oKvzTQ8B2/Am1qiGdhL7u
	jOCbXXzQ6CkjQoDZVnFt4cOaSlwdRJ+kpiOXIICCCxyfRM6v6sb+OXRHDKB5
X-Google-Smtp-Source: AGHT+IE+Vj6hKpzNSy60Z2qg1ZJQiFQLJAsXrJs/F8TkBKfO9nr1OxNuIcSZndHRxxoHJVmU4FzjPQ==
X-Received: by 2002:a05:6000:12c3:b0:367:96b5:7852 with SMTP id ffacd0b85a97d-3679de7ca88mr7436989f8f.55.1720447433002;
        Mon, 08 Jul 2024 07:03:53 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:5fea:3983:97ad:fb61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36794954c97sm13617529f8f.32.2024.07.08.07.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 07:03:52 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	peff@peff.net
Subject: [PATCH] builtin/push: call set_refspecs after validating remote
Date: Mon,  8 Jul 2024 16:03:50 +0200
Message-ID: <20240708140350.622986-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 9badf97c4 (remote: allow resetting url list), we reset the remote
URL if the provided URL is empty. This means any caller of
`remotes_remote_get()` would now get a NULL remote.

The 'builtin/push.c' code, calls 'set_refspecs' before validating the
remote. This worked earlier since we would get a remote, albeit with an
empty URL. With the new changes, we get a NULL remote and this crashes.

Do a simple fix by doing remote validation first and also add a test to
validate the bug fix.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

I noticed that this was breaking on master. We run tests on Git master
for Gitaly at GitLab and I noticed a SEFAULT. I could also reproduce the
bug by simply doing 'git push "" refs/heads/master' on master, next and
seen. 

 builtin/push.c         | 7 ++++---
 t/t5529-push-errors.sh | 8 ++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 8260c6e46a..992f603de7 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -630,10 +630,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	if (tags)
 		refspec_append(&rs, "refs/tags/*");
 
-	if (argc > 0) {
+	if (argc > 0)
 		repo = argv[0];
-		set_refspecs(argv + 1, argc - 1, repo);
-	}
 
 	remote = pushremote_get(repo);
 	if (!remote) {
@@ -649,6 +647,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		    "    git push <name>\n"));
 	}
 
+	if (argc > 0)
+		set_refspecs(argv + 1, argc - 1, repo);
+
 	if (remote->mirror)
 		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
 
diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
index 0247137cb3..771f5f8ae8 100755
--- a/t/t5529-push-errors.sh
+++ b/t/t5529-push-errors.sh
@@ -2,6 +2,9 @@
 
 test_description='detect some push errors early (before contacting remote)'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
@@ -38,6 +41,11 @@ test_expect_success 'detect missing sha1 expressions early' '
 	test_cmp expect rp-ran
 '
 
+test_expect_success 'detect empty remote' '
+	test_must_fail git push "" main 2> stderr &&
+	grep "fatal: bad repository ''" stderr
+'
+
 test_expect_success 'detect ambiguous refs early' '
 	git branch foo &&
 	git tag foo &&
-- 
2.45.1

