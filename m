Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89C9420248
	for <e@80x24.org>; Thu, 14 Mar 2019 15:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfCNPdN (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 11:33:13 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:38067 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfCNPdM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 11:33:12 -0400
Received: by mail-ed1-f52.google.com with SMTP id e10so1099650edy.5
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=15eJZPh/vIIN8jT/A+u0aM1SloGNC9f++DFJPf9NwTk=;
        b=szK214uaMpOEL+94p2KR7o0BFvHR7/8eIHrQhYi59xCycOWS8iYJWNUk1hMABvCA3d
         qieJBnPTZwEVVmmgn5nCPrM7H8M5x4evNst/4xSQ/mvWI2i5uKmxPVj58wb0FPB+5/dE
         09+DjJZFyh46cTMEdYcu1w2/u0qkcr4dWmd/2sYD6M3nNaJE8Nz21SbgKeL6vb2eCUDM
         RniUYXHfYFtQE8df1MHHDNqoIQVQRBO8Cr9KZPN4ht5z9WFn9IMMbQY67XWbyCwB529V
         hampHxlrTWUS1FdMIqJt9jmHH45TA8VQQDdRO6Jg2LfuaGmot2nRNtfyDiAAYd5gxszS
         5AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=15eJZPh/vIIN8jT/A+u0aM1SloGNC9f++DFJPf9NwTk=;
        b=ETZnDd7k0muPeMTewk0/r7qVGv8newx88EaVIsCewb4KMmGZNOfVuajWdVSyiZ4Rqw
         Xe25h59Khqge65uqe69EBT+4FqZ5AhG6yvf9uzroQRB0z7ZEITZ+POLQ2bxMOsre8P/f
         FxWu9fjhyHan9pgckLeu/TIKRi6DaPeUU5tR8Isp+zAMlFVQSt6MO2pEx97CeZHIs5F2
         kOyNFHLOE2F1d69kcofkKIp/uoeXjX9mf2NuHdtZU9ifUltvj6CibClyPk9o0AwGju5v
         pUz3wsodAHCTRQzkm9jyZgEuSkcaLURiv2TQ94evz/DUOZVxa+b6+c2XmB9ZiB/ykhEl
         YFmg==
X-Gm-Message-State: APjAAAWltKiTFSqq06ijcx5x3zZ2CFftZOTIYv6EJQkhuf/0sMh05nPL
        WKIgnqXGe0LwWXbzqba8WirM8BT4
X-Google-Smtp-Source: APXvYqxalSwqvdpfrm1xL0RYwis/od/lGnt9W1yJGK8xLBbd5M8tQMnbEKApWzYknVmV5RoVbAFO9A==
X-Received: by 2002:a17:906:69cf:: with SMTP id g15mr33458234ejs.157.1552577590466;
        Thu, 14 Mar 2019 08:33:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t33sm1579613edd.55.2019.03.14.08.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 08:33:10 -0700 (PDT)
Date:   Thu, 14 Mar 2019 08:33:10 -0700 (PDT)
X-Google-Original-Date: Thu, 14 Mar 2019 15:33:06 GMT
Message-Id: <41fc6eb9baa2ab54e6061c6894a17664209a0e53.1552577586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.161.v2.git.gitgitgadget@gmail.com>
References: <pull.161.git.gitgitgadget@gmail.com>
        <pull.161.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 4/4] get_oid(): when an object was not found, try harder
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is quite possible that the loose object cache gets stale when new
objects are written. Or that a new pack was installed. In those cases,
get_oid() would potentially say that it cannot find a given object, even
if it should find it.

Let's blow away the loose object cache as well as the read packs and try
again in that case.

Note: this does *not* affect the code path that was introduced to help
avoid looking for the same non-existing objects (which made some
operations really expensive via NFS): that code path is handled by the
`OBJECT_INFO_QUICK` flag (which does not even apply to `get_oid()`,
which has no equivalent flag, at least at the time this patch was
written).

This incidentally fixes the problem identified earlier where an
interactive rebase wanted to re-read (and validate) the todo list after
an `exec` command modified it.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sha1-name.c                 | 13 ++++++++++++-
 t/t3429-rebase-edit-todo.sh |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 6dda2c16df..36a6602696 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -415,7 +415,7 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 					 struct object_id *oid,
 					 unsigned flags)
 {
-	int status;
+	int status, attempts = 0;
 	struct disambiguate_state ds;
 	int quietly = !!(flags & GET_OID_QUIETLY);
 
@@ -438,10 +438,21 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 	else
 		ds.fn = default_disambiguate_hint;
 
+try_again:
 	find_short_object_filename(&ds);
 	find_short_packed_object(&ds);
 	status = finish_object_disambiguation(&ds, oid);
 
+	/*
+	 * If we did not find it, do the usual reprepare() slow-path, since the
+	 * object may have recently been added to the repository or migrated
+	 * from loose to packed.
+	 */
+	if (status == MISSING_OBJECT && !attempts++) {
+		reprepare_packed_git(the_repository);
+		goto try_again;
+	}
+
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
 		struct oid_array collect = OID_ARRAY_INIT;
 
diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
index 83e5bb5eba..d5d2925a44 100755
--- a/t/t3429-rebase-edit-todo.sh
+++ b/t/t3429-rebase-edit-todo.sh
@@ -11,7 +11,7 @@ test_expect_success 'rebase exec modifies rebase-todo' '
 	test -e F
 '
 
-test_expect_failure SHA1 'loose object cache vs re-reading todo list' '
+test_expect_success SHA1 'loose object cache vs re-reading todo list' '
 	GIT_REBASE_TODO=.git/rebase-merge/git-rebase-todo &&
 	export GIT_REBASE_TODO &&
 	write_script append-todo.sh <<-\EOS &&
-- 
gitgitgadget
