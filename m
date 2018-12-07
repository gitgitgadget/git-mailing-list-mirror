Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E38D20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 23:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLGXym (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 18:54:42 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:40377 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGXym (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 18:54:42 -0500
Received: by mail-qk1-f201.google.com with SMTP id y83so4770713qka.7
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 15:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N3SZ1QCsoUGEdOPnFhXh5qvrlPIaRjFBb+tjKJF/4HE=;
        b=ohSXa6Y6EZoDlRAfA0Uml6FklgVn435ZSavNodlFoxW8uQjB+lSc/FwI+AEzwBMWEN
         3P0dBfNbd+XSsgelhhXHrmQA442l6vEzWlh7kYwKoIIs5VmjVvPC/riABPDxL+mBYERU
         DXw8Reem6njSs3NJ50cPO5I1ycSqOUHvagooEhbLaKxCaXIXjTiJEapBaflWGcOEBdZn
         kqs5cOcr6EPx0hd4e7eq7afHObGdnrnFbPGiVgB4TPfII9+U/joLoZbDl4lzeztBbShq
         M7Bbp+FQ5Ok/pN88TaZwYgMWBCg2UW7Tbo+/acuTSyIVE/9JTIPef0CIs44fVyzoCV1A
         RS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N3SZ1QCsoUGEdOPnFhXh5qvrlPIaRjFBb+tjKJF/4HE=;
        b=sT5BASqx4Oe0TR521IT//HXPU96xm9azgZOUi4/+ldqYZWliC0FqLdEg86A39KQfaB
         yeJGmBbX76Oi2otJkbG3sRwsJHLAi7OsVrRETZAJpfKZlv4EzBRxKn7DRU/F+q6oKKQB
         UlrdbFJdLIvQXu1a2Cthp/J+FUua5p15aDsP1+pb8QmVZ5m+v0V9KG7vz3ZhMFG/CuEA
         kK7TcmomA9zD7F7jSH9TuZeMe6kZFQCGZST26CFo0zeF7bbbkjb06CN3r7473I6sP9ps
         ZaCGhlTfIXLIbwey/1AM3r7a5KtOOWYObzYqomDzwugvuf2bPDZPsxn0fNbOsxS09sMM
         7itg==
X-Gm-Message-State: AA+aEWYE5ZIiXYfE8VIyMO6IU5rhDtAnmhsa2WaDEGnu7pPca/u5g9vO
        ZEQaO6qI9jOdbs2dR5HPk7IKWJ4+67uFM/RGg5bPncFfbwqH8SanFRsZwbrNvpBLSPTnTZJUFnH
        0pjlsgi+N0jvJNozOs11Fma6/yNOq1v35MS5nkI64WRJab1SDwcrEzPXZ5dHs
X-Google-Smtp-Source: AFSGD/WZ/FxlEnINu3gm9HtZJRnurblQ6ZGahmIisaVwQgYkn8ld60iTQU9+8q5KQV42Zg1IxRs5TK+V69w0
X-Received: by 2002:ac8:25fc:: with SMTP id f57mr3162603qtf.12.1544226881071;
 Fri, 07 Dec 2018 15:54:41 -0800 (PST)
Date:   Fri,  7 Dec 2018 15:54:22 -0800
In-Reply-To: <20181207235425.128568-1-sbeller@google.com>
Message-Id: <20181207235425.128568-2-sbeller@google.com>
Mime-Version: 1.0
References: <20181207235425.128568-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH 1/4] submodule update: add regression test with old style setups
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As f178c13fda (Revert "Merge branch 'sb/submodule-core-worktree'",
2018-09-07) was produced shortly before a release, nobody asked for
a regression test to be included. Add a regression test that makes sure
that the invocation of `git submodule update` on old setups doesn't
produce errors as pointed out in f178c13fda.

The place to add such a regression test may look odd in t7412, but
that is the best place as there we setup old style submodule setups
explicitly.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7412-submodule-absorbgitdirs.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index ce74c12da2..1cfa150768 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -75,7 +75,12 @@ test_expect_success 're-setup nested submodule' '
 	GIT_WORK_TREE=../../../nested git -C sub1/.git/modules/nested config \
 		core.worktree "../../../nested" &&
 	# make sure this re-setup is correct
-	git status --ignore-submodules=none
+	git status --ignore-submodules=none &&
+
+	# also make sure this old setup does not regress
+	git submodule update --init --recursive >out 2>err &&
+	test_must_be_empty out &&
+	test_must_be_empty err
 '
 
 test_expect_success 'absorb the git dir in a nested submodule' '
-- 
2.20.0.rc2.403.gdbc3b29805-goog

