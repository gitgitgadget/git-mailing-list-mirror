Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9583C45C700
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197147; cv=none; b=JoW3D5+r+t+NPpweuWmrl1L4Ztt6C7kHQEeEOlckY58CXfpz5J5S2mE2YIKwZ+SAVWg+Pkt7uSsqHcdd9yDzfZvyuefLUNTHS0ZlqUGnzuvo4mENUlXPI5erGT+GUSITru8V9y5Nn45QqReZs6AG5WdOKKWwz2rKS9rPwGiRxyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197147; c=relaxed/simple;
	bh=2ovwkc6HBABX6A5KBKrpwWXPG5atESsb+RsdtrXof/Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Em9d/RUoxoRzkQHlmT7j7eEXTXGaL8e6ggoobIDpbWL4XxRlX7eHSImRUyDQfX/erVEPl8tw6F1jNGWdkxHHq1V+x8TodQpZ/lS67buNO7cmA5u43Q926B7xBExY6VBx/PLDmymtWqIh2zL1yzZslLqkaCGes4Re46r64mxDkK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA+GD7Oa; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA+GD7Oa"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-530187593e0so1355471cf.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788197144; x=1788801944; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E4UBUjPI4oeYs5u+kf1SnNxZqGbrpmyS9dm8AO5eStU=;
        b=PA+GD7OakuG2fv0lTMzmrCvPAvNecTkk3qmzbK739iBoB7iBpu1phjdiTK4p+tahVd
         KJ0GFcxtHWNQCtbfWqFrqC9cpHCrQh8nSDunJSlm+IcWQLB43SPWzgsEgBOR3agPDXoW
         H0tUIaP+OBCYDeZt5rMVuu2/rYT9kyhug5CToanoPCRt9F/C+H3/nuj9FYPRUeLhyL9C
         /nXfLXbyGrqhig8ucMF8+ac5urnZ1yzilbTfYqvRD2gZO5d9uptJ3OTQmnJcnWzMMjAt
         wpyJ38GgsAw73MHzzT/TBHxiFhUPQ6eYM4hYWYBS3hLiJ3kz+1zkveeUadls+hWWxSR9
         O6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788197144; x=1788801944;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E4UBUjPI4oeYs5u+kf1SnNxZqGbrpmyS9dm8AO5eStU=;
        b=VauLuLYCUUCx3FryV0aH3CqIYeW8JAhtPSW/qIpmV1OzI3C60UWEgq4ZfeN77wGwW2
         n31L2KZV6caRwUiSvDe0QfpoxzNfn5EpIF8w4ReQ69YCCrPwCfIYWOOw/A5EPuX7HT3g
         +LtgWr4KiONRUnPz9ElE1fBKMPDVBBSOMybvK13fXp2i2mY1iP4H1GzDvWX308AnLNSV
         LFPFzD/O3cs+num7Jg63sNIJMK8zXoq7Ef+PWLIoxa2UjFgMmo9Z0JnWalanNJRbHMVT
         7jZuKIXy/a44s2fciSeqMPlOu6NK3UwvC+gUdnfZluDAa9zcicaSgd0q8bb4wEdo1bC8
         LcrQ==
X-Gm-Message-State: AFuF++lwH+pA5cRw8LMawZmzIlbGU2VrvLzjscSaUTqkkbtMMKzcnRXk
	OU4KB7xFfK0hAC6k+JXev3gfdCdOy/N1bpKAsJJaYr/5old9FlVjpmMVLNHVKQ==
X-Gm-Gg: AR+sD12p8U5JTxBqc8BaPAr6UhIIlzgQxr8xyfsjPHaQQaxCgmJsxFgXAOKnGog+cgh
	SDIwegshlXtIf9CE49dpGklWM6YlX0nU4vpZVfw1cc8oiSDOSAT58wb1mOjakCQ1uRPkJB7MJNY
	S/wBpG/IQY0uvhjPEVfvlEtGFT7jv1XaYFyKD5D/nZUaUwfNbXqTakjVScTY4ihBnQy/3/HMS+I
	gnfwq1B1SWWCCc2xEHFIWtKm9T0TU3jQtJrHoK6IU8yRh+df4XRgvjVU9Koe/48BMvzVeNAw5Nk
	yEY6MgyFqqY0w6hq21inbUsI+S40M2WnzJ3B1/8oKYyPsV79HfLJXYIedk54iUaUVkUR6CEk2Ws
	EhRoCHozypqODgPX/HFb8Um9W8wllBbpv5oSaSWTwFvtUNXp9ALPTW4WMFCIeIl4/FYCZUZ1dYG
	HEo5evN97x/fJp0Vz9vuczmHb6J07U3GsmTPjDS5UBaZ8ilalVHluQgn3KnZZoPZcZ
X-Received: by 2002:ac8:5a02:0:b0:52e:f66:f1a5 with SMTP id d75a77b69052e-5300b7568e3mr101863911cf.5.1788197144167;
        Mon, 31 Aug 2026 10:25:44 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.223.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52fbe7fbe06sm77336341cf.17.2026.08.31.10.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 10:25:43 -0700 (PDT)
Message-Id: <pull.2178.v3.git.1788197143.gitgitgadget@gmail.com>
In-Reply-To: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Aug 2026 17:25:36 +0000
Subject: [PATCH v3 0/7] trace2: stop allowing die()
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
    Taylor Blau <ttaylorr@openai.com>,
    Elijah Newren <newren@gmail.com>,
    Jeff King <peff@peff.net>,
    Derrick Stolee <stolee@gmail.com>

NOTE: this v3 is rebased onto a recent 'master' due to conflicts in a test
script.

After v1 was posted, based on a concrete example of tracing leading to a
recursive die() problem, more evidence has come up to imply that allocations
are failing for some users more often. This is potentially an issue with the
allocator chosen by Git for Windows, which is being discussed elsewhere.

But the conclusion is this: the trace2 API shouldn't call helpers that might
call die(). It's too low-level for that.

In this v2, I have a much more robust approach to removing die() from the
trace2 API.

This starts with a new banned-die.h header file at the root of the repo and
including it from all trace2 API *.c files. It starts empty, but the later
patches will add one method at a time:

 * xsnprintf() : This is the original patch, but made more complete by
   adding the method to banned-die.h.
 * xstrdup()
 * ALLOC_ARRAY()
 * xstrfmt()
 * ALLOC_GROW()
 * xcalloc()

During each patch, the goal was to have the trace2 logic be "as correct as
possible" when an allocation failure occurs. This may mean that we have
incomplete messages or dropped trace messages.

The focus here is that the trace2 API should never cause a process-ending
failure, because those failures will trigger trace2 API calls while
reporting the failure.


Updates in V3
=============

 * Peff correctly points out that this is far from complete, as the strbuf
   library is not safe from die(). The banned-die.h provides incremental
   demonstration that these changes are showing progress and preventing
   regression in future changes, but not showing a complete picture. I will
   start an investigation into a "safe" or "gentle" variant of the strbuf
   API as a potential direction for these API layers.
 * The first patch had a lowercase banned() that should have been uppercase
   BANNED().
 * A 'return -1' was replaced with 'return 0' to avoid a misleading error
   message.
 * The ":<REDACTED>" string length was incorrect. This is fixed and tests
   are improved to cover this string manipulation. These test changes
   conflict with changes to use test_grep in 47f79f61983 (t: convert grep
   assertions to test_grep, 2026-07-06), so this v3 is rebased onto
   'master'.
 * Patch 6 was previously failing at runtime. The appropriate fix is pulled
   out of patch 7 and into patch 6.

Thanks, -Stolee

Derrick Stolee (7):
  banned-die: create header for banning of functions
  trace2: tolerate failed timestamp formatting
  trace2: remove use of xstrdup()
  trace2: remove use of ALLOC_ARRAY()
  trace2: remove use of xstrfmt()
  trace2: remove use of ALLOC_GROW()
  trace2: remove use of xcalloc()

 banned-die.h            | 32 +++++++++++++++++
 t/t0212-trace2-event.sh | 12 ++++---
 trace2.c                | 52 +++++++++++++++++++++++++---
 trace2/tr2_cfg.c        |  2 ++
 trace2/tr2_cmd_name.c   |  2 ++
 trace2/tr2_ctr.c        | 12 ++++++-
 trace2/tr2_dst.c        |  2 ++
 trace2/tr2_sid.c        |  2 ++
 trace2/tr2_sysenv.c     |  8 +++--
 trace2/tr2_tbuf.c       | 51 +++++++++++++++++++--------
 trace2/tr2_tgt_event.c  |  2 ++
 trace2/tr2_tgt_normal.c |  2 ++
 trace2/tr2_tgt_perf.c   |  2 ++
 trace2/tr2_tls.c        | 77 +++++++++++++++++++++++++++++++++++++++--
 trace2/tr2_tls.h        |  7 ++++
 trace2/tr2_tmr.c        | 16 +++++++--
 16 files changed, 250 insertions(+), 31 deletions(-)
 create mode 100644 banned-die.h


base-commit: c73e85354c275c9d409b26445089bc16940fc527
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2178%2Fderrickstolee%2Ftrace2-dont-die-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2178/derrickstolee/trace2-dont-die-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2178

Range-diff vs v2:

 1:  84634717e2 ! 1:  c483a4bf76 banned-die: create header for banning of functions
     @@ banned-die.h (new)
      + */
      +
      +#undef die
     -+#define die banned(die)
     ++#define die BANNED(die)
      +
      +#endif /* BANNED_DIE_H */
      
     @@ trace2.c
       #include "trace2/tr2_tgt.h"
       #include "trace2/tr2_tls.h"
       #include "trace2/tr2_tmr.h"
     ++/* banned-die must be last. */
      +#include "banned-die.h"
       
       static int trace2_enabled;
     @@ trace2/tr2_cfg.c
       #include "trace2/tr2_cfg.h"
       #include "trace2/tr2_sysenv.h"
       #include "wildmatch.h"
     ++/* banned-die must be last. */
      +#include "banned-die.h"
       
       static struct string_list tr2_cfg_patterns = STRING_LIST_INIT_DUP;
     @@ trace2/tr2_cmd_name.c
       #include "git-compat-util.h"
       #include "strbuf.h"
       #include "trace2/tr2_cmd_name.h"
     ++/* banned-die must be last. */
      +#include "banned-die.h"
       
       #define TR2_ENVVAR_PARENT_NAME "GIT_TRACE2_PARENT_NAME"
     @@ trace2/tr2_ctr.c
       #include "trace2/tr2_tgt.h"
       #include "trace2/tr2_tls.h"
       #include "trace2/tr2_ctr.h"
     ++/* banned-die must be last. */
      +#include "banned-die.h"
       
       /*
     @@ trace2/tr2_dst.c
       #include "trace2/tr2_dst.h"
       #include "trace2/tr2_sid.h"
       #include "trace2/tr2_sysenv.h"
     ++/* banned-die must be last. */
      +#include "banned-die.h"
       
       /*
     @@ trace2/tr2_sid.c
       #include "strbuf.h"
       #include "trace2/tr2_tbuf.h"
       #include "trace2/tr2_sid.h"
     ++/* banned-die must be last. */
      +#include "banned-die.h"
       
       #define TR2_ENVVAR_PARENT_SID "GIT_TRACE2_PARENT_SID"
     @@ trace2/tr2_sysenv.c
       #include "config.h"
       #include "dir.h"
       #include "tr2_sysenv.h"
     ++/* banned-die must be last. */
      +#include "banned-die.h"
       
       /*
     @@ trace2/tr2_tbuf.c
      @@
       #include "git-compat-util.h"
       #include "tr2_tbuf.h"
     ++/* banned-die must be last. */
      +#include "banned-die.h"
       
       void tr2_tbuf_local_time(struct tr2_tbuf *tb)
     @@ trace2/tr2_tgt_event.c
       #include "trace2/tr2_tgt.h"
       #include "trace2/tr2_tls.h"
       #include "trace2/tr2_tmr.h"
     ++/* banned-die must be last. */
      +#include "banned-die.h"
       
       static struct tr2_dst tr2dst_event = {
     @@ trace2/tr2_tgt_normal.c
       #include "trace2/tr2_tgt.h"
       #include "trace2/tr2_tls.h"
       #include "trace2/tr2_tmr.h"
     ++/* banned-die must be last. */
      +#include "banned-die.h"
       
       static struct tr2_dst tr2dst_normal = {
     @@ trace2/tr2_tgt_perf.c
       #include "trace2/tr2_tgt.h"
       #include "trace2/tr2_tls.h"
       #include "trace2/tr2_tmr.h"
     ++/* banned-die must be last. */
      +#include "banned-die.h"
       
       static struct tr2_dst tr2dst_perf = {
     @@ trace2/tr2_tls.c
       #include "thread-utils.h"
       #include "trace.h"
       #include "trace2/tr2_tls.h"
     ++/* banned-die must be last. */
      +#include "banned-die.h"
       
       /*
     @@ trace2/tr2_tmr.c
       #include "trace2/tr2_tls.h"
       #include "trace2/tr2_tmr.h"
       #include "trace.h"
     ++/* banned-die must be last. */
      +#include "banned-die.h"
       
       #define MY_MAX(a, b) ((a) > (b) ? (a) : (b))
 2:  bd45f46a34 ! 2:  754fffb74e trace2: tolerate failed timestamp formatting
     @@ Commit message
       ## banned-die.h ##
      @@
       #undef die
     - #define die banned(die)
     + #define die BANNED(die)
       
      +#undef xsnprintf
      +#define xsnprintf(...) BANNED(xsnprintf)
 3:  ec447a6a77 ! 3:  87d3f1b557 trace2: remove use of xstrdup()
     @@ Commit message
          trace2/tr2_sysenv.c.
      
          First, in tr2_sysenv_cb(), we need to handle a failed assignment of the
     -    value with a negative return to halt the config parsing loop.
     +    value with a zero-valued return to halt the config parsing loop. Note
     +    that we don't want to use a negative return here or we would imply to
     +    the config system that the config key or value was somehow invalid; such
     +    an output would mask the real issue that the process failed to allocate
     +    memory.
      
          Second, in tr2_sysenv_get(), the method will return NULL when strdup()
          returns NULL. This return is indistinguishable from the environment variable
     @@ Commit message
          failure at this level will likely lead to failure in another system, but at
          least the trace2 API will not cause the process to fail early.
      
     +    Helped-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## banned-die.h ##
     @@ trace2/tr2_sysenv.c: static int tr2_sysenv_cb(const char *key, const char *value
      -			tr2_sysenv_settings[k].value = xstrdup(value);
      +			tr2_sysenv_settings[k].value = strdup(value);
      +			if (!tr2_sysenv_settings[k].value)
     -+				return -1;
     ++				return 0;
       			return 0;
       		}
       	}
 4:  db6858d381 = 4:  5bf6ab91f3 trace2: remove use of ALLOC_ARRAY()
 5:  7f0bb405ad ! 5:  3e419c5522 trace2: remove use of xstrfmt()
     @@ Commit message
          construct redacted data to avoid copying password information in traced
          URLs.
      
     +    Update t0212 to more carefully test this behavior to explicitly include
     +    the ":<REDACTED>" string in the appropriate context.
     +
     +    Helped-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## banned-die.h ##
     @@ banned-die.h
       #define ALLOC_ARRAY(x, alloc) BANNED(ALLOC_ARRAY)
       
      
     + ## t/t0212-trace2-event.sh ##
     +@@ t/t0212-trace2-event.sh: test_expect_success 'unsafe URLs are redacted by default in cmd_start events' '
     + 
     + 	GIT_TRACE2_EVENT="$(pwd)/trace.event" \
     + 		test-tool trace2 300redact_start git clone https://user:pwd@example.com/ clone2 &&
     +-	test_grep ! user:pwd trace.event
     ++	test_grep ! user:pwd trace.event &&
     ++	test_grep "user:<REDACTED>@example.com/" trace.event
     + '
     + 
     + test_expect_success 'unsafe URLs are redacted by default in child_start events' '
     +@@ t/t0212-trace2-event.sh: test_expect_success 'unsafe URLs are redacted by default in child_start events'
     + 
     + 	GIT_TRACE2_EVENT="$(pwd)/trace.event" \
     + 		test-tool trace2 301redact_child_start git clone https://user:pwd@example.com/ clone2 &&
     +-	test_grep ! user:pwd trace.event
     ++	test_grep ! user:pwd trace.event &&
     ++	test_grep "user:<REDACTED>@example.com/" trace.event
     + '
     + 
     + test_expect_success 'unsafe URLs are redacted by default in exec events' '
     +@@ t/t0212-trace2-event.sh: test_expect_success 'unsafe URLs are redacted by default in exec events' '
     + 
     + 	GIT_TRACE2_EVENT="$(pwd)/trace.event" \
     + 		test-tool trace2 302redact_exec git clone https://user:pwd@example.com/ clone2 &&
     +-	test_grep ! user:pwd trace.event
     ++	test_grep ! user:pwd trace.event &&
     ++	test_grep "user:<REDACTED>@example.com/" trace.event
     + '
     + 
     + test_expect_success 'unsafe URLs are redacted by default in def_param events' '
     +@@ t/t0212-trace2-event.sh: test_expect_success 'unsafe URLs are redacted by default in def_param events' '
     + 
     + 	GIT_TRACE2_EVENT="$(pwd)/trace.event" \
     + 		test-tool trace2 303redact_def_param url https://user:pwd@example.com/ &&
     +-	test_grep ! user:pwd trace.event
     ++	test_grep ! user:pwd trace.event &&
     ++	test_grep "user:<REDACTED>@example.com/" trace.event
     + '
     + 
     + test_done
     +
       ## trace2.c ##
      @@ trace2.c: int trace2_is_enabled(void)
       static const char *redact_arg(const char *arg)
     @@ trace2.c: static const char *redact_arg(const char *arg)
      +	suffix_len = strlen(p + at);
      +
      +	if (unsigned_add_overflows(prefix_len, suffix_len) ||
     -+	    unsigned_add_overflows(prefix_len + suffix_len, redact_len))
     ++	    unsigned_add_overflows(prefix_len + suffix_len, redact_len) ||
     ++	    unsigned_add_overflows(prefix_len + suffix_len + redact_len, 1))
      +		return NULL;
      +
     -+	redacted_len = prefix_len + suffix_len + redact_len;
     ++	redacted_len = prefix_len + suffix_len + redact_len + 1;
      +
      +	redacted = malloc(redacted_len);
      +	if (!redacted)
      +		return NULL;
      +
      +	memcpy(redacted, arg, prefix_len);
     -+	memcpy(redacted + prefix_len, redact, redact_len - 1);
     -+	memcpy(redacted + prefix_len + redact_len - 1, p + at,
     -+	       suffix_len + 1);
     ++	memcpy(redacted + prefix_len, redact, redact_len);
     ++	memcpy(redacted + prefix_len + redact_len, p + at, suffix_len + 1);
      +	return redacted;
       }
       
 6:  120cf1967b ! 6:  ccd284fbeb trace2: remove use of ALLOC_GROW()
     @@ Commit message
          deepening the stack, giving as much nesting behavior as possible without
          failing the entire process.
      
     +    Helped-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## banned-die.h ##
     @@ trace2/tr2_tls.c: void tr2tls_unset_self(void)
      +		return;
      +	}
      +
     -+	if (ctx->nr_open_regions < ctx->alloc)
     -+		return;
     ++	if (ctx->nr_open_regions >= ctx->alloc) {
     ++		if (ctx->alloc >
     ++		    SIZE_MAX / (2 * sizeof(*ctx->array_us_start))) {
     ++			ctx->nr_skipped_regions++;
     ++			return;
     ++		}
     ++		new_alloc = ctx->alloc * 2;
      +
     -+	if (ctx->alloc > SIZE_MAX / (2 * sizeof(*ctx->array_us_start))) {
     -+		ctx->nr_skipped_regions++;
     -+		return;
     -+	}
     -+	new_alloc = ctx->alloc * 2;
     ++		new_array = realloc(ctx->array_us_start,
     ++				    new_alloc * sizeof(*ctx->array_us_start));
     ++		if (!new_array) {
     ++			ctx->nr_skipped_regions++;
     ++			return;
     ++		}
      +
     -+	new_array = realloc(ctx->array_us_start,
     -+			    new_alloc * sizeof(*ctx->array_us_start));
     -+	if (!new_array) {
     -+		ctx->nr_skipped_regions++;
     -+		return;
     ++		ctx->array_us_start = new_array;
     ++		ctx->alloc = new_alloc;
      +	}
     -+
     -+	ctx->array_us_start = new_array;
     -+	ctx->alloc = new_alloc;
       
      -	ALLOC_GROW(ctx->array_us_start, ctx->nr_open_regions + 1, ctx->alloc);
       	ctx->array_us_start[ctx->nr_open_regions++] = us_now;
 7:  c8fc195a2a ! 7:  fa10e8d246 trace2: remove use of xcalloc()
     @@ trace2/tr2_tls.c: void tr2tls_push_self(uint64_t us_now)
       	uint64_t *new_array;
       	size_t new_alloc;
       
     --	if (ctx->nr_skipped_regions) {
     --		ctx->nr_skipped_regions++;
     --		return;
     --	}
     --
     --	if (ctx->nr_open_regions < ctx->alloc)
      +	if (tr2tls_is_fallback(ctx))
     - 		return;
     - 
     --	if (ctx->alloc > SIZE_MAX / (2 * sizeof(*ctx->array_us_start))) {
     -+	if (ctx->nr_skipped_regions) {
     ++		return;
     ++
     + 	if (ctx->nr_skipped_regions) {
       		ctx->nr_skipped_regions++;
       		return;
     - 	}
     --	new_alloc = ctx->alloc * 2;
     - 
     --	new_array = realloc(ctx->array_us_start,
     --			    new_alloc * sizeof(*ctx->array_us_start));
     --	if (!new_array) {
     --		ctx->nr_skipped_regions++;
     --		return;
     -+	if (ctx->nr_open_regions >= ctx->alloc) {
     -+		if (ctx->alloc >
     -+		    SIZE_MAX / (2 * sizeof(*ctx->array_us_start))) {
     -+			ctx->nr_skipped_regions++;
     -+			return;
     -+		}
     -+		new_alloc = ctx->alloc * 2;
     -+
     -+		new_array = realloc(ctx->array_us_start,
     -+				    new_alloc * sizeof(*ctx->array_us_start));
     -+		if (!new_array) {
     -+			ctx->nr_skipped_regions++;
     -+			return;
     -+		}
     -+
     -+		ctx->array_us_start = new_array;
     -+		ctx->alloc = new_alloc;
     - 	}
     - 
     --	ctx->array_us_start = new_array;
     --	ctx->alloc = new_alloc;
     --
     - 	ctx->array_us_start[ctx->nr_open_regions++] = us_now;
     - }
     - 
      @@ trace2/tr2_tls.c: void tr2tls_pop_self(void)
       {
       	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();

-- 
gitgitgadget
