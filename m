Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2BF51F461
	for <e@80x24.org>; Sun, 25 Aug 2019 09:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfHYJMQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 05:12:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44987 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfHYJMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 05:12:16 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so21875556iog.11
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 02:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dIQa1oYV/mZUdlR4gDrpywOosuEtDsepvkiK/dnl1t8=;
        b=A00czdeP+JMqB3cfAKP0Q7dfcaKjBPj4EnffSIMCxStrn9ybyyqsVwdgmJU8AKXatp
         pghSCGo+vdoXTkUJnoZKBBY+fqUjbM0Lj/HgNwEUFDm4it8h7IzWZrqPYpQjTHy4DkdT
         X+JIv3/gzI/f+oPVSF0wAiCf199QlpWY10Mh1mzV94096Mj6bY9AT5MzUZhEUlCl3icW
         22nOFesxgvC1OcGPJIGKM6Pio2hvqI/1Q4jA1n8FSIKLqy1GBYWkWF7WnAHmfbB0mzmr
         BUaiY2PzUGkhsoA+JDlJ5hLW+qinEt6AofzFHW4Bwh4ogOFge2rxhPR3WtcF5OCrQA4U
         CWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dIQa1oYV/mZUdlR4gDrpywOosuEtDsepvkiK/dnl1t8=;
        b=RLUEgFlklpGotbfcaEE1ZXy2J3ajoA+iSo2SHcN1ADkRI5Q5Z1Tmuib5THL0iG7VjO
         /r4/nWfgbG8z4fvjt2LYxB3rQrktBc3b6qdmfrzIZ1w75vZDmZOLv4aQjU2Xfl2qJTR4
         bKWaAQlk50OO67aIDVBH3CHvVZWY2rIUjedLdYbFuSN83nUQ0jNohboGkf2rpbDrHZ3o
         YsIeNGN4zEZJpInDddlWmB4v1UE0hzKNAvVPnMfNXlF3B82+8mLrrMru3uzZxW5v/iW4
         iWIpI7mJParcAtDdynoDRDvnbhSbo4c/T4IEWb3ciVXVDW9aHF/qInL5XcSMBBs/gBlS
         6O2Q==
X-Gm-Message-State: APjAAAWSTwdT+0iPk0og4/rhFeg8YBFYoEVz5LIRcqgCZWSZdUpNplEJ
        oIX0mT76w2C8PWfcNRY2UY1Tg4yM
X-Google-Smtp-Source: APXvYqxsuzeW74+pChCq8sPxENzOzyvbLMrpipEz9UiabzRCpGl7I+YC0W6TnGYTbp49JRTN/VPLmA==
X-Received: by 2002:a6b:761a:: with SMTP id g26mr18148980iom.71.1566724334836;
        Sun, 25 Aug 2019 02:12:14 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id h18sm6548268iob.80.2019.08.25.02.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 02:12:14 -0700 (PDT)
Date:   Sun, 25 Aug 2019 05:12:12 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v9 7/9] rebase: fast-forward --fork-point in more cases
Message-ID: <4dab5847cbb7d40efc02cbd89203df6ff192a5b1.1566724236.git.liu.denton@gmail.com>
References: <20190508001252.15752-1-avarab@gmail.com>
 <cover.1566724236.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1566724236.git.liu.denton@gmail.com>
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
index bdb1d922a4..b78bd92002 100644
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
 
@@ -2043,9 +2047,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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

