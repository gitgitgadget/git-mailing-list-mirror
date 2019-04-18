Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEC6220248
	for <e@80x24.org>; Thu, 18 Apr 2019 13:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbfDRNQq (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 09:16:46 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44328 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388974AbfDRNQq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 09:16:46 -0400
Received: by mail-ed1-f67.google.com with SMTP id i13so1749689edf.11
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 06:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EVYrdDVhhDgQobJwrRf5o9oEVzcqtEKGkJbLQVHDEzw=;
        b=TswAmPnS+XUOgxQk217STtQaY5fHW1MWljfgb+46sYKBe3v1n9S+RzKM/K9WPcvyuq
         moYHLJc763osmDxg+IFZ+8nDfqx9l/IDEFrN82+lYRhZSw2nYSNI2BiL+6Ds9Tml4N4a
         Do+oxt824wg5NGFsxhHiP0phktNLotiqgbAIiiWZcePL3gfUG7i1WYUvyc3x3Hyg/2dU
         sNphji2HLHQGp/ZYW4zjY8CGQl8nWppdVKnVYJSJAJYXyasB9+ujSSd0BGB/vSub45rA
         K+o+a7HJqhHQ5p1UEt1/cYoCBOvX9BQuHfZ3wGvvOeutB/RX2NviCggxZbxr0+rdvr3E
         Qf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EVYrdDVhhDgQobJwrRf5o9oEVzcqtEKGkJbLQVHDEzw=;
        b=fwkn/r1+7J9u1fRtCtvCW+hKJwqBMF93g0VxhiMcVdnuSv3Zh9M7lF7FJwDBUe8yhd
         FzD6pKJno2urLFN5iNFdJ063KvClWM3JHtFJhZh+axCde3ThYhMZ1W/F0cWLCSAipknU
         gcDvnFt4dpwRwRyO6jFnTUYEw+bY1MBYwyN0pyzvw8IanvYL/PIaeXIO/lcwtYvcMm/K
         p8Hp26I0Poq1VwZODNcfFhQkcl3EkfGpTTk0D7++fGirgyAsWag7vXL7fNhRJZWZxbx9
         Ki0Fqc1HIIwGlG4O4OSB7W01JEn2Yr3H043g4Fg+Z6jKytCOnBz/E8FnVJIYd/vlvK01
         NSoA==
X-Gm-Message-State: APjAAAUEpL5Eu71/GqpbIJZZOlDG1gltz6uzQSjoSkqBtc80vJHymMAR
        2agQ3J/hL1cguldYPOvEjVNd1VOt
X-Google-Smtp-Source: APXvYqx07YbsAbIEH1qGSuognvipATfYd1I3dl0/l1nJyf12qDXsyUWBpSbC2iN0YGDjHQbmZG+EWg==
X-Received: by 2002:a17:906:28c1:: with SMTP id p1mr50617669ejd.85.1555593403296;
        Thu, 18 Apr 2019 06:16:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17sm380997eja.41.2019.04.18.06.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 06:16:42 -0700 (PDT)
Date:   Thu, 18 Apr 2019 06:16:42 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Apr 2019 13:16:32 GMT
Message-Id: <ac3670a8052c9b3ae9bfc383c6a4255128b8ff1d.1555593396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.168.v2.git.gitgitgadget@gmail.com>
References: <pull.168.git.gitgitgadget@gmail.com>
        <pull.168.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 4/8] check-docs: allow command-list.txt to contain excluded
 commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Among other things, the `check-docs` target ensures that
`command-list.txt` no longer contains commands that were dropped (or
that were never added in the first place).

To do so, it compares the list of commands from that file to the
commands listed in `$(ALL_COMMANDS)`.

However, some build options exclude commands from the latter. Fix the
target to handle this situation correctly by taking the just-introduced
`$(EXCLUDED_PROGRAMS)` into account.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e7bcfcaae9..d83104d884 100644
--- a/Makefile
+++ b/Makefile
@@ -3089,7 +3089,7 @@ check-docs::
 		    -e 's/\.txt//'; \
 	) | while read how cmd; \
 	do \
-		case " $(patsubst %$X,%,$(ALL_COMMANDS)) " in \
+		case " $(patsubst %$X,%,$(ALL_COMMANDS) $(EXCLUDED_PROGRAMS)) " in \
 		*" $$cmd "*)	;; \
 		*) echo "removed but $$how: $$cmd" ;; \
 		esac; \
-- 
gitgitgadget

