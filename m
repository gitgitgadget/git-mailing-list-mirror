Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099690;
	b=IgWWXYCA2TFRZecrl5Y3xaTw1fPoYqmYCV/Chs1essUeHoK4TRSkjS7P9oqffHwVssX4
	 ka0o2TuNCwJZM6fAsdGVmxDgp8pDjMU49MNftl4NMomXmVN5X+9vP13l99j//0UyJDFqY
	 PdlcAWqhp5apIXEz5ChKCD+D8Brh/pI8EJYFOxZ7hQv2BCYI97PDA+HhppSE09DVISrOC
	 jsHKb/eZ6Qjj/C0BaK5LejjwrBv9FYbOzJJuRaPXMNlfXzW5WBeEjF7ZyB3ZEm9dGXW7/
	 lh/cewhqQTQwXftpARElreDHI1DjJYhiRElvSQcj8Xw7DtnjoRQYnrGoZztWiD3NLZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=a+s+xXp3tqR4XPMeZuJQV004ARXEgccqkwkWZBrk/gk=;
	b=Uq57b87s3N8wJNvyZKoOCmJwccPnRo4oT5snVbhQmVU8lOaPxQX3QGqfikledGzibugp
	 sonD0NobdaJEhPL8Tv3pc55FrT0KOlaJqFvTh3K4tohTK+uhtEyZ/39bEWT7unzTVW6Nd
	 1yEx9gKjfc2tP4A1VtMRLzpiZoHhWiLTBMh6xVkGN/ZUpR6DqSEcf0bwY+IEX8HXViwIH
	 uFiK55udIwjGz0jpjZWSeqSOMyjPI6NRhP6sIc/P70Ne9EWWYwoLSwc4dQKx+clGNoSsx
	 pRXhipZRPQu+cGh1KstfZoRDBV0kpRG41SuQdbf9pBJDsL5z3Nfhpl1UwmhYpx7pKjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X85QCvDZ;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A87606A31B
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 11:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5A87606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X85QCvDZ
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd5e2d696e0so2168871a12.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 04:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793099689; x=1793704489; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a+s+xXp3tqR4XPMeZuJQV004ARXEgccqkwkWZBrk/gk=;
        b=X85QCvDZXPKjra/NLzITT5xjtZ5KMEvulBuWyBYCQ3NOwFFYRuZEiq2IrOENo3nun4
         8FHnJBTlfeJfRGj/dGUlDrMXVem/MjyuBQG9eipcb4tx42uPqs7E3xqiLd5/ni3ThOdp
         pjq3OIwYvGY1nA2mhatdDYRLZ+kSqdda/fpLkyPMU5T+ZG9sJi6v9iM+SeE/Lj1wZgX9
         nZuF0Hv5ehpxYuj6+Dlsa6EjDmROMlG5qN9u0Ox0xItLNmnGHzdZzTdo4zAaP+3FkmaJ
         MoZHSw/tIzLjTB97STwk4D6RdV8olOq+segOvOfxOJgCoIBUcQeoRM7RtaZWSFmeU2Ny
         IhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793099689; x=1793704489;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a+s+xXp3tqR4XPMeZuJQV004ARXEgccqkwkWZBrk/gk=;
        b=msHDI+CtvLdb9tl6aAN4J8zJfZkyutfb8kfmOEys9mzg0AcAkX/yyVJBgM2xqWn28P
         M6ZQlxra0GmyeXdWNc1KgEyq3bTWnlsL8bZ1MeaVsd19/bkIyYzjCQ9FThX5y/+VyeuJ
         RJntGK0qoC7VSS39LmL0miW3sCOC6NEa5I+zpohWJ/WkUvlYZqgJYRcO8GfsfqflrwUh
         jAcP3NMAKRxomgj/ukSoJjfzgZ46s4wxBqoxFmV2ZDQNDzhRI8BuU5o2veKA1PJ2r6uz
         INRuu5RKRr0HIxZ88fm5mjC900GYa0S2X2NxIVuipywk5xUHsEhTf1wd/0XiPHFlOUuU
         Rwqg==
X-Gm-Message-State: AFq9FYJqyTaGP9MUhYDnoW26ismeSAFCU+ggI82ZDNK0PCSPh7Y9R5xI
	UntEu407wWaaRfvknb4l155mLdtUykUk5IaaG8UGqXPD5Fi/bOXwr8FixuU+Xyhi
X-Gm-Gg: AYBFou1NLfVXRBpyqk6HrNGU1uiRdafqWOmLqkW6y97Ue3kmZhBsFeVk4AF72YeOGQM
	icdCXIW2xb6c8Z03k37EFTkzAVGFKHbUL0hZ+OFQ3VDqQqrRtLtQ3YkKmsEhlCG7udmVRGD1pbj
	Nun+QrNZZ0sUsDe/MNPlDhbO3+noNW5hVxkPhv+XMs8hAgPpPlOx72bnKyxWRhAyR3hXRI1a2DG
	/mHgCruuQgxwbi1OPuZAqJejWirND+BhEgBTBPAZbbvJEbkxeLCcMpn9vgNqcwxBqXk6+z1ljvH
	TE1NDJX+Adr8ey/UaffPT9JdLXt0PgCQBAOEgdighmusT3lwKcxQYRSOmlIgFtfiveJKD9BMf4U
	+j6NNsVwP2+laOBUfp1zCrCp2eIZZ/Pp59BHjbbkAwNd2aj6yE1trIP7ZxX12pXsE4IDoHdH7IK
	jzJGMDQ2y5EH22Kkz1veAWofR3d3az1rj/8x6MEocYWjQWCPHAeqIm0nFV4kfwfV20unONoLC0E
	vgs/HjQI/roj+na1AiaELaMKO1anwRcEytAmOJfiYZCUaajQEPwPQi71w==
X-Received: by 2002:a05:6a21:e08a:b0:3e2:83bb:a608 with SMTP id adf61e73a8af0-3e7afa9a445mr7910284637.2.1793099689122;
        Tue, 27 Oct 2026 04:14:49 -0700 (PDT)
Received: from [127.0.0.1] ([4.155.63.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36b37252bsm2100893b3a.28.2026.10.27.04.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:14:48 -0700 (PDT)
Message-Id: <pull.2280.git.1793099688076.gitgitgadget@gmail.com>
From: "Shashank S via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 11:14:48 +0000
Subject: [PATCH] test-chmtime: use parse_options() to parse command-line flags
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
    Shashank S Mogaveera <shashu8660@gmail.com>

From: Shashank S Mogaveera <shashu8660@gmail.com>

cmd__chmtime() currently parses the '-v'/'--verbose' and '-g'/'--get'
flags manually using strcmp() checks and manual index tracking.

Refactor cmd__chmtime() to use parse_options() and usage_with_options()
instead. Pass PARSE_OPT_KEEP_UNKNOWN_OPT so that negative relative time
offsets (such as '-86400') are not rejected as unknown short options
and remain in argv for timespec_arg() to parse.

Signed-off-by: Shashank S Mogaveera <shashu8660@gmail.com>
---
    [Outreachy]test-chmtime: use parse_options() to parse command-line flags

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2280%2Fshashu8660%2Foutreachy3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2280/shashu8660/outreachy3-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2280

 t/helper/test-chmtime.c | 46 +++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
index 0e5538833a..dc6281b1d6 100644
--- a/t/helper/test-chmtime.c
+++ b/t/helper/test-chmtime.c
@@ -38,10 +38,13 @@
  */
 #include "test-tool.h"
 #include "git-compat-util.h"
+#include "parse-options.h"
 #include <utime.h>
 
-static const char usage_str[] =
-	"(-v|--verbose|-g|--get) (+|=|=+|=-|-)<seconds> <file>...";
+static const char * const chmtime_usage[] = {
+	"test-tool chmtime (-v|--verbose|-g|--get) (+|=|=+|=-|-)<seconds> <file>...",
+	NULL
+};
 
 static int timespec_arg(const char *arg, long int *set_time, int *set_eq)
 {
@@ -68,40 +71,37 @@ static int timespec_arg(const char *arg, long int *set_time, int *set_eq)
 
 int cmd__chmtime(int argc, const char **argv)
 {
-	static int verbose;
-	static int get;
+	int verbose = 0;
+	int get = 0;
 
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
+	if (argc < 1 || (!get && !verbose && argc < 2))
+		usage_with_options(chmtime_usage, options);
 
 	if (timespec_arg(argv[i], &set_time, &set_eq)) {
 		++i;
 	} else {
 		if (get == 0 && verbose == 0) {
 			fprintf(stderr, "Not a base-10 integer: %s\n", argv[i] + 1);
-			goto usage;
+			usage_with_options(chmtime_usage, options);
 		}
 	}
 
 	if (i == argc)
-		goto usage;
+		usage_with_options(chmtime_usage, options);
 
 	for (; i < argc; i++) {
 		struct stat sb;
@@ -110,7 +110,7 @@ int cmd__chmtime(int argc, const char **argv)
 
 		if (stat(argv[i], &sb) < 0) {
 			fprintf(stderr, "Failed to stat %s: %s. Skipping\n",
-			        argv[i], strerror(errno));
+				argv[i], strerror(errno));
 			continue;
 		}
 
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

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
gitgitgadget
