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
	by dcvr.yhbt.net (Postfix) with ESMTP id 84CE11F461
	for <e@80x24.org>; Fri, 12 Jul 2019 15:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfGLPeA (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 11:34:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56183 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfGLPd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 11:33:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so9331889wmj.5
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 08:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LPMPYbj2HdqR+/jqbDIuDnTpVjiYj5AgoE+GY5hm/aU=;
        b=fMnRRQhAP3YH5/+MHKZ/RQ8w9IjNXiVly2YITGG+behizJXnnfcXGIaR4jfD74wEeC
         qwUJiNeGdBiMLCT8UJHzT1T2n01qv/bpLbEE3bJZxn8/XB7jzaR4dSGE4lqdejXPsyZf
         mtlnN+ULrm1HCWrK3O9O5v6uEHp5jMQ0ZjHI2IaoVEM2YrgQOKL6W1PrVJaTHN+Lr4dQ
         YzY+9+IbSsTaoYXUvkh9KjKKn8QGVW/QFnm+g8HQdCcOIO+ZiHTOeE2w5xxEPcfagD3e
         o/lYXWrKtwTbymgkRsDzn6SJ0T4TKU/oQYwedve3cIhN524fczaGDU6JR2uSTTd9QsYr
         pi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LPMPYbj2HdqR+/jqbDIuDnTpVjiYj5AgoE+GY5hm/aU=;
        b=Lm9w5+C1ra6Y3EPwU//QtI1oZBVJO7cVsG4gQ4UhPjZqFakkFvNlhh5ATYrE2Uwq5u
         Ct7sJNWUFm7Jb/bFcFDO9lmskfZ0JOZkNsGpu6MhuyntE1N8jsKbDpWO4p3G408WeudC
         z1dxlM7qdVTt/Fer6nH4My8h5ippWa9TAOkIAObT774MQoY1zqnRTjdqWB7e1Ug+rggL
         uFGWNFmN35jsqGaj80WGWSzz+TSNzJ0Mwd4IeY6vCo7UyrXfsbXQFLcs605pQXUQ3UHi
         sYp5zeCkLRDFk0bcsSoYUoy1j6XgZf/ek5hz01hazeYsuqy9KSUtjsq5AFN2aY58S5QC
         hJmQ==
X-Gm-Message-State: APjAAAXX37xXD2vcI+TuDzGdvI0a/XF5Htc8pBwwu5mfnVVDnnuBZ8ZN
        c88Kh6CZSo6c8LKpTOG5evEUDOQG
X-Google-Smtp-Source: APXvYqy5jE53QlplotM73BwVQKVEL6NvPuB4xIyB0A7P22SvDuokeXXmXj2SJezTtci+0fseo1/RqA==
X-Received: by 2002:a1c:f116:: with SMTP id p22mr10103799wmh.70.1562945637700;
        Fri, 12 Jul 2019 08:33:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7sm7666295wrh.67.2019.07.12.08.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 08:33:57 -0700 (PDT)
Date:   Fri, 12 Jul 2019 08:33:57 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Jul 2019 15:33:55 GMT
Message-Id: <e2daf21f1f2574a79f83d4e66591f67b1c937efe.1562945635.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.285.git.gitgitgadget@gmail.com>
References: <pull.285.git.gitgitgadget@gmail.com>
From:   "Robert Morgan via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] gpg(docs): use correct --verify syntax
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Robert Morgan <robert.thomas.morgan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Morgan <robert.thomas.morgan@gmail.com>

The gpg --verify usage example within the 'gpg.program' variable
reference provides an incorrect example of the gpg --verify command
arguments.

The command argument order, when providing both a detached signature
and data, should be signature first and data second:
https://gnupg.org/documentation/manuals/gnupg/Operational-GPG-Commands.html

Signed-off-by: Robert Morgan <robert.thomas.morgan@gmail.com>
---
 Documentation/config/gpg.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index f999f8ea49..cce2c89245 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -2,7 +2,7 @@ gpg.program::
 	Use this custom program instead of "`gpg`" found on `$PATH` when
 	making or verifying a PGP signature. The program must support the
 	same command-line interface as GPG, namely, to verify a detached
-	signature, "`gpg --verify $file - <$signature`" is run, and the
+	signature, "`gpg --verify $signature - <$file`" is run, and the
 	program is expected to signal a good signature by exiting with
 	code 0, and to generate an ASCII-armored detached signature, the
 	standard input of "`gpg -bsau $key`" is fed with the contents to be
-- 
gitgitgadget
