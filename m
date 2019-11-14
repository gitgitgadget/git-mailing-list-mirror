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
	by dcvr.yhbt.net (Postfix) with ESMTP id B94201F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 20:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKNUrQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 15:47:16 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34793 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfKNUrP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 15:47:15 -0500
Received: by mail-pf1-f194.google.com with SMTP id n13so5112188pff.1
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 12:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aa+cIxq5zH4k5RObl2etbFumCPktaDe/UVbDPSXwvHM=;
        b=Jt51BRBBak6ZuefArCABHCdycnN+vyU7GWkYLA4rmCPYPwzaGtvQ9aJ5CReBvzqNjm
         POsvpMJ1OflcXO3dZvj5uxYCsg58b3UYHrxGvaQg2d3VLMn8Dwhjo1Q/xx4l4qiLAE4x
         KHk4KAI2FYjJOtf+gqsNvR5R1fBxbApss7SS+byINF/tgYsod7Cc0VP8Gg4rZV40t5a5
         er/nNLNUUDACVc6n7mVSDF4dd97d1VCFlb4KGGxX5f4nmHZXIWCevD1nmwjY3pfripEH
         sofZXnjk4LrHzz70p3m0emt1wu4BAY1kqPT+BJvJIfeLni/gb1qwW39LyfhP0sK2XJkE
         tcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aa+cIxq5zH4k5RObl2etbFumCPktaDe/UVbDPSXwvHM=;
        b=JXNFbCLQzuzIkzWK6klkZ36/oR6i4gqkfv3bdaqo71RXKKRkoan0x0sdHqi2+NDAEg
         X2t6MCGXDXxWd2QHd3WZkI7c9g0wnemF3qgQLGOJ+QbhOBOzz8EwITSp9Vnmnb3dYBKf
         1nQiB+8Ec8E4JinFHk5chaQp8pPY1LD38c2h/0BtYibXf2P6ptRCS15ksUcPoqULhnNv
         z8vjz9niZnX/djm55CoQn9hvOdFUDcIXKGme/87NTiemgGyvsC84D6T96S+3/zl7V/72
         OW+yzBWhEHi8z6FyfZkix3ttcUOXRSDhXqlouyNSboGh8Xln9+b9aD6ncBXvneUr32Tm
         mvfQ==
X-Gm-Message-State: APjAAAU8BJniC2Ma05gogLX2z0yrJTHhmj5e3DEWV8NTDEIYiDhYfN7b
        CiGvasoHEcKQV8uU6cuAiZjEAVrJ
X-Google-Smtp-Source: APXvYqzrXXSpSyVbsb3+bNkTnZxPdaCrunWHvTCNlWX3VoJsVaOXBet/gAslzqESNV0Mlgi76hp5OA==
X-Received: by 2002:a62:75d7:: with SMTP id q206mr12722687pfc.232.1573764434548;
        Thu, 14 Nov 2019 12:47:14 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id k84sm10085470pfd.157.2019.11.14.12.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 12:47:14 -0800 (PST)
Date:   Thu, 14 Nov 2019 12:47:12 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 03/10] SubmittingPatches: remove dq from commit reference
Message-ID: <277d2b2506da5c67044dc684adaba3ec5e0640eb.1573764280.git.liu.denton@gmail.com>
References: <cover.1573241590.git.liu.denton@gmail.com>
 <cover.1573764280.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1573764280.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quoting SZEDER Gábor[1],

	SubmittingPatches is simply wrong: our de-facto standard format for
	referencing other commits does not enclose the subject in a pair of
	double-quotes:

	  $ git log v2.24.0 |grep -E '[0-9a-f]{7} \("' |wc -l
	  785
	  $ git log v2.24.0 |grep -E '[0-9a-f]{7} \([^"]' |wc -l
	  2276

	Those double-quotes don't add any value to the references, but they
	result in weird looking references for 1083 of our commits whose
	subject lines happen to end with double-quotes, e.g.:

	  f23a465132 ("hashmap_get{,_from_hash} return "struct hashmap_entry *"", 2019-10-06)

	and without those unnecessary pair of double-quotes we would have
	~3000 more commits whose summary would fit on a single line.

Remove references to the enclosing double-quotes from SubmittingPatches
since our de-facto standard for referencing commits does not actually
use them.

[1]: cf. <20191114011048.GS4348@szeder.dev>

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/SubmittingPatches | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index bb7e33ce15..7860dd2568 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -142,19 +142,19 @@ archive, summarize the relevant points of the discussion.
 
 [[commit-reference]]
 If you want to reference a previous commit in the history of a stable
-branch, use the format "abbreviated hash (subject, date)",
-with the subject enclosed in a pair of double-quotes, like this:
+branch, use the format "abbreviated hash (subject, date)", like this:
 
 ....
-	Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
+	Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
 	noticed that ...
 ....
 
 The "Copy commit summary" command of gitk can be used to obtain this
-format, or this invocation of `git show`:
+format (with the subject enclosed in a pair of double-quotes), or this
+invocation of `git show`:
 
 ....
-	git show -s --date=short --pretty='format:%h ("%s", %ad)' <commit>
+	git show -s --date=short --pretty='format:%h (%s, %ad)' <commit>
 ....
 
 [[git-tools]]
-- 
2.24.0.346.gee0de6d492

