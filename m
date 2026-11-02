Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639278;
	b=xzDpuGpef+SXM/DtMnwSmn4qr0H4Hz04dnOsO63KMBH7TK9FfC/QgUpXkp3jjb+1miwr
	 D2Tmjwn6mWMeqif2NP038Hx+kH973Cy8m1abGTgYMcxGXeFCvQSuh4ibCszPns8GIulUt
	 Oop+6NsEwXpVglR8E6HXgEU5O7FDfUuybB4KPL6cCyKbEQ603V/oX36wtXblOV0wLCBPw
	 B7TV6lyx5ULjlXLIvoMhuUoBmGOMWNsemsW8rZQoufB/cwGW3YZyZqxvOT+imRQ0UALSR
	 nUUerEWOIAQXWZwmMohUa3P3MXx5sgfFRbMlHVMWJxUkQmYuDnjpJ6A+cXaRVGDBLpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=sSa7pmrpQjkKDlcKH++d79kNDmOwX9HUEhEo8rA1Ric=;
	b=dKG23YtkbJl1axWLZ7KfQNrfzB6ny7MsKlTc6cPxogoOoPKKxDz4FwI/X+EGrAh9uK5T
	 zbBDcA55O14PwGWvqzpJ2fkSDeERXiLm4hQ7FQEV7xgrNmsKibJgXTUdm44HRDhkz2MfO
	 oC3YG9It9fUdo9l/HzCgOzkL5ypdPrE4Wc60x+EKD9YbVih2SHniuhXDTr+lAAbvvhl8Q
	 KHWq1lsV5mYQXacQPcKMZEAs0+wpiQE0Gr8f68JcENYfTUeIe+LmIVC6N88PDfpHPSQ8o
	 c4y21//Wg2+5nBvBfgcX4JmmjVMEYiTpKNscQFA7ndNQ8ypmvVQV4SxYwWYo65PaUtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jwu80aN1;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60652606A905
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 17:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60652606A905
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jwu80aN1
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e55db58cfso321567685a.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 09:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793639277; x=1794244077; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sSa7pmrpQjkKDlcKH++d79kNDmOwX9HUEhEo8rA1Ric=;
        b=jwu80aN1IpEK+Vu9+v1/sciMoXrfNJVDFhg+BTT28CIGJqQ5R3ylYOV0e2fYmf0M8f
         g0N2PXL8niI56rQfyIBJWa6FqDz1Rx6q5L11bzJu3oA9XLBLKlSetIUPrVlfbGvVxHo/
         ZB00b1JZHpyJj0Tyk3irPQHhMM3/zmLrGP/r+1FrUHZuLYLUPQehn8WQ5RIMzfgw0ks/
         vZRqz4vSuOqNzAPogp+ElLSGT8KOuOXp+e6ojnZItbJd5cCcThDkDMWzPoJg2eEDCtjw
         9nJVbP5ZfU27PnZlHRS5tJhMUx4zHASO4e6YBhrcnusB1q2jNHiZadmn555kChmJYOsC
         oafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793639277; x=1794244077;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sSa7pmrpQjkKDlcKH++d79kNDmOwX9HUEhEo8rA1Ric=;
        b=rRXM1iKlGo/3AJsMhx6Mkb7Rn+Qgm3CVMigDzb+FBEoJSqzzZ79TeKPkIWyfbnLW4m
         nkhZtw4NADduzMYb+oGutkmbwU7HEGcgScbHD8J3sa3+I4c1oKRr+eKvNUTM8MFl42FP
         x8nsOfB7U77ljFYSSmend9hn3yX7YsQ7vHzLgE8kfnD88sVRGMXnKMda3co8yOB9tqpw
         xTsj9ZKmlCHMAaE6oc1WC9B0pbBNFdZpunAmh3JO65QbsDrPGydwjU0OI0/weID3dBhx
         9Uv/Up6U4RChSfpVVSGaNr2aENUtgXKGVUBv3Z7qM6c2lCBJEMgGlalYUVnBVRgJWeE+
         mE9Q==
X-Gm-Message-State: AFq9FYKeOBhEeejG5ktu0Js8PHLxPr5JIseK3oOaduvQp1gqgPj3zYlL
	lLGDK8dthycxZxTmbqsF2s8id/cbT2K7odLLWjEodV7dPK0jVkQ+S9dQXzwFJIza
X-Gm-Gg: AYBFou2dOYSvX29EESsa8jn2527hu310rQlfX/8dIElLlJxXWI/mNUWcTCj+Rqv9nsM
	Rs1SsxJ5P+5Dxq+uJEsuzVyUVcsHgjou19gXo5Iy/tzrFjYnMU+5ptrxfclBlQeHnY2aZnAtK8S
	TYj3ZmQCo4Cx/r4Jr02cLgwn/n/45aAkhVlmqWFiTMy2G0dr2GluSs3/yG5m+OU1aJZ82W5KAdq
	7BQwtfEaN6/wy3f9No6mdFbK5tuW6yNmweA6vzb4Hnlc2sg14R5/E5F/0KUS+NcA/zD7HgA931y
	e4IexHcJYw751luG8lsdsNmWXbiJdQfg8L06kImSdg7+I2+7QCA4A/CNK/gnRmIkwrk26bVO4Li
	eDXeg4edO9RWo/rZXYzcga87+gdfMvFkiNxfJWojNTefRwFZ30RUj/DoP6jQPzBGpuOUjJ7skEM
	DAgGEA29WvaG7sNi0Y0NKipSj+FKvNbyE6ob5GJMabqWJ9XiIF5YDfLJ+2S6F/BwSck4EASg5oQ
	J+p4+AJ8OxCZNsjjnpq8sP8ode8c0G80loEYMosuofzoX2f62isrEqGOa+emh8FH/ru+CSDYMqM
	xV+iRiJEUcudPTvEN+pT+m5q0OlZQrQ=
X-Received: by 2002:a05:620a:2805:b0:93f:31f0:6a88 with SMTP id af79cd13be357-944217e9062mr1715901485a.65.1793639277285;
        Mon, 02 Nov 2026 09:07:57 -0800 (PST)
Received: from [127.0.0.1] ([20.55.13.169])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425ad7431sm872802885a.40.2026.11.02.09.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:07:56 -0800 (PST)
Message-Id: <pull.2280.v3.git.1793639275978.gitgitgadget@gmail.com>
In-Reply-To: <pull.2280.git.1793099688076.gitgitgadget@gmail.com>
References: <pull.2280.git.1793099688076.gitgitgadget@gmail.com>
From: "Shashank S via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 17:07:55 +0000
Subject: [PATCH v3] test-chmtime: use parse_options() to parse command-line
 flags
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
    Christian Couder <christian.couder@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Shashank S <shashu8660@gmail.com>,
    Cynthia Uche <herroyalpriestess@gmail.com>,
    Shashank S <shashu8660@gmail.com>,
    Shashank S Mogaveera <shashu8660@gmail.com>

From: Shashank S Mogaveera <shashu8660@gmail.com>

cmd__chmtime() currently parses the '-v'/'--verbose' and '-g'/'--get'
flags manually using strcmp() checks and manual index tracking.

Migrate cmd__chmtime() to use parse_options() and usage_with_options()
instead. Pass PARSE_OPT_KEEP_UNKNOWN_OPT so that negative relative time
offsets (such as '-86400') are not rejected as unknown short options
and remain in argv for timespec_arg() to parse.

Additionally, strictly prevent combining mutually exclusive options
('--get' and '--verbose') by utilizing die_for_incompatible_opt2(),
and introduce a new test script to verify both this restriction and
the standard usage.

This migration also introduces the following intended behavioral
improvements over the original manual parsing:
- Position-independent flags: Flags can now be safely passed after the
  timespec (e.g., `+0 --get file` now works, whereas it previously tried
  to stat a file literally named `--get`).
- Incompatible flags strictly abort: Passing both `-g` and `-v` now
  triggers a fatal error (exit 128), whereas it previously tried to stat
  `-v` and exited 0.
- Standardized error codes: Usage errors now properly exit with 129
  instead of 1.

Signed-off-by: Shashank S Mogaveera <shashu8660@gmail.com>
---
    [Outreachy]test-chmtime: use parse_options() to parse command-line flags

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2280%2Fshashu8660%2Foutreachy3-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2280/shashu8660/outreachy3-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2280

Range-diff vs v2:

 1:  43c96de13e ! 1:  512b17b39a test-chmtime: use parse_options() to parse command-line flags
     @@ Commit message
          and introduce a new test script to verify both this restriction and
          the standard usage.
      
     +    This migration also introduces the following intended behavioral
     +    improvements over the original manual parsing:
     +    - Position-independent flags: Flags can now be safely passed after the
     +      timespec (e.g., `+0 --get file` now works, whereas it previously tried
     +      to stat a file literally named `--get`).
     +    - Incompatible flags strictly abort: Passing both `-g` and `-v` now
     +      triggers a fatal error (exit 128), whereas it previously tried to stat
     +      `-v` and exited 0.
     +    - Standardized error codes: Usage errors now properly exit with 129
     +      instead of 1.
     +
          Signed-off-by: Shashank S Mogaveera <shashu8660@gmail.com>
      
       ## t/helper/test-chmtime.c ##
     @@ t/t0082-test-chmtime.sh (new)
      +	test_grep "usage: test-tool chmtime" err
      +'
      +
     ++test_expect_success 'negative offset is not taken as an option' '
     ++	test-tool chmtime =1000000000 file &&
     ++	test-tool chmtime --get -86400 file >actual &&
     ++	echo 999913600 >expect &&
     ++	test_cmp expect actual
     ++'
     ++
      +test_done


 t/helper/test-chmtime.c | 72 +++++++++++++++++++----------------------
 t/meson.build           |  1 +
 t/t0082-test-chmtime.sh | 29 +++++++++++++++++
 3 files changed, 64 insertions(+), 38 deletions(-)
 create mode 100755 t/t0082-test-chmtime.sh

diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
index 0e5538833a..cfcbca75a4 100644
--- a/t/helper/test-chmtime.c
+++ b/t/helper/test-chmtime.c
@@ -5,43 +5,46 @@
  *
  * The mtime can be changed to an absolute value:
  *
- *	test-tool chmtime =<seconds> file...
+ *  test-tool chmtime =<seconds> file...
  *
  * Relative to the current time as returned by time(3):
  *
- *	test-tool chmtime =+<seconds> (or =-<seconds>) file...
+ *  test-tool chmtime =+<seconds> (or =-<seconds>) file...
  *
  * Or relative to the current mtime of the file:
  *
- *	test-tool chmtime <seconds> file...
- *	test-tool chmtime +<seconds> (or -<seconds>) file...
+ *  test-tool chmtime <seconds> file...
+ *  test-tool chmtime +<seconds> (or -<seconds>) file...
  *
  * Examples:
  *
  * To print the mtime and the file name use --verbose and set
  * the file mtime offset to 0:
  *
- *	test-tool chmtime -v +0 file
+ *  test-tool chmtime -v +0 file
  *
  * To print only the mtime use --get:
  *
- *	test-tool chmtime --get file
+ *  test-tool chmtime --get file
  *
  * To set the mtime to current time:
  *
- *	test-tool chmtime =+0 file
+ *  test-tool chmtime =+0 file
  *
  * To set the file mtime offset to +1 and print the new value:
  *
- *	test-tool chmtime --get +1 file
+ *  test-tool chmtime --get +1 file
  *
  */
 #include "test-tool.h"
 #include "git-compat-util.h"
+#include "parse-options.h"
 #include <utime.h>
 
-static const char usage_str[] =
-	"(-v|--verbose|-g|--get) (+|=|=+|=-|-)<seconds> <file>...";
+static const char * const chmtime_usage[] = {
+	"test-tool chmtime [<options>] (+|=|=+|=-|-)<seconds> <file>...",
+	NULL
+};
 
 static int timespec_arg(const char *arg, long int *set_time, int *set_eq)
 {
@@ -71,37 +74,34 @@ int cmd__chmtime(int argc, const char **argv)
 	static int verbose;
 	static int get;
 
-	int i = 1;
+	int i = 0;
 	/* no mtime change by default */
 	int set_eq = 0;
 	long int set_time = 0;
 
-	if (argc < 3)
-		goto usage;
+	struct option options[] = {
+		OPT_BOOL('v', "verbose", &verbose, "print the mtime and the file name"),
+		OPT_BOOL('g', "get", &get, "print only the mtime"),
+		OPT_END()
+	};
 
-	if (strcmp(argv[i], "--get") == 0 || strcmp(argv[i], "-g") == 0) {
-		get = 1;
-		++i;
-	} else if (strcmp(argv[i], "--verbose") == 0 || strcmp(argv[i], "-v") == 0) {
-		verbose = 1;
-		++i;
-	}
+	argc = parse_options(argc, argv, NULL, options, chmtime_usage,
+			     PARSE_OPT_KEEP_UNKNOWN_OPT);
 
-	if (i == argc) {
-		goto usage;
-	}
+	die_for_incompatible_opt2(get, "--get", verbose, "--verbose");
+
+	if (argc < 1)
+		usage_with_options(chmtime_usage, options);
 
 	if (timespec_arg(argv[i], &set_time, &set_eq)) {
-		++i;
-	} else {
-		if (get == 0 && verbose == 0) {
-			fprintf(stderr, "Not a base-10 integer: %s\n", argv[i] + 1);
-			goto usage;
-		}
+		i++;
+	} else if (!get && !verbose) {
+		fprintf(stderr, "Not a base-10 integer: %s\n", argv[i] + 1);
+		usage_with_options(chmtime_usage, options);
 	}
 
 	if (i == argc)
-		goto usage;
+		usage_with_options(chmtime_usage, options);
 
 	for (; i < argc; i++) {
 		struct stat sb;
@@ -110,13 +110,13 @@ int cmd__chmtime(int argc, const char **argv)
 
 		if (stat(argv[i], &sb) < 0) {
 			fprintf(stderr, "Failed to stat %s: %s. Skipping\n",
-			        argv[i], strerror(errno));
+				argv[i], strerror(errno));
 			continue;
 		}
 
 #ifdef GIT_WINDOWS_NATIVE
 		if (!(sb.st_mode & S_IWUSR) &&
-				chmod(argv[i], sb.st_mode | S_IWUSR)) {
+		    chmod(argv[i], sb.st_mode | S_IWUSR)) {
 			fprintf(stderr, "Could not make user-writable %s: %s",
 				argv[i], strerror(errno));
 			return 1;
@@ -126,7 +126,7 @@ int cmd__chmtime(int argc, const char **argv)
 		utb.actime = sb.st_atime;
 		utb.modtime = set_eq ? set_time : sb.st_mtime + set_time;
 
-		mtime = utb.modtime < 0 ? 0: utb.modtime;
+		mtime = utb.modtime < 0 ? 0 : utb.modtime;
 		if (get) {
 			printf("%"PRIuMAX"\n", mtime);
 		} else if (verbose) {
@@ -150,14 +150,10 @@ int cmd__chmtime(int argc, const char **argv)
 			}
 #endif
 			fprintf(stderr, "Failed to modify time on %s: %s\n",
-			        argv[i], strerror(errno));
+				argv[i], strerror(errno));
 			return 1;
 		}
 	}
 
 	return 0;
-
-usage:
-	fprintf(stderr, "usage: %s %s\n", argv[0], usage_str);
-	return 1;
 }
diff --git a/t/meson.build b/t/meson.build
index 11b3752f00..004bda52c1 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -128,6 +128,7 @@ integration_tests = [
   't0071-sort.sh',
   't0080-unit-test-output.sh',
   't0081-find-pack.sh',
+  't0082-test-chmtime.sh',
   't0090-cache-tree.sh',
   't0091-bugreport.sh',
   't0092-diagnose.sh',
diff --git a/t/t0082-test-chmtime.sh b/t/t0082-test-chmtime.sh
new file mode 100755
index 0000000000..f1a9d6c466
--- /dev/null
+++ b/t/t0082-test-chmtime.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description='tests for test-tool chmtime'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo hello >file
+'
+
+test_expect_success 'mutually exclusive options are rejected' '
+	test_must_fail test-tool chmtime --get --verbose +0 file 2>err &&
+	test_grep "cannot be used together" err
+'
+
+test_expect_success 'missing timespec without -g or -v is rejected' '
+	test_must_fail test-tool chmtime file 2>err &&
+	test_grep "usage: test-tool chmtime" err
+'
+
+test_expect_success 'negative offset is not taken as an option' '
+	test-tool chmtime =1000000000 file &&
+	test-tool chmtime --get -86400 file >actual &&
+	echo 999913600 >expect &&
+	test_cmp expect actual
+'
+
+test_done

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
gitgitgadget
