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
	by dcvr.yhbt.net (Postfix) with ESMTP id D07281F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 00:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfKSAVS (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 19:21:18 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37254 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSAVS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 19:21:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id p24so11209899pfn.4
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 16:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MDuAzZQiH88nBgRfNS4JNxLwLLp5zSt8Y6JcUoOkwUs=;
        b=hGAX3H8L7dKkSL1GUWhYbgkQRjHivCsAAdHN8WpACsbZ2PAi151ncqXDVRir6pOzcb
         FbeEvHF8+kg4hA414CdfV9Ngwb3n1/2uRZk8TiqWaOegmN4On7oZX6jEiOJfdY/6V8A7
         RyoQn0xLSIpaa65XovpU0in2KiFrUSQtqk4DaMC6MgknxtTiazU9UIBUojZQV2nVGQQu
         KesHoY2lsqMkcZgpkvAa7EJ3L50hwBKMCEDSGqJqWklDLDBl0iLtph1PFHpoa0M7kT86
         pXuFASNS0D/kgS2ereKC/dU554+6DXTDp1GAZKnsRSZNLyBqNTgfDJxaHWSCoHdMPOq8
         95xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MDuAzZQiH88nBgRfNS4JNxLwLLp5zSt8Y6JcUoOkwUs=;
        b=H6hbcWgykcLLApYyCzpgzcK6CmjVBM9bqvdHWKzGKYZ1dUsdZBN9/HtrN4vYwVUXrk
         Whqlmw9bxTkx1ujAkMKscvLiU2EZ+1gvxru0KRZD9QTZE6e3EPc1HD+9GOSJRUwh9CWh
         yH4bdF4p2gf/YloxLdyGoHFeMJgXvA6qIrt/40MCon0Rvnwttpx/Qvzh0PSt6ch2tWaW
         kTLqa5Dy2QO/UzKNlcQ3KudtUKI/hBeyWb3jatAFRQDmTqFSDh5KQXY6jkog1aAA2E9K
         Bw1iAOkWB/RXFJeEJUhXFzMHdlrvQ00E9YTWtW8MVxWpZvKY9o8KNtk5BwKOWmQhQ4rw
         HQFA==
X-Gm-Message-State: APjAAAUVB1nMarQUqReOBxOq7tYlvQyAD0q0k4Rfv9wHNx+gKibhN5HC
        Hx2T2OpTMDIZL4LU0bi/LkkH12jn
X-Google-Smtp-Source: APXvYqxEl9zbpnbSZYlnaj32Yzaa6xE/VL0HccygGosR1U0rvBCSaLPFr4M1BbX7X3ufTBQJto+x1Q==
X-Received: by 2002:a63:225f:: with SMTP id t31mr2261283pgm.358.1574122877160;
        Mon, 18 Nov 2019 16:21:17 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id p7sm662948pjp.4.2019.11.18.16.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 16:21:16 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:21:15 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v4 03/11] SubmittingPatches: remove dq from commit reference
Message-ID: <61e1a25f93577ca755f0f8b4de6ce9ea00a7ab31.1574122784.git.liu.denton@gmail.com>
References: <cover.1573764280.git.liu.denton@gmail.com>
 <cover.1574122784.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1574122784.git.liu.denton@gmail.com>
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
2.24.0.420.g9ac4901264

