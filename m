Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D852420248
	for <e@80x24.org>; Fri, 22 Mar 2019 09:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfCVJc3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 05:32:29 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:36257 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbfCVJc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 05:32:29 -0400
Received: by mail-pf1-f169.google.com with SMTP id p10so1151867pff.3
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 02:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dp4yRhzscDtaxNgptHVBokbFOxRHcWFndnMRLiOXHHo=;
        b=enltlpg7TPWpyvOoaGKUKgPQ9Ka3g1cU3jcckbIwiafCiHLYRE34T9mvonvxhQOArh
         RnkTanhyHkW02GjLqfyLxOpMFv/h9K0yA8tYZL5APZ0eOdMGdTGbv6vq5K1yLgkGkPD+
         o7VkFmeuO9iNYRcx2QCcaCnPbTzOuP0SH3tP84NEUgo1ly9i7BlQIF2diPraVYIk5fvx
         ZA+WxEb390pHa2HmBva4hjn0bLB5+AUwvnponA0WUebgFyw685NKKOW68xQQK4ocM1/U
         KiRq2yehn4vECF/6ZswB08SVnFq+oNP6VQtJKa0qN8kxJcJ66e+bZrvYwv2Ei8KedaUk
         +y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dp4yRhzscDtaxNgptHVBokbFOxRHcWFndnMRLiOXHHo=;
        b=jfhGpL3lDFx8O3DMfXVjpATamqVEqGkI09EINYhURNsoUCgEvtebKZ052eC9x7pmO8
         sLmJp8TQziUrPvg/MlZBc6Aw9gzIagbsULdzLRCLHi7ikzs9NeDFzJHfROqy5s//MNDV
         dojX+icGWHPnR3T2JeE7uJ5Hg5DPYpQ6WRQyXm+Vv9L3ARuq7Np5JeSLtdkaFpce3hau
         JzV9gkh8ZguYa3CqxftUdMkY9ryeylP77VPW7O3zZlFB6K1cgv3tItcP9lehqPAuHgHe
         F4qTAqIlyZ9whyxhr0bTJOvPuLNqv3EEL6b8p3w4/hqGd4Y+8Mt7PtMovCly95YsTuVc
         UoNQ==
X-Gm-Message-State: APjAAAW2eR0UvCyJCQ5+r/aXRMPbLV59cvbEw5lP/Ap/Rfgq3vcRCwGT
        lFNouhmGXsfO1VmQU8l7xhkPlgblhMo=
X-Google-Smtp-Source: APXvYqyLtAXWOjT1bl3vppMIX51NjQC0N7CxfmBV8zefsts/ekafzHWISbS0pgJW1yXU/YOy5UzskQ==
X-Received: by 2002:a63:ca:: with SMTP id 193mr7937769pga.288.1553247148305;
        Fri, 22 Mar 2019 02:32:28 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id o38sm14716488pgm.36.2019.03.22.02.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 02:32:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 22 Mar 2019 16:32:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 4/4] checkout: prevent losing staged changes with --merge
Date:   Fri, 22 Mar 2019 16:31:38 +0700
Message-Id: <20190322093138.13765-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190322093138.13765-1-pclouds@gmail.com>
References: <20190322093138.13765-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When --merge is specified, we may need to do a real merge (instead of
three-way tree unpacking), the steps are best seen in git-checkout.sh
version before it's removed:

    # Match the index to the working tree, and do a three-way.
    git diff-files --name-only | git update-index --remove --stdin &&
    work=`git write-tree` &&
    git read-tree $v --reset -u $new || exit

    git merge-recursive $old -- $new $work

    # Do not register the cleanly merged paths in the index yet.
    # this is not a real merge before committing, but just carrying
    # the working tree changes along.
    unmerged=`git ls-files -u`
    git read-tree $v --reset $new
    case "$unmerged" in
    '')     ;;
    *)
            (
                    z40=0000000000000000000000000000000000000000
                    echo "$unmerged" |
                    sed -e 's/^[0-7]* [0-9a-f]* /'"0 $z40 /"
                    echo "$unmerged"
            ) | git update-index --index-info
            ;;
    esac

Notice the last 'read-tree --reset' step. We restore worktree back to
'new' tree after worktree's messed up by merge-recursive. If there are
staged changes before this whole command sequence is executed, they
are lost because they are unlikely part of the 'new' tree to be
restored.

There is no easy way to fix this. Elijah may have something up his
sleeves [1], but until then, check if there are staged changes and
refuse to run and lose them. The user would need to do "git reset" to
continue in this case.

A note about the test update. 'checkout -m' in that test will fail
because a deletion is staged. This 'checkout -m' was previously needed
to verify quietness behavior of unpack-trees. But a different check
has been put in place in the last patch. We can safely drop
'checkout -m' now.

[1] CABPp-BFoL_U=bzON4SEMaQSKU2TKwnOgNqjt5MUaOejTKGUJxw@mail.gmail.com

Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 11 ++++++++++-
 t/t7201-co.sh      | 10 +---------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 22fb6c0cae..7cd01f62be 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -725,7 +725,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 */
 			struct tree *result;
 			struct tree *work;
+			struct tree *old_tree;
 			struct merge_options o;
+			struct strbuf sb = STRBUF_INIT;
+
 			if (!opts->merge)
 				return 1;
 
@@ -735,6 +738,12 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 */
 			if (!old_branch_info->commit)
 				return 1;
+			old_tree = get_commit_tree(old_branch_info->commit);
+
+			if (repo_index_has_changes(the_repository, old_tree, &sb))
+				die(_("cannot continue with staged changes in "
+				      "the following files:\n%s"), sb.buf);
+			strbuf_release(&sb);
 
 			/* Do more real merge */
 
@@ -772,7 +781,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			ret = merge_trees(&o,
 					  get_commit_tree(new_branch_info->commit),
 					  work,
-					  get_commit_tree(old_branch_info->commit),
+					  old_tree,
 					  &result);
 			if (ret < 0)
 				exit(128);
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index f165582019..5990299fc9 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -224,15 +224,7 @@ test_expect_success 'switch to another branch while carrying a deletion' '
 	test_i18ngrep overwritten errs &&
 
 	test_must_fail git read-tree --quiet -m -u HEAD simple 2>errs &&
-	test_must_be_empty errs &&
-
-	git checkout --merge simple 2>errs &&
-	test_i18ngrep ! overwritten errs &&
-	git ls-files -u &&
-	test_must_fail git cat-file -t :0:two &&
-	test "$(git cat-file -t :1:two)" = blob &&
-	test "$(git cat-file -t :2:two)" = blob &&
-	test_must_fail git cat-file -t :3:two
+	test_must_be_empty errs
 '
 
 test_expect_success 'checkout to detach HEAD (with advice declined)' '
-- 
2.21.0.548.gd3c7d92dc2

