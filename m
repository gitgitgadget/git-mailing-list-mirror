Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18131E0DB0
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401385; cv=none; b=C/XXOCDG7LcHcZlK/sigIWjEve58Ulb7jKr2sFsws5ONN51tOEmKCuHo7AsKYB3M+SVVr3J+XUs8/LmtE4MhoJAMF45Na0hpGK6j18AqLZFF7kBkkz9i1WNmE3HW9FAS9RLktv1B3WGr6g3kYfHUbul8O1wd7nezghDaqVS/+ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401385; c=relaxed/simple;
	bh=kYQ10SePTXifM4QIBdEmOs7Tst46SiY1dJClmfg47ew=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hqK/XVEzT7P6o2NvEiFtYQpoNf+JZD51G5tms/A5NobuTAGDlDzbNNAJY4Jj+IWNMp9emwQzZkujwqIosxhz/psAppYBhst0tcxyhnteONY+kWoVtNTkmKtFA1YVXamfObC/ooh/gzxAY2pyBp2zg0D8NvNb77zN/6Rg+oLCI0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATn57X1X; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATn57X1X"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf848528aso39609405e9.2
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742401382; x=1743006182; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcRVSK1z3QYUBFhTWTicJ+gSXwZ7M8l19dxJfzK4uk4=;
        b=ATn57X1XGyA7g1AXK4omJkfw0++b5QfpdfdjI1BwO75TSQcw3nqc3YYqinOBNO1jwX
         gkHRH49stVOTh/zsdOnFC80+jaRlKwxdIjLD9+IZaMdHKHweU2N2Ep/722i6qEVlqADl
         Dn8SvjXhtEcSNVHk8UVW6xwZpU80ED5+weSW4mB8csRdkHwyQ4Ij5KXdomJIP+6hxBCJ
         72Se0AcGxEtggaiYqC/EUGa6gbR49z7st2736ckp6gSrnn8cWa+4NU9zHJEHRRwH0iJh
         KKPtu3XDQ/WH3FlNxUNbaJkkBMa45wUcOq2fY7mTb/C1GxJEqaNCAzb2X7skJVuf44dt
         DiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742401382; x=1743006182;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcRVSK1z3QYUBFhTWTicJ+gSXwZ7M8l19dxJfzK4uk4=;
        b=KoLhmPWABgpmHocLW6rlN2QXR85nzMBMkTKM25IY/K9TJ2bAZ0xSMs5Og7KBBLX3m5
         Rtm8D8KhyZ+mlPoIUIclssL84X0zE4i41SOy65eZCxRm+I1A+XrQJ02weY/3IzQxUwDp
         w180eATYihcBy03LEOAHxy0lthqwipYhfVFSuGrVHi++IBX5HY5O85FXb/5KzIAa0NsJ
         uPAGyGdVHbpak7alVqeQ2+rFlwpp5t5FwWb1qJxhFQw60EYydZFvjnqO0TbBffQC33fN
         goVYNTxR/NP5xMt84kCRm25FWcg5yeU+G50ASji3MepzDQzPgX6K8LbR89ZdIZ9D35+h
         Sw2A==
X-Gm-Message-State: AOJu0YztlXkmQLWJB1p1nquNuLasqJSaMNAYEMRePUWgSXgTf1rm8R6/
	ahd1y8mPuOTvXheDbJOafYLjRwVBboQQuK+4fdCqEMGkL9GXfxYzqETo9A==
X-Gm-Gg: ASbGncs79iOgdNnDGg63FeqPMC2o/VOE2QZP7CFaagh+3Z7hHeokDcYjKtaYY/hnJSV
	QaYedfEOLcOkZTlOSGQ65ADsGojemjp8lPA2frcEh0G046M5mZcP6wtgnSFtaU3HFWIH5n+48vY
	mT0CI8icACby4RPcsgvN+ifWHhuocBD67TeqtRp4w7fMWmi6dTQEf2H+tskk7ziOle5HUbKdfKC
	tCQZmwVKG9t91CGdsf2Rfm3ilWQO8HUZrkBvtc8JD5n3PX1vOw2CCKfNbgwhxqV6CYsK+N3DJOX
	r9SvExEaHOetDpWFJy7/YpF687SJ5HmMFcPNVkkQogNYAHVXGwHHaaXv
X-Google-Smtp-Source: AGHT+IEq9BeBbtoNhrNUflapAow6l3pX3uaCf0sorGCIWoUliNBA161396dy1FsPu/56VoHihE1Z6A==
X-Received: by 2002:a5d:64c5:0:b0:390:e62e:f31f with SMTP id ffacd0b85a97d-399739b4353mr2635263f8f.3.1742401381760;
        Wed, 19 Mar 2025 09:23:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b2bsm20947161f8f.26.2025.03.19.09.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:23:01 -0700 (PDT)
Message-Id: <223d8c0ca2a9f78ae9e281773037cc5673f0637a.1742401378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1881.v3.git.1742401378.gitgitgadget@gmail.com>
References: <pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
	<pull.1881.v3.git.1742401378.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Mar 2025 16:22:57 +0000
Subject: [PATCH v3 2/3] ci: add build checking for side-effects in assert()
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
    Taylor Blau <me@ttaylorr.com>,
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
with ASSERT() calls.

Example output from running:

```
ERROR: The compiler could not verify the following assert()
       calls are free of side-effects.  Please replace with
       ASSERT() calls.
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
index 00000000000..233bd9dfbc4
--- /dev/null
+++ b/ci/check-unsafe-assertions.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+
+make CHECK_ASSERTION_SIDE_EFFECTS=1 >compiler_output 2>compiler_error
+if test $? != 0
+then
+	echo >&2 "ERROR: The compiler could not verify the following assert()"
+	echo >&2 "       calls are free of side-effects.  Please replace with"
+	echo >&2 "       ASSERT() calls."
+	grep undefined.reference.to..not_supposed_to_survive compiler_error |
+		sed -e s/:[^:]*$// | sort | uniq | tr ':' ' ' |
+		while read f l
+		do
+			printf "${f}:${l}\n  "
+			awk -v start="$l" 'NR >= start { print; if (/\);/) exit }' $f
+		done
+	exit 1
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
index d7f3407128c..5891efaeb18 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1585,4 +1585,10 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
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

