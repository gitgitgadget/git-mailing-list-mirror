Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43839211B9
	for <e@80x24.org>; Tue, 25 Dec 2018 13:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbeLYN4J (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Dec 2018 08:56:09 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36445 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeLYN4I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Dec 2018 08:56:08 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so17821472itj.1
        for <git@vger.kernel.org>; Tue, 25 Dec 2018 05:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=drsZ+HTEEz4Pt42lm5MHaJSqyo9yzOvbp9jqI+JbbJ8=;
        b=T3YeZODRV04xzTiz+voeNzCeFs9nec5wcLPCSiPvmdpg7BzYtR8Pf5m0ZWuR7SJ4va
         2mZbleaeEjuN3mL9jrjj3FgSK1cRu6PC2PyGLr/7wMhLVh6LIRXQCWe68mQI53yTW1UK
         9xKwV0okP/tAYmitzb63obCg7SLFNQUE8Os1zkluhya6ijb9AXdhMr5V6Jtd3JifLW6g
         mbE+EOMdAaTlJg125lYJ9lN0Y4SAOx7V38nmT28wpgszi4QCc2Di0yWyacI3XqFviCjF
         tHpvQevFTvKh7oHy03y4ztbCqVk9+vo/eq1EFZNCFfcLLOZKIpAuN5fomQ1QKMovzDiC
         rv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=drsZ+HTEEz4Pt42lm5MHaJSqyo9yzOvbp9jqI+JbbJ8=;
        b=hvOcV8sAW3qRRCir0J8/iLUqbcJFbKA5keTHEUvlypV5HY6AXAujA7bvb8M1r/nclN
         kSYF/84SLIpEShpqfyYRIYNkfflUSLc98m/eQAhAwhz3Cm9N65Fq8NI1eejpbTZmHjd4
         EgrHB1gm1fOfvxNEswiuGfg6YHE++k3pok96Jc4mLnmOzzL/jc0U6w3biN+J67Cso+dH
         qXF/WQqxSJ78jmNaOJ4uONIU4YzPipPQGIkel0c+u1tbSIRVh01N9hVQCizeqYDShWYh
         z0BDyKjlCSna7Txb3S+WAgzcuWls/JbUwrLoQDMKgJVIh39m1VOsXRzR1HlGrzcOtxRE
         RJzg==
X-Gm-Message-State: AA+aEWadrPKQnh5LBIkW3y13azkSeRy8C1GK1sdx0eSjbM3hWkkpZN7+
        GzF/34x72PiXCKTOLgE6by2qzjXE
X-Google-Smtp-Source: AFSGD/US6+63UTnhCWY1iG9YWBJbOC0kjxvSU8V+ctSK0NaASpk59TT9QJC2UAaxiaBXlY1G+XNYdQ==
X-Received: by 2002:a02:95e4:: with SMTP id b91mr9862906jai.15.1545746167666;
        Tue, 25 Dec 2018 05:56:07 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [99.245.246.183])
        by smtp.gmail.com with ESMTPSA id q9sm14878550ioh.32.2018.12.25.05.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Dec 2018 05:56:07 -0800 (PST)
Date:   Tue, 25 Dec 2018 08:56:05 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v5 2/4] t7600: clean up 'merge --squash c3 with c7' test
Message-ID: <4361c3a31a703502fa7210bc2ac7b88a08b70126.1545745331.git.liu.denton@gmail.com>
References: <cover.1542768902.git.liu.denton@gmail.com>
 <cover.1545745331.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1545745331.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This cleans up the original test by removing some unnecessary braces and
removing a pipe.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7600-merge.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 106148254d..d879efd330 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -233,8 +233,7 @@ test_expect_success 'merge --squash c3 with c7' '
 	cat result.9z >file &&
 	git commit --no-edit -a &&
 
-	{
-		cat <<-EOF
+	cat >expect <<-EOF &&
 		Squashed commit of the following:
 
 		$(git show -s c7)
@@ -242,8 +241,8 @@ test_expect_success 'merge --squash c3 with c7' '
 		# Conflicts:
 		#	file
 		EOF
-	} >expect &&
-	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
+	git cat-file commit HEAD >tmp &&
+	sed -e '1,/^$/d' <tmp >actual &&
 	test_cmp expect actual
 '
 
-- 
2.20.1

