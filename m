Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECFFD1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 19:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932643AbcLHTB5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 14:01:57 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:32976 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932340AbcLHS7s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:59:48 -0500
Received: by mail-pg0-f54.google.com with SMTP id 3so176788627pgd.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=feajjchO1vfEbxVPVO75ouG2MfKojb3xI4uZBCRCPgc=;
        b=ij5akh+C34Po6d0iBiRlFSfdpbARUlRLjt5S3hKItp+IVzUSSVg5C7J3gHG/aGVskB
         /IB+1Ybkzkgo87uNW1O6+UpG/k389s4lFM5px4aBHrz9W4Ulm1qR7z2AyvPFIZudTy2f
         8RV14hxQ5IuwDI7ZAJgOoohxYLVcOuzIUCuq76Cekiq4Bze/CiGu7Zx8fT9NLua1CltD
         9kE2WZpWZswrE0AhxQtfzdV7MpOCbCfwJy6bxnmGU7uPaUcB5GIhZGm8s0ion2oYzTV8
         HXjoCgFkMqON34TMav1b1jZ0QdkyJ6ZRKSKEn4ceR0r0UOTwgS0Y24HPICAWVof7lZFR
         iYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=feajjchO1vfEbxVPVO75ouG2MfKojb3xI4uZBCRCPgc=;
        b=U9lKy5sncc2LSTFhrK2JoqZaSF49H1GTAlI5sVK5TtuLuctP8j8OvKgarHD20GbkIl
         IjDdh5T3Jxv/5vR+yoa6pg/qsGhMOkyCZM0T33OChPLy4L193zdvfoaEfPoL+USnQjzW
         j1AOalbNwEKwOIkHO8ITsMmhtUlZZiOoDnIIwOYiJnbvF/UFVeRWpHbJ0IgYyujBRw1b
         a113u7EBBMKiDtUzv0A6lZGhdmZZKV8/DYAO70tgrD3HY8qV4mncM9eWoJ3rUa5Kydyp
         ecbMK40QfUWNBiy3gZRzo3vAD8bW1LszT8PI5CQjQzZWL/axoqAlyym0hL/9jeX/KVpm
         3Ubg==
X-Gm-Message-State: AKaTC01j/7W9V/DL5ia2xai8J0PoTYJpFSQJfLJdkKXw/DutS4DcwOnKbvbqZeSAITL8bv4S
X-Received: by 10.99.3.202 with SMTP id 193mr133436276pgd.157.1481223585711;
        Thu, 08 Dec 2016 10:59:45 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id p64sm51815634pfi.88.2016.12.08.10.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:59:44 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v2 15/16] pathspec: small readability changes
Date:   Thu,  8 Dec 2016 10:59:09 -0800
Message-Id: <1481223550-65277-16-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481223550-65277-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few small changes to improve readability.  This is done by grouping related
assignments, adding blank lines, ensuring lines are <80 characters, and
adding additional comments.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index cf88390..4686298 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -336,6 +336,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 	if ((magic & PATHSPEC_LITERAL) && (magic & PATHSPEC_GLOB))
 		die(_("%s: 'literal' and 'glob' are incompatible"), elt);
 
+	/* Create match string which will be used for pathspec matching */
 	if (pathspec_prefix >= 0) {
 		match = xstrdup(copyfrom);
 		prefixlen = pathspec_prefix;
@@ -343,11 +344,16 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 		match = xstrdup(copyfrom);
 		prefixlen = 0;
 	} else {
-		match = prefix_path_gently(prefix, prefixlen, &prefixlen, copyfrom);
+		match = prefix_path_gently(prefix, prefixlen,
+					   &prefixlen, copyfrom);
 		if (!match)
 			die(_("%s: '%s' is outside repository"), elt, copyfrom);
 	}
+
 	item->match = match;
+	item->len = strlen(item->match);
+	item->prefix = prefixlen;
+
 	/*
 	 * Prefix the pathspec (keep all magic) and assign to
 	 * original. Useful for passing to another command.
@@ -364,8 +370,6 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 	} else {
 		item->original = xstrdup(elt);
 	}
-	item->len = strlen(item->match);
-	item->prefix = prefixlen;
 
 	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP)
 	    strip_submodule_slash_cheap(item);
@@ -373,13 +377,14 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE)
 	    strip_submodule_slash_expensive(item);
 
-	if (magic & PATHSPEC_LITERAL)
+	if (magic & PATHSPEC_LITERAL) {
 		item->nowildcard_len = item->len;
-	else {
+	} else {
 		item->nowildcard_len = simple_length(item->match);
 		if (item->nowildcard_len < prefixlen)
 			item->nowildcard_len = prefixlen;
 	}
+
 	item->flags = 0;
 	if (magic & PATHSPEC_GLOB) {
 		/*
-- 
2.8.0.rc3.226.g39d4020

