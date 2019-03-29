Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8014C20248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfC2KkE (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:40:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43912 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbfC2KkD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:40:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id m10so843932plt.10
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D0Xv7f8W5DVq8n3VwtsFRZxenm5+KkRqqoTe3PM5WFY=;
        b=uTbZBILKp+6bZ5ETzjF2544rLRksz/+YXqlqxdWRCJQriJnpuvggu0exQkCSi96ugT
         k5pP6CHJXR2nWJ1Y+CxuZg9iHP7lmlZcJyfml9BxBLh2OdyY3X6G8C3FJwCFHBnirukf
         Nvy2wxwxl5j9kEou4Ppb2FCz3qYlOck8T63PcIKAF4YAVcAe+277b4s66XUgsUV7En1o
         utL9Xg/QKofyYV3MrDIMe33KWsI4ifiesXj0TMZOy/maQzuCiy/pb9I/IeIU3mG9B8KW
         4MTWtV8hP79HZBCvZYB3kebpMc3SA7EknoHe/0Ja9ri62DByGgkeSbsbVt7dnJDZriOM
         FLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D0Xv7f8W5DVq8n3VwtsFRZxenm5+KkRqqoTe3PM5WFY=;
        b=j6RNSZBopzRo0VfFMCiR1YsJGjofgPxbUkb3qwpcF3wmUc+9drEk6NCIdlLYV2QCUO
         HJ3nONQH8wq5zyD4KBtWdq6GYEworHWv63YPVvtNnqe1F/+RWcMp6iEOrwOiN5ClA7VZ
         MRNaKeP2gYZjHqg8lACL1uhdVf/JQHT0gmqeLIdTMj5Vt4MNqMlNFB4165WZ5dFRBMUU
         /IMnQO8Q4gR/0oP1W0/ndAatVj3RvcDQ0ewQhwxtRBcRw4387uPgaoW3vFlscCPcX/nJ
         rTVKNACxlvTVGqNYYM1owxj9XL5j5J/TbjZ4H0tqQUWqJAiY/R1lexflKYjgLn7PORWn
         hEzA==
X-Gm-Message-State: APjAAAV2Bihf5AP8chnqApqPP8QDl6CgppiYa+Nol+NHIqF6KPpjetGd
        QqmHphIuEZ2o/YPuYR9lPWM=
X-Google-Smtp-Source: APXvYqzqfWqzQuYKzPrjT/+/3bJokVq1xR5kx0gaQe17dJMLlsyvqWq3R/TgbmHAPsMrgkvZ0HghSg==
X-Received: by 2002:a17:902:801:: with SMTP id 1mr16280545plk.299.1553856002554;
        Fri, 29 Mar 2019 03:40:02 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id g64sm5646908pfg.13.2019.03.29.03.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:40:01 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:39:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 03/27] doc: document --overwrite-ignore
Date:   Fri, 29 Mar 2019 17:38:55 +0700
Message-Id: <20190329103919.15642-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
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
 Documentation/git-checkout.txt | 6 ++++++
 Documentation/git-merge.txt    | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 28817cfa41..5280d1f9ed 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -271,6 +271,12 @@ Note that this option uses the no overlay mode by default (see also
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
 	Using --recurse-submodules will update the content of all initialized
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
2.21.0.479.g47ac719cd3

