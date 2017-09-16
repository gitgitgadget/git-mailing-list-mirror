Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C548720A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbdIPIJE (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:09:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33678 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbdIPIIf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id 187so4515323wmn.0
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZXFPBLRUC3VPBrSafw6AKvTlb3V0CTZEgLukxQEKQ2U=;
        b=gLVaqqiUNsciiRUasXg5IAG0iNeYPHiCLtyw8xDSKvNviM0rdr34O9IrCVOsVIbBcd
         bx+6gPrI01EcEaNiic/kcIcTeEEn5PZbdiXeikSZdRtIQDtpzQgGfLdcvselSCyZM6fy
         cCul8sNbGtvBiF3YAMHRpuIdml79r1jjoEzpCpVnnH2k0EFXWbnsMjtQYD/STBt6PD4C
         QECVfQKm9K7xauzuHGZY5uxfIFoxE7ZkipftqE9IpIlev2jebVGU/WTaWiT/FOl2Fxob
         rXMGzwTp/f3OC7FPic1GAHO48zsrcC2y26hQg8+Yq6pTqQMoLGkdW57k0QjfsUAmHb/G
         oXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZXFPBLRUC3VPBrSafw6AKvTlb3V0CTZEgLukxQEKQ2U=;
        b=G4TBxzy0WP5Z50L6S2Wl4wGVkjFisviMersN8y/p0vFvibm3RzZUxWPJfyuGGknbAB
         RSKXI5MJ9OwSkr73+YArOdN4RKX4U1W5pAlfcS+oEPqxxzHT5Nt4rzfRN9IIv/AjmgwI
         olURxRMDFdrLTLi0crEahK3WY70OT4U8pv66R9NiPJt+d26loWOh8ZXglztc8BYH9F54
         LZSI4jfTPEb/kLC9k2NJHkeqNTJlUWpqwkO3sssP9Adlrs9OUSMe++TecQUhUtMGVOS2
         8oL7koKrGJMV6xZo+ed5iwq8roxmXLd0yO+jz7rHwhc3CJZCKTwMirv6+f0D7RYtnfdt
         Lf4g==
X-Gm-Message-State: AHPjjUiK1LPYvGrYrENFbYB9Ce/RwfdtYCwz4JH0xzfdEM1hZiPCyP/b
        bS63gu5HJIZvaO1M
X-Google-Smtp-Source: AOwi7QBFzOdfSdA2mJIXl0zeeOM6S0tcIQJ8AHRqsnGyqvkNzYwkUGpU8+HN0qgTXP9QNClAff83DQ==
X-Received: by 10.28.174.80 with SMTP id x77mr4825006wme.83.1505549313498;
        Sat, 16 Sep 2017 01:08:33 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:32 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 35/40] clone: add 'initial' param to write_remote_refs()
Date:   Sat, 16 Sep 2017 10:07:26 +0200
Message-Id: <20170916080731.13925-36-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to make it possible to separate fetching remote refs into
an initial part and a later part. To prepare for that, let's add
an 'initial' boolean parameter to write_remote_refs() to tell this
function if we are performing the initial part or not.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clone.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index dcd5b878f1..2e5d60521d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -574,7 +574,7 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 	return local_refs;
 }
 
-static void write_remote_refs(const struct ref *local_refs)
+static void write_remote_refs(const struct ref *local_refs, int initial)
 {
 	const struct ref *r;
 
@@ -593,8 +593,13 @@ static void write_remote_refs(const struct ref *local_refs)
 			die("%s", err.buf);
 	}
 
-	if (initial_ref_transaction_commit(t, &err))
-		die("%s", err.buf);
+	if (initial) {
+		if (initial_ref_transaction_commit(t, &err))
+			die("%s", err.buf);
+	} else {
+		if (ref_transaction_commit(t, &err))
+			die("%s", err.buf);
+	}
 
 	strbuf_release(&err);
 	ref_transaction_free(t);
@@ -641,7 +646,8 @@ static void update_remote_refs(const struct ref *refs,
 			       const char *branch_top,
 			       const char *msg,
 			       struct transport *transport,
-			       int check_connectivity)
+			       int check_connectivity,
+			       int initial)
 {
 	const struct ref *rm = mapped_refs;
 
@@ -656,7 +662,7 @@ static void update_remote_refs(const struct ref *refs,
 	}
 
 	if (refs) {
-		write_remote_refs(mapped_refs);
+		write_remote_refs(mapped_refs, initial);
 		if (option_single_branch && !option_no_tags)
 			write_followtags(refs, msg);
 	}
@@ -1168,7 +1174,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport_fetch_refs(transport, mapped_refs);
 
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
-			   branch_top.buf, reflog_msg.buf, transport, !is_local);
+			   branch_top.buf, reflog_msg.buf, transport,
+			   !is_local, 0);
 
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
-- 
2.14.1.576.g3f707d88cd

