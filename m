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
	by dcvr.yhbt.net (Postfix) with ESMTP id D78161F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfG2UI1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50195 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730326AbfG2UIS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so54998512wml.0
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4E39/cJgnjFrWFwm9MSBe6qrPTWmtaSUqvous69vE58=;
        b=dwc/zGSxRcPU3dljP2foMBuAxgqtwfSmQIQtrirkuLKY/ppkE+d1eJuYQSEUpSBLC6
         RGJy2j7TyvLcryWVOvYrlAnz4Sa+FPt3QpWgaQD9BfGx1X9eyhUrWKnQcre5d8J42qaK
         rzw8bO3b7KfYYHTNAPjriu/VghHGHu3ILjz+in8Gb/NejJ1FrApXW5iU1SFPKnI28xLa
         1MNBlJSxQ22E5da+qozCOgTB6/CZV9rtuVFkUyZEmCNZwXo0qhSjci1uJczqyfeKSXtG
         I2lWLttUszi3rhvlq+l6kzVRNGqTt0GoK2Zk/4almfWl1ABcSGz2/k7E5VKGucn0m0Ho
         1K6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4E39/cJgnjFrWFwm9MSBe6qrPTWmtaSUqvous69vE58=;
        b=Phqc6ZSs+nbgj8BDC80xWeQmmL/G9a41rMsXuFVPc7MSfg3t05/I3JpP/4tpoR50iS
         Podyebk4wnIK6GjOAa4Qt9eoytkGBdaacueHjeAjasYatU3oEU4VvKodypQg193AW409
         3UN+7IFUEpwlJtbv8fpmMpSwi0N2MvL/tLZREeE8kRmdoySBTXudRRi7G20/6x/cYA2B
         ZMUfMw8mIog2jrWU8TOHW73od3FtXeZiwx3cn2u5yXx4qBAv1Wq0pDZMEXp3kYVj85k/
         UYJbRZV4cYS+I/5CScTFqU6FtnxJJ8s9n16zO82HoTPvNB8irHL+ju3JQOdrH+rVOKQQ
         qVxg==
X-Gm-Message-State: APjAAAVNPKEMgnHvYvH8Xs77OZFajSEaQB0OuGezxPby24VZgCO8gjbD
        Ug/AhC4tH4Yp24xQliqklywcN0VA
X-Google-Smtp-Source: APXvYqyHtLJpHhs6P3xtWGt5sVKXjWxSxuLJkDB4bQc4GCRVLlG++XypmAdoQt7IAWJnKjr5TGuKbw==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr93278676wmk.147.1564430897134;
        Mon, 29 Jul 2019 13:08:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 18sm52685426wmg.43.2019.07.29.13.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:16 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:16 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:59 GMT
Message-Id: <6452dc11bc5f715455318917525e2217ecc99232.1564430879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 23/23] git: avoid calling aliased builtins via their dashed
 form
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

This is one of the few places where Git violates its own deprecation of
the dashed form. It is not necessary, either.

As of 595d59e2b53 (git.c: ignore pager.* when launching builtin as
dashed external, 2017-08-02), Git wants to ignore the pager.* config
setting when expanding aliases. So let's strip out the
check_pager_config(<command-name>) call from the copy-edited code.

This code actually made it into upstream git.git already, but it was
disabled in `#if 0 ... #endif` guards so far.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/git.c b/git.c
index f4c0478f32..3049dae85b 100644
--- a/git.c
+++ b/git.c
@@ -743,8 +743,6 @@ static int run_argv(int *argcp, const char ***argv)
 		 */
 		if (!done_alias)
 			handle_builtin(*argcp, *argv);
-
-#if 0 // TODO In GFW, need to amend a7924b655e940b06cb547c235d6bed9767929673 to include trace2_ and _tr2 lines.
 		else if (get_builtin(**argv)) {
 			struct argv_array args = ARGV_ARRAY_INIT;
 			int i;
@@ -779,7 +777,6 @@ static int run_argv(int *argcp, const char ***argv)
 				exit(i);
 			die("could not execute builtin %s", **argv);
 		}
-#endif // a7924b655e940b06cb547c235d6bed9767929673
 
 		/* .. then try the external ones */
 		execv_dashed_external(*argv);
-- 
gitgitgadget
