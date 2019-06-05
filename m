Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 955EC1F462
	for <e@80x24.org>; Wed,  5 Jun 2019 20:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfFEUKQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 16:10:16 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36919 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfFEUKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 16:10:16 -0400
Received: by mail-it1-f194.google.com with SMTP id s16so5598055ita.2
        for <git@vger.kernel.org>; Wed, 05 Jun 2019 13:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z/GoHw6VmmNs2qhySlFs9Xllm3rJPQWEXqitL+W8ZRE=;
        b=XKK6ciNx9AhnrFIV1j6so9SCIg8G0t7ZOd1G1nzBNYUoNbG99GjxN1c6s8z6lacdcO
         iJbaj9C91Z1cBbnEHA/gVzjiYe74KhQB829nJEW17U9gCDiRB6pkx5p5vb3ymeS1aXdU
         0dXIn1c9QQrK8se8jdC1OZLdEsIo9rWT0Q68o5FOJQvV8YZWSkvPGITExjfbwUKYvX3z
         Tqe6lZI7fyVCCxm4Q91bmbT95HF84o08Vh47pAnhXkFdR5z0SHzHr6LX2kaqvsYfS2zH
         g3bND6suEVumX3OABvDH/CK0bTLQVo1aS2HT/bNpFfiUxlEqdkCF5Se5Fsg4hEKIup1j
         46rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z/GoHw6VmmNs2qhySlFs9Xllm3rJPQWEXqitL+W8ZRE=;
        b=k9QnOr9bdY13hlYQK9yUjFsckWh1flAwguLrB/cJgvt/osoNAIMbqROcIG+W33Qygw
         VTDuwDx5p7wzXwP++Q/vQ3fK3fNa7yZ/6zpFhmRKPjSd4g2QKkb79oljZxB4wXxe487J
         XhFtw4GGO1IOA/GShnU3CUUTEU7ZX9f9SSzWlxqB1dcPtxBnOBVRPDV83KS04SrK4abG
         vxDe2EgDGD/Zt55NcYSu8RWAdx2uM2Uw6gbz5Wq997PqzRvfciKc/RMngjh3ovuL8sIW
         Jc6kj2aWf5nCblkBxqnZqP6jcsuUjtQdXKRxU1tycifYWtlv8YFf1dD/NvcBSUBsQRsF
         YfjQ==
X-Gm-Message-State: APjAAAUA7oQAotU7XKwpSizPB+6sPlaNlf61G2rveB9bv8uu1AiqutBc
        IVmFjIGlwXu64wlDWpDypIdlYFNb
X-Google-Smtp-Source: APXvYqzKD/2OL2tggEhnNJQDe4SMCc87GRmGuvZ7IMk7TjysDZQnipgn1LQv/tVFXT9SB7WxN1N7hA==
X-Received: by 2002:a24:ca46:: with SMTP id k67mr29009678itg.5.1559765415137;
        Wed, 05 Jun 2019 13:10:15 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id r139sm7338934iod.61.2019.06.05.13.10.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 13:10:14 -0700 (PDT)
Date:   Wed, 5 Jun 2019 16:10:13 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 2/2] config/alias.txt: document alias accepting
 non-command first word
Message-ID: <44c4e1c560de607f30eb87234611a5bbc00620a7.1559755652.git.liu.denton@gmail.com>
References: <cover.1559333840.git.liu.denton@gmail.com>
 <cover.1559755652.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559755652.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One can see that an alias that begins with a non-command first word,
such as `loud-rebase = -c commit.verbose=true rebase`, is permitted.
However, this isn't immediately obvious to users as alias instances
typically begin with a command.

Document the fact that an alias can begin with a non-command first word
so that users will be able to discover that this is a feature.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/alias.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/config/alias.txt b/Documentation/config/alias.txt
index 5425449a50..f1ca739d57 100644
--- a/Documentation/config/alias.txt
+++ b/Documentation/config/alias.txt
@@ -7,6 +7,16 @@ alias.*::
 	spaces, the usual shell quoting and escaping is supported.
 	A quote pair or a backslash can be used to quote them.
 +
+Note that the first word of an alias does not necessarily have to be a
+command. It can be a command-line option that will be passed into the
+invocation of `git`. In particular, this is useful when used with `-c`
+to pass in one-time configurations or `-p` to force pagination. For example,
+`loud-rebase = -c commit.verbose=true rebase` can be defined such that
+running `git loud-rebase` would be equivalent to
+`git -c commit.verbose=true rebase`. Also, `ps = -p status` would be a
+helpful alias since `git ps` would paginate the output of `git status`
+where the original command does not.
++
 If the alias expansion is prefixed with an exclamation point,
 it will be treated as a shell command.  For example, defining
 `alias.new = !gitk --all --not ORIG_HEAD`, the invocation
-- 
2.22.0.rc1.169.g49223abbf8

