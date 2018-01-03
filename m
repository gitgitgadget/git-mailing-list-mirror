Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D8FA1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750979AbeACQhM (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:37:12 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46548 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeACQe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:26 -0500
Received: by mail-wr0-f195.google.com with SMTP id g17so2138416wrd.13
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9ykOISnbjk5cj9WJZ+oGtk2kn57WQ/17WtGojnMbtj8=;
        b=sEx2pPP4Lrgqy6TyLLfOMXjILlWKdc7TGg5ewTwUuq1uHCh7bHNcmxSHGK4NOI76jZ
         cRG9GvEe4CaG3xBSLXDHEUThqpt/vuySEpSNnOCDip20ywmXtCXviijnVP60cldzQe7f
         pX5ymCzQw5d4Fs/IXEaO2vu+1y9IsclQZTNlZDCRADKxkmQgoFT/DctDL/6hzRKzVrR9
         71eiFeyQVvXZWJJyY38QKM6WxytlC2dV3+Y65uoqrJESneHASUD41whSkz8zFP8LH+To
         GNzoern4AbthgUpCMs5QAl8oW+/y+L01f0l/wFzvx3Kxqx/7rYjI2mkLA4a1724HAWmt
         C9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9ykOISnbjk5cj9WJZ+oGtk2kn57WQ/17WtGojnMbtj8=;
        b=rIp4pxre54iRQsMutLjqep5UyVa03XBI2ev8ea2bBglY1+oqfQy9f/+hZmmUiDKNyd
         ObiMAF/uycXO7BaVUHrpNCVEZYFFA+6LCWPjgAMUmFgeGEeM3DD0USj25K1oYay3FU1t
         0lJ2ydldRiV/jVLiivxs/Sy6FWNjTYx4KxgFwBTMp0q+DuBIW0YCbxWKSUUs+KnKPZ8R
         B/zDtKU192WWIfhwDH1kr7jZSyN6cFVDZya/iB1Cyv7m90BwnnP3tWNm26mjGxuLpjiE
         SDx/nLgbJxGOvPRAfvBpOxQZhFnm1qqFPjcII+k8sTYDLx6dgm3Y1TEYLVNdaolSf7+R
         Lcmw==
X-Gm-Message-State: AKGB3mIIjjcfsn+IKPF0yC8iWa5GpfSGVs/GPuQXjWGyIuZCtWjixevo
        TOrrYBBiZtgKib8GBL1a7tM26jFM
X-Google-Smtp-Source: ACJfBovvch9kKg/MHYi0F34I9xufh0qhTwSfU7ffhtuvi0YH8OtlftAhoT6nYw6JCuQ1WEDJhC9DFg==
X-Received: by 10.223.143.12 with SMTP id p12mr1870026wrb.99.1514997264614;
        Wed, 03 Jan 2018 08:34:24 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:24 -0800 (PST)
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
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 06/40] fsck: support referenced promisor objects
Date:   Wed,  3 Jan 2018 17:33:29 +0100
Message-Id: <20180103163403.11303-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Teach fsck to not treat missing promisor objects indirectly pointed to
by refs as an error when extensions.partialclone is set.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsck.c           | 11 +++++++++++
 t/t0410-partial-clone.sh | 23 +++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index c6bb29d242..b8bcb0e40c 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -149,6 +149,15 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 	if (obj->flags & REACHABLE)
 		return 0;
 	obj->flags |= REACHABLE;
+
+	if (is_promisor_object(&obj->oid))
+		/*
+		 * Further recursion does not need to be performed on this
+		 * object since it is a promisor object (so it does not need to
+		 * be added to "pending").
+		 */
+		return 0;
+
 	if (!(obj->flags & HAS_OBJ)) {
 		if (parent && !has_object_file(&obj->oid)) {
 			printf("broken link from %7s %s\n",
@@ -208,6 +217,8 @@ static void check_reachable_object(struct object *obj)
 	 * do a full fsck
 	 */
 	if (!(obj->flags & HAS_OBJ)) {
+		if (is_promisor_object(&obj->oid))
+			return;
 		if (has_sha1_pack(obj->oid.hash))
 			return; /* it is in pack - forget about it */
 		printf("missing %s %s\n", printable_type(obj),
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index c4639e1134..46c88e8dfa 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -102,4 +102,27 @@ test_expect_success 'missing ref object, but promised, passes fsck' '
 	git -C repo fsck
 '
 
+test_expect_success 'missing object, but promised, passes fsck' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo 1 &&
+	test_commit -C repo 2 &&
+	test_commit -C repo 3 &&
+	git -C repo tag -a annotated_tag -m "annotated tag" &&
+
+	C=$(git -C repo rev-parse 1) &&
+	T=$(git -C repo rev-parse 2^{tree}) &&
+	B=$(git hash-object repo/3.t) &&
+	AT=$(git -C repo rev-parse annotated_tag) &&
+
+	promise_and_delete "$C" &&
+	promise_and_delete "$T" &&
+	promise_and_delete "$B" &&
+	promise_and_delete "$AT" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
+	git -C repo fsck
+'
+
 test_done
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

