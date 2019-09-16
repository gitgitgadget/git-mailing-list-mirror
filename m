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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FBEA1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 19:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390906AbfIPTXS (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 15:23:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40248 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387404AbfIPTXS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 15:23:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so505757pfb.7
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 12:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F3x4eGXrbuHbyFyJMwQY1+2edjqDt14ME4fASz1KF7U=;
        b=ZtMNvg1EIlK3m6W3hyprC8ZEUOjMGHdRtKe2G2JGsFZKqz23K1vIQluSA5v3XHdIDv
         8PhY7/JJGlIS1gpXV1dYnciNHizNeawLZ1fk+jL7h4QWEzZzI49Xqp+VDNrlN1dRHR5J
         sYQ+c2N5Y+fpOfuOsDxgnsS/TKNiwxaSoPsVjCnuP+cZJ5Nbglgnm8DLF9Ua1gIZ/pTy
         +k3bNL0P4cgDkjTJyV/+MweUt6RhjFch4mT/uq+nQ3fYXEHFx8cSqHMrElKAqv2mIp42
         RasXU2F9y+jWGzDdScuD4Q8uqNv/3/tv5969QDxbGVAaIvFwIZICdNPC+cFK3PSBK1SS
         tofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F3x4eGXrbuHbyFyJMwQY1+2edjqDt14ME4fASz1KF7U=;
        b=Hu8zmDaqIy31fuWXiUNfSQR/UVE44j/DfHFGRBPdP8iizDk1fyXA3kw+nDuip8ZQBC
         Ck6hcExZ/VXT2S9H3m6wCLKjI2eqb24Hx/Hp/cT4oEiemLcLLUw0vWoNCwna+XYR/gxY
         BkLmGTmZQ3DSwPF+TMe9XHpCkm5NLADEk8ehWc8qPmax7duVTrgF3O5X41uchqNqms0H
         Z1GCInC8KqVm6n+Zzn7ElLIQxnWBuprWnykP9wmMs0Df/7tUPsuFQWN7c9uCbpmkMkB7
         0oZNE+ugfQLAgu3E0kA610OZbuJi4qBKDDB5/KjTemH91teX7kgXV6SehmDSt7D/nqHB
         c7VQ==
X-Gm-Message-State: APjAAAWJ/i28ovCkyepp42YvLylSN3uA8xUhpUP7eB3C3DvCXsD2iFEu
        vQtWnnDkJhPvzFy0n+xhOm9k3Jx+NNY=
X-Google-Smtp-Source: APXvYqxh1FKDnzjbs6g+qL0ssujqfiq4Qwv5Wl98QHC0XHouxcdwLYy63sG7Y7+7iX+69LiwEUSI0g==
X-Received: by 2002:a65:4841:: with SMTP id i1mr712949pgs.316.1568661796600;
        Mon, 16 Sep 2019 12:23:16 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id a4sm7172740pgq.6.2019.09.16.12.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 12:23:15 -0700 (PDT)
Date:   Mon, 16 Sep 2019 12:23:14 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/4] Makefile: strip leading ./ in $(FIND_SOURCE_FILES)
Message-ID: <71861cbdf833c8c9300c6b45930b29655f5de611.1568661443.git.liu.denton@gmail.com>
References: <cover.1568309119.git.liu.denton@gmail.com>
 <cover.1568661443.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568661443.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, $(FIND_SOURCE_FILES) has two modes: if `git ls-files` is
present, it will use that to enumerate the files in the repository; else
it will use `$(FIND) .` to enumerate the files in the directory.

There is a subtle difference between these two methods, however. With
ls-files, filenames don't have a leading `./` while with $(FIND), they
do. This does not currently pose a problem but in a future patch, we
will be using `filter-out` to process the list of files with the
assumption that there is no prefix.

Unify the two possible invocations in $(FIND_SOURCE_FILES) by using sed
to remove the `./` prefix in the $(FIND) case.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 49839579ec..20eb5c5c42 100644
--- a/Makefile
+++ b/Makefile
@@ -2612,6 +2612,7 @@ FIND_SOURCE_FILES = ( \
 		-o \( -name 'trash*' -type d -prune \) \
 		-o \( -name '*.[hcS]' -type f -print \) \
 		-o \( -name '*.sh' -type f -print \) \
+		| sed -e 's|^\./||' \
 	)
 
 $(ETAGS_TARGET): FORCE
-- 
2.23.0

