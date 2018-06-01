Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 757161F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 21:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbeFAVKn (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 17:10:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34172 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeFAVKk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 17:10:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id q4-v6so7778704wmq.1
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=b4kqkIWu7jnlbGjduBQ1ykNY896p5Rm+wG/zMyO7kZE=;
        b=Ee5wIbdwCKjw1r/aFYf8osgMDNW6EOtpzz66rjFGFWA32FAGVY6DRAZHAObSnHb7pq
         2CmW3gR9+Rg0X7zEqQvPbzRBr21lNZ6fhk+SH+3bkEG+myb329P7XX9X5PUPsFTky8/+
         tDCm8oUpGluwCb1YbOYDCzZhrleuJXy8Ok4mI3uajhSiC00yL2ZZKeEhTNYOnUmbu0+q
         CVwehG3BUmH6rbFlAYQYgqa3IhVjLsuPEU7Au58XgfTOhNpFcjJKDawRabO0HKn++HXl
         +5lKbWGvS6AXg0v643DMt1+VFQfBxcNfeAlbFmd0Jwz2Qe63HzXybbaLnMB/5WD1UpUF
         /HZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b4kqkIWu7jnlbGjduBQ1ykNY896p5Rm+wG/zMyO7kZE=;
        b=Wbty0vd2knB7wgdRnmV5JhsrgfwElHj9gqXOPNQya4ps2uL98PqKSohCTlKfnypxKx
         nNgRE1Quf8DlqwjoI13kDH1HhOYs5WlWLCkL7LvffgDKx1K+HixWB+cdvZL4ZgSeg0By
         Zp7y0RLqc2g6OMCHi8MZaNt/HxcZX2ZTHGmdw+Nl7DdTRPt06NHtXiQpSe83HzTMuXTK
         yj5iLK3++WVM+e2qn+/OHOcavbWkiyIr6n1fZVMg0A2jnpiakYxd0ZCYfORalkpz3W3u
         051LdLqJE7fiU0efAKyUJVY6BD03X5xhme3eVGVfJmR5GcXkc/iSGCFflc5g4pmK8nK9
         sfdw==
X-Gm-Message-State: APt69E3OVof/6VafwIVQMZ0PxQv1tCHnAaT6t4o3oxyhKt4WQ6LAP8EY
        ZUs253olh8auX2VISsnoIfLTG218
X-Google-Smtp-Source: ADUXVKKtk+bNGCG4KxAmg6rULfDxM8iDzBmShpLqZFnOM9n/QcyvfrSrgWw1Ig9V2XdnKH8hndcUSQ==
X-Received: by 2002:a1c:91c4:: with SMTP id t187-v6mr3896986wmd.51.1527887438755;
        Fri, 01 Jun 2018 14:10:38 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k126-v6sm3516235wmd.45.2018.06.01.14.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 14:10:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 4/8] checkout.[ch]: change "unique" member to "num_matches"
Date:   Fri,  1 Jun 2018 21:10:11 +0000
Message-Id: <20180601211015.11919-5-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180601211015.11919-1-avarab@gmail.com>
References: <20180601211015.11919-1-avarab@gmail.com>
In-Reply-To: <20180531195252.29173-1-avarab@gmail.com>
References: <20180531195252.29173-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Internally track how many matches we find in the check_tracking_name()
callback. Nothing uses this now, but it will be made use of in a later
change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 checkout.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/checkout.c b/checkout.c
index 80e430cda8..7662a39a62 100644
--- a/checkout.c
+++ b/checkout.c
@@ -7,10 +7,10 @@ struct tracking_name_data {
 	/* const */ char *src_ref;
 	char *dst_ref;
 	struct object_id *dst_oid;
-	int unique;
+	int num_matches;
 };
 
-#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 1 }
+#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 0 }
 
 static int check_tracking_name(struct remote *remote, void *cb_data)
 {
@@ -23,9 +23,9 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 		free(query.dst);
 		return 0;
 	}
+	cb->num_matches++;
 	if (cb->dst_ref) {
 		free(query.dst);
-		cb->unique = 0;
 		return 0;
 	}
 	cb->dst_ref = query.dst;
@@ -39,7 +39,7 @@ const char *unique_tracking_name(const char *name, struct object_id *oid)
 	cb_data.dst_oid = oid;
 	for_each_remote(check_tracking_name, &cb_data);
 	free(cb_data.src_ref);
-	if (cb_data.unique)
+	if (cb_data.num_matches == 1)
 		return cb_data.dst_ref;
 	free(cb_data.dst_ref);
 	return NULL;
-- 
2.17.0.290.gded63e768a

