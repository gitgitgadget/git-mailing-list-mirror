Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 943541F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeCCLiB (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:38:01 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40922 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeCCLiA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:38:00 -0500
Received: by mail-pf0-f195.google.com with SMTP id x1so3261564pfh.7
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xrl3wtAG/wsXMS5tWsLBfVzPnlMuvKRrvfWimQAsY+w=;
        b=epFZX6vplWaY0hnpfYJATKBaXOKX2FqEJKY0oh3PSBVDYcq7D6UcVfGbur8N4TtNhN
         CyYET2BgFOfLMqfKOOd5Z7b0K549FDJj2/Pz6lcbKUKMUB7L3vs+Yti0OD2R8A06A1zl
         Mx0aBUC3IDiqdVqgMwz2ba16TDuwirWeIxkhpDC9LbMaIauRlqJFVUvmEIfEcEvxxq7f
         qWbKP1Pk1e5tj8ue7xNxetrHhUTgwIHsLwPsz/xwlpK3Sa1Xw+kkOr3cSFeYs7h340N+
         MrRB9kuR0c0x+XrgzKr/qyb6SGkRull15p1kF4HERUitl5AfgSQnjDjbWjgBQ50UDH0g
         YJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xrl3wtAG/wsXMS5tWsLBfVzPnlMuvKRrvfWimQAsY+w=;
        b=G54mwQHdpc2g8DSOhwPhTOUBxc9AKIaW+2LSr7rovtOIFX8whmBhKOr4ElGOvQuVpO
         vozrmEdQJNVfX0qMV4v+05hj4gUWvfu4rt7X1KfEOBhwjZnsGOpjQnt48Zy7uqOTmOw0
         nacuJHgdQsLg5/dmf9lu9e6Fffr/fxPTS6jyllZQKxEXv2iDNPPo5W+Y9Uv9evSEMn+7
         YVdDPTWUn+/2tPV/6CXmZ8IVEM6PN1+PfG4DNogqLy9xmOrdPtawRD122DR0rVmmWeAQ
         t8RMuUNNukllaNqTtBWfNVZPUAzFUen/m9kmWJ8YWgAev94oeE1d+d+Tu9m8IMT0kppw
         cUQg==
X-Gm-Message-State: APf1xPBdpH3jMrrplk6edbGlTSgzbEO7VAGY67XQjKFxuAZZYSkGEWv6
        qOV+Xs9FDOKepsC94AbJd7LV5w==
X-Google-Smtp-Source: AG47ELsP8lIIkAULQcg9jxrnQrIM5SQ702x94V4dCxqYQTVQbMcOofY0CNdfQUyhmqiCSi2H7jhohw==
X-Received: by 10.98.80.15 with SMTP id e15mr8641427pfb.90.1520077080096;
        Sat, 03 Mar 2018 03:38:00 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id v68sm16136753pfv.61.2018.03.03.03.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:37:59 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:37:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/44] sha1_file: add repository argument to link_alt_odb_entry
Date:   Sat,  3 Mar 2018 18:36:08 +0700
Message-Id: <20180303113637.26518-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Add a repository argument to allow the link_alt_odb_entry caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

Since the implementation does not yet work with other repositories,
use a wrapper macro to enforce that the caller passes in
the_repository as the first argument. It would be more appealing to
use BUILD_ASSERT_OR_ZERO to enforce this, but that doesn't work
because it requires a compile-time constant and common compilers like
gcc 4.8.4 do not consider "r == the_repository" a compile-time
constant.

This and the following three patches add repository arguments to
link_alt_odb_entry, read_info_alternates, link_alt_odb_entries
and prepare_alt_odb. Three out of the four functions are found
in a recursive call chain, calling each other, and one of them
accesses the repositories `objectdir` (which was migrated; it
was an obvious choice) and `ignore_env` (which we need to keep in
the repository struct for clarify); hence we will pass through the
repository unlike just the object store object + the ignore_env flag.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1_file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 77c099dadd..2ee5fe6ba3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -390,8 +390,9 @@ static int alt_odb_usable(struct raw_object_store *o,
  * terminating NUL.
  */
 static void read_info_alternates(const char * relative_base, int depth);
-static int link_alt_odb_entry(const char *entry, const char *relative_base,
-	int depth, const char *normalized_objdir)
+#define link_alt_odb_entry(r, e, rb, d, n) link_alt_odb_entry_##r(e, rb, d, n)
+static int link_alt_odb_entry_the_repository(const char *entry,
+	const char *relative_base, int depth, const char *normalized_objdir)
 {
 	struct alternate_object_database *ent;
 	struct strbuf pathbuf = STRBUF_INIT;
@@ -488,7 +489,8 @@ static void link_alt_odb_entries(const char *alt, int sep,
 		alt = parse_alt_odb_entry(alt, sep, &entry);
 		if (!entry.len)
 			continue;
-		link_alt_odb_entry(entry.buf, relative_base, depth, objdirbuf.buf);
+		link_alt_odb_entry(the_repository, entry.buf,
+				   relative_base, depth, objdirbuf.buf);
 	}
 	strbuf_release(&entry);
 	strbuf_release(&objdirbuf);
-- 
2.16.1.435.g8f24da2e1a

