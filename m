Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350344;
	b=rbYdYgMZ2uMXSaiX4neXgGhUD2tGOulfOnPiYHsizj4eTScqM8+bayXPcGZa3dopoM2w
	 lsgLmsw4vc3r0WUHFHS+eUZZH8hoRbfr7Z/aZNyrsInAI1rT9RHsO4iKHXyq20RLTNptq
	 JGSwPwbva4/8kUP2HrioBvER2P+E/+PRYJMiUQxNszAAC69vS04gnIL6+ha1N/+CUOIxi
	 QzGfbvN74FQTK5U2v8vhvnvVmJUzpSxT2mZVBebIYnE9cjHnyega/y0bOWPVOU8oWzO/5
	 1mcJyGzoji8G99mu9j2pyHJblD5YFtWsTsxm5w5VkA8Xpmk7y+2iifV/5bk/A0HIRZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=MKvawX9F+ZU7Kv5mbXuWUSueZu9ojF6pDJ7s4piv8ZE=;
	b=DWsx+nuP4kRUm2CZzE+EHtfrSdkx32ZulpDx75A3jZ88Xic5kZK0vAmd2GE6wJXxI281
	 og2rN+aLkz7oirqruUaB2lj5QD0j3muX192DNPikqOhuwhfL/g6lUZBkfnXdRjL/uO3FR
	 Rca0Ip5PTVswpAH0dVLuvD40KMz6DEpio88cD8E3n8C5gIk26HmVgmZzdvMbu2O2KwJhD
	 YBpRIF5oznlXF2VJqXtteiXMhF6ClE1BtfHbQNDOcqWOkwQaiajphA8nSEixTpoVStGXm
	 RlvdELOW+6dENhSXJPAmoedBHI0INNtkE0hPhezkQLCghWTkXYi56ddEDUvyKIEHX6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ujsFd0T4;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEB9606A322
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 08:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FEB9606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ujsFd0T4
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so178549a12.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 01:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793350343; x=1793955143; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MKvawX9F+ZU7Kv5mbXuWUSueZu9ojF6pDJ7s4piv8ZE=;
        b=ujsFd0T4x0PnuTPcfH2y4NkcxWIxdljyRb460su0azR2eG3B7Ubch3em7wGriP96vf
         XtmEAr354gFIPZXsg1s/CWce7/OXPJEjHx9usncqq2D4U4QTUkz/MaXwcVR752EB2qdX
         ejAGp7TKT70IqwBX3XIgC1nSzXkuPIIkUzdi0V+PAWYAMFbUpUP+XFHJqlE6dwUipurl
         zKQbFRdXYX/G0okMleU3HBbA5qChKxdFE5OcrHhJjZxg2z7A3CfMJrUkLJcR5oni3hM2
         OcGR2oj+pDh6+Bthxrkcba0hcRVgl7plnEMT06zefSKQsmHkvkJ4u74F3MdNGrNzCAL8
         d/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793350343; x=1793955143;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MKvawX9F+ZU7Kv5mbXuWUSueZu9ojF6pDJ7s4piv8ZE=;
        b=idYKRFQ712UsaQRtlGwSNTJswcYI85vFf9ZAc+ziqvvXjemJhlUsyiAIhfRciaZAFQ
         HlvthJeEBd44gMRl8CU6cgUgPeAk41AwrQpf8KVT6/HAkkHGny7qsb4+SCZ0Pvq0H3LZ
         rbylBxJhKMIBiKKH0g+DIp8JuRcuFv5fxTlQCSBpc/QpPOcPt6K06deDeUM42Rg8Y8Qa
         L6uz8Uf2HGdv0KLS1uhemZtdbUql+vhBg6s5ueUPKUGsEPZzzQ9n1mD1Lix5rYCa68FF
         CXBGbWIEnhfX8RPaQIYbdHatkBGERGICfDbUbjpKyAad3drx3uk5nXJZKBliwB/FDa/n
         xj1Q==
X-Gm-Message-State: AFq9FYLbupxZI3kcLH36p8b1z4hxwZa9g/7ps55GzTzNbG3RKo0v+AD/
	bHEAL/l/2wAFgV/XrDRpNs94CwItA2cvdHlRlSA1MFy2V4TPm72cNdU1gK0Psj2V
X-Gm-Gg: AYBFou19z9OCfUhuC4CRSyThX68r+alDFCEoA9zeLmaDQs2liCYBeMsZtTENW4riBP3
	DMNKo9c+BYkNoE7j33zC4UH+F0/DZjnFFIsXARbDLC40unmD8Ay9RujBLAgwh8fjPhRRTU1hQTP
	8Fb6GEAqr0K+9AFKapycabuP0MtuyZqib2G3UcL/RS0jiRllb8xmke6cg7o9eUCvFEP3ZKh7YBx
	RN76XAYL3V9o1rVzL2MdoEvGWzl5HxEOuCS679Qm8xp8Nb+cLu/A/1e3BGmdYkWYJDo+z5Zf195
	3emmAcSP73NT8uy+JkAF4Vkra+5vvaS0IMvUYSM7nnTGuitrgyXBsy8iI0JGekKdRm/w1V6xLup
	QrQRWk3ZS8I4AHqcTgK47r+i2hp6u6MX4FFwc57VyavDnEaHolXBl2zpibG0Gqte+xwKRCWcjQK
	ZxM5+F6US5hp73UEtTtIEMECqEqcHNX4O22bX3xv4kPTike5dtJjblVzNqW78VLJ2thiUTMpzkj
	yqp4PcYqJbOnbrRNvsUWaCsr1iB1tqgDnGADebWsgTZhC8ILBkGdb/o95Mkpdrgdn5A6ZhfcVKz
	9bnIyJdLzQpKnBfhIXGuZpK5cqZpGvEB2vKSh9ActsKE528qTQnOKw==
X-Received: by 2002:a17:90b:4f87:b0:3ac:af8d:c839 with SMTP id 98e67ed59e1d1-3ae897f6e6dmr1251632a91.35.1793350343125;
        Fri, 30 Oct 2026 01:52:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.86.196.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845fb9f6sm3173798a91.17.2026.10.30.01.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 01:52:22 -0700 (PDT)
Message-Id: <pull.2280.v2.git.1793350341743.gitgitgadget@gmail.com>
In-Reply-To: <pull.2280.git.1793099688076.gitgitgadget@gmail.com>
References: <pull.2280.git.1793099688076.gitgitgadget@gmail.com>
From: "Shashank S via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 Oct 2026 08:52:21 +0000
Subject: [PATCH v2] test-chmtime: use parse_options() to parse command-line
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

Signed-off-by: Shashank S Mogaveera <shashu8660@gmail.com>
---
    [Outreachy]test-chmtime: use parse_options() to parse command-line flags

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2280%2Fshashu8660%2Foutreachy3-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2280/shashu8660/outreachy3-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2280

Range-diff vs v1:

 1:  4f702e3f0b ! 1:  43c96de13e test-chmtime: use parse_options() to parse command-line flags
     @@ Commit message
          cmd__chmtime() currently parses the '-v'/'--verbose' and '-g'/'--get'
          flags manually using strcmp() checks and manual index tracking.
      
     -    Refactor cmd__chmtime() to use parse_options() and usage_with_options()
     +    Migrate cmd__chmtime() to use parse_options() and usage_with_options()
          instead. Pass PARSE_OPT_KEEP_UNKNOWN_OPT so that negative relative time
          offsets (such as '-86400') are not rejected as unknown short options
          and remain in argv for timespec_arg() to parse.
      
     +    Additionally, strictly prevent combining mutually exclusive options
     +    ('--get' and '--verbose') by utilizing die_for_incompatible_opt2(),
     +    and introduce a new test script to verify both this restriction and
     +    the standard usage.
     +
          Signed-off-by: Shashank S Mogaveera <shashu8660@gmail.com>
      
       ## t/helper/test-chmtime.c ##
      @@
     +  *
     +  * The mtime can be changed to an absolute value:
     +  *
     +- *	test-tool chmtime =<seconds> file...
     ++ *  test-tool chmtime =<seconds> file...
     +  *
     +  * Relative to the current time as returned by time(3):
     +  *
     +- *	test-tool chmtime =+<seconds> (or =-<seconds>) file...
     ++ *  test-tool chmtime =+<seconds> (or =-<seconds>) file...
     +  *
     +  * Or relative to the current mtime of the file:
     +  *
     +- *	test-tool chmtime <seconds> file...
     +- *	test-tool chmtime +<seconds> (or -<seconds>) file...
     ++ *  test-tool chmtime <seconds> file...
     ++ *  test-tool chmtime +<seconds> (or -<seconds>) file...
     +  *
     +  * Examples:
     +  *
     +  * To print the mtime and the file name use --verbose and set
     +  * the file mtime offset to 0:
     +  *
     +- *	test-tool chmtime -v +0 file
     ++ *  test-tool chmtime -v +0 file
     +  *
     +  * To print only the mtime use --get:
     +  *
     +- *	test-tool chmtime --get file
     ++ *  test-tool chmtime --get file
     +  *
     +  * To set the mtime to current time:
     +  *
     +- *	test-tool chmtime =+0 file
     ++ *  test-tool chmtime =+0 file
     +  *
     +  * To set the file mtime offset to +1 and print the new value:
     +  *
     +- *	test-tool chmtime --get +1 file
     ++ *  test-tool chmtime --get +1 file
     +  *
        */
       #include "test-tool.h"
       #include "git-compat-util.h"
     @@ t/helper/test-chmtime.c
      -static const char usage_str[] =
      -	"(-v|--verbose|-g|--get) (+|=|=+|=-|-)<seconds> <file>...";
      +static const char * const chmtime_usage[] = {
     -+	"test-tool chmtime (-v|--verbose|-g|--get) (+|=|=+|=-|-)<seconds> <file>...",
     ++	"test-tool chmtime [<options>] (+|=|=+|=-|-)<seconds> <file>...",
      +	NULL
      +};
       
       static int timespec_arg(const char *arg, long int *set_time, int *set_eq)
       {
     -@@ t/helper/test-chmtime.c: static int timespec_arg(const char *arg, long int *set_time, int *set_eq)
     - 
     - int cmd__chmtime(int argc, const char **argv)
     - {
     --	static int verbose;
     --	static int get;
     -+	int verbose = 0;
     -+	int get = 0;
     +@@ t/helper/test-chmtime.c: int cmd__chmtime(int argc, const char **argv)
     + 	static int verbose;
     + 	static int get;
       
      -	int i = 1;
      +	int i = 0;
     @@ t/helper/test-chmtime.c: static int timespec_arg(const char *arg, long int *set_
      -	if (i == argc) {
      -		goto usage;
      -	}
     -+	if (argc < 1 || (!get && !verbose && argc < 2))
     ++	die_for_incompatible_opt2(get, "--get", verbose, "--verbose");
     ++
     ++	if (argc < 1)
      +		usage_with_options(chmtime_usage, options);
       
       	if (timespec_arg(argv[i], &set_time, &set_eq)) {
     - 		++i;
     - 	} else {
     - 		if (get == 0 && verbose == 0) {
     - 			fprintf(stderr, "Not a base-10 integer: %s\n", argv[i] + 1);
     +-		++i;
     +-	} else {
     +-		if (get == 0 && verbose == 0) {
     +-			fprintf(stderr, "Not a base-10 integer: %s\n", argv[i] + 1);
      -			goto usage;
     -+			usage_with_options(chmtime_usage, options);
     - 		}
     +-		}
     ++		i++;
     ++	} else if (!get && !verbose) {
     ++		fprintf(stderr, "Not a base-10 integer: %s\n", argv[i] + 1);
     ++		usage_with_options(chmtime_usage, options);
       	}
       
       	if (i == argc)
     @@ t/helper/test-chmtime.c: int cmd__chmtime(int argc, const char **argv)
       			continue;
       		}
       
     + #ifdef GIT_WINDOWS_NATIVE
     + 		if (!(sb.st_mode & S_IWUSR) &&
     +-				chmod(argv[i], sb.st_mode | S_IWUSR)) {
     ++		    chmod(argv[i], sb.st_mode | S_IWUSR)) {
     + 			fprintf(stderr, "Could not make user-writable %s: %s",
     + 				argv[i], strerror(errno));
     + 			return 1;
     +@@ t/helper/test-chmtime.c: int cmd__chmtime(int argc, const char **argv)
     + 		utb.actime = sb.st_atime;
     + 		utb.modtime = set_eq ? set_time : sb.st_mtime + set_time;
     + 
     +-		mtime = utb.modtime < 0 ? 0: utb.modtime;
     ++		mtime = utb.modtime < 0 ? 0 : utb.modtime;
     + 		if (get) {
     + 			printf("%"PRIuMAX"\n", mtime);
     + 		} else if (verbose) {
      @@ t/helper/test-chmtime.c: int cmd__chmtime(int argc, const char **argv)
       			}
       #endif
     @@ t/helper/test-chmtime.c: int cmd__chmtime(int argc, const char **argv)
      -	fprintf(stderr, "usage: %s %s\n", argv[0], usage_str);
      -	return 1;
       }
     +
     + ## t/meson.build ##
     +@@ t/meson.build: integration_tests = [
     +   't0071-sort.sh',
     +   't0080-unit-test-output.sh',
     +   't0081-find-pack.sh',
     ++  't0082-test-chmtime.sh',
     +   't0090-cache-tree.sh',
     +   't0091-bugreport.sh',
     +   't0092-diagnose.sh',
     +
     + ## t/t0082-test-chmtime.sh (new) ##
     +@@
     ++#!/bin/sh
     ++
     ++test_description='tests for test-tool chmtime'
     ++
     ++TEST_PASSES_SANITIZE_LEAK=true
     ++. ./test-lib.sh
     ++
     ++test_expect_success 'setup' '
     ++	echo hello >file
     ++'
     ++
     ++test_expect_success 'mutually exclusive options are rejected' '
     ++	test_must_fail test-tool chmtime --get --verbose +0 file 2>err &&
     ++	test_grep "cannot be used together" err
     ++'
     ++
     ++test_expect_success 'missing timespec without -g or -v is rejected' '
     ++	test_must_fail test-tool chmtime file 2>err &&
     ++	test_grep "usage: test-tool chmtime" err
     ++'
     ++
     ++test_done


 t/helper/test-chmtime.c | 72 +++++++++++++++++++----------------------
 t/meson.build           |  1 +
 t/t0082-test-chmtime.sh | 22 +++++++++++++
 3 files changed, 57 insertions(+), 38 deletions(-)
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
index 0000000000..277df4ff1a
--- /dev/null
+++ b/t/t0082-test-chmtime.sh
@@ -0,0 +1,22 @@
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
+test_done

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
gitgitgadget
