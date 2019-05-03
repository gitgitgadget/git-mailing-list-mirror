Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C82B71F453
	for <e@80x24.org>; Fri,  3 May 2019 08:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfECIBM (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 04:01:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39304 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECIBL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 04:01:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so5539810wmk.4
        for <git@vger.kernel.org>; Fri, 03 May 2019 01:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=93wRixw3kP78ek+3w+QqEagpOsnFZ8kjVPehlIoExyk=;
        b=BOm4bU7Kxzg1BFMp/cuYur1f+2nO87ApBmEKV6Oo4K6Fs1CxyuJ9ZK/oyXIuSjkn0N
         4Gk7DDznXYu7fIkpy2p/5SCUEjsRO3VqNp+r2li3dAkiyHYhtzQofFJYwi2YzAY0/OZ0
         /1yNfypsmcT6QAf87rsJS11MQntLNC1A7u+NKDiDkRxqiU47ggkbS3AnhG9PoodXoRvt
         /DBGa40yv8kVKHtrVTcjbvQlHPwbXPqHlZrN2VdptWTKW7yEavQ8W8rxxy8kZF6QZ4KM
         3pI1Ev3dSfS1E/P10hVYlK9wAqDpfpzsgjt9WhPo+n+gE4qVG9K3chbaZ3zP8t6r2HL1
         /Y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=93wRixw3kP78ek+3w+QqEagpOsnFZ8kjVPehlIoExyk=;
        b=Rth2OwUb3q0EwSQM7gAd1MNoDNhJICl2XGNkYM4uKakyL7/Sp9HLqxGIQww8uzLnRL
         GrSzApONE0jfToqosBvVTHceLdPbPSUgLidZmRti9cXCjUDfaLHMDQyGxDbgnWrisDb8
         TIe/OgmkSq2vNDGQ18//O+4JOAvRUpydyiySqTEKt/y8XKY0/qYUAvEp+akOnW/uRrJo
         cLgAV8Btw7da4a4SGktNZ/hG9bINIMQRe7FmjGOR4WXDRMeIKw4Caz3j/8tT7L+xEuOg
         5N/i6EMMbN7LlwndzHhf/nmK37OWf9zCslxAtn1XssVwUIoyKpnleFY+aEfsyhVoq/GN
         Ccrw==
X-Gm-Message-State: APjAAAX/w/vxDwZ9ngpnB7L3bOpWQCdzL4R+XNp7QfqJwzQo3PSznWUZ
        pF4hZQI4h2yycawlt8AWu/8=
X-Google-Smtp-Source: APXvYqwU8mRhF9wlG+tNQx/DlEtsPrOOdjBVKEyjtC374dITlxTwV3tCBHWm7J8BLMkQmEmIZ79NeA==
X-Received: by 2002:a1c:7406:: with SMTP id p6mr280717wmc.125.1556870470453;
        Fri, 03 May 2019 01:01:10 -0700 (PDT)
Received: from ?IPv6:2001:a62:437:4001:fd44:6515:8790:2e05? ([2001:a62:437:4001:fd44:6515:8790:2e05])
        by smtp.googlemail.com with ESMTPSA id m8sm2337831wrg.18.2019.05.03.01.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 01:01:09 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] cleanup revisions.txt
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
 <cover.1556367012.git.liu.denton@gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <7e9ab65d-aee9-b900-c294-8810e0109721@gmail.com>
Date:   Fri, 3 May 2019 10:01:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cover.1556367012.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.04.19 um 14:15 schrieb Denton Liu:

While reading/reviewing I stumbled across another case for marking optional
clauses. But the solutions is not a one-liner. @Denton Would you please add
that one as Patch 4/4 to your series?

----------------- 8< ----------------------------
Subject: [PATCH] revisions.txt: remove ambibuity between <rev>:<path> and :<path>

The revision ':README' is mentioned as an example for '<rev>:<path>'
but the explanation forwards to the ':<n>:<path>' syntax. At the same
time ':<n>:<path>' did not mark the '<n>:' as optional.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/revisions.txt | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 372b286755..f11d1edc57 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -196,19 +196,16 @@ existing tag object.
   Depending on the given text, the shell's word splitting rules might
   require additional quoting.
 
-'<rev>:<path>', e.g. 'HEAD:README', ':README', 'master:./README'::
+'<rev>:<path>', e.g. 'HEAD:README', 'master:./README'::
   A suffix ':' followed by a path names the blob or tree
   at the given path in the tree-ish object named by the part
   before the colon.
-  ':path' (with an empty part before the colon)
-  is a special case of the syntax described next: content
-  recorded in the index at the given path.
   A path starting with './' or '../' is relative to the current working directory.
   The given path will be converted to be relative to the working tree's root directory.
   This is most useful to address a blob or tree from a commit or tree that has
   the same tree structure as the working tree.
 
-':<n>:<path>', e.g. ':0:README', ':README'::
+':[<n>:]<path>', e.g. ':0:README', ':README'::
   A colon, optionally followed by a stage number (0 to 3) and a
   colon, followed by a path, names a blob object in the
   index at the given path. A missing stage number (and the colon
-- 
2.21.0
