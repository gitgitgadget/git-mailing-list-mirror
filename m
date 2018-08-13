Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0870E1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 22:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbeHNB1D (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 21:27:03 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:40355 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbeHNB1D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 21:27:03 -0400
Received: by mail-ua1-f73.google.com with SMTP id y3-v6so8436959uao.7
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 15:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HAax4ONjM5ve8aiQHE+c6l22jY3GnhVKlV4yxp8FdjU=;
        b=iHXe2Wgs0xUqj68VGgh8z3JvXYnTGuz+hYG/4pVYhJqXqs9wWqHHeCkfEmYPcJ0zQs
         wO0L+w0cyzALZXkXBawNsWcRJ9t9l0oIrczr3TospElPFWBRg0IR8oA3YPchl1WLZJgz
         9kfbGyPkwFnZW4fjxTOEMvPlDSbn9Y2prfKuZeB4qr3h3byLhf0YbZ6fNgInp9NEOzU2
         E9mgiWazaufHwahimK4rtMl2h4UcBVZdsTi9QnfJSXxW6aHiqzArbVJvx4fIQ9DvmZxs
         KlpZfeL/3Q+Fo97RGN89zPq236Wws5C79+iJHxQqS8mVuM3R7Jl4sb1QOMHaupYvKD6a
         Sgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HAax4ONjM5ve8aiQHE+c6l22jY3GnhVKlV4yxp8FdjU=;
        b=WbOtoQbjFQ+WA0BrOeWoQbstuUFp7nkuRgUGmanENL1rNLn8AcK4VRMixAvA1+1Iya
         sniMobuU5/O1WOMeHsfaQMn/hdbLMdSyS9PqSpg2c+MP4QtDUOll3U6o0qgBJXGdNMfn
         zwo9utH0Erdz/aV4IzFyKm5EGNZefLW4uQnWNtxrOayoH4A07L0sEfg73ZN0fP8KL5TD
         GGAM9IeK53zXNTRmsha2MIUaLg2lGUCyeCOwfpspjYpiUcuoA1AtGxl3uGN8ANMEaOv8
         nZnxjMKC/y8w7SJdMuZ+q9NGfuC7lm9nj3pt97vuQQgCHJzoz7MaLQZ6V0wtZ/1NaHzf
         XLRg==
X-Gm-Message-State: AOUpUlHF8S5YJ5BqIChoIL+pK3KpnAdBPeK95wiyQBXRCLwhD9ds3ZfR
        gCx/Jgsjjs+mmuPq6UunOgwFfVoY0ZJh
X-Google-Smtp-Source: AA+uWPzdSh4GF12MVfB4jwMYA7WdhaAQ9D0IXPmpK7cB6/u9CBR9ApTkgoUajYgh4oLVNAyaJNs0lOloBmvW
X-Received: by 2002:ab0:250:: with SMTP id 74-v6mr8721252uas.74.1534200166847;
 Mon, 13 Aug 2018 15:42:46 -0700 (PDT)
Date:   Mon, 13 Aug 2018 15:42:30 -0700
In-Reply-To: <20180813224235.154580-1-sbeller@google.com>
Message-Id: <20180813224235.154580-3-sbeller@google.com>
Mime-Version: 1.0
References: <20180803222322.261813-1-sbeller@google.com> <20180813224235.154580-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 2/7] git-submodule.sh: rename unused variables
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 5 ++---
 git-submodule.sh            | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a3c4564c6c8..da700c88963 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1573,9 +1573,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
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
index 5a58812645d..8caaf274e25 100755
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
2.18.0.865.gffc8e1a3cd6-goog

