Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36F6D20248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbfC3LVt (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:21:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46950 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbfC3LVs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:21:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so2243316pfj.13
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9UDdC6QudJc1/9WbTZNYgF9nZ77a17Sjj1O8i1ENOk8=;
        b=kLgvIpstaBg0haLncWI3EYQacurZl87NpiAckdmzmdeAhgKq7eMV5B9SEzWi06O0e/
         Re6JLIa/YPk5UuPdngi6oJPmCzf7I9gB2i3/jz2xqc7gg0BSutnApeKSD/FimS0FdPZt
         mKHR6YtuBQYQW+GtBBDnC1kHYlZ2XLJRIWQ36MpNoH5DK20v0iZZ5kK0a7lutCAnUAVF
         730DHwqrKr8lSo468ehCgffA/04Z8mFDEDWUfL26/5kZ2e/57yIhHIBe8CB1n+8HgPdM
         avDWKjFJw+sjyWQw1RRws0jhVohMFSIp0CF1oUcsZw3bflSNKGT2BweJiALza060mWYI
         YQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9UDdC6QudJc1/9WbTZNYgF9nZ77a17Sjj1O8i1ENOk8=;
        b=dGpT7OLYfxxdcoGKbeFsHXwMRamgdelTdg9BYogg9SaiHmaQSUqlwSVc0XuQzvyGhc
         gI7aE42+BNgR9uvqCoh3eC1xebTmDDwVmA3af2Dv2rMeVcLOC/TxHLQO0GlbdkkShBr3
         lzPZVcQLxrLXpkHB6vunoYD0WHR5a85VMHBAUHynmvLktm46q0JhiOcY7XN8WshaP4Yo
         qzo/uoUYdWYma9jK8ubjss/9jYxWtfk8vCAwpSXbDt2R1zecDi4xzxJz3U0mEA16LzNf
         397yPBPVBqdd0xCVmopMzcICNyBgJwgDFpR5vD6mpJ2AAt+hbekCwHpj7M8aLjWRCtVo
         GfBA==
X-Gm-Message-State: APjAAAV3pkesVV6l9EyhVSJ57UpuYyU8Q9ugIcKShgaRv55iPLXcs76g
        vkmfBRcqcwQe4a40oIog2FndNEIk
X-Google-Smtp-Source: APXvYqwGHkXlpgbFAgK6d0brWgoHY/sX0i3G4sdimVWONx3FYcgo9PVixkma65J7gRjvwqmEcHttRg==
X-Received: by 2002:a65:5b47:: with SMTP id y7mr50944733pgr.449.1553944908038;
        Sat, 30 Mar 2019 04:21:48 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id n75sm8208595pfb.39.2019.03.30.04.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:21:47 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:21:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 16/31] sha1-name.c: remove the_repo from interpret_nth_prior_checkout()
Date:   Sat, 30 Mar 2019 18:19:12 +0700
Message-Id: <20190330111927.18645-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190330111927.18645-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 2643b75b54..af8bf5b351 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -771,7 +771,7 @@ static inline int push_mark(const char *string, int len)
 }
 
 static enum get_oid_result get_oid_1(const char *name, int len, struct object_id *oid, unsigned lookup_flags);
-static int interpret_nth_prior_checkout(const char *name, int namelen, struct strbuf *buf);
+static int interpret_nth_prior_checkout(struct repository *r, const char *name, int namelen, struct strbuf *buf);
 
 static int get_oid_basic(const char *str, int len, struct object_id *oid,
 			  unsigned int flags)
@@ -835,7 +835,7 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 		struct strbuf buf = STRBUF_INIT;
 		int detached;
 
-		if (interpret_nth_prior_checkout(str, len, &buf) > 0) {
+		if (interpret_nth_prior_checkout(the_repository, str, len, &buf) > 0) {
 			detached = (buf.len == the_hash_algo->hexsz && !get_oid_hex(buf.buf, oid));
 			strbuf_release(&buf);
 			if (detached)
@@ -1288,7 +1288,8 @@ static int grab_nth_branch_switch(struct object_id *ooid, struct object_id *noid
  * Parse @{-N} syntax, return the number of characters parsed
  * if successful; otherwise signal an error with negative value.
  */
-static int interpret_nth_prior_checkout(const char *name, int namelen,
+static int interpret_nth_prior_checkout(struct repository *r,
+					const char *name, int namelen,
 					struct strbuf *buf)
 {
 	long nth;
@@ -1312,12 +1313,14 @@ static int interpret_nth_prior_checkout(const char *name, int namelen,
 	cb.remaining = nth;
 	strbuf_init(&cb.buf, 20);
 
-	retval = 0;
-	if (0 < for_each_reflog_ent_reverse("HEAD", grab_nth_branch_switch, &cb)) {
+	retval = refs_for_each_reflog_ent_reverse(get_main_ref_store(r),
+			"HEAD", grab_nth_branch_switch, &cb);
+	if (0 < retval) {
 		strbuf_reset(buf);
 		strbuf_addbuf(buf, &cb.buf);
 		retval = brace - name + 1;
-	}
+	} else
+		retval = 0;
 
 	strbuf_release(&cb.buf);
 	return retval;
@@ -1484,7 +1487,7 @@ int repo_interpret_branch_name(struct repository *r,
 		namelen = strlen(name);
 
 	if (!allowed || (allowed & INTERPRET_BRANCH_LOCAL)) {
-		len = interpret_nth_prior_checkout(name, namelen, buf);
+		len = interpret_nth_prior_checkout(the_repository, name, namelen, buf);
 		if (!len) {
 			return len; /* syntax Ok, not enough switches */
 		} else if (len > 0) {
-- 
2.21.0.479.g47ac719cd3

