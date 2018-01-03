Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51B301F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeACQgn (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:36:43 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:42666 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbeACQe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:27 -0500
Received: by mail-wm0-f66.google.com with SMTP id b141so3671405wme.1
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LYp2bAow2442hTMuQsiErMtlz/HOu9iWaqhS/t3wF3I=;
        b=VORdVo3YpERMibOnacni1tF6BaUrwK4NX2jgWOVfYAh4e0HN9QORpQHYgNgmV46tTk
         R+ClBHNiWWWRclamIRgWeIv4mDb1IjiXeQzlwK0A8E0GeGKPZ1a1eJg7OQrNR1ho/vh0
         pqd9G0pT3L6Cq5D0X/AdMfBrYUmopnqiT8QA8jxQfMvX3x1RS5Bwcp5Qt1U2AWps+nMu
         AJ89ZJD+WFs1tskca4PpHoOIenGomcrD6wz0BGJrF2V5DAO1mvWkihJOTyyUIrBRmGUg
         /Q4Owl1UEP6f9S6e99NXhWJX27c66bxtBXADOKNVB02MLFO5yre1RTn686oOxMfjwXyH
         E0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LYp2bAow2442hTMuQsiErMtlz/HOu9iWaqhS/t3wF3I=;
        b=l+lvZPK/3UX4FkbuqMx4xVgKTOvG7chRSye1IM8phQA2p+SZ84WsQXsRwW+Xz6fvqv
         XHefQ7R18vCF1qIu4pIIFnQPJbUxvy5LWPOA4bP3H1p6lTfzOHYBj5DFwfVvV3odf/Ve
         n/4/IscVURbQYao9gOAHvhN7OrHEYQGXDvh6fGbvIq4SrhrNqbpB2fX4DsODMC9Nexyc
         VwHakyQEoNZCC90eM2H0ejeYQF8haqoDQxMGX0dkFjiTVPnnjgiQGUnrOGui3IVu/FOp
         KVMqJje63D76h39UhgcPlI7rXA/MmDtkah37fwR42K867Zrk2s8tGy3rdgDuCfc7Jqy/
         WViQ==
X-Gm-Message-State: AKGB3mI2Fm2bH+1e6IS8GXPffWJS1PGW7zbBLEOZ/h0as/qtXH6Sms5J
        PJGiqVKdP7QxRTip/XnFnwICJ1HJ
X-Google-Smtp-Source: ACJfBou0kfipjqRrxAjQkwGxA2TEKs+jJHn6qrKmzfGdyCXMolAK97raRMunzdpMJL9Z6Z14IzaIbQ==
X-Received: by 10.28.45.193 with SMTP id t184mr1961131wmt.140.1514997266172;
        Wed, 03 Jan 2018 08:34:26 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:25 -0800 (PST)
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
Subject: [PATCH 07/40] fsck: support promisor objects as CLI argument
Date:   Wed,  3 Jan 2018 17:33:30 +0100
Message-Id: <20180103163403.11303-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Teach fsck to not treat missing promisor objects provided on the CLI as
an error when extensions.partialclone is set.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsck.c           |  2 ++
 t/t0410-partial-clone.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index b8bcb0e40c..a6fa6d6482 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -750,6 +750,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			struct object *obj = lookup_object(oid.hash);
 
 			if (!obj || !(obj->flags & HAS_OBJ)) {
+				if (is_promisor_object(&oid))
+					continue;
 				error("%s: object missing", oid_to_hex(&oid));
 				errors_found |= ERROR_OBJECT;
 				continue;
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 46c88e8dfa..a0f901fa1d 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -125,4 +125,17 @@ test_expect_success 'missing object, but promised, passes fsck' '
 	git -C repo fsck
 '
 
+test_expect_success 'missing CLI object, but promised, passes fsck' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+	promise_and_delete "$A" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
+	git -C repo fsck "$A"
+'
+
 test_done
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

