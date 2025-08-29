Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851AB2E542C
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483380; cv=none; b=Y/wC/le5EFLPaeoZGcMOgj/FG9gtQ2yyhxry8XusUcpdZvbPcMdmV6ta1TJoGnv0G7VQsgT1FFrwwyOkGsO6sIkAj9pd/LVfb4HwNDVlQaZWYh3k8mpJCtZNkOvYqdfZ5cXvp/DZ0SUZ151vhDQnelNSB6vj5TbRLEmbrWlg+SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483380; c=relaxed/simple;
	bh=fAArEZ0XvsUT4yc3HaUKTOaQoQ23bfrClBbRbblY3pg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=U2p5Mdg7OsYA8CLj8VRUIZkZETuScQFWYiKHQTPu8mrqsYzoVgjBIFm70zkq5IgWsvaTJq5w7b23cHOD9cNe16SHuF+9wrRkxARB2mQd50zo5wX5iMdagb5Yx3Zxzmb6gMr7o+YQgAHZGgjUevdlccqwBLMWjeJk4AiQ0qIeO/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihfobFQr; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihfobFQr"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7f722cb35fdso218251185a.3
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756483377; x=1757088177; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iT+d2X4843NTR/3ctPd65YWtXIbItBN0HGY+7zOPkFY=;
        b=ihfobFQr/mpVUjQJIu103EK39I8yM+t4JhmItp6oNEmTDLAdf2VLuWYdSBQ31QaLRA
         1KLSiSisy3TzBEX2DuZ06Zi09xPIaYqS+nVg3s26mpTqtmgen2zU4sc1RttTZCeYRT4h
         SEu2t6cPidsJAzClPzENA+XRxWCVPdea/Bn6UEyWU4O1VLjy10Oc1Hp/DkZPIeDE5ryW
         OJx4U7plaBq4KeGD6xpRy41jMYjBGmsZ6JlzfckyPaZuJ5rC+A9fv0DZZ6FSNTrDepqz
         xLcU5wE+qSKCnHdc/7EDB5UZZteBd95u82lnBzqE7N9mlhRz7PzhMjJpuZZtxKsm84zP
         MFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756483377; x=1757088177;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iT+d2X4843NTR/3ctPd65YWtXIbItBN0HGY+7zOPkFY=;
        b=bzG09+YbjiR0VEfG9ATUzVBsj/eoFch0ymvNhrzSP65YWekWakpNOm+axpFi4Q1RKj
         f0jq8x2RYD6mmpDARjVe0MA0eh/7i3OpMtPSerdS7bw3V5/Ox7qphwTnRWW18P1v8fQ5
         H+Yub9jndD/nS4WHTEkqMwTI9m88xUlTjw1MvxwcKCJHmYLn89iI19anXk1hWHXkeCkz
         Kc1bLA/fQZhkKmlTUHTQaPpQjWAIMvjhAnjLD4H18LGXVcrya60GU3AgX1Wd3NzgcLsp
         nDsmeEutr3X9p6tDbmKeMC1UGrjy7wU3LWwZfJ8B3HDG8N+fSyGlGREhHofdJYbHrW5h
         UrXg==
X-Gm-Message-State: AOJu0Yz9dsPgsV4tkQ+65b6M56v8YFy3Vv+YIJp1YPUS98yeEDcsavoB
	vKTY6/Xr/u8FkLa16p8ZSYR/Z5129Laqimjw6XKaRklor+J3Z8A/vRAsZ+/0aQ==
X-Gm-Gg: ASbGncvIHALP/RCFa7MRlnYRbBtbyzXrc/B66XnpFBqBN3qxe8q2XOIm0Q7b2N1XO25
	dVLdYAtXoE3SEMVqjis7QBMaylBkRZjwutysIb6A7mfTDDFS9PqhY0ZJIR960MtceSS+2XwK5XF
	JON392gIihVOU+IKDGnZdma3zvtITcwP868919r1UkQhA5F+RVsN3LKdO2IGd5YeftrF0Zp/5Hn
	3J7wHhOph3P5EE/2AiOl++hYECge73xOc0BJ4Ks61FnACfIiYYY5I/RTRCzfrdzW9HtTTgD93Ji
	tPomAxKp6vTJeKsIAHrKQEDpAuQnS/e7iRiN7xgwnWumldiHIIrDVKVvlVAPeRPy8fes6DFKG+f
	xbJkV0zFW+YJfKbWDjH9tIfk1VQ==
X-Google-Smtp-Source: AGHT+IG/ulp0+hpnGLvjk30IkZOBuz6g+aHJnZWU3WYDPEZz3l0N1MAphwnTTKMM+cFH32Tzgw08Og==
X-Received: by 2002:a05:620a:4450:b0:7f4:2e87:148 with SMTP id af79cd13be357-7f42e8705eamr1870068885a.54.1756483376209;
        Fri, 29 Aug 2025 09:02:56 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.127.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc1500901csm200319785a.46.2025.08.29.09.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 09:02:55 -0700 (PDT)
Message-Id: <pull.1958.v4.git.1756483374980.gitgitgadget@gmail.com>
In-Reply-To: <pull.1958.v3.git.1756465231183.gitgitgadget@gmail.com>
References: <pull.1958.v3.git.1756465231183.gitgitgadget@gmail.com>
From: "Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 16:02:54 +0000
Subject: [PATCH v4] range-diff: add configurable memory limit for cost matrix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Paulo Casaretto <pcasaretto@gmail.com>,
    Paulo Casaretto <pcasaretto@gmail.com>

From: Paulo Casaretto <pcasaretto@gmail.com>

When comparing large commit ranges (e.g., 250,000+ commits), range-diff
attempts to allocate an n×n cost matrix that can exhaust available
memory. For example, with 256,784 commits (n = 513,568), the matrix
would require approximately 256GB of memory (513,568² × 4 bytes),
causing either immediate segmentation faults due to integer overflow or
system hangs.

Add a memory limit check in get_correspondences() before allocating the
cost matrix. This check uses the total size in bytes (n² × sizeof(int))
and compares it against a configurable maximum, preventing both
excessive memory usage and integer overflow issues.

The limit is configurable via a new --max-memory option that accepts
human-readable sizes (e.g., "1G", "500M"). The default is 4GB for 64 bit
systems and 2GB for 32 bit systems. This allows comparing ranges of
approximately 32,000 (16,000) commits - generous for real-world use cases
while preventing impractical operations.

When the limit is exceeded, range-diff now displays a clear error
message showing both the requested memory size and the maximum allowed,
formatted in human-readable units for better user experience.

Example usage:
  git range-diff --max-memory=1G branch1...branch2
  git range-diff --max-memory=500M base..topic1 base..topic2

This approach was chosen over alternatives:
- Pre-counting commits: Would require spawning additional git processes
  and reading all commits twice
- Limiting by commit count: Less precise than actual memory usage
- Streaming approach: Would require significant refactoring of the
  current algorithm

This issue was previously discussed in:
https://lore.kernel.org/git/RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com/

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paulo Casaretto <pcasaretto@gmail.com>
---
    range-diff: add configurable memory limit for cost matrix
    
    
    Problem Description
    ===================
    
    When git range-diff is given extremely large ranges, it can result in
    either:
    
     1. Segmentation fault due to integer overflow in array index
        calculations
     2. Excessive memory consumption leading to system hangs or OOM kills
     3. Poor user experience with the command appearing to hang for minutes
    
    
    Reproduction Case
    =================
    
    In a Shopify's large monorepo a range-diff command like this crashes
    after several minutes with a SIGBUS error
    
    $ git range-diff 4430f36511..316c1276c6 cb5240b6a8..2bbd292091
    
    
    Range statistics:
    
     * First range: 256,783 commits
     * Second range: 1 commit
     * Total: 256,784 commits
     * Memory required for cost matrix: n² × 4 bytes = ~260GB
    
    
    Stack Trace (Segmentation Fault)
    ================================
    
    (lldb) bt
    * thread #1, queue = 'com.apple.main-thread', stop reason = EXC_BAD_ACCESS (code=2, address=0x6e000ae3b8)
      * frame #0: 0x000000010029a284 git`get_correspondences(a=0x000000016fde6188, b=0x000000016fde6160, creation_factor=60) at range-diff.c:356:20
        frame #1: 0x0000000100299310 git`show_range_diff(range1="4430f36511cbacf5c517c6851e2b8508a72dfd30..316c1276c63f55ad9413fa18bf3b6483564a9cf4", range2="cb5240b6a8ba59b4a1f282559ee0742721b0cafc..2bbd292091e376d177ce62e264dae8872ca6be5a", range_diff_opts=0x000000016fde6308) at range-diff.c:593:3
        frame #2: 0x00000001000c719c git`cmd_range_diff(argc=2, argv=0x0000600000bcd8c0, prefix="areas/core/shopify/", repo=0x0000000100468b20) at range-diff.c:167:8
        frame #3: 0x000000010000277c git`run_builtin(p=0x00000001004408d8, argc=3, argv=0x0000600000bcd8c0, repo=0x0000000100468b20) at git.c:480:11
        frame #4: 0x0000000100001020 git`handle_builtin(args=0x000000016fde6c70) at git.c:746:9
        frame #5: 0x0000000100002074 git`run_argv(args=0x000000016fde6c70) at git.c:813:4
        frame #6: 0x0000000100000d3c git`cmd_main(argc=3, argv=0x000000016fde7350) at git.c:953:19
        frame #7: 0x000000010012750c git`main(argc=4, argv=0x000000016fde7348) at common-main.c:9:11
        frame #8: 0x000000018573ab98 dyld`start + 6076
    
    
    
    Root Cause Analysis
    ===================
    
    The crash occurs in get_correspondences() at line 356:
    
    static void get_correspondences(struct string_list *a, struct string_list *b, ...)
    {
        int n = a->nr + b->nr;  // Integer overflow: 256,784 fits in int
        ...
        ALLOC_ARRAY(cost, st_mult(n, n));  // Would allocate ~260GB
        ...
        cost[i + n * j] = c;  // Line 356: Invalid memory access
    }
    
    
    Problems:
    
     1. Integer overflow: While n=256,784 fits in an int, n*n overflows
     2. Memory allocation: Even with proper types, allocating 260GB is
        impractical
    
    
    Solution
    ========
    
    Add a memory limit check in get_correspondences() before allocating the
    cost matrix. This check uses the total size in bytes (n² × sizeof(int))
    and compares it against a configurable maximum, preventing both
    excessive memory usage and integer overflow issues.
    
    The limit is configurable via a new --max-memory option that accepts
    human-readable sizes (e.g., "1G", "500M"). The default is 4GB for 64 bit
    systems and 2GB for 32 bit systems. This allows comparing ranges of
    approximately 32,000 (16,000) commits - generous for real-world use
    cases while preventing impractical operations.
    
    When the limit is exceeded, range-diff now displays a clear error
    message showing both the requested memory size and the maximum allowed,
    formatted in human-readable units for better user experience.
    
    Example usage: git range-diff --max-memory=1G branch1...branch2 git
    range-diff --max-memory=500M base..topic1 base..topic2
    
    This approach was chosen over alternatives:
    
     * Pre-counting commits: Would require spawning additional git processes
       and reading all commits twice
     * Limiting by commit count: Less precise than actual memory usage
     * Streaming approach: Would require significant refactoring of the
       current algorithm
    
    This issue was previously discussed in:
    https://lore.kernel.org/git/RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com/
    
    Acked-by: Johannes Schindelin johannes.schindelin@gmx.de
    [https://github.com/gitgitgadget/git/pull/1958#issuecomment-3224133138]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1958%2Fpcasaretto%2Frange-diff-size-limit-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1958/pcasaretto/range-diff-size-limit-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1958

Range-diff vs v3:

 1:  6d7ff43e56 ! 1:  203113ea2a range-diff: add configurable memory limit for cost matrix
     @@ range-diff.c: static int diffsize(const char *a, const char *b)
      +		strbuf_humanise_bytes(&max_str, max_memory);
      +		die(_("range-diff: unable to compute the range-diff, since it "
      +		      "exceeds the maximum memory for the cost matrix: %s "
     -+		      "(%"PRIuMAX" bytes) needed, %s (%"PRIuMAX" bytes) available"),
     ++		      "(%"PRIuMAX" bytes) needed, limited to %s (%"PRIuMAX" bytes)"),
      +		    cost_str.buf, (uintmax_t)cost_bytes, max_str.buf, (uintmax_t)max_memory);
      +	}
      +	ALLOC_ARRAY(cost, cost_size);


 builtin/log.c        |  1 +
 builtin/range-diff.c | 21 +++++++++++++++++++++
 log-tree.c           |  1 +
 range-diff.c         | 20 ++++++++++++++++----
 range-diff.h         |  5 +++++
 5 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index c2f8bbf863..5f552d14c0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1404,6 +1404,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 		struct range_diff_options range_diff_opts = {
 			.creation_factor = rev->creation_factor,
 			.dual_color = 1,
+			.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
 			.diffopt = &opts,
 			.other_arg = &other_arg
 		};
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index a563abff5f..aafcc99b96 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -6,6 +6,7 @@
 #include "parse-options.h"
 #include "range-diff.h"
 #include "config.h"
+#include "parse.h"
 
 
 static const char * const builtin_range_diff_usage[] = {
@@ -15,6 +16,21 @@ N_("git range-diff [<options>] <base> <old-tip> <new-tip>"),
 NULL
 };
 
+static int parse_max_memory(const struct option *opt, const char *arg, int unset)
+{
+	size_t *max_memory = opt->value;
+	uintmax_t val;
+
+	if (unset)
+		return 0;
+
+	if (!git_parse_unsigned(arg, &val, SIZE_MAX))
+		return error(_("invalid max-memory value: %s"), arg);
+
+	*max_memory = (size_t)val;
+	return 0;
+}
+
 int cmd_range_diff(int argc,
 		   const char **argv,
 		   const char *prefix,
@@ -25,6 +41,7 @@ int cmd_range_diff(int argc,
 	struct strvec diff_merges_arg = STRVEC_INIT;
 	struct range_diff_options range_diff_opts = {
 		.creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT,
+		.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
 		.diffopt = &diffopt,
 		.other_arg = &other_arg
 	};
@@ -40,6 +57,10 @@ int cmd_range_diff(int argc,
 				  PARSE_OPT_OPTARG),
 		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
 				  N_("style"), N_("passed to 'git log'"), 0),
+		OPT_CALLBACK(0, "max-memory", &range_diff_opts.max_memory,
+			     N_("size"),
+			     N_("maximum memory for cost matrix (default 4G)"),
+			     parse_max_memory),
 		OPT_PASSTHRU_ARGV(0, "remerge-diff", &diff_merges_arg, NULL,
 				  N_("passed to 'git log'"), PARSE_OPT_NOARG),
 		OPT_BOOL(0, "left-only", &left_only,
diff --git a/log-tree.c b/log-tree.c
index 233bf9f227..73d21f7176 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -717,6 +717,7 @@ static void show_diff_of_diff(struct rev_info *opt)
 		struct range_diff_options range_diff_opts = {
 			.creation_factor = opt->creation_factor,
 			.dual_color = 1,
+			.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
 			.diffopt = &opts
 		};
 
diff --git a/range-diff.c b/range-diff.c
index 8a2dcbee32..ca449a0769 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -325,13 +325,24 @@ static int diffsize(const char *a, const char *b)
 }
 
 static void get_correspondences(struct string_list *a, struct string_list *b,
-				int creation_factor)
+				int creation_factor, size_t max_memory)
 {
 	int n = a->nr + b->nr;
 	int *cost, c, *a2b, *b2a;
 	int i, j;
-
-	ALLOC_ARRAY(cost, st_mult(n, n));
+	size_t cost_size = st_mult(n, n);
+	size_t cost_bytes = st_mult(sizeof(int), cost_size);
+	if (cost_bytes >= max_memory) {
+		struct strbuf cost_str = STRBUF_INIT;
+		struct strbuf max_str = STRBUF_INIT;
+		strbuf_humanise_bytes(&cost_str, cost_bytes);
+		strbuf_humanise_bytes(&max_str, max_memory);
+		die(_("range-diff: unable to compute the range-diff, since it "
+		      "exceeds the maximum memory for the cost matrix: %s "
+		      "(%"PRIuMAX" bytes) needed, limited to %s (%"PRIuMAX" bytes)"),
+		    cost_str.buf, (uintmax_t)cost_bytes, max_str.buf, (uintmax_t)max_memory);
+	}
+	ALLOC_ARRAY(cost, cost_size);
 	ALLOC_ARRAY(a2b, n);
 	ALLOC_ARRAY(b2a, n);
 
@@ -591,7 +602,8 @@ int show_range_diff(const char *range1, const char *range2,
 	if (!res) {
 		find_exact_matches(&branch1, &branch2);
 		get_correspondences(&branch1, &branch2,
-				    range_diff_opts->creation_factor);
+				    range_diff_opts->creation_factor,
+				    range_diff_opts->max_memory);
 		output(&branch1, &branch2, range_diff_opts);
 	}
 
diff --git a/range-diff.h b/range-diff.h
index cd85000b5a..9d39818e34 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -5,6 +5,10 @@
 #include "strvec.h"
 
 #define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
+#define RANGE_DIFF_MAX_MEMORY_DEFAULT \
+	(sizeof(void*) >= 8 ? \
+		((size_t)(1024L * 1024L) * (size_t)(4L * 1024L)) : /* 4GB on 64-bit */ \
+		((size_t)(1024L * 1024L) * (size_t)(2L * 1024L)))   /* 2GB on 32-bit */
 
 /*
  * A much higher value than the default, when we KNOW we are comparing
@@ -17,6 +21,7 @@ struct range_diff_options {
 	unsigned dual_color:1;
 	unsigned left_only:1, right_only:1;
 	unsigned include_merges:1;
+	size_t max_memory;
 	const struct diff_options *diffopt; /* may be NULL */
 	const struct strvec *other_arg; /* may be NULL */
 };

base-commit: 954d33a9757fcfab723a824116902f1eb16e05f7
-- 
gitgitgadget
