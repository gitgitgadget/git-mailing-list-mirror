Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01C1920248
	for <e@80x24.org>; Fri, 12 Apr 2019 12:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfDLMAe (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 08:00:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42098 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDLMAe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 08:00:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id x61so8074879edc.9
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 05:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=fsRXmxsHknzStyOSzfru5tYTFJds2VIn7azXyKABgfM=;
        b=KmSXFKFpzrn9mlWp350XEamIu9Oq8nJRYjmFyYDkahJzo+XCl/ZtzOB6TTLIdRApoA
         lhNkKB2lXFJcH0Rthgs3KKjiARkiiFlg3apV0sReydy78UaZ4XVs0/NWuNZz7ZDm2OyS
         t8viWBIUJkY52Gm4cR664D/YyqNUjAmXuOrJCtQiMaDMNq284kkKkyYDLB0c/k32g20p
         krwVHOugXt8bEG1Al9y/RwYnrTImPYi8e4woYHTZ2SI/iw5JN8oSVIDjnf0QRMMo0TsP
         g1SBE0k21gf1tmsrsT86TpHUH5gpdvwirZkccY1lJv02mXuep7LS0CZVLRkYEi1TlDxB
         hWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=fsRXmxsHknzStyOSzfru5tYTFJds2VIn7azXyKABgfM=;
        b=Je1OaEp+PDlrmH6y6OWKgLNlgcr6vD1UTBGqLrA0PE/mGkW/6XXrhswTpj8VWw2xq8
         PC2M0N6XbpXxTXKwE5TbbxhrEvF6lkmGEnOHXtwCcaFQB9o3mlptDadh+WCkO5kpGN83
         tNwkQZnusrpw+KzXgh/v1LwzPKqvar+aWIQ4JFPmSvGmvih+vRE5jNjIy614p1qvQ5bs
         c9sEaXdTsa3RSOHg7nXJNx2dcTNUYftgdifjk+RWlVkfsrbghUsa2lAcVnxfdG5DDtF/
         5rdKMu9gax1EpxQiLnUCBJKsSq3TmsqGLtwdZgMrXjLrB0Zoo9N6pxBVq2PXIYFASSlG
         U3mw==
X-Gm-Message-State: APjAAAUqHrO2JSJ2NfY77JyWbhizjyg30GPUo/BCGUecwNkc1UBfMsZe
        fj3Vyqjq4PlyhRZvXJKP/Viuk7US
X-Google-Smtp-Source: APXvYqz/yiBRIY62zGTmnWXMecikFq9bpBi/EkqUU7M95Wc7g8/KDE8ejMQPkXsSOG+xhWgCV5UR8A==
X-Received: by 2002:a17:906:4c4e:: with SMTP id d14mr22335932ejw.127.1555070432370;
        Fri, 12 Apr 2019 05:00:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 25sm7437116ejv.27.2019.04.12.05.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 05:00:31 -0700 (PDT)
Date:   Fri, 12 Apr 2019 05:00:31 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 12:00:24 GMT
Message-Id: <81c08b178be6329d51586fa9d615063d3c6f9625.1555070430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.168.git.gitgitgadget@gmail.com>
References: <pull.168.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/7] remote-testgit: move it into the support directory for
 t5801
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `git-remote-testgit` script is really only used in
`t5801-remote-helpers.sh`. It does not even contain any `@@<MAGIC>@@`
placeholders that would need to be interpolated via `make
git-remote-testgit`.

Let's just move it to a new home, decluttering the top-level directory
and clarifying that this is just a test helper, not an official Git
command that we would want to ever support.

Suggested by Ævar Arnfjörð Bjarmason.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore                                          | 1 -
 Makefile                                            | 3 ---
 t/t5801-remote-helpers.sh                           | 2 ++
 git-remote-testgit.sh => t/t5801/git-remote-testgit | 0
 4 files changed, 2 insertions(+), 4 deletions(-)
 rename git-remote-testgit.sh => t/t5801/git-remote-testgit (100%)

diff --git a/.gitignore b/.gitignore
index 7374587f9d..de8fc2f5b1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -135,7 +135,6 @@
 /git-remote-ftps
 /git-remote-fd
 /git-remote-ext
-/git-remote-testgit
 /git-remote-testpy
 /git-remote-testsvn
 /git-repack
diff --git a/Makefile b/Makefile
index 8654c130f8..26f8ed2228 100644
--- a/Makefile
+++ b/Makefile
@@ -633,7 +633,6 @@ SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-legacy-rebase.sh
-SCRIPT_SH += git-remote-testgit.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
@@ -657,8 +656,6 @@ SCRIPT_PERL += git-svn.perl
 
 SCRIPT_PYTHON += git-p4.py
 
-NO_INSTALL += git-remote-testgit
-
 # Generated files for scripts
 SCRIPT_SH_GEN = $(patsubst %.sh,%,$(SCRIPT_SH))
 SCRIPT_PERL_GEN = $(patsubst %.perl,%,$(SCRIPT_PERL))
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index aaaa722cca..d04f8007e0 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -8,6 +8,8 @@ test_description='Test remote-helper import and export commands'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
+PATH="$TEST_DIRECTORY/t5801:$PATH"
+
 compare_refs() {
 	git --git-dir="$1/.git" rev-parse --verify $2 >expect &&
 	git --git-dir="$3/.git" rev-parse --verify $4 >actual &&
diff --git a/git-remote-testgit.sh b/t/t5801/git-remote-testgit
similarity index 100%
rename from git-remote-testgit.sh
rename to t/t5801/git-remote-testgit
-- 
gitgitgadget

