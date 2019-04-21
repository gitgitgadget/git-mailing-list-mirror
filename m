Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D9EE20248
	for <e@80x24.org>; Sun, 21 Apr 2019 08:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfDUILe (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 04:11:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38434 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfDUILd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 04:11:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so4430661plb.5
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FaK3V2X0tbv/BZURnkk1VChlpGtK4yvs41+AmQmQKb0=;
        b=f05LbXm5UPMl6pNTIoh4cfhP7U/7w1PwFCF+0gDIisK1HvTlT6fyjc+I5foCO8cjdz
         xrhFIb3lExdNC5sdKj/Plfy3skO8tU/8eoOKiftSmsQ+l5vOwAY797qv9sKjeNC/S7js
         J4s8QzN/8iuQXCA40VGdwSX/z9LDffe70iU69AKMr2JNMiHpdqCzRcHzgEmPpZVy3thx
         4hEZHfBxY2vIo5iy/IKk596CaojM+PJgMD2uRJifW96pl7wE/n76K3Ln/YKSWuuxJeVP
         cT79dPO/sVaFEvzDnPZqTSY/3uFKIg4LBKivrclKMBlhlwuRZOfP3fjJYvi6ZaUAMx2F
         BkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FaK3V2X0tbv/BZURnkk1VChlpGtK4yvs41+AmQmQKb0=;
        b=CYOqnfMPlOL+8mdaFb3wx9BR7ZwRKc0E3JEywGxAT3R4SP58zUEEQNg+JXCB7ehPJL
         0FzWfUe85Iady/AfL4T4LXysW1bbOv/wP3UgWJPCQ2oHil45+LPfuZB6CHA1G/Zehm4l
         WyAPds/LNO2jWfEgRAIKKqZEN4KXVNCQ6iornPty0nXXg8DY++15OS9LAxGMD4sRqYW2
         iXbdJbA4aoeBVWuVOzGWyX0hn9g1+OdCVdS1hN8bbg0swCtJU9UZPdZp9oGl/w80zMVD
         mhBJPXj6g4G+8gq2bfTuN9l79B+VasZ+56Dvx20PddEkKtWW+hP0g6rCzhGh+cV8pDg9
         Z3mQ==
X-Gm-Message-State: APjAAAUX+JbCtGyEgfgeQPBTUNa1oP50uWpigBcLz7zIsEXX9s1zDeaf
        kW6O6YV5KrDZDE5HY3ozjZYYY8At
X-Google-Smtp-Source: APXvYqzqLX9M0ZooVMgzpAG/lux205Bf8Abv8SAFlS2vPQOS1+3AeY3XvBl0fcc/CFLr8M2E2vl6fA==
X-Received: by 2002:a17:902:6bc8:: with SMTP id m8mr4582616plt.21.1555834292307;
        Sun, 21 Apr 2019 01:11:32 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:647:4b00:5d::661d])
        by smtp.gmail.com with ESMTPSA id z14sm13222144pfn.161.2019.04.21.01.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 01:11:31 -0700 (PDT)
Date:   Sun, 21 Apr 2019 01:11:29 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v7 5/6] rebase: fast-forward --fork-point in more cases
Message-ID: <8254730810eed7b413baebe918efb43e26e04af8.1555832783.git.liu.denton@gmail.com>
References: <cover.1555523176.git.liu.denton@gmail.com>
 <cover.1555832783.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1555832783.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
index fdb42eb09f..66c59ebe22 100644
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
 
@@ -1703,9 +1707,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
2.21.0.967.gf85e14fd49

