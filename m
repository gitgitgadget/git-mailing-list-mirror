Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61279CD
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 00:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729729505; cv=none; b=adjjoDoz3/02YbtaOk25LYaqBXnEvTWcJr2QWywTuOsBG7iKpxSXEGBem+gCOs9FGcFCwCezIiR6+qqDVDnuI54slJI8ZriK5YFhd+7YSDE50AIHujqIcoX/+7ti38YD8Z+mNCPMSeu6yOTGXSEfVcyF35LMTRNBekZKlIrj0Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729729505; c=relaxed/simple;
	bh=ODO9ScfDkfM0XW0YykHJlR5+CsRtXGN/2dxCnZgwxyQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Zpvb82aNovWIQgZcjt0FnQI6r74qR/PEMblT1ElsFFGtkU/EcX3sRtt138M0SbKZvkVduSunDAIFmjzY7qsMgp4MK0P6xINIBIXJz9ZUM4vGuWj/B4W0NCCGoEVfUIdEB5lKdNlawRnkAAMeksU6+0VWBeHk10L7ASgs3m+UnoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/vLxYn4; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/vLxYn4"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso4572461fa.1
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 17:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729729501; x=1730334301; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tijPZD14nHygSw5Uu1jf8sqx//yURjke4twtsvHYB8=;
        b=K/vLxYn42aZug6Bx8/KQE4Lt2c/TxJp03bUn8G2yC7q0jFbVf6ClzF4ksGD/PUIGbW
         X4/aUccN9TCbdaYHd8gs5XpPKI3WPp0pVEVeHrb1lnmAOzvnSmYDgWyUFqQO+2sQf9+f
         8pgOFpaZfSqGnz9v9BByO9fc+5+gpsD1oGlWLZeFWya0/HoH6CSrksy/oIf3EPS0wz8h
         Ow9li7eibui/FTv3xHHG/SAp/21FXNVMGd7OKITuh2BcGnWu/q/d0dyuBWjR9j4k7rZf
         L2Goq1PxnGEvk52n84x9KRR/kOUTwQ6n6pU8fF004dNdRfex487KwdQZVIjIY5cb1GIC
         EDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729729501; x=1730334301;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tijPZD14nHygSw5Uu1jf8sqx//yURjke4twtsvHYB8=;
        b=cSXH0d73DyfexXn4pG2KuWg4OltYYKavwxny20EC1f+uJ8PXfCwHYH/UH0TlDMlsko
         Ok8axYFNx2JN4oOQqKx1jioRSxSBK9+dnGH6XIVH80TejmBjFU9tbQZlul1ZLaj5tPXL
         bzrIWmXgrpsDOVIP7QLeSH6IyassBjvz1yiLC73LzRSyEBquJi4zkZWRmQdBRDdsR5c0
         pd6gUqKyHvdCS6pIafd3XkvT4BHBPv90OFW/7MkNfeIbhNnIRNXqm5C1gGv0dmM4J7jS
         LZJb+FwS7lXJKPO5nVMuuQtSOOxUzEinlCOucSgJaaAo8IzeJOTPh5rZOcb75c1SIV7x
         KW0g==
X-Gm-Message-State: AOJu0YyYwWEzK3tc3wgtmHqyoPe9+vyCGyNHa1cSic63u0o4pfPznVpv
	/sbxAelXdsmWoh5UTwnaCSSM7VMYTSdqCBG3dU2HbSMBCG03BZOfXA8Psg==
X-Google-Smtp-Source: AGHT+IEKb2yrkvKLyD3Tt+bnEN0DeyftrqG6JP0vg4J0VvDRNtbuCQNenOWAZDh/Pxim54AvokMyCQ==
X-Received: by 2002:a05:6512:1282:b0:533:4785:82ab with SMTP id 2adb3069b0e04-53b1a315e50mr4266770e87.1.1729729501107;
        Wed, 23 Oct 2024 17:25:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370fe5sm537397866b.112.2024.10.23.17.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 17:25:00 -0700 (PDT)
Message-Id: <3daedaeb260eee873c525fbfad5838c933e1e8e5.1729729499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v6.git.git.1729729499.gitgitgadget@gmail.com>
References: <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
	<pull.1810.v6.git.git.1729729499.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Oct 2024 00:24:56 +0000
Subject: [PATCH v6 1/3] daemon: replace atoi() with strtoul_ui() and
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Patrick Steinhardt <ps@pks.im>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

Replace atoi() with strtoul_ui() for --timeout and --init-timeout
(non-negative integers) and with strtol_i() for --max-connections
(signed integers). This improves error handling and input validation
by detecting invalid values and providing clear error messages.
Update tests to ensure these arguments are properly validated.

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 daemon.c              | 12 ++++++++----
 t/t5570-git-daemon.sh | 25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
index cb946e3c95f..a40e435c637 100644
--- a/daemon.c
+++ b/daemon.c
@@ -4,6 +4,7 @@
 #include "abspath.h"
 #include "config.h"
 #include "environment.h"
+#include "gettext.h"
 #include "path.h"
 #include "pkt-line.h"
 #include "protocol.h"
@@ -1308,17 +1309,20 @@ int cmd_main(int argc, const char **argv)
 			continue;
 		}
 		if (skip_prefix(arg, "--timeout=", &v)) {
-			timeout = atoi(v);
+			if (strtoul_ui(v, 10, &timeout))
+				die(_("invalid timeout '%s', expecting a non-negative integer"), v);
 			continue;
 		}
 		if (skip_prefix(arg, "--init-timeout=", &v)) {
-			init_timeout = atoi(v);
+			if (strtoul_ui(v, 10, &init_timeout))
+				die(_("invalid init-timeout '%s', expecting a non-negative integer"), v);
 			continue;
 		}
 		if (skip_prefix(arg, "--max-connections=", &v)) {
-			max_connections = atoi(v);
+			if (strtol_i(v, 10, &max_connections))
+				die(_("invalid max-connections '%s', expecting an integer"), v);
 			if (max_connections < 0)
-				max_connections = 0;	        /* unlimited */
+				max_connections = 0;  /* unlimited */
 			continue;
 		}
 		if (!strcmp(arg, "--strict-paths")) {
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index c5f08b67996..e3df7d86410 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -8,6 +8,31 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-git-daemon.sh
+
+test_expect_success 'daemon rejects invalid --init-timeout values' '
+	for arg in "3a" "-3"
+	do
+		test_must_fail git daemon --init-timeout="$arg" 2>err &&
+		test_grep "fatal: invalid init-timeout ${SQ}$arg${SQ}, expecting a non-negative integer" err ||
+		return 1
+	done
+'
+
+test_expect_success 'daemon rejects invalid --timeout values' '
+	for arg in "3a" "-3"
+	do
+		test_must_fail git daemon --timeout="$arg" 2>err &&
+		test_grep "fatal: invalid timeout ${SQ}$arg${SQ}, expecting a non-negative integer" err ||
+		return 1
+	done
+'
+
+test_expect_success 'daemon rejects invalid --max-connections values' '
+	arg='3a' &&
+	test_must_fail git daemon --max-connections=3a 2>err &&
+	test_grep "fatal: invalid max-connections ${SQ}$arg${SQ}, expecting an integer" err
+'
+
 start_git_daemon
 
 check_verbose_connect () {
-- 
gitgitgadget

