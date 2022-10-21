Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0F0C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiJUJWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiJUJV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:21:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8422565FA
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:21:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j7so3927700wrr.3
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnFrEQZq/tYFelV4w6tUcxxWcgExlvUcEYhQ0895DKQ=;
        b=oVy2IYp1Fx+RUnD9JgxiRsfB9Pv8hfdVf97TC00/T8GN7aYBpS4E6Lry7yPFjecsju
         sPSYs61pdrD+hfaNs6LYCsBDCt6qGpKqb3HVVHvv7eErw6vcChjvtSqRCWIUbAoTbbSM
         y5bTn3NmMiuXcnIpX02xDCKCm7Eek0vnoirK/8TvjilS1EDdfU9Mfjtr9Bmmyf6ZCJrA
         fmOvLxV18KkRNvoqoRPmzGH1uTPxD8S1lnZoQqNeNj+BMztL5YJ4pI6bxz7dfqG77Jv/
         OlvHLMqKj/rsmb1zkK3d64wSrw8GZ6BNwGNMtbneU7MpFwmCnwMSMw68IdVgsAOA+eJY
         gR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnFrEQZq/tYFelV4w6tUcxxWcgExlvUcEYhQ0895DKQ=;
        b=mo8vcvG92QNJuJzXP1Vme4Drhw+Dg/6lNjSL18qJsBQymhH/EKu40XpAvWQ5AhQmmO
         G89oA/q8uculyOCVopm+DU/08DOwbjzim3gCrWs6yLvfZ+cq650o7l647n29sfhdhpS8
         TnljA/+kqpuxUih3VbWS02HnCK0qMYS2b+xdso8EVJh6o+PLdNSHC2MPm7CZgrEjFEKt
         Uiodg34EeOALKWSeiBmfMgjiI6q49bej0F9LZh+bVPBw/RV1zwO0G6XVLFiQu7A+gMIN
         EBdTilkNIYLtT2mWDakhrabigQDntYstZkjTGtcOROHicUYikni4o2ZUOlUJkAmzByGo
         nfDQ==
X-Gm-Message-State: ACrzQf0HcyHogs0SUGWBWB7MyaRUVUBZTf25JM9r8xyjMgob8/N8IiWE
        TlmsYYUXMluTgPv13BhydN34q3Nq15w=
X-Google-Smtp-Source: AMsMyM6/PIdx0Ny1edLpc0zFX/7cziPhsg/nfi0xvuS9E0VCYfNkxPTRBfkIeSDWXdHfgmHOhOKa5g==
X-Received: by 2002:a05:6000:1565:b0:22f:1407:9bfd with SMTP id 5-20020a056000156500b0022f14079bfdmr11389778wrz.620.1666344112612;
        Fri, 21 Oct 2022 02:21:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b003b5054c6f87sm2157110wmq.21.2022.10.21.02.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:21:51 -0700 (PDT)
Message-Id: <12701ef7c7cd5a2cde57670db2afa071a5e5622f.1666344108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
References: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
        <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 09:21:42 +0000
Subject: [PATCH v4 2/8] rebase --apply: improve fast-forward reflog message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Using move_to_original_branch() when reattaching HEAD after a
fast-forward improves HEAD's reflog message when rebasing a branch. This
is because it uses separate reflog messages for "HEAD" and
"branch". HEAD's reflog will now record which branch we're returning to.

When rebasing a detached HEAD there is no change in behavior. We
currently call reset_head() when head_name is NULL but
move_to_original_branch() does not. However the existing call does not
add a message to the reflog because we're not changing the commit that
HEAD points to and so lock_ref_for_update() skips the update.

Note that the removal of "strbuf_reset(&msg)" is safe as there is a call
to strbuf_release(&msf) just above this hunk which can be seen by
viewing the diff with -U6.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          | 11 +----------
 t/t3406-rebase-message.sh |  8 +-------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index ef520f66fb8..e67020b3586 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1811,19 +1811,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * If the onto is a proper descendant of the tip of the branch, then
 	 * we just fast-forwarded.
 	 */
-	strbuf_reset(&msg);
 	if (oideq(&branch_base, &options.orig_head->object.oid)) {
 		printf(_("Fast-forwarded %s to %s.\n"),
 			branch_name, options.onto_name);
-		strbuf_addf(&msg, "rebase finished: %s onto %s",
-			options.head_name ? options.head_name : "detached HEAD",
-			oid_to_hex(&options.onto->object.oid));
-		memset(&ropts, 0, sizeof(ropts));
-		ropts.branch = options.head_name;
-		ropts.flags = RESET_HEAD_REFS_ONLY;
-		ropts.head_msg = msg.buf;
-		reset_head(the_repository, &ropts);
-		strbuf_release(&msg);
+		move_to_original_branch(&options);
 		ret = finish_rebase(&options);
 		goto cleanup;
 	}
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 413d6132ea2..5253dd1551d 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -143,14 +143,8 @@ test_reflog () {
 	) &&
 
 	git log -g --format=%gs -2 >actual &&
-	if test "$mode" = "--apply"
-	then
-		finish_msg="refs/heads/fast-forward onto $(git rev-parse main)"
-	else
-		finish_msg="returning to refs/heads/fast-forward"
-	fi &&
 	write_reflog_expect <<-EOF &&
-	${reflog_action:-rebase} (finish): $finish_msg
+	${reflog_action:-rebase} (finish): returning to refs/heads/fast-forward
 	${reflog_action:-rebase} (start): checkout main
 	EOF
 	test_cmp expect actual &&
-- 
gitgitgadget

