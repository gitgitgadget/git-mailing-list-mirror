Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C463C1F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 18:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755035AbcH0SqZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 14:46:25 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33484 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754938AbcH0SqO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 14:46:14 -0400
Received: by mail-it0-f65.google.com with SMTP id d65so2942092ith.0
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NXRwyekqCN4AtJZWeynGwwNKqOt+EI3MBVrHd31hHyg=;
        b=ZnQujFPmRliOJkvRmiUCY5QPXZbSf6c/QRSQBaHEq53cG88s4Qm58bPjJbSyU58EN3
         1FruWN4CSnRvA+Yil/NAFlr8nLmbT2NTmPtTvF6L5mbpZXlUwJDgAVqV4NROatwuVt0B
         sjWzz+SdKLH7F5UWrzCHXppyM+UJUnmIIwfj4vOFcCqD0B+9Xm1b3oDWBJSNpp/xXGmM
         seAUiBHmiZG7yJY2F8M6mza7/h7UbxkmrGpxrHudegmJqm45qSMnv3aOHDz3dPd9pA9S
         Zk9nHoufwDcrfjS39jvX2uVb7SGE/ebRo5r4m71CFQ15vSoSeVX7lKTq2p8cLcpF9AXg
         nurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NXRwyekqCN4AtJZWeynGwwNKqOt+EI3MBVrHd31hHyg=;
        b=llGPCjlC7o5BxSDn0sh+D7o6K78KAOIZYb4U3OuLeI+EHV+K93gAutvGdXIoMjerOg
         5lbmOeNFt8g8y4N1srgIBdp8MQ/u40eRJVxnti5T01wEFx00yi1jz3XXZPZYV8TtaMGc
         qJqhl51N44cnJKQPd4tgLK1VdXWkrXtFuXAWY6lgZ7U3lWpzwspeyu/wre6vlLZe7FVW
         d6oKilhptuX6PZTTggqeh3V89nADftHPMN5EKdKH14FjUyjvYseZ+3PThfUDSDCw9oMH
         ciBNH2WnNpJ1VmfsDJhoBO0DwA+mX6g2koLhJVtinWpzylvuC5gFI545B+h0naR4sE40
         /HTg==
X-Gm-Message-State: AE9vXwNyyRs11XV4MPx/KDRY3QmPvM8TDIXw0s8xNtCbzhD6IJwRouItxIzwAGB69JWhhg==
X-Received: by 10.36.23.142 with SMTP id 136mr5783157ith.73.1472323574074;
        Sat, 27 Aug 2016 11:46:14 -0700 (PDT)
Received: from christian-Latitude-E6330.starbucks.net (TOROON12-3096782379.sdsl.bell.ca. [184.149.38.43])
        by smtp.gmail.com with ESMTPSA id r123sm2350901ith.1.2016.08.27.11.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Aug 2016 11:46:13 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v13 13/14] apply: learn to use a different index file
Date:   Sat, 27 Aug 2016 20:45:46 +0200
Message-Id: <20160827184547.4365-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.770.g14ff7d2
In-Reply-To: <20160827184547.4365-1-chriscool@tuxfamily.org>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes we want to apply in a different index file.

Before the apply functionality was libified it was possible to
use the GIT_INDEX_FILE environment variable, for this purpose.

But now, as the apply functionality has been libified, it should
be possible to do that in a libified way.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 27 +++++++++++++++++++++------
 apply.h |  1 +
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/apply.c b/apply.c
index 276e4af..5cd037d 100644
--- a/apply.c
+++ b/apply.c
@@ -3993,12 +3993,21 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 	return err;
 }
 
+static int read_apply_cache(struct apply_state *state)
+{
+	if (state->index_file)
+		return read_cache_from(state->index_file);
+	else
+		return read_cache();
+}
+
 /* This function tries to read the sha1 from the current index */
-static int get_current_sha1(const char *path, unsigned char *sha1)
+static int get_current_sha1(struct apply_state *state, const char *path,
+			    unsigned char *sha1)
 {
 	int pos;
 
-	if (read_cache() < 0)
+	if (read_apply_cache(state) < 0)
 		return -1;
 	pos = cache_name_pos(path, strlen(path));
 	if (pos < 0)
@@ -4071,7 +4080,7 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 			; /* ok */
 		} else if (!patch->lines_added && !patch->lines_deleted) {
 			/* mode-only change: update the current */
-			if (get_current_sha1(patch->old_name, sha1))
+			if (get_current_sha1(state, patch->old_name, sha1))
 				return error("mode change for %s, which is not "
 					     "in current HEAD", name);
 		} else
@@ -4675,10 +4684,16 @@ static int apply_patch(struct apply_state *state,
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
-	if (state->update_index && state->newfd < 0)
-		state->newfd = hold_locked_index(state->lock_file, 1);
+	if (state->update_index && state->newfd < 0) {
+		if (state->index_file)
+			state->newfd = hold_lock_file_for_update(state->lock_file,
+								 state->index_file,
+								 LOCK_DIE_ON_ERROR);
+		else
+			state->newfd = hold_locked_index(state->lock_file, 1);
+	}
 
-	if (state->check_index && read_cache() < 0) {
+	if (state->check_index && read_apply_cache(state) < 0) {
 		error(_("unable to read index file"));
 		res = -128;
 		goto end;
diff --git a/apply.h b/apply.h
index e2b89e8..1ba4f8d 100644
--- a/apply.h
+++ b/apply.h
@@ -63,6 +63,7 @@ struct apply_state {
 	int unsafe_paths;
 
 	/* Other non boolean parameters */
+	const char *index_file;
 	enum apply_verbosity apply_verbosity;
 	const char *fake_ancestor;
 	const char *patch_input_file;
-- 
2.9.2.770.g14ff7d2

