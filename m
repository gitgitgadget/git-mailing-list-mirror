Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08DD31F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 22:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389673AbfJRWKb (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:10:31 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:40620 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390212AbfJRWKa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:10:30 -0400
Received: by mail-pg1-f178.google.com with SMTP id e13so4075958pga.7
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e95ojsHm7vmKqMzqBTVWGVgpE6h9ehNY26fnbtBrNJU=;
        b=FrPkpffDjG5rRWxaVDGkvd3HIgQUWxtnfQaVyCPgbX9s2rEZsM4KACNT3yT7bhQpvD
         Rq+wXVzbUaXurPVQ2NnxX8msW40SpvYQMbFPFY6h2zJcucPQ+/xZL3CMVQco0G7eW7RQ
         lI4QNFY+PKSybB8Fc7vCon07+Ndg7N2v/W2URy77gIucc4rQnfmMJBd5TSN8kYpLMGwv
         h4GN8H4tqFipf+mzUx2IXzoU6wkRPnprVZXERSYsF3lf3I+FuJHXOybEt/wMplRhnA3q
         8obHrys5izJ+hyK/fnsVQhQRqhI+ONhzGGoch/aBXBa/U3s6pwZUpN4igVjedpE1mP2I
         4/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e95ojsHm7vmKqMzqBTVWGVgpE6h9ehNY26fnbtBrNJU=;
        b=ghKQYfxYTXcT3v7sY7cckeC3xXbKiSO/gGbsomPB2tGf1VL0aW4xX9J0HH3jIwFqr4
         cVJHtgME4E+b6sbUby+bMwBa612MpYlwdIPMW3v065kUOLKko5AGWFccwmmdnbVE9b25
         VyddWYyeY/IRFnxQ8FJa+t2cBquTg86SA190axs4d8lMfkLRIgFtN7fm2z8GSDC//TGe
         5S0OcQah2OkzB0iLjjdAzDkT/BRv8Wp7tm4s/skiTr+NSEOb6wVSIFoH/WtX9IqMyo2O
         NSHuhMEYBrs5MrssDeD1tiWeA+R4ZQBprB6h+rbObBLlT+6yV2MMT+AlAaz6rLxnF12y
         G40w==
X-Gm-Message-State: APjAAAVc/IXr6pw+Toq2N3Be3e+9Syfx776Yxx7wTUWDB7IQA1+vcSCd
        5PvlFUXLBzt2Id6X3CRZ7OPqaty3
X-Google-Smtp-Source: APXvYqwTFpmFOX5Fg6wZr56cFBo+SsoomNvJNBVaq6V+kkj+RrfH837QgFtB7+r9seyumX6ibDInnw==
X-Received: by 2002:a63:1c03:: with SMTP id c3mr12057394pgc.198.1571436629276;
        Fri, 18 Oct 2019 15:10:29 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id w65sm8194019pfb.106.2019.10.18.15.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:10:28 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:10:26 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 04/15] t5520: use sq for test case names
Message-ID: <dfa89ba1cbf8c361aa438b42dcd42e4ae6b49eb6.1571435195.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
 <cover.1571435195.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571435195.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The usual convention is for test case names to be written between
single-quotes. Change all double-quoted test case names to single-quotes
except for two test case names that use variables within.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 51d6ce8aec..a3de2e19b6 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -408,7 +408,7 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
-test_expect_success "pull --rebase warns on --verify-signatures" '
+test_expect_success 'pull --rebase warns on --verify-signatures' '
 	git reset --hard before-rebase &&
 	git pull --rebase --verify-signatures . copy 2>err &&
 	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
@@ -416,7 +416,7 @@ test_expect_success "pull --rebase warns on --verify-signatures" '
 	test_i18ngrep "ignoring --verify-signatures for rebase" err
 '
 
-test_expect_success "pull --rebase does not warn on --no-verify-signatures" '
+test_expect_success 'pull --rebase does not warn on --no-verify-signatures' '
 	git reset --hard before-rebase &&
 	git pull --rebase --no-verify-signatures . copy 2>err &&
 	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
-- 
2.23.0.897.g0a19638b1e

