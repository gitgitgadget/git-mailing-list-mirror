Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EE741F461
	for <e@80x24.org>; Tue, 27 Aug 2019 05:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfH0FiF (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 01:38:05 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35769 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0FiF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 01:38:05 -0400
Received: by mail-io1-f65.google.com with SMTP id b10so34397940ioj.2
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 22:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=F60fZwnt39XfVOJovpBOzsC+gIlPxSPyARZ47M61hD0=;
        b=I1iGMK8FTvsQlIvGDCiu8Gh/hKXNYAphCnCgT9NwBOEj7nylmrwlZaJpW+E2Mq6BWs
         uKf+5sy5U9PqLkSGR2IU1ZZ7pMoPW/D8qgteHA+fv5xpH5YjG0wttQy2Ap1LwwMJBCh1
         Rr91YxEJghNlEfzCtJ0G70OwnltvAkvnwxoHfdOO3kV4768bibS6XGDtt5AZP0hEFcUb
         Uflx4GpCSGg2VhT3FjBCeTTohJa/ztlsboeuCEnNkGUQEL9VnV44XK6T0zVVEAqlJWza
         ZV3NkHOHPmcdQAdMwKsz7GYsfnALr5ICuElNOG/T99qfRkFp0jOKQtZV+8CBNhyQO3OD
         7u1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=F60fZwnt39XfVOJovpBOzsC+gIlPxSPyARZ47M61hD0=;
        b=rVJC7avRk0P0cyK7yWOUhjuGz4m7W/DYdyZfQvzuFHunVVR9LN0iwXT1+UHOz9Dhaf
         WLgktCGEZd/Ks3QbqwTlnh8jaqwB6LMm32vVNk3Xvb5CSzrfwEHtpTJ8aQ5RvU3EUDeH
         9W6stXMH2eyjPsa3cIo0g0CMLYmHBVWrc/Q8dL/ez0XMhg2jH38XTzlnpw27ATSvCL0n
         RRsEpk+frc3RJVMWT5CJJJg/pM9mNoBqHv61JhRvFFVoiJFwlC40a8vMBloWCBLplzyD
         wImG60N6Z8ArSrHMszgjMHheZ56UuUHee4qu5+5AcTxu/ueCrmHIpxsEi/6/DE5624f4
         DrwA==
X-Gm-Message-State: APjAAAUjjJopf4uoBak4p7698F2bc5oQpqyR6syj1Dh/M7kTzJG+0FqL
        zHYsDiACA84xpR3EwNnpTpgiJoZb
X-Google-Smtp-Source: APXvYqxtUnAzG2ZRqw5z/pn9nTB+sGmTOo/MSGgf6PUYVaSJezn5FMfyYXJHStOYpPxCGHinb1DJ1w==
X-Received: by 2002:a5d:9a01:: with SMTP id s1mr1197295iol.255.1566884284169;
        Mon, 26 Aug 2019 22:38:04 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id q3sm12209469ios.70.2019.08.26.22.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 22:38:03 -0700 (PDT)
Date:   Tue, 27 Aug 2019 01:38:01 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v10 7/9] rebase: fast-forward --fork-point in more cases
Message-ID: <126c20a95d1d7afa4e0cba384fbd08a4bea43614.1566884063.git.liu.denton@gmail.com>
References: <cover.1566724236.git.liu.denton@gmail.com>
 <cover.1566884063.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1566884063.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
 t/t3432-rebase-fast-forward.sh | 20 ++++++++++----------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1e1406c8ba..7ef9095e7c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1261,6 +1261,7 @@ static int is_linear_history(struct commit *from, struct commit *to)
 }
 
 static int can_fast_forward(struct commit *onto, struct commit *upstream,
+			    struct commit *restrict_revision,
 			    struct object_id *head_oid, struct object_id *merge_base)
 {
 	struct commit *head = lookup_commit(the_repository, head_oid);
@@ -1280,6 +1281,9 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
 	if (!oideq(merge_base, &onto->object.oid))
 		goto done;
 
+	if (restrict_revision && !oideq(&restrict_revision->object.oid, merge_base))
+		goto done;
+
 	if (!upstream)
 		goto done;
 
@@ -2042,9 +2046,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * with new commits recreated by replaying their changes. This
 	 * optimization must not be done if this is an interactive rebase.
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
index d9957e5f1e..fbedfe7b4a 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -70,32 +70,32 @@ test_rebase_same_head_ () {
 }
 
 changes='no changes'
-test_rebase_same_head success work same success work same
+test_rebase_same_head success noop same success work same
 test_rebase_same_head success noop same success noop-force same master
 test_rebase_same_head success noop same success noop-force diff --onto B B
 test_rebase_same_head success noop same success noop-force diff --onto B... B
 test_rebase_same_head success noop same success noop-force same --onto master... master
 test_rebase_same_head success noop same success noop-force same --no-fork-point
-test_rebase_same_head success work same success work same --fork-point master
-test_rebase_same_head failure noop same success work diff --fork-point --onto B B
-test_rebase_same_head failure work same success work diff --fork-point --onto B... B
-test_rebase_same_head success work same success work same --fork-point --onto master... master
+test_rebase_same_head success noop same success work same --fork-point master
+test_rebase_same_head success noop same success work diff --fork-point --onto B B
+test_rebase_same_head success noop same success work diff --fork-point --onto B... B
+test_rebase_same_head success noop same success work same --fork-point --onto master... master
 
 test_expect_success 'add work same to side' '
 	test_commit E
 '
 
 changes='our changes'
-test_rebase_same_head success work same success work same
+test_rebase_same_head success noop same success work same
 test_rebase_same_head success noop same success noop-force same master
 test_rebase_same_head success noop same success noop-force diff --onto B B
 test_rebase_same_head success noop same success noop-force diff --onto B... B
 test_rebase_same_head success noop same success noop-force same --onto master... master
 test_rebase_same_head success noop same success noop-force same --no-fork-point
-test_rebase_same_head success work same success work same --fork-point master
-test_rebase_same_head failure work same success work diff --fork-point --onto B B
-test_rebase_same_head failure work same success work diff --fork-point --onto B... B
-test_rebase_same_head success work same success work same --fork-point --onto master... master
+test_rebase_same_head success noop same success work same --fork-point master
+test_rebase_same_head success noop same success work diff --fork-point --onto B B
+test_rebase_same_head success noop same success work diff --fork-point --onto B... B
+test_rebase_same_head success noop same success work same --fork-point --onto master... master
 
 test_expect_success 'add work same to upstream' '
 	git checkout master &&
-- 
2.23.0.248.g3a9dd8fb08

