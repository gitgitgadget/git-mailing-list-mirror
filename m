Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 758C21F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbeCWRWL (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:11 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41162 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbeCWRWD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:22:03 -0400
Received: by mail-lf0-f68.google.com with SMTP id o102-v6so19365228lfg.8
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rGbQErkijdvuDIOE2QkMvJdivy/rSAA/42bLSrzKWFo=;
        b=VqmufJ0iowBIwNF16BUDzOx6nrw6cqE22vDazXPik/y7Aa8+PPxqHlPwhbTIVVL+d0
         U3B5xpnNIq1JpO+WI+Ukq7NE5Q5CiPYy28a+gtOksdRfH0TZwFT2aIR5D91aSm0Z2gY2
         pbTlQEm4bfi4QyMVy7q1lUTMqfMvNsjlOq5V7Xt0a9zsjTLNL17CgeFDq+YsrKdxg8yQ
         rHQKjjt54D4rkcJJuqIvRACV5vp2fLuyWQcWQ2fRfE7Pkh+AoJIrSMqBczSsJZnIhxSa
         uMYORwqfzq4tul/mCxPvboFfLQEHBAY7gWTIO1ITg41fJQJtV0v9dbIFBakrMtq5+Kz2
         eLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rGbQErkijdvuDIOE2QkMvJdivy/rSAA/42bLSrzKWFo=;
        b=q16WI21t0M1dtpRbMODrixg+xy5wmHTE/87cSNJwcitEE8LnHN61dWOIhGfoZNs5Ki
         mKeLpjfBhF+OU+EDAjLbJgGVfqRx7LLDVnoFVae98fkBbILHw9FFS+KFkDu1HYLrU1vS
         xrsR0Jt45OPQQONMtpZUbX9f2uqSgmc/Jj2cyWfiR4vETXgZ7oaA3iA2KC5fLYIQ93Qz
         uFtKqS0p8iInsZdESbeB2blOpBPfMCoE15anj7hzjW29kqLFkel/H3DreM1sr1JWRprL
         JGbnWMWhBTNoUlZMqQ3z+NvzAZzMPca5HuFWMj/OXd6Cg9XN0Ca87k0evIzBrQeqNGBW
         L+nQ==
X-Gm-Message-State: AElRT7GjAM/sumqyiVqIkbJIUzwEzpXVPQ1QecslKThOA6Pukt/0AFkk
        805CclACNPGlj7M6zYAnXN0=
X-Google-Smtp-Source: AIpwx480IflAEk1Adwtz1/b831YEC2Bb5X1EUagGo8yGL+CXr4faLApWzl+Cr5TjdK4u2XNuarx1Cg==
X-Received: by 10.46.16.1 with SMTP id j1mr2042867lje.102.1521825722433;
        Fri, 23 Mar 2018 10:22:02 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:22:01 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 17/27] sha1_file: add repository argument to stat_sha1_file
Date:   Fri, 23 Mar 2018 18:21:11 +0100
Message-Id: <20180323172121.17725-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Add a repository argument to allow the stat_sha1_file caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index fe16d30f66..80bac89014 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -867,8 +867,9 @@ int git_open_cloexec(const char *name, int flags)
  * Note that it may point to static storage and is only valid until another
  * call to sha1_file_name(), etc.
  */
-static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
-			  const char **path)
+#define stat_sha1_file(r, s, st, p) stat_sha1_file_##r(s, st, p)
+static int stat_sha1_file_the_repository(const unsigned char *sha1,
+					 struct stat *st, const char **path)
 {
 	struct alternate_object_database *alt;
 	static struct strbuf buf = STRBUF_INIT;
@@ -1174,7 +1175,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
-		if (stat_sha1_file(sha1, &st, &path) < 0)
+		if (stat_sha1_file(the_repository, sha1, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
@@ -1388,7 +1389,7 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 		die("replacement %s not found for %s",
 		    sha1_to_hex(repl), sha1_to_hex(sha1));
 
-	if (!stat_sha1_file(repl, &st, &path))
+	if (!stat_sha1_file(the_repository, repl, &st, &path))
 		die("loose object %s (stored in %s) is corrupt",
 		    sha1_to_hex(repl), path);
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

