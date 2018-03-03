Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BA671FAE2
	for <e@80x24.org>; Sat,  3 Mar 2018 11:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932075AbeCCLh4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:37:56 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46653 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeCCLhz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:37:55 -0500
Received: by mail-pl0-f67.google.com with SMTP id y8-v6so7175636pll.13
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vGLF50FCA/JkN0bhlNPXmacLm7WZqgHZzNd90tGfr7A=;
        b=lIQmZ1uvAdZ2kTd6t6VIyztzW9vlJ78e2831awmYY+FaLKovyezIjIcKGY7DZic2C7
         ukDW14PtXsTrHpR4VsLxYMD8/8qhCJQbxYRb83GCQ9Cu+cE4UsglIvKsjMGZv6ApKl+I
         LvhR7kLaP+wcVhJm63rBaKUvcNvqNnj3rXxRn9flQNBgaqYYyhSHL44jQCMfdp00giDy
         MlMiecKCcAqjsh64WnHl4nw0bo9uHEdX0q8QQxt0k0RYjhx5M8L2H7L4Z07Yw9xOHnve
         6y/DHMRdHWnCwlF8HOaikUO6dfWNV5nx/P1Han3Q62V4DQQFHgP2E+QhLCX538fxaEa2
         bw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vGLF50FCA/JkN0bhlNPXmacLm7WZqgHZzNd90tGfr7A=;
        b=iGaKW8XtpS0tUVVq+0p8iH6WeO0BVyCTvA2zojFVhUqgkMKi0O3z+J+sP+i7UdXNhS
         I9rlT0q7szfRQDouq7Ac0C1JVRskNaR7/3LkUAnkDsKwrcnYqQ+M7nvlR8pU7EiWuU+Q
         SPCnVY1X9+6F5Z8iAShuDWy7nK+Sr1a2izWAB5euSc0vmqZl5vtt05wv+iyjOU6LOnb9
         ubXqEEdnrAiMt7AAw2kU6V87+KvQL0XByraNdCWIvEP1f+VAUL4lhgPP3SbjUF1TMqGo
         +TMFjMPXr+D3U+qmsZpttZGtB6Lx0l0uReMzXSqGV8ySVpSuYrzNCl6ongrqszYCBUvi
         TiQA==
X-Gm-Message-State: APf1xPCE9EqVg8eTj5Mtc/QrB5NEMl1pFpOg5tl1qd5mRv+elnCQWz5K
        OyY9d2TGobYxCIpQp0TEAp+CTw==
X-Google-Smtp-Source: AG47ELsU2OaknNYea4qOqw0ytjRD3kj+2vUu0ZtRB65AUI46e3PEYazLD5l7qVIXOp77NXDW50R+Rg==
X-Received: by 2002:a17:902:aa43:: with SMTP id c3-v6mr8022364plr.357.1520077075062;
        Sat, 03 Mar 2018 03:37:55 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id 5sm19778925pfh.133.2018.03.03.03.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:37:54 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:37:50 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/44] sha1_file: add raw_object_store argument to alt_odb_usable
Date:   Sat,  3 Mar 2018 18:36:07 +0700
Message-Id: <20180303113637.26518-15-pclouds@gmail.com>
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

Add a raw_object_store to alt_odb_usable to be more specific about which
repository to act on. The choice of the repository is delegated to its
only caller link_alt_odb_entry.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1_file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4c9635dada..77c099dadd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -346,7 +346,9 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
-static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
+static int alt_odb_usable(struct raw_object_store *o,
+			  struct strbuf *path,
+			  const char *normalized_objdir)
 {
 	struct alternate_object_database *alt;
 
@@ -362,7 +364,7 @@ static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = o->alt_odb_list; alt; alt = alt->next) {
 		if (!fspathcmp(path->buf, alt->path))
 			return 0;
 	}
@@ -414,7 +416,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(&pathbuf, normalized_objdir)) {
+	if (!alt_odb_usable(&the_repository->objects, &pathbuf, normalized_objdir)) {
 		strbuf_release(&pathbuf);
 		return -1;
 	}
-- 
2.16.1.435.g8f24da2e1a

