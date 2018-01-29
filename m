Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FA551F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbeA2Wh7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:37:59 -0500
Received: from mail-vk0-f73.google.com ([209.85.213.73]:43068 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbeA2Whx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:37:53 -0500
Received: by mail-vk0-f73.google.com with SMTP id u71so5828606vkb.10
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=AiSQPLju8zlEYZEW6mmyKiN9sLvHOKFEjdb1qq4O/g0=;
        b=kqgMekZdDI/4Hn6rdS8c8/12Nk53JRG4T+9UPSANaFV6lrshyww9TmwsQMwY5GXX1a
         omy7N6DLeBimLmtNQhaPG3l7oPy7qZkDYlVI8GtEk4xYYzumOs8aLSzL7GxHV4N10NGA
         VHlEk6xP2LgN5w/1SuPBI56bUVnP2xRFTeGMU5D5vaRrcDeQTli3ypexDC4Q2pGFA0my
         orjF4ZZkrPBCgBSSYh2ttdSh5csNBLvbVVFzXrZJrcCvwnuUHxrbHmMqv7Sop4g4j8uG
         4valIPop9DEaBDJK7dA08/HVrz6fpWfQeGJoli5OaV8sFeJGW6FSOMt4dPgZcJ4OYbYi
         EDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=AiSQPLju8zlEYZEW6mmyKiN9sLvHOKFEjdb1qq4O/g0=;
        b=YMf1Uw/9IcN19aPQqxZm3VI2tOs5aoJg5NEsQ/mtyrXjMh3Axj7Jq/Inu6+5zCqWFN
         7JJLWfF4ryr+/TPL4OZzGcMAIafj9NqcKbHyAiwLc0PAbpw11TiTSIuIHuqii80Qlhcv
         uGnRlVmZ3pJruX0U0QQ3uthqDxXcxGFE+bnVeMW7w3RMQLxjToQyb4gJ+XHck6S8pf/J
         uMrqoHhGNPXC4XYReBhTHCADREGc8WwiILEY9boxSrgy0ziMHGWVUWW9rcV4UTGSxLbI
         fDNJpJkNJsItvkfsnBuU+i2nmcjHAgdabqLaaLPHPsxRE0AWVYW0QDPwXbRE6zsLlOYX
         fsyA==
X-Gm-Message-State: AKwxytfKrbBCnXgt71GL4nFs7GHXsSiXdhXIahnor/z6VT7tb8I6aRis
        UOMLv2TkdDfNNix4zzO5D0/FxI2FKly3yTNfaGkPU2yfkQRaFmcLqStKhxcHrmxiIb0C4G0r5ng
        n3sc5mDoT8PgIV4pe49XRkIsAnf8iUIkmR1Q6tkfCBzMa8ZizxQNE1fVgpQ==
X-Google-Smtp-Source: AH8x224pCVmOTP0cuXx2TJTwLAq+nU8qUsucD6Wjyqsl/+4N+9HHz3Kqv8xiD0s+JAuMqz8DctCPTtScJvw=
MIME-Version: 1.0
X-Received: by 10.176.27.70 with SMTP id n6mr12318651uai.15.1517265473056;
 Mon, 29 Jan 2018 14:37:53 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:36:56 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-6-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 05/37] rev-parse: rename 'this' variable
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/rev-parse.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 74aa644cb..171c7a2b4 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -243,28 +243,28 @@ static int show_file(const char *arg, int output_prefix)
 static int try_difference(const char *arg)
 {
 	char *dotdot;
-	struct object_id oid;
-	struct object_id end;
-	const char *next;
-	const char *this;
+	struct object_id start_oid;
+	struct object_id end_oid;
+	const char *end;
+	const char *start;
 	int symmetric;
 	static const char head_by_default[] = "HEAD";
 
 	if (!(dotdot = strstr(arg, "..")))
 		return 0;
-	next = dotdot + 2;
-	this = arg;
-	symmetric = (*next == '.');
+	end = dotdot + 2;
+	start = arg;
+	symmetric = (*end == '.');
 
 	*dotdot = 0;
-	next += symmetric;
+	end += symmetric;
 
-	if (!*next)
-		next = head_by_default;
+	if (!*end)
+		end = head_by_default;
 	if (dotdot == arg)
-		this = head_by_default;
+		start = head_by_default;
 
-	if (this == head_by_default && next == head_by_default &&
+	if (start == head_by_default && end == head_by_default &&
 	    !symmetric) {
 		/*
 		 * Just ".."?  That is not a range but the
@@ -274,14 +274,14 @@ static int try_difference(const char *arg)
 		return 0;
 	}
 
-	if (!get_oid_committish(this, &oid) && !get_oid_committish(next, &end)) {
-		show_rev(NORMAL, &end, next);
-		show_rev(symmetric ? NORMAL : REVERSED, &oid, this);
+	if (!get_oid_committish(start, &start_oid) && !get_oid_committish(end, &end_oid)) {
+		show_rev(NORMAL, &end_oid, end);
+		show_rev(symmetric ? NORMAL : REVERSED, &start_oid, start);
 		if (symmetric) {
 			struct commit_list *exclude;
 			struct commit *a, *b;
-			a = lookup_commit_reference(&oid);
-			b = lookup_commit_reference(&end);
+			a = lookup_commit_reference(&start_oid);
+			b = lookup_commit_reference(&end_oid);
 			exclude = get_merge_bases(a, b);
 			while (exclude) {
 				struct commit *commit = pop_commit(&exclude);
-- 
2.16.0.rc1.238.g530d649a79-goog

