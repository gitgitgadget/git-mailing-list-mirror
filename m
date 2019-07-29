Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993811F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbfG2UIR (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:17 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:53295 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbfG2UIO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:14 -0400
Received: by mail-wm1-f42.google.com with SMTP id x15so54990563wmj.3
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D4hbnnz1wl16W68xXYb3sjuP3z16WnFfPUUKFYLJTlU=;
        b=fOb4rPOQZUm/MFvj8zm6F9Fzw5sc9zdv3/a13mCs5PTJHxQIL8/MrUsGMTvkOXR2Jc
         fhqGwDbe7XSclyNcBj+ELerrGuhscXEkHds4ViysOetnk2q6QTyymUL0Ms4OAvXNdojM
         abKFnWL+lBp8vMudHaZpihpxoZYkSWK1iFRHERk4oVmdNTQgUYh5h87s97ufU8w2le9L
         RLSOlFZ97wRnJSof79kNEnkipM2KspEUMbruC76FDMrbma/88S/tmVoWKMExhhDIX2Ii
         VRiKBg+AHWbCZbBLutW8koUKUYCL8dMWCw93Bfi2pglWpXYOmJTlr2NK8oENddUf0NKm
         KUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D4hbnnz1wl16W68xXYb3sjuP3z16WnFfPUUKFYLJTlU=;
        b=U0F7Zcic8L881bnC4gCdKYQDe23aGloaKPKR0fTioSyl5qX/TSO/42xOVtLXTVeMFW
         cnadw7/n7TAEJsvOwbXgxlDfV281HQVbqPUL3kLwNfDD84ekLtwg43e1TjlEsFN32PKR
         ICR0CZC9pZraZp49G+DXQlzOg3EZANVUqs0krUqDYI4SKtf+x0XXElsz9pC3biP/qM4P
         qOmpaO9DlvnaOEYGDAeTXEIm0s5rubJMH2lqqLvQtQ32lnfO2Hol0EMex8U/2ba2KaXv
         89Wv9/yxf+J0MoXydCM4Hv+huEuwiNJiz9pStBcQUAB3ZYNQHgjehA3raPXT0dzsBaXS
         bgtg==
X-Gm-Message-State: APjAAAXXo0SZTV5mUxTh72nvl+TaHENHfmn6oU8wW7H5BZLw016VJ4xA
        vAWCVFofRHlqsHZT65uWLSTYpw+K
X-Google-Smtp-Source: APXvYqyaLTTqbTXKwiqUy13sLpNxbzMy1i2odEYZC3qNfBleHKTo58N7VTECYxavymIvpLKl6Rd80g==
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr71157813wmh.141.1564430891934;
        Mon, 29 Jul 2019 13:08:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm54362929wmc.3.2019.07.29.13.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:11 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:11 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:52 GMT
Message-Id: <1d4c5539ef5e9c1e83e0ce6d641c535dabf5d242.1564430879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 16/23] contrib/buildsystems: handle options starting with a
 slash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

With the recent changes to allow building with MSVC=1, we now pass the
/OPT:REF option to the compiler. This confuses the parser that wants to
turn the output of a dry run into project definitions for QMake and Visual
Studio:

	Unhandled link option @ line 213: /OPT:REF at [...]

Let's just extend the code that passes through options that start with a
dash, so that it passes through options that start with a slash, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/engine.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 9bde7ae15b..8bb07e8e25 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -351,7 +351,7 @@ sub handleLinkLine
             push(@libs, "expat.lib");
         } elsif ("$part" eq "-liconv") {
             push(@libs, "libiconv.lib");
-        } elsif ($part =~ /^-/) {
+        } elsif ($part =~ /^[-\/]/) {
             push(@lflags, $part);
         } elsif ($part =~ /\.(a|lib)$/) {
             $part =~ s/\.a$/.lib/;
-- 
gitgitgadget

