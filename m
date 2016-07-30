Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFAD91F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbcG3R1p (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:27:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35468 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so20041840wmg.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:26:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YLOKgBU3Cx7B8kxcjTE6Cqf+nZyk6n4VuefChZd9RSs=;
        b=pk5E2BXfNtHFUJYtfYm3GS4RXwqB4vYBdHKvgD+h7ZuXrQPu43v0yzO0R4tRQ2TPK3
         zV8uCNGGBKcOD68623mtyl2syGfYiTAD9Lvc8wYgPXY53bhwNPROw4j+YmY8J9PxMqY3
         ayFxxfEXFPaRQy/1w8gEW1DWvS8/fdkeRltIFjxvWzASGzpEVHQjgyDWuqfoi0zimE/7
         JRO4IaGzIat2Hj1mK06uIePAw1vR/V9dKzZs0uvZ3+7piiv6C2PvzQFRX59++m55o+2P
         1DaZQjo6mITSxaI/fMxTRb7A1RIDlTCSJRWuBn3eZNJMHhshP/kum7v6+juciop0Z9aJ
         2IbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YLOKgBU3Cx7B8kxcjTE6Cqf+nZyk6n4VuefChZd9RSs=;
        b=Py35Rk2erw8SjmLqFiMzk5Lkp/ub1LGQ6o6MuliHIJStxN7H2/6JXruZ5TJxmHFXMC
         rJzf3eJQnuW3xF2mUOjCWFxUDhqB6R3KqMMhfyCswKcC/GlFEPtrqeLdekjTUUV/Eo5V
         4phLd8Qdwao0WucZkUeSzFIsVGTEjuHPDBNtJA4uihEDCRmOFcD2SFb5MfgvMTvIpIeR
         SCWHTcPO/RokeeSXKFSIoKoSHgukyCXPXFrIHdc1dY+AzpddtRtjM1Tx4Cq/WDfogLdV
         8ZLw/NTGDnkRE37K70m0EVKJoRVUecQqtG5K76yXacDBspSWjxLmFfdwPn9ueX0QZJr7
         6pCg==
X-Gm-Message-State: AEkoouujsIe9BF10TkklEgUi1pfaiS+0o0lKTCeHzIVaYis+kY0mMvlziUh8q7Aby0DfLw==
X-Received: by 10.28.38.196 with SMTP id m187mr6188446wmm.81.1469899585046;
        Sat, 30 Jul 2016 10:26:25 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:26:24 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v9 33/41] environment: add set_index_file()
Date:	Sat, 30 Jul 2016 19:25:01 +0200
Message-Id: <20160730172509.22939-34-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Introduce set_index_file() to be able to temporarily change the index file.

It should be used like this:

    /* Save current index file */
    old_index_file = get_index_file();
    set_index_file((char *)tmp_index_file);

    /* Do stuff that will use tmp_index_file as the index file */
    ...

    /* When finished reset the index file */
    set_index_file(old_index_file);

It is intended to be used by builtins commands, in fact `git am`, to
temporarily change the index file used by libified code.

This is useful when libified code uses the global index, but a builtin
command wants another index file to be used instead.

And yeah this is a short cut and this new function should not be used
by other code.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h       |  1 +
 environment.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/cache.h b/cache.h
index b5f76a4..18b96fe 100644
--- a/cache.h
+++ b/cache.h
@@ -461,6 +461,7 @@ extern int is_inside_work_tree(void);
 extern const char *get_git_dir(void);
 extern const char *get_git_common_dir(void);
 extern char *get_object_directory(void);
+extern void set_index_file(char *index_file);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
diff --git a/environment.c b/environment.c
index ca72464..eb23d01 100644
--- a/environment.c
+++ b/environment.c
@@ -292,6 +292,18 @@ int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1)
 	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
 }
 
+/*
+ * Temporarily change the index file.
+ * Please save the current index file using get_index_file() before changing
+ * the index file. And when finished, reset it to the saved value.
+ * Yeah, the libification of 'apply' took a short-circuit by adding this
+ * technical debt; please do not call this function in new codepaths.
+ */
+void set_index_file(char *index_file)
+{
+	git_index_file = index_file;
+}
+
 char *get_index_file(void)
 {
 	if (!git_index_file)
-- 
2.9.2.558.gf53e569

