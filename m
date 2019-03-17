Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F43320248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfCQMt4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:49:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45690 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:49:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id v21so9390745pfm.12
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hmP/b0mvRrYnqSM1WdUfs0anmj+xBr/qMdgta41Zx9w=;
        b=edVMXVEynLSV1EfzMhy5JTOLTXAklAlBkHbltyAojsvir0C2BeMtNJp9/QuK70hr5a
         67TTqIqwljaeCCeJu8WftnSXNjTdPzWATueTs3h/i67Ph80DJOtVuyyBgGmvfdemQYIr
         6CcKn3lMuc6C9Ex8z065+k4LciQ7O/vohrljCV6zKah5PUD1lTKWOCJoaWl2+9B7SD0h
         6xLtOPHBlIiTybhM1yaIO+A0D/+f/WHjxiu88nwDkhh/qhbR9i1cm2kuGG4xmrsoiI2p
         BzkLfs6lF0UFZjVDWIzLGrlMxOHNkymMIGlJvflrP7sg846RBGXf98z9Qz0HO4H9xXhJ
         ft9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hmP/b0mvRrYnqSM1WdUfs0anmj+xBr/qMdgta41Zx9w=;
        b=A9HRUiLWOQ/2paLdusiRq4FqHSntChYh2yF+1kWE7XhZ06+7BsPNydeXGozsVqwJ7+
         3gA3NcDQdtBhh2cNSS2TdSdPfbOti3+Z9aiGSH7uNrgwTre0ypj7uyf3rQB1CbSDfmOM
         YZK/TS+sd9DISXdN1baaw2pprGmKkcH62Ve26NYK5a0qUR+QPup7YAA/wXyciLLjcdcx
         JL9x2ZKqjefVjqptUU7knHo/ZRbvpcZ60jrjDLymR02dM3Zq4ssIRV45PWUMQbPVRdKB
         MS0kspkN2DpdsM0ksDcJnYUG9JS8fYgjHC4q5RZflWWznP65se92LndZdwMZkN72j6c4
         Bztg==
X-Gm-Message-State: APjAAAUtdFJedGc5MJ58j41wK2PhE2M8YQW3OYYH//uFCbAoiP4bJqHh
        ckAlrj8pDS+83BJbKENzk9g=
X-Google-Smtp-Source: APXvYqxpQUJ7Rv+gQRRWPkJfsLSdq+pOewvnVHrv9nSB0DSWuKNXwwk5YkOKv+kvw3kunaDyLlrTdg==
X-Received: by 2002:a63:101c:: with SMTP id f28mr12525054pgl.224.1552826995796;
        Sun, 17 Mar 2019 05:49:55 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id l7sm23641252pfj.162.2019.03.17.05.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:49:55 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:49:50 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 03/26] doc: document --overwrite-ignore
Date:   Sun, 17 Mar 2019 19:49:03 +0700
Message-Id: <20190317124926.17137-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190317124926.17137-1-pclouds@gmail.com>
References: <20190308095752.8574-1-pclouds@gmail.com>
 <20190317124926.17137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I added this option in git-checkout and git-merge in c1d7036b6b
(checkout,merge: disallow overwriting ignored files with
--no-overwrite-ignore - 2011-11-27) but did not remember to update
documentation. This completes that commit.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-checkout.txt | 14 ++++++++++----
 Documentation/git-merge.txt    |  5 +++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 28817cfa41..82e0f81869 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -271,15 +271,21 @@ Note that this option uses the no overlay mode by default (see also
 	out anyway. In other words, the ref can be held by more than one
 	worktree.
 
+--overwrite-ignore::
+--no-overwrite-ignore::
+	Silently overwrite ignored files when switching branches. This
+	is the default behavior. Use `--no-overwrite-ignore` to abort
+	the operation when the new branch contains ignored files.
+
 --recurse-submodules::
 --no-recurse-submodules::
-	Using --recurse-submodules will update the content of all initialized
+	Using `--recurse-submodules` will update the content of all initialized
 	submodules according to the commit recorded in the superproject. If
 	local modifications in a submodule would be overwritten the checkout
-	will fail unless `-f` is used. If nothing (or --no-recurse-submodules)
+	will fail unless `-f` is used. If nothing (or `--no-recurse-submodules`)
 	is used, the work trees of submodules will not be updated.
-	Just like linkgit:git-submodule[1], this will detach the
-	submodules HEAD.
+	Just like linkgit:git-submodule[1], this will detach `HEAD` of the
+	submodule.
 
 --no-guess::
 	Do not attempt to create a branch if a remote tracking branch
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 4cc86469f3..6a9163d8fe 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -87,6 +87,11 @@ will be appended to the specified message.
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
+--overwrite-ignore::
+--no-overwrite-ignore::
+	Silently overwrite ignored files from the merge result. This
+	is the default behavior. Use `--no-overwrite-ignore` to abort.
+
 --abort::
 	Abort the current conflict resolution process, and
 	try to reconstruct the pre-merge state.
-- 
2.21.0.548.gd3c7d92dc2

