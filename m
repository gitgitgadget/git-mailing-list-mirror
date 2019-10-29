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
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D881F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 16:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390595AbfJ2Qyg (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 12:54:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39213 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390580AbfJ2Qyg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 12:54:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id v4so9990245pff.6
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i9fAyAaIvZ+v1sIiOPoN9H0rLrbx0kCRyd+kDMXMeu0=;
        b=P038VewfvizR/DCgzFsCIXPDsSQA6UJ5pTn1k+Our+jysORq06HE2PXBjpHTVByIRJ
         iUFpEZvgKqA+5/Y2NQLqvtRYBRrC2aCPDiwoZfmECFQJJjtDK3TVgyqRBWeRS704s0Kh
         OrfmVdLkMY48tLb4qZ2j37r2ZzxEl/6PcI1TWoLVAipV+6V3wbWcI+aUUMSPGqMEZaZ4
         TmWIDS1jNghLiyX9wIDlJcjcHQ7R09yVC+W6vj1jFGgDv/2JzRTBxbdhrMC4LYjKmUOw
         QHQRHpGKz4MZ21/cXi3mhtAKp6y4aUkv2oURgZyhL9J7sX4eRLVYEKSXSqZlf/XlLVJJ
         KHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i9fAyAaIvZ+v1sIiOPoN9H0rLrbx0kCRyd+kDMXMeu0=;
        b=nMJAK6qrVvrtq0EuVLejm9sAbmIxiC7cxGUmT3P040zFH+RXJXH2BjoaVZss4uBAEX
         u21oE11AqsV13Zr9QctUcipf3yKpb9HLm6JJh1oQdBdE7b2d+quVDyD0p9xhF8UaENZ3
         sapv2j20+UXCMHLXWmAq28au2fjAlNzogRcg0SKAeAQwQgn067C+q9uj6U4FWVpxVFNS
         ZzP8Bca0+vPQo6pMRjNeBJNu/GeKmh64/FzstyeqDL4oHkmNcA07im5xdmge4Uylh6Ck
         59mj9dI99Fowc5rEXz9/M/HBH0pvkNQ5r/6TOhjpLVDqaaeh00y0awIpkq0VwE2i0bu4
         1DqA==
X-Gm-Message-State: APjAAAUh2EMNeSTRft324fhgiA6yhHp2H5lTZ3deLNQxDAsiv/fQiRs2
        o9vF7fZHXyeGwlfNeFfOER+PaXJJ
X-Google-Smtp-Source: APXvYqwTf5DypMOS3rsCNPS8/RshjfuNQxULis3y/iKGsCL4E59VfxxxtJ+NOysnwmYIDOGA8gOezQ==
X-Received: by 2002:a62:6d41:: with SMTP id i62mr29198068pfc.38.1572368075218;
        Tue, 29 Oct 2019 09:54:35 -0700 (PDT)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id f15sm14482452pfd.141.2019.10.29.09.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 09:54:34 -0700 (PDT)
Date:   Tue, 29 Oct 2019 09:54:32 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] git-diff.txt: document return code of `--no-index`
Message-ID: <ed9f16c30a0f3852abaf0053d8c2b4a0ecd12f01.1572367897.git.liu.denton@gmail.com>
References: <3f6d132663cacde01df68bfe88c6ef108cf6cf74.1572337045.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f6d132663cacde01df68bfe88c6ef108cf6cf74.1572337045.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Within diff_no_index(), we have the following:

	revs->diffopt.flags.exit_with_status = 1;

	...

	/*
	 * The return code for --no-index imitates diff(1):
	 * 0 = no changes, 1 = changes, else error
	 */
	return diff_result_code(&revs->diffopt, 0);

Which means when `git diff` is run in `--no-index` mode, `--exit-code`
is implied. However, the documentation for this is missing in
git-diff.txt.

Add a note about how `--exit-code` is implied in the `--no-index`
documentation to cover this documentation blindspot.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Thanks for the review, Dscho. I guess it slipped my mind that we could
write it this way too. Oops!

 Documentation/git-diff.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 72179d993c..56b396ef81 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -36,7 +36,7 @@ two blob objects, or changes between two files on disk.
 	running the command in a working tree controlled by Git and
 	at least one of the paths points outside the working tree,
 	or when running the command outside a working tree
-	controlled by Git.
+	controlled by Git. This form implies `--no-exit`.
 
 'git diff' [<options>] --cached [<commit>] [--] [<path>...]::
 
-- 
2.24.0.rc0.197.g0926ab8072

