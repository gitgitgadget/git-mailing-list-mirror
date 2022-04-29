Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE28EC433EF
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 09:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357170AbiD2KAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 06:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357145AbiD2KAL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 06:00:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C365D45AC5
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 02:56:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c11so244956wrn.8
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 02:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V02L8s8EBQzkdw4TBhkPUpsVl9AfSAtv1XWp0fHySVg=;
        b=gX9jrYeoU9I7UP4wUdlyzy7q3zejszqGA/jMnj6eMLwuRKXoAKVtOfDcGSnIzx8OWO
         zlUywXsW9GGUq1fZSzSFcsebZKS2KQTVFi8f56JUUVVMEdEfTLksLX2subw7Om9MM6ap
         24e/X0rDfpIXWLd4ECi9yImjQTjdKnDw23pojP+lcZwH7HobfkA3A68r+CecJyDfjOMG
         /GGDG5W5Q5Cbqkne/rBoac4tmcOouT4AWvndXq5KT4j4UNdnkBTvQfl+IWS70Hy236r0
         QhkI2zEECTtRVGkVJHSs5jmnPt+nXp+9PZe/wRl8L0LNGaVXN6a7L7jpoCNyMvFBsLl9
         +lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V02L8s8EBQzkdw4TBhkPUpsVl9AfSAtv1XWp0fHySVg=;
        b=t3uKaqi1h0ICY7gvMqOLvjk6W6ZB8Qzh5rHmSTIraHrozGDUoQV5ISOtJ+2Xu8YXyU
         BVfwHWBiR7QmisuZv8nqF9dCjVtoatCOYtZQ4nuZSt/jXrnK8K7k2GElzoZkNaQqP5T3
         kBTUpZw7GWNuvEOmO3tE3VN8ioOvasbMy7PHMG9Z/CArifLCmyVpbJ5pq7ROYM2+Qbb+
         npo9HiAA3C2tfx1OwSrEZThk9B05Vy1C6ghRiwUIztBubwj/BEBuIBItXftolrYP1d/v
         +a6g3yH7wNp30/I+dCTB+gyE49XsqlTwscKGzcbQePO7+To3epcvZ2gocQiNE8mZ1z4I
         0HqA==
X-Gm-Message-State: AOAM5306kkX7T24iOsBDIisSiCBkR7B+qbk1aGVboTnwgM242nt9SdNj
        ksIbpc25RpPGHNP57gL1lEhE7zMPqQ4=
X-Google-Smtp-Source: ABdhPJzvswCGx2rwmxfC9CBvkyY83M4HTGBoza5zGWpbaL8p6Pu4gvDXkdlU7Gb+460sFocDbceiyA==
X-Received: by 2002:a5d:408d:0:b0:20a:ce37:1306 with SMTP id o13-20020a5d408d000000b0020ace371306mr26946228wrp.215.1651226210932;
        Fri, 29 Apr 2022 02:56:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r204-20020a1c44d5000000b003941901f2b0sm2540336wma.41.2022.04.29.02.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 02:56:50 -0700 (PDT)
Message-Id: <31184c3a65d64826a7f546fcc04f6efc6f2d017f.1651226207.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1161.v5.git.1651226206.gitgitgadget@gmail.com>
References: <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com>
        <pull.1161.v5.git.1651226206.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Apr 2022 09:56:45 +0000
Subject: [PATCH v5 2/3] push: default to single remote even when not named
 origin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Josh Steadmon <steadmon@google.com>,
        Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

With "push.default=current" configured, a simple "git push" will push to
the same-name branch on the current branch's branch.<name>.pushRemote, or
remote.pushDefault, or origin. If none of these are defined, the push will
fail with error "fatal: No configured push destination".

The same "default to origin if no config" behavior applies with
"push.default=matching".

Other commands use "origin" as a default when there are multiple options,
but default to the single remote when there is only one - for example,
"git checkout <something>". This "assume the single remote if there is
only one" behavior is more friendly/useful than a defaulting behavior
that only uses the name "origin" no matter what.

Update "git push" to also default to the single remote (and finally fall
back to "origin" as default if there are several), for
"push.default=current" and for other current and future remote-defaulting
push behaviors.

This change also modifies the behavior of ls-remote in a consistent way,
so defaulting not only supplies 'origin', but any single configured remote
also.

Document the change in behavior, correct incorrect assumptions in related
tests, and add test cases reflecting this new single-remote-defaulting
behavior.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 Documentation/config/branch.txt |  5 +--
 remote.c                        |  2 ++
 t/t5512-ls-remote.sh            | 17 +++++++--
 t/t5528-push-default.sh         | 63 ++++++++++++++++++++++++++++++++-
 4 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index 8df10d07129..445341a906b 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -40,8 +40,9 @@ branch.<name>.remote::
 	may be overridden with `remote.pushDefault` (for all branches).
 	The remote to push to, for the current branch, may be further
 	overridden by `branch.<name>.pushRemote`.  If no remote is
-	configured, or if you are not on any branch, it defaults to
-	`origin` for fetching and `remote.pushDefault` for pushing.
+	configured, or if you are not on any branch and there is more than
+	one remote defined in the repository, it defaults to `origin` for
+	fetching and `remote.pushDefault` for pushing.
 	Additionally, `.` (a period) is the current local repository
 	(a dot-repository), see `branch.<name>.merge`'s final note below.
 
diff --git a/remote.c b/remote.c
index 42a4e7106e1..930fdc9c2f6 100644
--- a/remote.c
+++ b/remote.c
@@ -543,6 +543,8 @@ static const char *remotes_remote_for_branch(struct remote_state *remote_state,
 	}
 	if (explicit)
 		*explicit = 0;
+	if (remote_state->remotes_nr == 1)
+		return remote_state->remotes[0]->name;
 	return "origin";
 }
 
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index f53f58895a1..20d063fb9ae 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -15,6 +15,10 @@ generate_references () {
 	done
 }
 
+test_expect_success 'dies when no remote found' '
+	test_must_fail git ls-remote
+'
+
 test_expect_success setup '
 	>file &&
 	git add file &&
@@ -30,7 +34,8 @@ test_expect_success setup '
 	git show-ref -d	>refs &&
 	sed -e "s/ /	/" refs >>expected.all &&
 
-	git remote add self "$(pwd)/.git"
+	git remote add self "$(pwd)/.git" &&
+	git remote add self2 "."
 '
 
 test_expect_success 'ls-remote --tags .git' '
@@ -83,11 +88,17 @@ test_expect_success 'ls-remote --sort="-refname" --tags self' '
 	test_cmp expect actual
 '
 
-test_expect_success 'dies when no remote specified and no default remotes found' '
+test_expect_success 'dies when no remote specified, multiple remotes found, and no default specified' '
 	test_must_fail git ls-remote
 '
 
-test_expect_success 'use "origin" when no remote specified' '
+test_expect_success 'succeeds when no remote specified but only one found' '
+	test_when_finished git remote add self2 "." &&
+	git remote remove self2 &&
+	git ls-remote
+'
+
+test_expect_success 'use "origin" when no remote specified and multiple found' '
 	URL="$(pwd)/.git" &&
 	echo "From $URL" >exp_err &&
 
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index f280e00eb79..0d6c9869ed3 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -94,13 +94,74 @@ test_expect_success '"upstream" does not push when remotes do not match' '
 	test_must_fail git push parent2
 '
 
-test_expect_success 'push from/to new branch with upstream, matching and simple' '
+test_expect_success '"current" does not push when multiple remotes and none origin' '
+	git checkout main &&
+	test_config push.default current &&
+	test_commit current-multi &&
+	test_must_fail git push
+'
+
+test_expect_success '"current" pushes when remote explicitly specified' '
+	git checkout main &&
+	test_config push.default current &&
+	test_commit current-specified &&
+	git push parent1
+'
+
+test_expect_success '"current" pushes to origin when no remote specified among multiple' '
+	git checkout main &&
+	test_config remote.origin.url repo1 &&
+	test_config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" &&
+	test_commit current-origin &&
+	test_push_success current main
+'
+
+test_expect_success '"current" pushes to single remote even when not specified' '
+	git checkout main &&
+	test_when_finished git remote add parent1 repo1 &&
+	git remote remove parent1 &&
+	test_commit current-implied &&
+	test_push_success current main repo2
+'
+
+test_expect_success 'push from/to new branch with non-defaulted remote fails with upstream, matching, current and simple ' '
 	git checkout -b new-branch &&
 	test_push_failure simple &&
 	test_push_failure matching &&
+	test_push_failure upstream &&
+	test_push_failure current
+'
+
+test_expect_success 'push from/to new branch fails with upstream and simple ' '
+	git checkout -b new-branch-1 &&
+	test_config branch.new-branch-1.remote parent1 &&
+	test_push_failure simple &&
 	test_push_failure upstream
 '
 
+# The behavior here is surprising but not entirely wrong:
+#  - the current branch is used to determine the target remote
+#  - the "matching" push default pushes matching branches, *ignoring* the
+#       current new branch as it does not have upstream tracking
+#  - the default push succeeds
+#
+# A previous test expected this to fail, but for the wrong reasons:
+# it expected a fail becaause the branch is new and cannot be pushed, but
+# in fact it was failing because of an ambiguous remote
+#
+test_expect_failure 'push from/to new branch fails with matching ' '
+	git checkout -b new-branch-2 &&
+	test_config branch.new-branch-2.remote parent1 &&
+	test_push_failure matching
+'
+
+test_expect_success 'push from/to branch with tracking fails with nothing ' '
+	git checkout -b tracked-branch &&
+	test_config branch.tracked-branch.remote parent1 &&
+	test_config branch.tracked-branch.merge refs/heads/tracked-branch &&
+	test_push_failure nothing
+'
+
 test_expect_success '"matching" fails if none match' '
 	git init --bare empty &&
 	test_must_fail git push empty : 2>actual &&
-- 
gitgitgadget

