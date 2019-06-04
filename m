Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C236B1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 02:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfFDCNh (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 22:13:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45339 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfFDCNg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 22:13:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id t24so4334690otl.12
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 19:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UFBefJvUzI90CP/0uzCa8e6rEEfs8QVpQrzPCOWnhx8=;
        b=ExRe2twLdXmelIAKAK9iufDDhNC9BdVHLbNFsAmv0bMZ9zh/PF42IDN4JtAShaoI2J
         XQ3kJmO/de8l67Wj9TM8AqK0AuOZ2/hneKTz45ybA50GRLzlQeggux9dWM4N3TP1ACq8
         rLuKILLEgBQQ0NJe21HFbiB6Hs0NE9KVqtaneaKv6VXzAm3QMhhe/pgPFjIu8+BjadKk
         BKohtpFmd8Yd34NNORKQN6v+BB9hkQmI35U9sY3rDiv1zqj6OUsM9u/y5l4t+k6FRALB
         UAPzjeLtOgN6CxkwVgkPZFzinRec+YXfmV9dilNM2b0zrdfy6k4QJ7taqxibUrogOMoz
         /Hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UFBefJvUzI90CP/0uzCa8e6rEEfs8QVpQrzPCOWnhx8=;
        b=UpiVXV51rJ0Yae6v0eNumEOmpF0cNyicqMY8Vc4/iqFuhkrEfn99YvtkgWYcNenpxM
         xQ2Ax78NHGRJnU2eXITEuF9v4S0uqEdu6TxQSpZEdwUFx9sumamfpN9INpsxsPE6zGus
         fR3IFIUETDYswRxq8BNLp6h1j1UlyGZeWe01NjneI28vSfnQ0arix04S114BSJkG/nFj
         MU4QJbZby+b+9w2kpI2idnlrTs6g/Wo5B2/GM50AFeeesgJlXLi6YH5Vo4WTmGzrtcmT
         Hdrn+fdrwFur+ObrtC0LXTg0/di8WO24LWgWvlLrIHEVIP9PqoR5Lo8/F0QLFV3/E83S
         ECGQ==
X-Gm-Message-State: APjAAAXI627zkCG4z+sjBpDXx/JbyuZA258Ye7fksGHflcEJYUuG2+GX
        AjtIFt9Ri0a+uWP/fpTNGrUq0ZgD8qI=
X-Google-Smtp-Source: APXvYqygJ8Uc3sm7UDmIEl/CJPtgmvgK3Vgjf7M+qhoJKNuT8Jks9FovpAt5lPj1mmWt9E/gf9yxGQ==
X-Received: by 2002:a05:6830:2041:: with SMTP id f1mr2106589otp.167.1559614415711;
        Mon, 03 Jun 2019 19:13:35 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id n10sm3183282otq.63.2019.06.03.19.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 19:13:35 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 3/5] fetch: trivial cleanup
Date:   Mon,  3 Jun 2019 21:13:28 -0500
Message-Id: <20190604021330.16130-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604021330.16130-1-felipe.contreras@gmail.com>
References: <20190604021330.16130-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a helper function to clear an item. The way items are cleared has
changed, and will change again soon.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fetch.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4ba63d5ac6..8af5e319f1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -287,6 +287,11 @@ static int refname_hash_exists(struct hashmap *map, const char *refname)
 	return !!hashmap_get_from_hash(map, strhash(refname), refname);
 }
 
+static void clear_item(struct refname_hash_entry *item)
+{
+	oidclr(&item->oid);
+}
+
 static void find_non_local_tags(const struct ref *refs,
 				struct ref **head,
 				struct ref ***tail)
@@ -319,7 +324,7 @@ static void find_non_local_tags(const struct ref *refs,
 			    !will_fetch(head, ref->old_oid.hash) &&
 			    !has_object_file_with_flags(&item->oid, OBJECT_INFO_QUICK) &&
 			    !will_fetch(head, item->oid.hash))
-				oidclr(&item->oid);
+				clear_item(item);
 			item = NULL;
 			continue;
 		}
@@ -333,7 +338,7 @@ static void find_non_local_tags(const struct ref *refs,
 		if (item &&
 		    !has_object_file_with_flags(&item->oid, OBJECT_INFO_QUICK) &&
 		    !will_fetch(head, item->oid.hash))
-			oidclr(&item->oid);
+			clear_item(item);
 
 		item = NULL;
 
@@ -354,7 +359,7 @@ static void find_non_local_tags(const struct ref *refs,
 	if (item &&
 	    !has_object_file_with_flags(&item->oid, OBJECT_INFO_QUICK) &&
 	    !will_fetch(head, item->oid.hash))
-		oidclr(&item->oid);
+		clear_item(item);
 
 	/*
 	 * For all the tags in the remote_refs_list,
-- 
2.21.0

