Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618191DB352
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259586; cv=none; b=tTTnnQ315WykEKYFwjstQknFEZzpcxcWv6TRsUtdM2tUGpfinnaqVnF5g+97AhhjhbO3/pj5PN6XOiLjbkKJ+0Lr7TagY5HnbFfPsO8ZGDQ4fTN97qBCLdgnbD4JpEUbrI8zeKCWGw0u60v7uu7APQh4tea4PM7gqRHcqCDaj1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259586; c=relaxed/simple;
	bh=53MrBnSNGEyFztSOSWt0itWtqc/b42nJAKSTghDVT6s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KxoEX6+FBFd9UQdKhAsbb/6wXu1nJ40FQa9skvKlsF2aesy1BvnxsyR2wjAbj08TQyQOzRv3yUsxH1gKniWAIgvOqJ0hSJ3M2EXCdgtnlctFA86eAtYGvh65uT/5rCXdGPdOAUHGC+qNKImPcIl7U9gxwEUgtlb8EoXCiV+ZwV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZEzCKks; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZEzCKks"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c973697b52so2603911a12.0
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729259582; x=1729864382; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG5ARXK3Y2BKvKe0Et9O6/iMo0qfhLf+M3SZIH1LvHY=;
        b=DZEzCKks21bU2ZjE7PtUsIcti3qCPfKTqI+fvtxrv8pcbarPGcBhqo+YrE80z4mKHW
         5uEs4mwG58j7QajZVWVcUE80QG5E1A7B+ViULI6OLpesTaqtQr76y+Hq8lgLYLWelBYW
         SssLkdJNjTiU5PLyukJwo7okxeNarBGftMlp/8Wl0UxgtXSuigyu2ocID1pnlwnlgTbM
         QVJwEKEgU076sB2On/s30KVbVzeJgjAueMrOmJUGDpPvNdpORGsoYusQtA0FnUTHKPvv
         ybqG4fa5DkBYlbbwLbhSyuMEiMnf33DmZh8uKZ4OMIT0w3wcJycdXukYLQepqmO8haqY
         useA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729259582; x=1729864382;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TG5ARXK3Y2BKvKe0Et9O6/iMo0qfhLf+M3SZIH1LvHY=;
        b=RlqMYV2SmJbPfvWLL9FphCoS3EuMmzegsumL5qjg6SZzAl/1sG2bVVbbFacaZodjuC
         XlL9Meu+zUe3oB+H1/ONuPb/vV6jq/7VSEgtNIkcPMEbI3imaTwRGvJ/l+t+gXhz2tbd
         gCufoFDVbFMV6gG4YlYA0croIk0aOKELEnXJZ17SDYaEjnrecg9Hh6cB/rTkUPUwrrQc
         mQYIk42LJHGZLhwJhE681E//DUkLIC3BF1y0/oAdOI0OIFKiN9smc14G/A8mKIM1hOWM
         TdOdynvNrwxnAhGdy2oBxeVSHEe3LPBus/L03mX7I0/zadWpc5uY4BBz1M2RUUZRa0si
         b46A==
X-Gm-Message-State: AOJu0YyeTWU/NHTv4ydSBxdtybg2FKAtlOrY5v9/DOeEmTtATyN5Yvxp
	CViOYnOtU9NXLMMX8hvxuYRk2PZoDo+dM9dmWbOBxgOaPChVjZSqMWlx/g==
X-Google-Smtp-Source: AGHT+IG1piFsC65na/Ax2rx7EmbJZd1/OSEFYgUjNTILH/rW6wIYdaXCUBZ0PBXgSRjwik1ycqObxw==
X-Received: by 2002:a05:6402:35cd:b0:5c4:24c2:43e0 with SMTP id 4fb4d7f45d1cf-5ca0ac5821dmr1901166a12.13.1729259582092;
        Fri, 18 Oct 2024 06:53:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ca0b07703asm755339a12.19.2024.10.18.06.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:53:01 -0700 (PDT)
Message-Id: <a333d8a40134f4a06812fdbf85c2b011e9d3e472.1729259580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
	<pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 18 Oct 2024 13:52:58 +0000
Subject: [PATCH v2 1/3] daemon: replace atoi() with strtoul_ui() and
 strtol_i()
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
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

Replaced atoi() with strtoul_ui() for --timeout and --init-timeout
(non-negative integers) and with strtol_i() for --max-connections
(signed integers). This improves error handling and input validation
by detecting invalid values and providing clear error messages.
Updated tests to ensure these arguments are properly validated.

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 daemon.c              | 11 +++++++----
 t/t5570-git-daemon.sh | 27 ++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/daemon.c b/daemon.c
index cb946e3c95f..09a31d2344d 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1308,17 +1308,20 @@ int cmd_main(int argc, const char **argv)
 			continue;
 		}
 		if (skip_prefix(arg, "--timeout=", &v)) {
-			timeout = atoi(v);
+			if (strtoul_ui(v, 10, &timeout))
+				die("invalid timeout '%s', expecting a non-negative integer", v);
 			continue;
 		}
 		if (skip_prefix(arg, "--init-timeout=", &v)) {
-			init_timeout = atoi(v);
+			if (strtoul_ui(v, 10, &init_timeout))
+				die("invalid init-timeout '%s', expecting a non-negative integer", v);
 			continue;
 		}
 		if (skip_prefix(arg, "--max-connections=", &v)) {
-			max_connections = atoi(v);
+			if (strtol_i(v, 10, &max_connections))
+				die("invalid max-connections '%s', expecting an integer", v);
 			if (max_connections < 0)
-				max_connections = 0;	        /* unlimited */
+				max_connections = 0;  /* unlimited */
 			continue;
 		}
 		if (!strcmp(arg, "--strict-paths")) {
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index c5f08b67996..c73c2196981 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='test fetching over git protocol'
+test_description='test fetching over git protocol and daemon rejects invalid options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
@@ -8,6 +8,31 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-git-daemon.sh
+
+test_expect_success 'daemon rejects invalid --init-timeout values' '
+	for arg in "3a" "-3"
+	do
+		test_must_fail git daemon --init-timeout="$arg" 2>actual_error &&
+		test_write_lines "fatal: invalid init-timeout '\''$arg'\'', expecting a non-negative integer" >expected &&
+		test_cmp actual_error expected || return 1
+	done
+'
+
+test_expect_success 'daemon rejects invalid --timeout values' '
+	for arg in "3a" "-3"
+	do
+		test_must_fail git daemon --timeout="$arg" 2>actual_error &&
+		test_write_lines "fatal: invalid timeout '\''$arg'\'', expecting a non-negative integer" >expected &&
+		test_cmp actual_error expected || return 1
+	done
+'
+
+test_expect_success 'daemon rejects invalid --max-connections values' '
+	test_must_fail git daemon --max-connections=3a 2>actual_error &&
+	test_write_lines "fatal: invalid max-connections '\''3a'\'', expecting an integer" >expected &&
+	test_cmp actual_error expected
+'
+
 start_git_daemon
 
 check_verbose_connect () {
-- 
gitgitgadget

