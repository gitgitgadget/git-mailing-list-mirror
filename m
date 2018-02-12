Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAAE51F576
	for <e@80x24.org>; Mon, 12 Feb 2018 09:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933378AbeBLJuR (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 04:50:17 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:35627 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933377AbeBLJuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 04:50:16 -0500
Received: by mail-it0-f66.google.com with SMTP id e1so5828029ita.0
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 01:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ezszZ7dJkWyKFowfr1q8BUYsJur4Muhc0+Ms89M0DAQ=;
        b=QwcG3UkByv1N8UJoh/3ODvMsUi7SuwxaPSiwyKlpOng79uisaArzmbX4iu5VhKRGbJ
         OsW4vMmte9WFWUjrx8pW/12i/02VsAmDnbqO4tmhAeKFXQgwuXurGxi8fCVW5ifnJuKu
         3XRdRAbdsV02A3mJjE+pKRloT/g3lr+xuRQO+OcragHrYmDcQ5ln621PQzoi/KSyI4Q1
         zdUH14FwPXiwDbMabzU5y9Hm78MzqTRFGqoC2Bu0htgo9PEBJktiiT+GyeF2Ns/chKww
         smmNFI9gcI+nkdVGzlW7hyYdwzOS60dfsodELaFjgY2wCB/IZcHOGXmCsZ0x68nsf/3B
         i+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ezszZ7dJkWyKFowfr1q8BUYsJur4Muhc0+Ms89M0DAQ=;
        b=mp0vW6cb1rWTFzKT2vkR7zJXBUkmbR/29oha5iika9zR9OFp61Jnio1XBqK0ZNqrqq
         UFYnQIMuoiC+L/+r8H8je1zCOFb+BschcDL1+3W9yqc14tjep6OQHYMfI7+qRMMVRUtw
         1FDzw+OPnNa+LAdGw4yNboHCif0xySNUepL8/drolIaMMW2SZxWtaTZ7yShucp6GqDSK
         3Eb0axaI0VhfQOPfIOGFotrcsKxtjBJ1eObxNnGXxXcxwcGB0y2a1cAb1BxgvpJhwV6d
         RWpWweb5mQC7K05GqsBQ8gQ9XmLf+q5GEDrMKnI1hOWJ4o4VvNb1KXmMXhJdfs0Nzi26
         KrRw==
X-Gm-Message-State: APf1xPAwkpLgSmP3tN1LhhuoYAhOZsHqQ6N4P+pheOREO6UYkMUzrCsT
        j4wnSIoIm66iMksW0VFG80c/og==
X-Google-Smtp-Source: AH8x225TafKJpi9w5bBydAS+aYdihvizqFnVjVadAMb67jjU3OKSDBYrYtA/0z0EkcLmsujzCmZJ0Q==
X-Received: by 10.36.22.206 with SMTP id a197mr4447397ita.57.1518429015981;
        Mon, 12 Feb 2018 01:50:15 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id d65sm6586257itd.19.2018.02.12.01.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2018 01:50:15 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 12 Feb 2018 16:50:10 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 2/7] worktree.c: add update_worktree_location()
Date:   Mon, 12 Feb 2018 16:49:35 +0700
Message-Id: <20180212094940.23834-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.399.g632f88eed1
In-Reply-To: <20180212094940.23834-1-pclouds@gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com>
 <20180212094940.23834-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 worktree.c | 17 +++++++++++++++++
 worktree.h |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/worktree.c b/worktree.c
index b238d87bf1..0373faf0dc 100644
--- a/worktree.c
+++ b/worktree.c
@@ -326,6 +326,23 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg)
 	return ret;
 }
 
+void update_worktree_location(struct worktree *wt, const char *path_)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	if (is_main_worktree(wt))
+		die("BUG: can't relocate main worktree");
+
+	strbuf_realpath(&path, path_, 1);
+	if (fspathcmp(wt->path, path.buf)) {
+		write_file(git_common_path("worktrees/%s/gitdir", wt->id),
+			   "%s/.git", path.buf);
+		free(wt->path);
+		wt->path = strbuf_detach(&path, NULL);
+	}
+	strbuf_release(&path);
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index cb577de8cd..a913428c3d 100644
--- a/worktree.h
+++ b/worktree.h
@@ -68,6 +68,12 @@ extern const char *is_worktree_locked(struct worktree *wt);
 extern int validate_worktree(const struct worktree *wt,
 			     struct strbuf *errmsg);
 
+/*
+ * Update worktrees/xxx/gitdir with the new path.
+ */
+extern void update_worktree_location(struct worktree *wt,
+				     const char *path_);
+
 /*
  * Free up the memory for worktree(s)
  */
-- 
2.16.1.399.g632f88eed1

