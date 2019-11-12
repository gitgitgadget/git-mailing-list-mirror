Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4B4D1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 10:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfKLKir (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 05:38:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33575 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfKLKio (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 05:38:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id w9so11132588wrr.0
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 02:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sa73V0138qjREEXwSdy7csXIRfVeLgAaUYEFtqXcrVs=;
        b=ptWg1pVH/uyeZNCYgtjXvvB4cxAnVVvADw9ByKlJP4UooFYtljd8DmUqvUQsuxmGPm
         wJ+Zsbt9o0zgUiZiNaUBjc9PRyhOeJkIzZ6tT9TwJVkl670KL/Ni/rWHkwVHNW6CAAm/
         D7n5iFMw6fZKlmZRZsziPZqO3j+x+ncy2tYg4GU+zNPJ8gdpC3mGRJTVS6FXmF9RZWtP
         52UJPfEXXlGoSqjh5Az1jUj7dffJCmyEu6d5IyG2ukIzkEn2Qc6ujiDbeqVqPSSpf1SO
         7y/8CIZiD5k4PVmLLVZ6QDzYQmaDogQTmtbRdRsCwzeobMKJ/8uMG9pD+GzRxLU5Qmld
         qf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sa73V0138qjREEXwSdy7csXIRfVeLgAaUYEFtqXcrVs=;
        b=pma0pOGerGWhgGtQFq6192OcLtnyrpcOm+OeOv73sM4wg39bf9WFAoUKq+itSQbDTO
         1+TZaCzuMFl+6c/rk1zxBZ7bN9Q16eLqOKpU4uhul3uCwLIiNVSKwYjvwbsl6oBEp+2n
         dIOXK6Gt6NNO1OLUkqfYyO/jcGySYQyVBhS8Q00je8LdTrJYMVV/RU50gI/sxPp4bO5F
         2UvXh183ZrYKdg31vNS3YmMLa2AhpsdB5lLisRB8Q5BN5ZeNBb0TfYpl2bPKLRFyllq3
         B6LJBpqNUjXYO5uMInZ5RUWSb9LoJeW7yk/8VcBoOsO0RRNonKKcwpGGj11ax2BI+ahv
         kKHA==
X-Gm-Message-State: APjAAAUieYf/aIYev8JYXmxWAOMy+Vv1RoSQIvEzYKZg4A+q4GwzChWV
        suleE8ecFs0oEIRUQL+yy/I=
X-Google-Smtp-Source: APXvYqzNQYsUrCMxtbBfF4VTIX2mXPr7534Geb68BSdupC6UE+ul8e0qEbOspztuDQ1FYJulj22Y5g==
X-Received: by 2002:adf:ed48:: with SMTP id u8mr23561961wro.28.1573555122166;
        Tue, 12 Nov 2019 02:38:42 -0800 (PST)
Received: from localhost.localdomain (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id f24sm2313759wmb.37.2019.11.12.02.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Nov 2019 02:38:41 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 11/13] name-rev: drop name_rev()'s 'generation' and 'distance' parameters
Date:   Tue, 12 Nov 2019 11:38:19 +0100
Message-Id: <20191112103821.30265-12-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.388.gde53c094ea
In-Reply-To: <20191112103821.30265-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20191112103821.30265-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following the previous patches in this series we can get the values of
name_rev()'s 'generation' and 'distance' parameters from the 'stuct
rev_name' associated with the commit as well.

Let's simplify the function's signature and remove these two
unnecessary parameters.

Note that at this point we could do the same with the 'tip_name',
'taggerdate' and 'from_tag' parameters as well, but those parameters
will be necessary later, after the recursion is eliminated.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6416c49f67..fc61d6fa71 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -106,8 +106,9 @@ static struct rev_name *create_or_update_name(struct commit *commit,
 
 static void name_rev(struct commit *commit,
 		const char *tip_name, timestamp_t taggerdate,
-		int generation, int distance, int from_tag)
+		int from_tag)
 {
+	struct rev_name *name = get_commit_rev_name(commit);
 	struct commit_list *parents;
 	int parent_number = 1;
 
@@ -116,7 +117,7 @@ static void name_rev(struct commit *commit,
 			parents = parents->next, parent_number++) {
 		struct commit *parent = parents->item;
 		const char *new_name;
-		int new_generation, new_distance;
+		int generation, distance;
 
 		parse_commit(parent);
 		if (parent->date < cutoff)
@@ -126,25 +127,25 @@ static void name_rev(struct commit *commit,
 			size_t len;
 
 			strip_suffix(tip_name, "^0", &len);
-			if (generation > 0)
+			if (name->generation > 0)
 				new_name = xstrfmt("%.*s~%d^%d", (int)len, tip_name,
-						   generation, parent_number);
+						   name->generation,
+						   parent_number);
 			else
 				new_name = xstrfmt("%.*s^%d", (int)len, tip_name,
 						   parent_number);
-			new_generation = 0;
-			new_distance = distance + MERGE_TRAVERSAL_WEIGHT;
+			generation = 0;
+			distance = name->distance + MERGE_TRAVERSAL_WEIGHT;
 		} else {
 			new_name = tip_name;
-			new_generation = generation + 1;
-			new_distance = distance + 1;
+			generation = name->generation + 1;
+			distance = name->distance + 1;
 		}
 
 		if (create_or_update_name(parent, new_name, taggerdate,
-					  new_generation, new_distance,
+					  generation, distance,
 					  from_tag))
-			name_rev(parent, new_name, taggerdate,
-				 new_generation, new_distance, from_tag);
+			name_rev(parent, new_name, taggerdate, from_tag);
 	}
 }
 
@@ -288,7 +289,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 				tip_name = xstrdup(path);
 			if (create_or_update_name(commit, tip_name, taggerdate,
 						  0, 0, from_tag))
-				name_rev(commit, tip_name, taggerdate, 0, 0,
+				name_rev(commit, tip_name, taggerdate,
 					 from_tag);
 			else
 				free(to_free);
-- 
2.24.0.388.gde53c094ea

