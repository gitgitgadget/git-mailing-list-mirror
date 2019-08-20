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
	by dcvr.yhbt.net (Postfix) with ESMTP id 375CD1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 07:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfHTHSz (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 03:18:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38149 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfHTHSz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 03:18:55 -0400
Received: by mail-io1-f67.google.com with SMTP id p12so7640861iog.5
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 00:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IUxUkhQu8IKRPJnJfvXqpZRjIm/zAINbPLEtvMCz0aY=;
        b=JmqjUX/xCHBsN1GZPgljmb+T57lOx9hY91LiPl/X4StEURGiKrP6qn+MPZyfn/iPux
         SjTB/61wqKXToEHAkt9U2/e7K2uuXuMMvQ5FYCr7BWJR4+Whn6uJpjHC3AuaTlLEUWg3
         kF7HTipZ9I5kdoemmy3VEwjrWNDs4y7XqB4iAXtqCq3YhMnzFtZtV8A1QPw9YvTk73aF
         teDoLrUeoXE4oYZzbYQ3ndVw5c7jki6RrJkjMf9ezxTffuZpG8XYFNzLuEQpv1JcbBe8
         bOScTDdkT7U1gDyIiI7DadXB1xJp+mlZogklknxtSM3aAJOyFGdJc3buUvu3LNjh6EWc
         cMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IUxUkhQu8IKRPJnJfvXqpZRjIm/zAINbPLEtvMCz0aY=;
        b=mdvz0asi5plKO4EUwQfDq90JmRxgWE8JnfIvSpcJA6g5JdRSOeDewEW3ij2bts0I7U
         i3UUZI7oUVMs8KHpxrQO0a6YSBPdjMvHBWMidACgW4F85e0HvtBzdchFrha8guz371Iy
         dYw8KjAY6YsJtBCYnsOSXnnQwbGuvG4B53dXt/uExefqlvxS1tsAKMPHimPPpUWK5Pic
         zHXWnvOxb8LC55wXyQMO1tZs17L3D+vPZdiCsyK6mwJpdGzW75ZVnmfmiIEBuIIyknqX
         6ylmjwKcbzpdF9r3nzmfTREJEofXpDMFVAZBRJsjvSCqijEWH71yhIkDd7A3+BGkWVzE
         rT7w==
X-Gm-Message-State: APjAAAU61qLY8qb6Mj1yfjQmQ9bFgrzLk/CuAhI2ZmJ31xylMaf3vRgh
        hOMMYzEsST9mnI3Ytqo3ej98O+yy
X-Google-Smtp-Source: APXvYqzihmuSgpK4uTiQr4OSenhWTVQ6e1AQwTrTP3mA5pQw7/YkWGicMVSuF4ADNIdrMkbd7b5t4g==
X-Received: by 2002:a5d:824e:: with SMTP id n14mr6674174ioo.205.1566285533648;
        Tue, 20 Aug 2019 00:18:53 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id q8sm14357321ion.82.2019.08.20.00.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 00:18:53 -0700 (PDT)
Date:   Tue, 20 Aug 2019 03:18:51 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 03/13] t4014: move closing sq onto its own line
Message-ID: <a205a920bdd310df043b49ba74469ffbc88d7573.1566285151.git.liu.denton@gmail.com>
References: <cover.1566258525.git.liu.denton@gmail.com>
 <cover.1566285151.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566285151.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The usual convention for test cases is for the closing sq to be on its
own line. Move the sq onto its own line for cases that do not conform to
this style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 62f5680f05..5e8eb6fb27 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -790,11 +790,13 @@ test_expect_success 'options no longer allowed for format-patch' '
 	test_must_fail git format-patch --name-status 2> output &&
 	test_i18ncmp expect.name-status output &&
 	test_must_fail git format-patch --check 2> output &&
-	test_i18ncmp expect.check output'
+	test_i18ncmp expect.check output
+'
 
 test_expect_success 'format-patch --numstat should produce a patch' '
 	git format-patch --numstat --stdout master..side > output &&
-	test 5 = $(grep "^diff --git a/" output | wc -l)'
+	test 5 = $(grep "^diff --git a/" output | wc -l)
+'
 
 test_expect_success 'format-patch -- <path>' '
 	git format-patch master..side -- file 2>error &&
-- 
2.23.0.248.g3a9dd8fb08

