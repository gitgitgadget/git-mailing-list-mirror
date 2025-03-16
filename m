Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B70F16F282
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742107329; cv=none; b=Jfg3DAvfHDtPmhpJrbjBt1mbnliGqCrA8D1y6npToV1PV4IB6pzyao8sELRbpLIaJJ48iUX4yQsj+d8irJqRwhd7Ros9ZKQL7yS+PwjHZQZVDEEBveOqwvWI6ThpJncq6ySvicxqt0OfHmNQKGBMyS1lJHbANLfuawZGngoNZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742107329; c=relaxed/simple;
	bh=ZGogjwM/0atSSLaghuPJkK5zqZ1S/YH6MludFo/IKXU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ILt5zPcbTgA2GIluBm49taX1aiV44wMqXPNssnnTXSoi0594oPHA+b1txfeC1bZBZ2VHHs8VXOqXc78ZgqbXw/9NO0LNmXaT0QC70oVWhEx+I9kqmHAW0houyXWbZSNE84gLK+D+z1KvaPZZmhvjMWehVN3TXrSRn5qctSpXaKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhGjoBWT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhGjoBWT"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso7363035e9.3
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 23:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742107325; x=1742712125; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcvlNJLPB1uWY32mUCNxzjxUYDnX2VNOB3ObzhubuxQ=;
        b=KhGjoBWTlHWjMk68U+7s414dIId+zvxa7cKRFGNnPfzz8qrT5NpQ+MGv0mAKhRisKW
         7ZfF+H7BmybvZ6TDF4NF7b/bLtEcNB42poFGi+uDll3U6UDXNUO2IP6rXC5cGwnfaMln
         KRHqduWHXSmFuTbBXdrasxyqNWC+VuNHJ7D1Nb+PUR0DQ8rvJ/uqiGpPF1FRvoi0hCuC
         FLOJKqaQZ3RLk3xf3LbZCAXaN/XzRNijo1Y/9BMQhR3be/pvSIBcoIE5fXz2nJ0w7NLE
         XeN0BApuGvJSA0LIrceCbOJTbr2DT4JBoptPhibkfI4WclouFJSpfyZhtPazUzUMUmsN
         Yy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742107325; x=1742712125;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcvlNJLPB1uWY32mUCNxzjxUYDnX2VNOB3ObzhubuxQ=;
        b=GdNl+pagl2R9BYgUGnVuPQXnrDaYQPRlrRU6cSPRHhrVGbcywkPGwpWsbylycotJmt
         xgzZP4ecH032lCY4QMgTTuIbAND+PLi+hJuWOpqQ4K9FBvIa/WcnH6YydOyIoSFwaRLd
         weDdSddZPHAslFOHUelSVnLL0OSlCa+MWNWHV0UtoupdGCU+fHO4H+7zIyOf1f5NOw/h
         pVbSjisSSvaiBPTw5eL8BTeg59ZsVB59GElD9W6a1ebT3Rp2361fZ8yBJwTue7Bat1D0
         jAdwZLyYdehhroGNQjUOySNDc7wfLt3sk8SZ0b4toqKdeRfoHiUqhjpWqAx/CNDNaAIC
         l8PA==
X-Gm-Message-State: AOJu0YykxEslo16KX2jAl4yicfEy8qode1tNLLN3P0O3qzP2iyptmzAl
	wn/HMBYzOKjO+1ewLZCeXvRlNKWpbk1JGehcgAQHl7Mvvvd9Ik89BjRbIA==
X-Gm-Gg: ASbGnctzinDqpUJHt6wx4c5Bc/dJIGqAxb6JZdjrA7qvgDvVM6Gro8mm+S92dg+BL/x
	R7xNYEV1fByPIiTkE9iwIv+bOe5DOZFcqw4GCQ+5xgjlNulIKSgZUpjKSEsPmcqG/Jk13/FJB85
	Wj8t8npJRXeVCWk9MYqbWpEKK2SNZhNwOQJsRxgbe1guYQQSyzvYKn8bP27a1XVP1+gV4/XSBIF
	BMZ7Vn4B+vvtqZ7BRwHoo7gbkSVXU7Mv5dXqsQQBS95R3ciYLK2S2DHBbcfuQwDvtjbId5r2ygD
	N3iXKwdi3eEuY+sqa+W9jdkJpJKyna53EkXQ/XiyGcr94w==
X-Google-Smtp-Source: AGHT+IFOAZ7uJMS84Xrw1kaVE+dBRhFQSdAiRCThx9pizUem/q++mMIsRdnZvVA+JRUvMyrtJ9t3oA==
X-Received: by 2002:a05:6000:1fa5:b0:390:f55b:ba94 with SMTP id ffacd0b85a97d-3971d3336e4mr10862251f8f.13.1742107325530;
        Sat, 15 Mar 2025 23:42:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318a96sm11348945f8f.69.2025.03.15.23.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:42:05 -0700 (PDT)
Message-Id: <58cb8f6a1609b10d761e86bdad541d1c018cb582.1742107322.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
	<pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 16 Mar 2025 06:42:01 +0000
Subject: [PATCH v2 2/3] ci: add build checking for side-effects in assert()
 calls
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

It is a big no-no to have side-effects in an assertion, because if the
assert() is compiled out, you don't get that side-effect, leading to the
code behaving differently.  That can be a large headache to debug.

We have roughly 566 assert() calls in our codebase (my grep might have
picked up things that aren't actually assert() calls, but most appeared
to be).  All but 9 of them can be determined by gcc to be free of side
effects with a clever redefine of assert() provided by Bruno De Fraine
(from
https://stackoverflow.com/questions/10593492/catching-assert-with-side-effects),
who upon request has graciously placed his two-liner into the public
domain without warranty of any kind.  The current 9 assert() calls
flagged by this clever redefinition of assert() appear to me to be free
of side effects as well, but are too complicated for a compiler/linker
to figure that since each assertion involves some kind of function call.
Add a CI job which will find and report these possibly problematic
assertions, and have the job suggest to the user that they replace these
with BUG_IF_NOT() calls.

Example output from running:

```
ERROR: The compiler could not verify the following assert()
       calls are free of side-effects.  Please replace with
       BUG_IF_NOT() calls.
/home/newren/floss/git/diffcore-rename.c:1409
	assert(!dir_rename_count || strmap_empty(dir_rename_count));
/home/newren/floss/git/merge-ort.c:1645
			assert(renames->deferred[side].trivial_merges_okay &&
			       !strset_contains(&renames->deferred[side].target_dirs,
						path));
/home/newren/floss/git/merge-ort.c:794
	assert(omittable_hint ==
	       (!starts_with(type_short_descriptions[type], "CONFLICT") &&
		!starts_with(type_short_descriptions[type], "ERROR")) ||
	       type == CONFLICT_DIR_RENAME_SUGGESTED);
/home/newren/floss/git/merge-recursive.c:1200
	assert(!merge_remote_util(commit));
/home/newren/floss/git/object-file.c:2709
	assert(would_convert_to_git_filter_fd(istate, path));
/home/newren/floss/git/parallel-checkout.c:280
	assert(is_eligible_for_parallel_checkout(pc_item->ce, &pc_item->ca));
/home/newren/floss/git/scalar.c:244
	assert(have_fsmonitor_support());
/home/newren/floss/git/scalar.c:254
	assert(have_fsmonitor_support());
/home/newren/floss/git/sequencer.c:4968
		assert(!(opts->signoff || opts->no_commit ||
			 opts->record_origin || should_edit(opts) ||
			 opts->committer_date_is_author_date ||
			 opts->ignore_date));
```

Note that if there are possibly problematic assertions, not necessarily
all of them will be shown in a single run, because the compiler errors
may include something like "ld: ... more undefined references to
`not_supposed_to_survive' follow" instead of listing each individually.
But in such cases, once you clean up a few that are shown in your first
run, subsequent runs will show (some of) the ones that remain, allowing
you to iteratively remove them all.

Helped-by: Bruno De Fraine <defraine@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Makefile                      |  4 ++++
 ci/check-unsafe-assertions.sh | 18 ++++++++++++++++++
 ci/run-static-analysis.sh     |  2 ++
 git-compat-util.h             |  6 ++++++
 4 files changed, 30 insertions(+)
 create mode 100755 ci/check-unsafe-assertions.sh

diff --git a/Makefile b/Makefile
index 7315507381e..57774912f18 100644
--- a/Makefile
+++ b/Makefile
@@ -2261,6 +2261,10 @@ ifdef WITH_BREAKING_CHANGES
 	BASIC_CFLAGS += -DWITH_BREAKING_CHANGES
 endif
 
+ifdef CHECK_ASSERTION_SIDE_EFFECTS
+	BASIC_CFLAGS += -DCHECK_ASSERTION_SIDE_EFFECTS
+endif
+
 ifdef INCLUDE_LIBGIT_RS
 	# Enable symbol hiding in contrib/libgit-sys/libgitpub.a without making
 	# us rebuild the whole tree every time we run a Rust build.
diff --git a/ci/check-unsafe-assertions.sh b/ci/check-unsafe-assertions.sh
new file mode 100755
index 00000000000..d66091efd22
--- /dev/null
+++ b/ci/check-unsafe-assertions.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+
+make CHECK_ASSERTION_SIDE_EFFECTS=1 >compiler_output 2>compiler_error
+if test $? != 0
+then
+    echo "ERROR: The compiler could not verify the following assert()" >&2
+    echo "       calls are free of side-effects.  Please replace with" >&2
+    echo "       BUG_IF_NOT() calls." >&2
+    grep undefined.reference.to..not_supposed_to_survive compiler_error \
+      | sed -e s/:[^:]*$// | sort | uniq | tr ':' ' ' \
+      | while read f l
+      do
+	printf "${f}:${l}\n  "
+	awk -v start="$l" 'NR >= start { print; if (/\);/) exit }' $f
+      done
+    exit 1
+fi
+rm compiler_output compiler_error
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index 0d51e5ce0e7..ae714e020ae 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -31,4 +31,6 @@ exit 1
 
 make check-pot
 
+${0%/*}/check-unsafe-assertions.sh
+
 save_good_tree
diff --git a/git-compat-util.h b/git-compat-util.h
index c3415ad7e0a..0aefd763751 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1584,4 +1584,10 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
 	((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))
 #endif /* !__GNUC__ */
 
+#ifdef CHECK_ASSERTION_SIDE_EFFECTS
+#undef assert
+extern int not_supposed_to_survive;
+#define assert(expr) ((void)(not_supposed_to_survive || (expr)))
+#endif /* CHECK_ASSERTION_SIDE_EFFECTS */
+
 #endif
-- 
gitgitgadget

