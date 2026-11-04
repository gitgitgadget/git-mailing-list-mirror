Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806683;
	b=rU3WtOunnG+hkNQuwVHlo9F0lqoYKOqUSnMNiYZQsjyNNYodF3pf874zv8DyHB48r1sl
	 VU0Jxfv891GHsuJACXAYcGFaMJWvAcctfCWGXBUgMxucGbhzHVA143Ie5atjyokRv898p
	 VoXuUxFVh2hBsfpEOIWPI4Q8WVderdITyssn8+2IRnN4MYF6gjo/X+0/lDbVVjHSYF9Yl
	 M2wRWYiOPJ3ZU5zQpitZR+TB2cahk6t7l3YTMqhI9QekKTX/kD9mByShDK7V/nW1CI3A8
	 HszmQ2+NDHhY7zk9AU3VQdhc+2J/Tyfm2u8A8j+CDrhE9eKCCL3iHPBAdlOjpD0S5oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=cLmZQATXcMfAJpC8T8yIY81ZgKWOn4gqlWj1N+r0JN4=;
	b=10VDzOs8ae1oNf9/K/jtrk/DdgKhTerfh3wPXqQoGXDbaCWKKCGUzgsp3UxasttKKBTc
	 zsm+UhaWhew94vSpBeQSxS5samGh9uoHnjpJNuGFwgkQWSSQq5IAzHqUun/kUhD57/5fh
	 fLnK7vYPeNBATEzJerLy2O+DJXGzxf+upwlizfcy8GN9vzcptiZJUrY70xj194sRNqCng
	 d5IEol1uSBEe72iWEWx2c0iYhZvxNIfOkQPb43lVifpL/ncQIcUuz3Fwmxy3I4VAXCWTW
	 Lxx4dx0wVHuQitV30sLBmf+Zj/Ww0KjvfySofnS3eRrPjeJ5jJrt6TbFON6eEkE4hrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jqhmiutU;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D86606D81E
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 15:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60D86606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jqhmiutU
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91c7b00a75fso8956536d6.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 07:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793806682; x=1794411482; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cLmZQATXcMfAJpC8T8yIY81ZgKWOn4gqlWj1N+r0JN4=;
        b=jqhmiutUfcDjwRRM5H68yVLFf2lWeWEqAE0kmivlRzZX0q1ERZVF5VRyISe3s/bA6j
         8ksh3tuESCLFxQmWEY22vUsglifMZQmUtr3P7AkW5rn8hrEBtIx6u8Yd6eUtM3RmwFbe
         WyY4RbrlZmMDnobDMCzTeh6atoxZ3XGe+HJs5sKUgb4jADkPQo1ATtmEpmRQri44Sgaa
         dMWTmPEz351uMZ8ls43gfyf1qVSAL03WS0CwmiT5emdex/dmi0efV0+Y/G2eC9ZmuSvW
         etoYqdvxNAoX/RiVdeRe9TzDUpuXDzZzokbA4JHTy4RDfFKPW2dddjPblIuq/1zNtIsQ
         UxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806682; x=1794411482;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cLmZQATXcMfAJpC8T8yIY81ZgKWOn4gqlWj1N+r0JN4=;
        b=M/O9OcM21nuEKxRQfR+DEUaTcBpnXBdzsYERZ+Kzv022sIY2WOhdSHAPAmcb4Tu33r
         yleU+ZxRIyOI9VTO4pvVVciaSEd1KU9diMKI39Uz+srLNpv/YV5Ej5zpbXw2s1Q5ZH8Q
         FCzvXHa+5v6eCJ4LsybUzUQTQIgGGKoMBGySC94m6kEW/A2LgqVUx+i0SjI65TajKzTp
         Zzj22ITpKuJNAXkmay3H40Fm3AE2l7tuiytgnojm9fwVkNXiS8ukDABCpnwcG8S0klbh
         9diFWIWOkqBu47VgnIMo8iOAQqMv1ivNiSmVzLNUHcmhR6QdH5ytW7C0LSGVtKXAYRhG
         K4oA==
X-Gm-Message-State: APuU4Z90Dw9AOhNouBhKW3Zh2f2PK9JpVJk72ohKmD25hlQYiictE4AN
	d6iUyZfgYZm6yIi6mSJXkBgWgGkAEkkoiGftOA9mC1v/xyBOCZs+SzlCzk1RPJIJFGY=
X-Gm-Gg: AYBFou2Vs0um6MyKpMR1P2ei3I7tC7hr3hI/IA2IGVSJdrnGqsbwK4Eha4s9bqXnpDq
	ORJDNWPJiIEfJdyOPg1gv7ReiXd/KMVx0I29YjhaZoI8gEmHN8t6XRk692gmVjbpbv3qM+sPWpn
	I+GZcQip6EvbcP/LOFGHyAKkAimclD8gJQzSuiPFElslNP+r/hTB6RR2DoAGGgmNjOidfCvOCgt
	xnsGFjHrVJRfj6QCynDrTZtr3ChAKq4iSYpaUjpjdcNLCjw2qUuUXmbxznUEwMqxJmOaSBj2por
	QPC3OZ/814PIvrzxKQiNfHE+qgGh7Gpwl8DM6bQLwnpqb+EgVSoPCIQ3jcj882bOUaBqdHr3y4R
	QraMH+iq/JuwTh30rw92/O7fhkepQTbBxdgrsItO1iLyK2UM/qctCtef7iPwGw6m/R1kDfFDucj
	HS69KJCLaJu3Ctb1pdFgRBcauEIWiKqq0RO2Utm6h6xUqqZj5zwbO6EMzC5ubXBsin7E15jkiCn
	AUVXTD1mCOIYtNzvAf0vYqeG98xKnK8UlURujq2wZijsoPjyHQPtI9I7Dw4hzxt8nEKZhEZNneW
	QUaamLdfBk/b9HkolqLjAnemltEBh2M44A==
X-Received: by 2002:a05:6214:27ef:b0:91c:9316:f4e8 with SMTP id 6a1803df08f44-91ca4ba72f4mr265038546d6.54.1793806682055;
        Wed, 04 Nov 2026 07:38:02 -0800 (PST)
Received: from [127.0.0.1] ([20.106.199.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfe9730sm21629376d6.17.2026.11.04.07.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:38:00 -0800 (PST)
Message-Id: <pull.2295.git.1793806679163.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Nov 2026 15:37:59 +0000
Subject: [PATCH] fsmonitor: invalidate untracked cache after losing history
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
Cc: gitster@pobox.com,
    Johannes.Schindelin@gmx.de,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When fsmonitor fails or returns a trivial response, refresh_fsmonitor()
clears CE_FSMONITOR_VALID and disables fsmonitor use for the untracked
cache. Unfortunately, this may leave untracked cache entries marked
'valid' so future commands may miss necessary updates.

A command such as 'git update-index --refresh' can save the replacement
fsmonitor token without scanning untracked directories. If the next
query returns no changes, fsmonitor use is enabled again and 'git status'
trusts directory contents cached before the loss of event history. New
untracked files can remain invisible.

This integration bug between fsmonitor and the untracked cache has
existed since the fsmonitor feature was introduced in 883e248b8a0
(fsmonitor: teach git to optionally utilize a file system monitor to
speed up detecting new or changed files., 2017-09-22).

To fix the problem, react more completely on a failed fsmonitor token
request. In this case, invalidate every untracked cache directory and
mark the untracked extension as changed. To guarantee that the index is
updatede, set UNTRACKED_CHANGED so that the index is written even when
no tracked entry changes. Keep the directory nodes intact to preserve
pointers held by callers.

A new pair of tests validate this approach. They use the fsmonitor hook
implementation because it's easier to trigger these failure conditions,
but the fix applies to both the hook and builtin versions. The tests
confirm that the untracked cache is invalidated.

Performance tests in p7527-builtin-fsmonitor.sh demonstrate that this
change does not introduce any performance degradation, with one caveat.
My initial testing on Linux did not have its max_user_watches high
enough, so the first test run _did_ show a regression for the cases
where the untracked cache was enabled. This added 50-75% additional time
to commands, but this is because it correctly did the extra work to
validate the untracked cache when the fsmonitor failed to start.

Recall that to extend the maximum user watches, one can run

  sudo sysctl -w fs.inotify.max_user_watches=1048576

With this increased watch count, my peformance numbers equalized again,
since the fsmonitor could start successfully and did not invalidate the
untracked cache, as it would with normal operation.

Assisted-by: GPT-6.1 Sol
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    fsmonitor: invalidate untracked cache after losing history
    
    A user of an internal monorepo reported this behavior, including an
    AI-assisted powershell script to prove how it worked. I used an agent to
    assist in porting that to a Git test script and a code fix, but then
    applied significant human editing and validation on top to get it up to
    my standards.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2295%2Fderrickstolee%2Ffsmonitor-untracked-v2.56-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2295/derrickstolee/fsmonitor-untracked-v2.56-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2295

 dir.c                       | 18 ++++++++++++++++++
 dir.h                       |  1 +
 fsmonitor.c                 |  4 +++-
 t/t7519-status-fsmonitor.sh | 38 +++++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index d896e7be4b..99a2bd9fe2 100644
--- a/dir.c
+++ b/dir.c
@@ -3976,6 +3976,24 @@ static void invalidate_one_directory(struct untracked_cache *uc,
 	ucd->untracked_nr = 0;
 }
 
+static void invalidate_directory_recursive(struct untracked_cache *uc,
+					  struct untracked_cache_dir *ucd)
+{
+	invalidate_one_directory(uc, ucd);
+	for (size_t i = 0; i < ucd->dirs_nr; i++)
+		invalidate_directory_recursive(uc, ucd->dirs[i]);
+}
+
+void untracked_cache_invalidate_all(struct index_state *istate)
+{
+	if (!istate->untracked || !istate->untracked->root)
+		return;
+
+	invalidate_directory_recursive(istate->untracked,
+				       istate->untracked->root);
+	istate->cache_changed |= UNTRACKED_CHANGED;
+}
+
 /*
  * Normally when an entry is added or removed from a directory,
  * invalidating that directory is enough. No need to touch its
diff --git a/dir.h b/dir.h
index 83e0f648a8..d2de762da8 100644
--- a/dir.h
+++ b/dir.h
@@ -596,6 +596,7 @@ static inline int dir_path_match(struct index_state *istate,
 int cmp_dir_entry(const void *p1, const void *p2);
 int check_dir_entry_contains(const struct dir_entry *out, const struct dir_entry *in);
 
+void untracked_cache_invalidate_all(struct index_state *);
 void untracked_cache_invalidate_path(struct index_state *, const char *, int safe_path);
 /*
  * Invalidate the untracked-cache for this path, but first strip
diff --git a/fsmonitor.c b/fsmonitor.c
index 107767527e..9c3079f64a 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -713,8 +713,10 @@ apply_results:
 		if (is_cache_changed)
 			istate->cache_changed |= FSMONITOR_CHANGED;
 
-		if (istate->untracked)
+		if (istate->untracked) {
+			untracked_cache_invalidate_all(istate);
 			istate->untracked->use_fsmonitor = 0;
+		}
 	}
 	trace2_region_leave("fsmonitor", "apply_results", istate->repo);
 
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 93973ed25a..7d3ff4ec6b 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -394,6 +394,44 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 	test_cmp before after
 '
 
+for response in trivial failure
+do
+	test_expect_success UNTRACKED_CACHE \
+		"invalidate untracked cache after fsmonitor response: $response" '
+		test_create_repo "untracked-$response" &&
+		(
+			cd "untracked-$response" &&
+			git config core.untrackedCache true &&
+			git config core.fsmonitor .git/hooks/fsmonitor-test &&
+			git config core.fsmonitorHookVersion 2 &&
+			echo empty >.git/fsmonitor-response &&
+			test_hook --setup fsmonitor-test <<-\EOF &&
+			printf "token\0"
+			case "$(cat .git/fsmonitor-response)" in
+			trivial) printf "/\0" ;;
+			failure) exit 1 ;;
+			esac
+			EOF
+
+			mkdir -p inc/deep &&
+			git update-index --force-write-index &&
+			git status --porcelain >../actual &&
+			test_must_be_empty ../actual &&
+
+			>inc/deep/new &&
+			echo "$response" >.git/fsmonitor-response &&
+			git update-index --refresh &&
+			echo empty >.git/fsmonitor-response &&
+
+			test-tool dump-untracked-cache >../actual &&
+			test_grep ! " valid" ../actual &&
+			echo "?? inc/" >../expect &&
+			git status --porcelain >../actual &&
+			test_cmp ../expect ../actual
+		)
+	'
+done
+
 test_expect_success 'discard_index() also discards fsmonitor info' '
 	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
 	test_might_fail git update-index --refresh &&

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
gitgitgadget
