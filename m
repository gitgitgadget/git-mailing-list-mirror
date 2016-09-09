Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D9BA20705
	for <e@80x24.org>; Fri,  9 Sep 2016 20:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754811AbcIIURy (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 16:17:54 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36212 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754721AbcIIURr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 16:17:47 -0400
Received: by mail-pa0-f42.google.com with SMTP id id6so31399273pad.3
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 13:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qt649A2xdqcUdXUvF+zcmr8mJcSfxUutsu0ixGQw2vc=;
        b=isFYHHFt5t47Zul124IOB/eg1IY04Q0tjN+gSflUJCLXtQOiqyScmko0WE4lElfERm
         FfA314TMAYmnwwjT9wWJkXWumJOd+mllwWUkDGXw91F4cLsbiX4wSdh4Qwt8dXYL6sz0
         OcW517lmJqc0+G3bb7bPVOQGZPLFtQB1SZ5SQwij3jlHL0W8cbYrI2qDCNsU5aXgPkap
         aHSnjhmfS/HNy7Wa+XBD6+jg8QggtSqY7PwcDI9UEUQOqTLBp+VKwFA6Z1cWRHziRC06
         HYE8UCOGtYv5m70p+uZ9Px3YncheMK6OY0+WglBoM43NSzxAkrMTyHBilG3R0AvCYYk+
         i38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qt649A2xdqcUdXUvF+zcmr8mJcSfxUutsu0ixGQw2vc=;
        b=mhrtHfWurrILiGDxvyNazJNr7tgrYHfXm/TXvL03EDNAc/IdcwqmaxM0JhzdaKBCUH
         9VgNp1eD9k6pwbKdJakXR+de3ywhZaceP+6DIQAKR5DFI/fVPfzWSO/DMbwW8fZGhpik
         z+PNdr3V79FKikp3ZU7gh+fSnmUkDjNDDDKmHEINLtx3Ra4mwsN8YLM/U36kz2946wtH
         lxOYR8QBmtEP5DfpUCnYILeesNLLH1zZdI7U043FIYR59tHpxWb46QYXn48RGb/mAgaA
         2yv7/lG4JiW/9GMzAxjOJBd+bUj6AeUbKhuZ7K9C+ZcgPV+xgInKVpiTHdMBHUYPJyKq
         e8sA==
X-Gm-Message-State: AE9vXwM9Yhh/6Kh04ckua/HfSU4VgqpB7HCuboczBNKyWl46OukKhSKfllhnPaWnXnFT6Gm9
X-Received: by 10.66.148.202 with SMTP id tu10mr9812564pab.52.1473452266303;
        Fri, 09 Sep 2016 13:17:46 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id s1sm7203690paz.47.2016.09.09.13.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Sep 2016 13:17:45 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        gitster@pobox.com
Subject: [PATCH v5 3/3] connect: advertized capability is not a ref
Date:   Fri,  9 Sep 2016 13:17:37 -0700
Message-Id: <f2ccb239ba1f85b434c3dfa60e86b89c414dfffa.1473452153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1473452153.git.jonathantanmy@google.com>
References: <cover.1473452153.git.jonathantanmy@google.com>
In-Reply-To: <cover.1473452153.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com> <cover.1473452153.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cloning an empty repository served by standard git, "git clone" produces
the following reassuring message:

	$ git clone git://localhost/tmp/empty
	Cloning into 'empty'...
	warning: You appear to have cloned an empty repository.
	Checking connectivity... done.

Meanwhile when cloning an empty repository served by JGit, the output is more
haphazard:

	$ git clone git://localhost/tmp/empty
	Cloning into 'empty'...
	Checking connectivity... done.
	warning: remote HEAD refers to nonexistent ref, unable to checkout.

This is a common command to run immediately after creating a remote repository
as preparation for adding content to populate it and pushing. The warning is
confusing and needlessly worrying.

The cause is that, since v3.1.0.201309270735-rc1~22 (Advertise capabilities
with no refs in upload service., 2013-08-08), JGit's ref advertisement includes
a ref named capabilities^{} to advertise its capabilities on (following the
specification in pack-protocol.txt), while git's ref advertisement is empty in
this case. This allows the client to learn about the server's capabilities and
is needed, for example, for fetch-by-sha1 to work when no refs are advertised.

This also affects "ls-remote". For example, against an empty repository served
by JGit:

	$ git ls-remote git://localhost/tmp/empty
	0000000000000000000000000000000000000000        capabilities^{}

Git advertises the same capabilities^{} ref in its ref advertisement for push
but since it never did so for fetch, the client didn't need to handle this
case. Handle it.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 connect.c            | 14 ++++++++++++++
 t/t5512-ls-remote.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/connect.c b/connect.c
index 0c01a49..7224b5e 100644
--- a/connect.c
+++ b/connect.c
@@ -123,6 +123,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 	 * response does not necessarily mean an ACL problem, though.
 	 */
 	int saw_response;
+	int got_dummy_ref_with_capabilities_declaration = 0;
 
 	*list = NULL;
 	for (saw_response = 0; ; saw_response = 1) {
@@ -172,8 +173,21 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			continue;
 		}
 
+		if (!strcmp(name, "capabilities^{}")) {
+			if (saw_response)
+				die("protocol error: unexpected capabilities^{}");
+			if (got_dummy_ref_with_capabilities_declaration)
+				die("protocol error: multiple capabilities^{}");
+			got_dummy_ref_with_capabilities_declaration = 1;
+			continue;
+		}
+
 		if (!check_ref(name, flags))
 			continue;
+
+		if (got_dummy_ref_with_capabilities_declaration)
+			die("protocol error: unexpected ref after capabilities^{}");
+
 		ref = alloc_ref(buffer + GIT_SHA1_HEXSZ + 1);
 		oidcpy(&ref->old_oid, &old_oid);
 		*list = ref;
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 819b9dd..befdfee 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -207,5 +207,45 @@ test_expect_success 'ls-remote --symref omits filtered-out matches' '
 	test_cmp expect actual
 '
 
+test_lazy_prereq GIT_DAEMON '
+	test_tristate GIT_TEST_GIT_DAEMON &&
+	test "$GIT_TEST_GIT_DAEMON" != false
+'
+
+# This test spawns a daemon, so run it only if the user would be OK with
+# testing with git-daemon.
+test_expect_success PIPE,JGIT,GIT_DAEMON 'indicate no refs in standards-compliant empty remote' '
+	JGIT_DAEMON_PORT=${JGIT_DAEMON_PORT-${this_test#t}} &&
+	JGIT_DAEMON_PID= &&
+	git init --bare empty.git &&
+	>empty.git/git-daemon-export-ok &&
+	mkfifo jgit_daemon_output &&
+	{
+		jgit daemon --port="$JGIT_DAEMON_PORT" . >jgit_daemon_output &
+		JGIT_DAEMON_PID=$!
+	} &&
+	test_when_finished kill "$JGIT_DAEMON_PID" &&
+	{
+		read line &&
+		case $line in
+		Exporting*)
+			;;
+		*)
+			echo "Expected: Exporting" &&
+			false;;
+		esac &&
+		read line &&
+		case $line in
+		"Listening on"*)
+			;;
+		*)
+			echo "Expected: Listening on" &&
+			false;;
+		esac
+	} <jgit_daemon_output &&
+	# --exit-code asks the command to exit with 2 when no
+	# matching refs are found.
+	test_expect_code 2 git ls-remote --exit-code git://localhost:$JGIT_DAEMON_PORT/empty.git
+'
 
 test_done
-- 
2.8.0.rc3.226.g39d4020

