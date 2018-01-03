Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3F01F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbeACQhZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:37:25 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36344 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeACQeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:25 -0500
Received: by mail-wm0-f67.google.com with SMTP id b76so3684460wmg.1
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1mPqFeFBoHEV/mI/l3LfXupZEPipaRl2APONM95BcVk=;
        b=AYlH2/5ek8aM4LsmqyHMj98eQrFutMQyDrjox5/j/rvAyZRJF2nWOGaFw9y0q/2mOf
         Ee6GnbhRA+Y1FejESnomVPqiaEOus4TNb8cp0OUKwnFqtUIUrY12DMPtSUdkoeuYRnPW
         XT3atCkk4a/Njnt1AzSotKk+Bm1tGqYx9v/54V/4mJQkPjxFdjcjFI+vROs7YI+DiaR0
         XnkTRphJODpd6hmiWTfPfnxcxbdy42uHbWhY3c9geIr3DlYUbxtzDO/qP6Yp8HIGJWlQ
         a+vLbtOnjFBSPWXPXpkVV6FDNpaZVwvXjoQQIFtIouZHAz9rfwkaUMsiucMQU8/pdgV1
         35Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1mPqFeFBoHEV/mI/l3LfXupZEPipaRl2APONM95BcVk=;
        b=gc1u1Br9rx8cjSvDTu+1B3LDp/kADHQoaSDSWWA9+XYc7qkjBgjbysmRiYDKTZJt5/
         eBVP+TY2bknjrbXEGTjpWEpRKf360bK3PwXuc6Y0Mq6CASQ5XhVAEZwaTjHzgmZaxbbC
         qzIBhlJ3RkJF2ActzjakSSWvVPkc/zl7Uw82WyWQWsbeiQ6taQV/81k17ncGOuEMVTac
         MnJuL2edTV45VnFHUnBxvaX27irQ76gMfW3e08/RvW+MDhQxgV2DCkVj31JEPdveCduG
         w54rTm5cMFI9ozxafS+b2Gvt3IqBVkPnuiLpxWujgI21nkEYU2e1VeSbqOmphezGdkLu
         R5QA==
X-Gm-Message-State: AKGB3mJnIPT9ubQD7YjZyq1HPJd7byLFIpYQdpVyFH7L7BoPveeORcLr
        MVJaq3Orxbh9i9C1qdy/wBpWrP4G
X-Google-Smtp-Source: ACJfBosSe6T+gHCOJ9vTThHCgfoh9wYMjut93kFw1jYcKdYHsC3f7U466gbS+gNHONDmQ0DeJCtHDQ==
X-Received: by 10.28.110.26 with SMTP id j26mr1786135wmc.46.1514997263167;
        Wed, 03 Jan 2018 08:34:23 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:22 -0800 (PST)
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
Subject: [PATCH 05/40] fsck: support refs pointing to promisor objects
Date:   Wed,  3 Jan 2018 17:33:28 +0100
Message-Id: <20180103163403.11303-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Teach fsck to not treat refs referring to missing promisor objects as an
error when extensions.partialclone is set.

For the purposes of warning about no default refs, such refs are still
treated as legitimate refs.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsck.c           |  8 ++++++++
 t/t0410-partial-clone.sh | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 793d289367..c6bb29d242 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -434,6 +434,14 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 
 	obj = parse_object(oid);
 	if (!obj) {
+		if (is_promisor_object(oid)) {
+			/*
+			 * Increment default_refs anyway, because this is a
+			 * valid ref.
+			 */
+			 default_refs++;
+			 return 0;
+		}
 		error("%s: invalid sha1 pointer %s", refname, oid_to_hex(oid));
 		errors_found |= ERROR_REACHABLE;
 		/* We'll continue with the rest despite the error.. */
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 9257b8c885..c4639e1134 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -13,6 +13,14 @@ pack_as_from_promisor () {
 	>repo/.git/objects/pack/pack-$HASH.promisor
 }
 
+promise_and_delete () {
+	HASH=$(git -C repo rev-parse "$1") &&
+	git -C repo tag -a -m message my_annotated_tag "$HASH" &&
+	git -C repo rev-parse my_annotated_tag | pack_as_from_promisor &&
+	git -C repo tag -d my_annotated_tag &&
+	delete_object repo "$HASH"
+}
+
 test_expect_success 'missing reflog object, but promised by a commit, passes fsck' '
 	test_create_repo repo &&
 	test_commit -C repo my_commit &&
@@ -78,4 +86,20 @@ test_expect_success 'missing reflog object alone fails fsck, even with extension
 	test_must_fail git -C repo fsck
 '
 
+test_expect_success 'missing ref object, but promised, passes fsck' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+
+	# Reference $A only from ref
+	git -C repo branch my_branch "$A" &&
+	promise_and_delete "$A" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config odb.magic.promisorRemote "arbitrary string" &&
+	git -C repo fsck
+'
+
 test_done
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

