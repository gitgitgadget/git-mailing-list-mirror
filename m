Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1A551F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbeGRU2b (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:28:31 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:39519 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbeGRU2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:28:30 -0400
Received: by mail-io0-f201.google.com with SMTP id x5-v6so4138104ioa.6
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=hA0iwRJgLVtjZgCdKEa5vqDRFj0UiyIb7LNjysJqIQg=;
        b=UPpFS5XXnI9SGHp1Zbe/YFJCbAZZq/wi9pQIk4iU9+Jw9ExqBx2aWCL5gvd1yPuxzp
         bYREu8RZxvVwPxaxyA/6fNDbQhq+2hBoKnr55vzEfZj146JizsQhuxl1RalrgnqPTxnb
         kk0QUPjIlHjGcp4DFDszFTpHpTwvQ3zTQq9Ij6c1fNy+LrbfxpUVJdSMPk4Im+13QZih
         PILYGHffEDoIGjb57Nwx8dovpR/7KuBsYW/jAhdplpz9T3EGnYP1dOGOEU6kDo6SYfyn
         Sp0zAdwWEk5gRERBwul/wi4CD5Xd7PfQ2OSlI5mVX24RAyzEbqK+/TH15bdO6SoMZPe8
         iRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=hA0iwRJgLVtjZgCdKEa5vqDRFj0UiyIb7LNjysJqIQg=;
        b=AZFL8cC9OivFlMxIX/0Ew6k04GwpiZl19yAwU4jDSGXcYIMjrzT8zQg4jyACOz5cnH
         JRS0dapZahi2YRpBWzhslP8IsBf6JqiZ3qTmZQQKkW+S1dFEVB7K+9lUwEXuPm6ub4Gp
         9BFJ5CpQOkGFCNOaV1m5pMEH7aKPvDIFClAkwLor+t044fXedQDJvAZQMklJNl00GXSK
         MQQVxhfz1bZuN3mMIQVeSkxrag9JmMpprpN3mZIKamwbvvyBl+N4/TNRPpRiHVC0Kw0h
         pKNBgvUVV3Nj1+tpyokGdEWWNhVldVjY/bB5s3CS/sAKT86MgpBakDCiHfiZhV7KHIWL
         nxCA==
X-Gm-Message-State: AOUpUlGXgxZyw1te1NX18UJwCyrNBsL0BFUkP64S/GFIxjAtaYtj2gKm
        2yrqsARH7tm8BfGXXUf2CvUhrbhCa3aTiY2iWy10z/b8pf1932pnjrtMyJbGt+J1JMz0XoB09Ml
        WhYm6IMu8jax8K0gpvi0o4mh3rsbZMTyhTskCELhKeE/KadWCufAxxCG7uNRC
X-Google-Smtp-Source: AAOMgpcO4eQRRzle14nKha6q8SqZyTAjf/9kdLHNm2eru5mlr6oiQbmCMryLSCkJ4ZR/GuA9ca30O++YBVam
MIME-Version: 1.0
X-Received: by 2002:a24:6b07:: with SMTP id v7-v6mr1578086itc.37.1531943346003;
 Wed, 18 Jul 2018 12:49:06 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:48:49 -0700
In-Reply-To: <20180718194853.57994-1-sbeller@google.com>
Message-Id: <20180718194853.57994-3-sbeller@google.com>
References: <20180718194853.57994-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 2/6] git-submodule.sh: rename unused variables
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, szeder.dev@gmail.com, stolee@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'mode' variable is not used in cmd_update for its original purpose,
rename it to 'dummy' as it only serves the purpose to abort quickly
documenting this knowledge.

The variable 'stage' is also not used any more in cmd_update, so remove it.

This went unnoticed as first each function used the commonly used
submodule listing, which was converted in 74703a1e4df (submodule: rewrite
`module_list` shell function in C, 2015-09-02). When cmd_update was
using its own function starting in 48308681b07 (git submodule update:
have a dedicated helper for cloning, 2016-02-29), its removal was missed.

A later patch in this series also touches the communication between
the submodule helper and git-submodule.sh, but let's have this as
a preparatory patch, as it eases the next patch, which stores the
raw data instead of the line printed for this communication.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 5 ++---
 git-submodule.sh            | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 20ae9191ca3..ebcfe85bfa9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1571,9 +1571,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	needs_cloning = !file_exists(sb.buf);
 
 	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%06o %s %d %d\t%s\n", ce->ce_mode,
-			oid_to_hex(&ce->oid), ce_stage(ce),
-			needs_cloning, ce->name);
+	strbuf_addf(&sb, "dummy %s %d\t%s\n",
+		    oid_to_hex(&ce->oid), needs_cloning, ce->name);
 	string_list_append(&suc->projectlines, sb.buf);
 
 	if (!needs_cloning)
diff --git a/git-submodule.sh b/git-submodule.sh
index 8a611865397..56588aa304d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -531,9 +531,9 @@ cmd_update()
 		"$@" || echo "#unmatched" $?
 	} | {
 	err=
-	while read -r mode sha1 stage just_cloned sm_path
+	while read -r quickabort sha1 just_cloned sm_path
 	do
-		die_if_unmatched "$mode" "$sha1"
+		die_if_unmatched "$quickabort" "$sha1"
 
 		name=$(git submodule--helper name "$sm_path") || exit
 		if ! test -z "$update"
-- 
2.18.0.233.g985f88cf7e-goog

