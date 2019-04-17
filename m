Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B86C20248
	for <e@80x24.org>; Wed, 17 Apr 2019 18:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbfDQSBe (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 14:01:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39859 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731968AbfDQSBd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 14:01:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3so12356237pga.6
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 11:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=25BB9G9B49LVIFNoKqRFbyVLgzCBukpzISPRjgi3sOk=;
        b=qo57R9PBz0TmLB85IV4xkSAn47yOn8FJzM2Z/1YCT1OT8fzB/jiVsyMcWv4T4fcDmo
         OGwGCJRM5+kde+AS1pQA+chPPxONrhmZGLzrPTwqfxvmizDb9MpRl2hqPFyYOVDU8muw
         0K3ZPRq54QD4r5fI0NTCflN/+8oiTFjQ7ezjg5GPwDM2pXjHczrNACf8za7YDHcDKj1t
         MPxsAeqHRLdJkVgvMIcqfQGtzsdEXV+GPAVnbV6nF6YivKR+tal5f9xzgvFr8tLzED9R
         W43LqyqbPfGvdtOKg8M0BgZwxZhOoZ4/tPVDVIojcUUepRG0+S8AWSyyLNd89FtHhrZP
         Y1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=25BB9G9B49LVIFNoKqRFbyVLgzCBukpzISPRjgi3sOk=;
        b=AhaDZrUxnPrwSA9EdxigNJaJWoah50mo2p5Ve+lOCWSyvzmCKtr0ihlSeDfqIanR5Y
         PjFwNZnyzO8cRLQzWVCMlm3/jN2T/qIkedeO8ELTdXEL8E3Lb0HIN+wS/n+89H9RxKOR
         yTj9P7lUCczLzB3P9ukhT2qV4GFjzfQ2OT4kM18MgLtKcYSBINwoiOFLTjMQNxr9OI6Z
         SF/1/4glSD2V6FrUd4ICzwejC3jrqHGxKZy5Dz4opDOye0/HBbAdhe/wbAeG47XN8xY+
         /HrTZaNTfuHOvlcsaJd8ysFjSINKkxjZQZ48HUrVCxtBbvbt/laK6SjOsp+b2tf+IXB/
         T5Ow==
X-Gm-Message-State: APjAAAVFTy+e8s2GjP/djzhxiY1czalGC87BJtcChO9EyGwfDCNwG8MG
        SBnEmdj1ibPKs5sFW0GOD+6MSKFvek0=
X-Google-Smtp-Source: APXvYqxvzUGOT1IIHiihRWohUMKG4O5X0U2/XfBFKxTuQB2Hj2I5PmwlfXlEbfe08Jpr0Z8ihsU5rQ==
X-Received: by 2002:aa7:9888:: with SMTP id r8mr37072918pfl.116.1555524092514;
        Wed, 17 Apr 2019 11:01:32 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id n26sm162551438pfi.165.2019.04.17.11.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:01:31 -0700 (PDT)
Date:   Wed, 17 Apr 2019 11:01:31 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v6 5/6] rebase: fast-forward --fork-point in more cases
Message-ID: <0a466e830f7704f3ae75691db535946a3d57ddc9.1555523176.git.liu.denton@gmail.com>
References: <cover.1554500051.git.liu.denton@gmail.com>
 <cover.1555523176.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1555523176.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, when we rebased with a --fork-point invocation where the
fork-point wasn't empty, we would be setting options.restrict_revision.
The fast-forward logic would automatically declare that the rebase was
not fast-forwardable if it was set. However, this was painting with a
very broad brush.

Refine the logic so that we can fast-forward in the case where the
restricted revision is equal to the merge base, since we stop rebasing
at the merge base anyway.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c               | 10 +++++++---
 t/t3432-rebase-fast-forward.sh | 12 ++++++------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index f5aca1eee0..2e29ea652f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -896,6 +896,7 @@ static int is_linear_history(struct commit *from, struct commit *to)
 }
 
 static int can_fast_forward(struct commit *onto, struct commit *upstream,
+			    struct commit *restrict_revision,
 			    struct object_id *head_oid, struct object_id *merge_base)
 {
 	struct commit *head = lookup_commit(the_repository, head_oid);
@@ -915,6 +916,9 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
 	if (!oideq(merge_base, &onto->object.oid))
 		goto done;
 
+	if (restrict_revision && !oideq(&restrict_revision->object.oid, merge_base))
+		goto done;
+
 	if (!upstream)
 		goto done;
 
@@ -1702,9 +1706,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * Check if we are already based on onto with linear history,
 	 * but this should be done if this is not an interactive rebase.
 	 */
-	if (can_fast_forward(options.onto, options.upstream, &options.orig_head,
-		    &merge_base) &&
-	    !is_interactive(&options) && !options.restrict_revision) {
+	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
+		    &options.orig_head, &merge_base) &&
+	    !is_interactive(&options)) {
 		int flag;
 
 		if (!(options.flags & REBASE_FORCE)) {
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index d0e5b1f3e6..1cb2896fb4 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -35,8 +35,8 @@ test_rebase_same_head success --onto B... B
 test_rebase_same_head success --onto master... master
 test_rebase_same_head success --no-fork-point
 test_rebase_same_head success --fork-point master
-test_rebase_same_head failure --fork-point --onto B B
-test_rebase_same_head failure --fork-point --onto B... B
+test_rebase_same_head success --fork-point --onto B B
+test_rebase_same_head success --fork-point --onto B... B
 test_rebase_same_head success --fork-point --onto master... master
 
 test_expect_success 'add work to side' '
@@ -51,8 +51,8 @@ test_rebase_same_head success --onto B... B
 test_rebase_same_head success --onto master... master
 test_rebase_same_head success --no-fork-point
 test_rebase_same_head success --fork-point master
-test_rebase_same_head failure --fork-point --onto B B
-test_rebase_same_head failure --fork-point --onto B... B
+test_rebase_same_head success --fork-point --onto B B
+test_rebase_same_head success --fork-point --onto B... B
 test_rebase_same_head success --fork-point --onto master... master
 
 test_expect_success 'add work to upstream' '
@@ -65,8 +65,8 @@ changes='our and their changes'
 test_rebase_same_head success --onto B B
 test_rebase_same_head success --onto B... B
 test_rebase_same_head success --onto master... master
-test_rebase_same_head failure --fork-point --onto B B
-test_rebase_same_head failure --fork-point --onto B... B
+test_rebase_same_head success --fork-point --onto B B
+test_rebase_same_head success --fork-point --onto B... B
 test_rebase_same_head success --fork-point --onto master... master
 
 test_done
-- 
2.21.0.944.gce45564dfd

