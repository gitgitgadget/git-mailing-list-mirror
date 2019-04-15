Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2927920248
	for <e@80x24.org>; Mon, 15 Apr 2019 22:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfDOW32 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 18:29:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40190 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbfDOW32 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 18:29:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so9323257pfc.7
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=59WCqBnAXQktICWHjz4e8DHvy2E8XOWgjme3Yt2djMw=;
        b=YhBEdIZpRmbFwT6Wgjote+ECziVLHXKyxe6qX1/+MgRhmaCovGUWqpEbLHHH/ZBN44
         MgPbQqX2wbQhj6+yKc3gODscqD3jD0nG9yaHe0lspdShj5tGPkgwBXx5zSzb5XJEKS5x
         1zufxvlYVzrS2IqbQYss1V6bVTpl+wzpIgUn7zgyCFzcyIc0g77lGDD0O2aYFVHVj/q7
         XEM48oFSCp6YPKLu4ToawmuVSz4MVuQ4ZIY2SG3JMZycxiIIbT8SpngNIpiZsT9rv9la
         pQPfSjadJq4Fx8Hg4Boss8Eau3zT4vXhmr3pamDw4P16cAsyQs972dOXlMuobOBwWHO8
         YtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=59WCqBnAXQktICWHjz4e8DHvy2E8XOWgjme3Yt2djMw=;
        b=PzIlLVrJE0/4YSRTapMNYUCGTA0dWd1HLLtvkhXmXbYUwNtECiNKPzwyWlT/WVe/1K
         abweXYicVWqyx+rqKvalqSzgBQtq9EpCy/YcM5329kTJCsKo0wsy9PkD65KcaJ/f4l7K
         kEr93ny/VatXmPS0JFwCFZ3n0PlDDN9QuSVpU9xEIFwWKz2x4SMexwk0x+JVyJZW4zFu
         c7M9+JLkBp10QNoh6KGs06jMKmrOQIC+mK9x3VaIrLV/rb9pPW92lNPyS34T9bp7HpmJ
         Q2YZDKX04mnxVzrTPQJ4LPgePXrZvpYxcywDxcBvLLUvWXoZPc6NW5xwfuTapHMhaeKB
         EHnQ==
X-Gm-Message-State: APjAAAXnNY5fQm42Z8lw01kGLJMNL23z42kLu5zMAUSNgWc7vDBBCue5
        6pN28QHHyk0slWkr6bfOEbWUt7TI
X-Google-Smtp-Source: APXvYqyv8S7SsUNEaZiBudtXRNEVhm+bxKj3GEzbXRuP+hN3J4T+xyIec4lTVCFIRg/c4cDTaNfeLw==
X-Received: by 2002:a65:480c:: with SMTP id h12mr72325054pgs.266.1555367366995;
        Mon, 15 Apr 2019 15:29:26 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id 26sm67188664pfj.93.2019.04.15.15.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 15:29:26 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:29:25 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v5 4/5] rebase: fast-forward --fork-point in more cases
Message-ID: <2256a902c17fb70ddedeb65f5d0395c5767800f2.1555366891.git.liu.denton@gmail.com>
References: <cover.1554500051.git.liu.denton@gmail.com>
 <cover.1555366891.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1555366891.git.liu.denton@gmail.com>
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
 builtin/rebase.c               |  9 +++++++--
 t/t3432-rebase-fast-forward.sh | 12 ++++++------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7aa6a090d4..5f00d91b68 100644
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
 		goto done;
 	}
 
+	if (restrict_revision && !oideq(&restrict_revision->object.oid, merge_base))
+		goto done;
+
 	if (!upstream)
 		goto done;
 
@@ -1701,8 +1705,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * Check if we are already based on onto with linear history,
 	 * but this should be done if this is not an interactive rebase.
 	 */
-	if (can_fast_forward(options.onto, options.upstream, &options.orig_head, &merge_base) &&
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
2.21.0.921.gb27c68c4e9

