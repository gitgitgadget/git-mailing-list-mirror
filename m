Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF1B41F45F
	for <e@80x24.org>; Wed,  8 May 2019 00:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfEHAN1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 20:13:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51913 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfEHAN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 20:13:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id o189so834270wmb.1
        for <git@vger.kernel.org>; Tue, 07 May 2019 17:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5kBHmMaSoFVjoR1WMzXNjCUHK4LkQYOV3lJXlOdfnqc=;
        b=cx+4Be5VZDLuwqMAJP/lmJS1+PtXPmy2ZZVJe+2b5vJV95M9U2k3Liu90DyqkkOfCb
         H3KftsdZ5A+t50lYfw3hPJRCw7JnBrzzPiZ0h8rQYC1ZspC1sr9oGZ4jt6FctLYqwDfr
         tE6bar2UxKwcLXiRbzrqSYiZmU9VjEzE+WkqAxIk+SRk7+9I0a09AM+aISkncUMrBMg7
         qteFj5aK1lzcHuiR7xD0pYLZjWDEhiZP1/+Vop3TamkZx8MLcuQS+QpMoIUzfIiPz3E6
         +tMKWZayFjJsN/bluMYqN4KinsRSK9Z8mu4xl2NJnRhmS6yt8Qkm/va0mCgH1FJ55NUP
         /V/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5kBHmMaSoFVjoR1WMzXNjCUHK4LkQYOV3lJXlOdfnqc=;
        b=tjPvNyCXDAzyRa8dVmvdG92i9T7ALY6tLfKSkV2rB2xfGoqMPgL3eco2xOALoGAYzg
         7vRS3v03UYtx6Imp0OWpIWlY7VNylotm+nuZeNP7+itiKmtXXrXQDoiFOiZGHDJKu/4L
         guTjhzE9YLYEtpbY2Ch+VAms9wsnlgJFOgKwcA3hShcitAHFWhxjvLyNY5IAc5Mw4+oH
         nJ8KsLteZdt9b4lq6wDcsn95aZe7pf6MOp/q8UtyzeckU24QMwsUbBRcS5Ma6SM4yGjJ
         Ab6Fe7dc2UzHCf1EhKB9kTxJx7bv17IRdSrqcGomMMrpfEINJEFI/BK5uid626leAUaR
         JD5Q==
X-Gm-Message-State: APjAAAVg76YpkyAnaVZeTU3EpNe1Y/j6DUc/BjBfjI2znYlxpLgpVqWE
        vS3vJy4CTG+a7p68595hkv8Ee/9crvI=
X-Google-Smtp-Source: APXvYqzy8ioF+fh+u4R3c4LDMHOKGgIENX01e/HNe8yBwrOsBITdVYRk5FFidwiMtQe4jJyBh1FAzw==
X-Received: by 2002:a1c:701a:: with SMTP id l26mr745552wmc.50.1557274403872;
        Tue, 07 May 2019 17:13:23 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm5167825wrp.58.2019.05.07.17.13.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 17:13:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC WIP PATCH v8 12/13] rebase: add a should_fast_forward() utility function
Date:   Wed,  8 May 2019 02:12:51 +0200
Message-Id: <20190508001252.15752-13-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <cover.1555832783.git.liu.denton@gmail.com>
References: <cover.1555832783.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The is_interactive() test gets tricky around --rebase-merges. Let's
split our use of it for the purposes of whether we should try
fast-forwarding a rebase into a utility function to prepare for adding
more logic to that specific codepath.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index cb5d7fcb53..167d4fcf67 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -890,6 +890,11 @@ static void populate_merge_bases(struct commit *head, struct commit *onto,
 	oidcpy(merge_base, &merge_bases->item->object.oid);
 }
 
+static int should_fast_forward(struct rebase_options *opts)
+{
+	return !is_interactive(opts);
+}
+
 static int can_fast_forward(struct commit *head,
 			    struct commit *onto, struct commit *upstream,
 			    struct commit *restrict_revision,
@@ -1715,7 +1720,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (head_commit)
 		populate_merge_bases(head_commit, options.onto, merge_bases,
 				     &merge_base);
-	if (!is_interactive(&options) &&
+	if (should_fast_forward(&options) &&
 	    can_fast_forward(head_commit, options.onto, options.upstream,
 			     options.restrict_revision, &options.orig_head,
 			     merge_bases, &merge_base)) {
-- 
2.21.0.1020.gf2820cf01a

