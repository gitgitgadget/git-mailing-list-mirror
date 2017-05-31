Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC1571FD09
	for <e@80x24.org>; Wed, 31 May 2017 15:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbdEaPEo (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 11:04:44 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35445 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdEaPEn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 11:04:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so2827449pfd.2
        for <git@vger.kernel.org>; Wed, 31 May 2017 08:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yuia17m92yjVOpJ1UA+Hnqoyqr0jyfeM/P5OmvQse9k=;
        b=A9ngjhz7rg1hnpz72RmrZR2ATUr9JxgTJVWPUwtcdOotAJLN/jLFeNEC7ShdJ8NLH2
         jp4t0CewVisnqb23gAwMkUa5F6Fyhty5/X06138okUlMp5bjFwADZN8S+98JUPEZh8JQ
         805yFJQDan65fQc6SjONjIqzSd1oi5LpxkfU2rDd6MwRflrm5xinLUZwtCL0HsEppiji
         yULWZVWl0iZEsLpOq9RjO5Nd/d1q8ZNlqhxmp9D2xCo3f8tmdzkBZpqbH4HTb1pUe5ar
         Egq9kXwbW+U43SfoClkZJQP9VyPwgpfSRRwXSALzKZXtVbh6Ak6x+jiLCpf6NAUPTsyQ
         a6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yuia17m92yjVOpJ1UA+Hnqoyqr0jyfeM/P5OmvQse9k=;
        b=I0FbOu138ySAqh4DyUBAGLad74/WV5IhmEuzvOIBAh1pdcoF1dVX2AH5hU+ngTIfZC
         yalcsQb2I5JzSGdMR4Ddzjn5a8ItJBW7XUHwTOF5ErURt/xF/KA3b/OgKJBN+3z/4XP/
         bCpSFtFh6q6i1qN/8OCpsyiCy0xt+gac5onDPB2gAsIuMz4taEzUYQt9zzEG6qRBOGhK
         N3uUn6vE9grxlA02XNiUD/SVY8Pq6TvQtdqkVNOCT8GaVsLu1+jQg5eSBqeiIhGHWsZc
         bj4se0CAjL3DJGUuetLTJS88e6pkDh0fRanEeOevZoLzrWb02bau75dmvN5guai1jVk9
         Z+cw==
X-Gm-Message-State: AODbwcBbnNbSnwel1UCsxAlquDytSZUJKQhaK/xX5+B9ko1V73T/qQPK
        cKie4nIxLFoiviOc6l0=
X-Received: by 10.98.8.142 with SMTP id 14mr31322557pfi.35.1496243082304;
        Wed, 31 May 2017 08:04:42 -0700 (PDT)
Received: from kewillf-git.redmond.corp.microsoft.com ([2001:4898:80e8:f::3b6])
        by smtp.gmail.com with ESMTPSA id g20sm30213737pfk.21.2017.05.31.08.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 08:04:41 -0700 (PDT)
From:   Kevin Willford <kcwillford@gmail.com>
X-Google-Original-From: Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 2/2] rebase: turn on progress option by default for format-patch
Date:   Wed, 31 May 2017 08:04:27 -0700
Message-Id: <20170531150427.7820-3-kewillf@microsoft.com>
X-Mailer: git-send-email 2.13.0.92.g73a4ce6a77
In-Reply-To: <20170531150427.7820-1-kewillf@microsoft.com>
References: <20170531150427.7820-1-kewillf@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change passes the progress option of format-patch by
default and passes the -q --quiet option through to the
format-patch call so that it is respected as well.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 git-rebase--am.sh | 5 +++--
 git-rebase.sh     | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 375239341f..ab2be30abf 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -51,8 +51,9 @@ then
 else
 	rm -f "$GIT_DIR/rebased-patches"
 
-	git format-patch -k --stdout --full-index --cherry-pick --right-only \
-		--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
+	git format-patch $git_format_patch_opt -k --stdout --full-index \
+		--cherry-pick --right-only --src-prefix=a/ --dst-prefix=b/ \
+		--no-renames --no-cover-letter --progress \
 		"$revisions" ${restrict_revision+^$restrict_revision} \
 		>"$GIT_DIR/rebased-patches"
 	ret=$?
diff --git a/git-rebase.sh b/git-rebase.sh
index db1deed846..b72e319ac9 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -73,6 +73,7 @@ test "$(git config --bool rebase.stat)" = true && diffstat=t
 autostash="$(git config --bool rebase.autostash || echo false)"
 fork_point=auto
 git_am_opt=
+git_format_patch_opt=
 rebase_root=
 force_rebase=
 allow_rerere_autoupdate=
@@ -308,6 +309,7 @@ do
 	--quiet)
 		GIT_QUIET=t
 		git_am_opt="$git_am_opt -q"
+		git_format_patch_opt="$git_format_patch_opt -q"
 		verbose=
 		diffstat=
 		;;
-- 
2.13.0.92.g73a4ce6a77

