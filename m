Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5980F32C8B
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370295; cv=none; b=okUNI8Mbc49yn+tizp1KG/8bGgwCZtsCkmLWlhrEWbXYiIkXd6vWMfoQaJg6v1bbgcM/jLWEspKhp/JMtm1SlIlb2tqWePmK7n+Qefx3lpaE5q4+O9laBI2GqtMjIhCiVy4m9mcJCap3Gv/uuHY4lR+ntS8SCyAQGlcpAsqpZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370295; c=relaxed/simple;
	bh=i4ZRjz2Tx0fCSWsPwOYc7XRsBraJhP9eDf0B/0pCoAM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=CixIitd9NAmZsGaXEn09NckUpKce0MDZ5NLj6cZduScGfl7lR9yNZR1uqg+9A3e6PrSmDl+VjwoXQ/PoqEvp/noQvZOeRR7qpJJMdNbOOs4XaDbj/NnoXNbOF0MA5gakUhmx1y0bXeMWmno0h/gUjqOziE1WYU+W4tBFu4SGR2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccxBlEtM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccxBlEtM"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b629c8035so3622955e9.3
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 01:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756370291; x=1756975091; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKZ4cK3H8lAR75ikhlG5HMm2cNrcN7kGI2F8fRGoLCs=;
        b=ccxBlEtMQSzqmOWluKPAZ0MiWN0nBUyrsIuXNNi4EIdEGh4y9p8awzM7Vrq33Q2uUs
         J7FqhJEJ/kn8gRU3DE5LM4lfAyx0YqtJcRiTozpHd7VXpbmf8wqUGQxQwv4TNTN+yhQM
         T3fVTtShI7mibyko5DSBKigi3XJVVxBu7JkSZOoYqUT7vXxfG9UF9ike5spqOPPwFemx
         fHadhXcHC6WoMnqjSoU5iE1vx7nzjfoBPiKzN7XRo8l0tde6lEf6LGB7/gNGFOtFNsVw
         XEdUtivcVqMfF6VcOKtX8FxnALygOKEUHMbPcxJUS0g4dGuPvUlQM88b127rQJZ57vlW
         3p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756370291; x=1756975091;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKZ4cK3H8lAR75ikhlG5HMm2cNrcN7kGI2F8fRGoLCs=;
        b=otW3TPlHStNpPmx8ax/s84B72s4eAKCNn/Q/mubjkXcsfZ3bPjc0gD2pLEZniER8+V
         wEhGzcjfgwwhf5A6JThZkhmDaedi/DqqjT4PFTO29/Js4QdfgGj5viZX2/fwN8vbNU5t
         /3dUQlWzUUsYJ4OmJvC7ghCHzXMbWvqXYUcohb95IBhUYOo8FPZubFlQrQPuS2ulJcMv
         GCguCmuGJdJAYGPexCjxSWmSxDO6qRleRTaztHe9lYktujeYOmZOA9oeol4vzYEktenx
         i5ufnI5s+8HCMcSMF+uZeyQGIXcjTTCba8LiZLf8Tm6Qmf/1ab5oLhptedQkXS4ENNBt
         XQqg==
X-Gm-Message-State: AOJu0Yy4yMtMDfseDKtlZA+SUVAGH9VVoMcRBK4STETAkFx0nvNHsLMA
	HSnB5cU8WJRGctgmLlK98BL2CRKy5DaJQK5O6TVALbFpuTqgCRkjnuNzmt0D0A==
X-Gm-Gg: ASbGncvycAxvQuabgBo0HQFG+iBxONxa0bJd66okNt2pjfDYxQnLb0lAfnOHei6lTUp
	QXKr6fczI3NnXoYHu0z8COtGosauVrd0SosEnrMzXJRKdK8znQ6jhO5lmT9rLpqUFwg6GTgUqSW
	kSbwj/UcQPYt/RR2ioQw6Flw9BVK4BeRytjw+0lm8p8m2ejXp1WxfMY4n5owcBRMipVZTh9y2lP
	6Ln2yMtwoXplR7h8/yYQILw7WTR86g/8pIEhi7Rvttvlw2sbC+7QXTIRM6KyXp608meXACSocCi
	puQGye7EAZORAYYQ2UGy3QISWcOmp9DACXoJFY+a2kw8GwAvpmbtgEytiuSYlTRnOUKDea7D1q0
	znTKzPaZCDJ99IZmI8UJsjoOEOJAIFEY/HCY6GQ==
X-Google-Smtp-Source: AGHT+IEg+n0FouR/MrLvvh65Xc7Lba2kalMolTJnOR3n2t4W+lby1E3wshuVXVZusTK+HlMfm9FElg==
X-Received: by 2002:a05:600c:1c82:b0:45b:5efc:e97b with SMTP id 5b1f17b1804b1-45b5f4e343cmr131995895e9.12.1756370291051;
        Thu, 28 Aug 2025 01:38:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b797dd66dsm21926905e9.20.2025.08.28.01.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:38:10 -0700 (PDT)
Message-Id: <pull.1958.v2.git.1756370289.gitgitgadget@gmail.com>
In-Reply-To: <pull.1958.git.1756228693233.gitgitgadget@gmail.com>
References: <pull.1958.git.1756228693233.gitgitgadget@gmail.com>
From: "Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 08:38:06 +0000
Subject: [PATCH v2 0/2] range-diff: add configurable memory limit for cost matrix
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
Cc: Paulo Casaretto <pcasaretto@gmail.com>


Problem Description
===================

When git range-diff is given extremely large ranges, it can result in
either:

 1. Segmentation fault due to integer overflow in array index calculations
 2. Excessive memory consumption leading to system hangs or OOM kills
 3. Poor user experience with the command appearing to hang for minutes


Reproduction Case
=================

In a Shopify's large monorepo a range-diff command like this crashes after
several minutes with a SIGBUS error

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

Add a memory limit check in get_correspondences() before allocating the cost
matrix. This check uses the total size in bytes (n² × sizeof(int)) and
compares it against a configurable maximum, preventing both excessive memory
usage and integer overflow issues.

The limit is configurable via a new --max-memory option that accepts
human-readable sizes (e.g., "1G", "500M"). The default is 4GB for 64 bit
systems and 2GB for 32 bit systems. This allows comparing ranges of
approximately 32,000 (16,000) commits - generous for real-world use cases
while preventing impractical operations.

When the limit is exceeded, range-diff now displays a clear error message
showing both the requested memory size and the maximum allowed, formatted in
human-readable units for better user experience.

Example usage: git range-diff --max-memory=1G branch1...branch2 git
range-diff --max-memory=500M base..topic1 base..topic2

This approach was chosen over alternatives:

 * Pre-counting commits: Would require spawning additional git processes and
   reading all commits twice
 * Limiting by commit count: Less precise than actual memory usage
 * Streaming approach: Would require significant refactoring of the current
   algorithm

This issue was previously discussed in:
https://lore.kernel.org/git/RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com/

Acked-by: Johannes Schindelin johannes.schindelin@gmx.de
[https://github.com/gitgitgadget/git/pull/1958#issuecomment-3224133138]

pcasaretto (2):
  range-diff: reorder options lexicographically
  range-diff: add configurable memory limit for cost matrix

 builtin/log.c        |  1 +
 builtin/range-diff.c | 29 +++++++++++++++++++++++++----
 log-tree.c           |  1 +
 range-diff.c         | 20 ++++++++++++++++----
 range-diff.h         |  5 +++++
 5 files changed, 48 insertions(+), 8 deletions(-)


base-commit: 954d33a9757fcfab723a824116902f1eb16e05f7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1958%2Fpcasaretto%2Frange-diff-size-limit-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1958/pcasaretto/range-diff-size-limit-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1958

Range-diff vs v1:

 -:  ----------- > 1:  ec5dcdf9d00 range-diff: reorder options lexicographically
 1:  5cf3e8921a7 ! 2:  c81f920fee0 range-diff: add configurable memory limit for cost matrix
     @@ Commit message
          This issue was previously discussed in:
          https://lore.kernel.org/git/RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com/
      
     -    Acked-by: Johannes Schindelin johannes.schindelin@gmx.de
     -    Signed-off-by: pcasaretto <paulo.casaretto@shopify.com>
     +    Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     +    Signed-off-by: Paulo Casaretto <paulo.casaretto@shopify.com>
      
       ## builtin/log.c ##
      @@ builtin/log.c: static void make_cover_letter(struct rev_info *rev, int use_separate_file,
     @@ builtin/range-diff.c: N_("git range-diff [<options>] <base> <old-tip> <new-tip>"
      +	size_t *max_memory = opt->value;
      +	uintmax_t val;
      +
     -+	if (unset) {
     ++	if (unset)
      +		return 0;
     -+	}
      +
      +	if (!git_parse_unsigned(arg, &val, SIZE_MAX))
      +		return error(_("invalid max-memory value: %s"), arg);
     @@ builtin/range-diff.c: int cmd_range_diff(int argc,
       		.other_arg = &other_arg
       	};
      @@ builtin/range-diff.c: int cmd_range_diff(int argc,
     - 		OPT_INTEGER(0, "creation-factor",
     - 			    &range_diff_opts.creation_factor,
     - 			    N_("percentage by which creation is weighted")),
     -+		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
     -+				  N_("style"), N_("passed to 'git log'"), 0),
     -+		OPT_BOOL(0, "left-only", &left_only,
     -+			 N_("only emit output related to the first range")),
     + 				  N_("style"), N_("passed to 'git log'"), 0),
     + 		OPT_BOOL(0, "left-only", &left_only,
     + 			 N_("only emit output related to the first range")),
      +		OPT_CALLBACK(0, "max-memory", &range_diff_opts.max_memory,
      +			     N_("size"),
      +			     N_("maximum memory for cost matrix (default 4G)"),
     @@ builtin/range-diff.c: int cmd_range_diff(int argc,
       		OPT_BOOL(0, "no-dual-color", &simple_color,
       			    N_("use simple diff colors")),
       		OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
     - 				  N_("notes"), N_("passed to 'git log'"),
     - 				  PARSE_OPT_OPTARG),
     --		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
     --				  N_("style"), N_("passed to 'git log'"), 0),
     - 		OPT_PASSTHRU_ARGV(0, "remerge-diff", &diff_merges_arg, NULL,
     - 				  N_("passed to 'git log'"), PARSE_OPT_NOARG),
     --		OPT_BOOL(0, "left-only", &left_only,
     --			 N_("only emit output related to the first range")),
     - 		OPT_BOOL(0, "right-only", &right_only,
     - 			 N_("only emit output related to the second range")),
     - 		OPT_END()
      
       ## log-tree.c ##
      @@ log-tree.c: static void show_diff_of_diff(struct rev_info *opt)
     @@ log-tree.c: static void show_diff_of_diff(struct rev_info *opt)
       
      
       ## range-diff.c ##
     -@@
     - #include "apply.h"
     - #include "revision.h"
     - 
     -+
     - struct patch_util {
     - 	/* For the search for an exact match */
     - 	struct hashmap_entry e;
     -@@ range-diff.c: static void find_exact_matches(struct string_list *a, struct string_list *b)
     - }
     - 
     - static int diffsize_consume(void *data,
     --			     char *line UNUSED,
     --			     unsigned long len UNUSED)
     -+			    char *line UNUSED,
     -+			    unsigned long len UNUSED)
     - {
     - 	(*(int *)data)++;
     - 	return 0;
      @@ range-diff.c: static int diffsize(const char *a, const char *b)
       }
       
     @@ range-diff.c: static int diffsize(const char *a, const char *b)
       	ALLOC_ARRAY(a2b, n);
       	ALLOC_ARRAY(b2a, n);
       
     -@@ range-diff.c: static void get_correspondences(struct string_list *a, struct string_list *b,
     - 		}
     - 
     - 		c = a_util->matching < 0 ?
     --			a_util->diffsize * creation_factor / 100 : COST_MAX;
     -+			    a_util->diffsize * creation_factor / 100 :
     -+			    COST_MAX;
     - 		for (j = b->nr; j < n; j++)
     - 			cost[i + n * j] = c;
     - 	}
     -@@ range-diff.c: static void get_correspondences(struct string_list *a, struct string_list *b,
     - 		struct patch_util *util = b->items[j].util;
     - 
     - 		c = util->matching < 0 ?
     --			util->diffsize * creation_factor / 100 : COST_MAX;
     -+			    util->diffsize * creation_factor / 100 :
     -+			    COST_MAX;
     - 		for (i = a->nr; i < n; i++)
     - 			cost[i + n * j] = c;
     - 	}
     -@@ range-diff.c: static void output(struct string_list *a, struct string_list *b,
     - 		if (i < a->nr && a_util->matching < 0) {
     - 			if (!range_diff_opts->right_only)
     - 				output_pair_header(&opts, patch_no_width,
     --					   &buf, &dashes, a_util, NULL);
     -+						   &buf, &dashes, a_util, NULL);
     - 			i++;
     - 			continue;
     - 		}
     -@@ range-diff.c: static void output(struct string_list *a, struct string_list *b,
     - 		while (j < b->nr && b_util->matching < 0) {
     - 			if (!range_diff_opts->left_only)
     - 				output_pair_header(&opts, patch_no_width,
     --					   &buf, &dashes, NULL, b_util);
     -+						   &buf, &dashes, NULL, b_util);
     - 			b_util = ++j < b->nr ? b->items[j].util : NULL;
     - 		}
     - 
      @@ range-diff.c: int show_range_diff(const char *range1, const char *range2,
       	if (!res) {
       		find_exact_matches(&branch1, &branch2);

-- 
gitgitgadget
