Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214CDC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 10:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbiCAKZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 05:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiCAKZg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 05:25:36 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A325A082
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 02:24:55 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d3so19732809wrf.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 02:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nJre/5YVUl/6Rb6oFRIeWPosN+8SFbb9ia2xvqQ32t4=;
        b=H/jjCseVDS7CNF3UyswaXUh1jTozYO7ZV5D2MXoHvrfMNIWHYvgZM1HbkcFwJn0xSt
         Wrl4bX1Z2pmHIy/IbP+cyyJvsG82ASNLxDMXtZ5QrbwkY8waVKLwdRhOB+SHki/4B8hO
         PIPeMA9gASplh7AxRvxvl9zIKYksP67Be+O5/JhzrVQIJamOW8I+7k9lM3DgOhaQTqgE
         usRJp1XZNrbYpbd18NjOrEyC/kKlcuvLPKzXKFKZqHBJDgP8vjwzH0WW7xoR8yhUIQuI
         f8QMKfEHcKtI1jb67h8wCD7JztpWgYuxgDi9gTaQwGcPrjqUgmiOpK58EbfFWFRrmbQM
         YgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nJre/5YVUl/6Rb6oFRIeWPosN+8SFbb9ia2xvqQ32t4=;
        b=4+rX4zwc8J4g2bxv7zYvBI/f0XTXzO/AqOWNnvYbdJhm5NfyJI+2dEwhgOUc7YwXNj
         bnpJxvIjeZhtVTLTU7Ba2L7CLkfD9BgTDJ9IDcwCWM62v+ikXAzYnLWreoStIPj/pWmS
         jjVk8DHje2ZIUJfV1502FjN+a7XKl09rCTYY4Z05F7xWvR9jijfz4zz9WH/EsHEEZxVR
         0mnEDM5tdJ8SMGF1jRZc/412HdJmwwxyEoxuOg74iyagKvxA0FwmP/6UXwngBZcykuP0
         JDbcD0RvPtyhROCFVPATx+mdP6RwFW92FaD8mqgVOR2af+Rq9qwyq7jsHN2vaizdaJtZ
         M9fw==
X-Gm-Message-State: AOAM530uAbY2FDfuFt5SPe+YdhuYizLqZCjzHqVKCCmDvSCpv2pG4au7
        kwCTzDKgve5U4Tyf7GuW6HZFaZxUUvI=
X-Google-Smtp-Source: ABdhPJwatdej7wexb4CWUNBaqhUQi+f7emwqOYE7CXIXp322Y34eNo5Rsao+pdfpwM8xEbFyVoAYiQ==
X-Received: by 2002:a05:6000:1242:b0:1ef:846b:290a with SMTP id j2-20020a056000124200b001ef846b290amr11320120wrx.235.1646130293412;
        Tue, 01 Mar 2022 02:24:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c2f0100b00381821b4dbdsm1985920wmn.6.2022.03.01.02.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 02:24:53 -0800 (PST)
Message-Id: <f72254a9ac6ef90f222d64c8c9a08e79ee4544c7.1646130289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 10:24:44 +0000
Subject: [PATCH v2 4/9] ci/run-build-and-tests: add some structure to the
 GitHub workflow output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The current output of Git's GitHub workflow can be quite confusing,
especially for contributors new to the project.

To make it more helpful, let's introduce some collapsible grouping.
Initially, readers will see the high-level view of what actually
happened (did the build fail, or the test suite?). To drill down, the
respective group can be expanded.

Note: sadly, workflow output currently cannot contain any nested groups
(see https://github.com/actions/runner/issues/802 for details),
therefore we take pains to ensure to end any previous group before
starting a new one.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh                 | 56 ++++++++++++++++++++++++++++++++++-----
 ci/run-build-and-tests.sh |  4 +--
 ci/run-test-slice.sh      |  2 +-
 3 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 2b2c0932320..2a1b22db12a 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,5 +1,50 @@
 # Library of functions shared by all CI scripts
 
+if test true != "$GITHUB_ACTIONS"
+then
+	begin_group () { :; }
+	end_group () { :; }
+
+	group () {
+		shift
+		"$@"
+	}
+	set -x
+else
+	begin_group () {
+		need_to_end_group=t
+		echo "::group::$1" >&2
+		set -x
+	}
+
+	end_group () {
+		test -n "$need_to_end_group" || return 0
+		set +x
+		need_to_end_group=
+		echo '::endgroup::' >&2
+	}
+	trap end_group EXIT
+
+	group () {
+		set +x
+		begin_group "$1"
+		shift
+		"$@"
+		res=$?
+		end_group
+		return $res
+	}
+
+	begin_group "CI setup"
+fi
+
+# Set 'exit on error' for all CI scripts to let the caller know that
+# something went wrong.
+#
+# We already enabled tracing executed commands earlier. This helps by showing
+# how # environment variables are set and and dependencies are installed.
+set -e
+
 skip_branch_tip_with_tag () {
 	# Sometimes, a branch is pushed at the same time the tag that points
 	# at the same commit as the tip of the branch is pushed, and building
@@ -88,12 +133,6 @@ export TERM=${TERM:-dumb}
 # Clear MAKEFLAGS that may come from the outside world.
 export MAKEFLAGS=
 
-# Set 'exit on error' for all CI scripts to let the caller know that
-# something went wrong.
-# Set tracing executed commands, primarily setting environment variables
-# and installing dependencies.
-set -ex
-
 if test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
 then
 	CI_TYPE=azure-pipelines
@@ -138,7 +177,7 @@ then
 			test_name="${test_exit%.exit}"
 			test_name="${test_name##*/}"
 			printf "\\e[33m\\e[1m=== Failed test: ${test_name} ===\\e[m\\n"
-			cat "t/test-results/$test_name.out"
+			group "Failed test: $test_name" cat "t/test-results/$test_name.out"
 
 			trash_dir="t/trash directory.$test_name"
 			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
@@ -234,3 +273,6 @@ linux-leaks)
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
+
+end_group
+set -x
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 1ede75e5556..7abfa00adc0 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -45,10 +45,10 @@ pedantic)
 	;;
 esac
 
-make
+group Build make
 if test -n "$run_tests"
 then
-	make test ||
+	group "Run tests" make test ||
 	handle_failed_tests
 fi
 check_unignored_build_artifacts
diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index 63358c23e11..a3c67956a8d 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
 *) ln -s "$cache_dir/.prove" t/.prove;;
 esac
 
-make --quiet -C t T="$(cd t &&
+group "Run tests" make --quiet -C t T="$(cd t &&
 	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
 	tr '\n' ' ')" ||
 handle_failed_tests
-- 
gitgitgadget

