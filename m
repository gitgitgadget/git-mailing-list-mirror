Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 293C0202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 23:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbdIVXhi (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 19:37:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34275 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbdIVXhh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 19:37:37 -0400
Received: by mail-wm0-f65.google.com with SMTP id i131so2483634wma.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 16:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NEt96ypzlZk4NLuRKT1lAjuYpZXc3V7BM8vJKLLpUFY=;
        b=pEOggOF/aAOWOcQbiPQL4f8I40+bg9ueA7/GAQoK9i5JXH7Ne+4Rcgy0B1BlueZ0rO
         H3Y0i+EK57Emd73Yy8gYjizTaSa77OWzm02nh1PQEh0LwPCugCEGKbwoD/OgqMiMWSY4
         gAbo9IqI0hfRkWsapZdf3g9HD/r3PVgMkv0VIhTM9LgcG2LsPVW/qVZp1ZdUZp4Op+/s
         GLNfm45tKXrk3qHNEbNWi6Di6bQlx1/oCFiqlgkCTthSRFoVEUlRucSJhg7bNQazP08c
         WYgePvqG9MqQ2CDKxHjAXiHAi5+CpXsAR98R5xWzFK2EcoxWc+CJVVeLfXxHl6PWoATl
         driw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NEt96ypzlZk4NLuRKT1lAjuYpZXc3V7BM8vJKLLpUFY=;
        b=dySATPfmclJukgZo/aZcwWNgrWYMtmoYamNIiNiPl4m41OElLfPJBpAY80+PkSRGaC
         FBAozLX0caesBia5ZZw8/+ou/I9P0O5pQ1HVEdrvxHnWgytf20Dofda8G6wbiIlN+yaD
         +BW8xrMh6D0oDjDl4YxVCkUmkJBHsvKBGvWDZZucV+QvBoBT1UczgdLVux4g0V8gKPso
         xc0I3ooUi87sOauqjiMK2JaWdSz93zeuDevjKJV+pfjXYNEbIr6XYC4Bcvqb4L5DGB8Q
         o99uZyKRL7VwVm8sGfyMJTZASIlOZrNWQojxKsMj3dtb3bIofIYYKqOJJ7YKqVpwj52h
         nC/g==
X-Gm-Message-State: AHPjjUgNoElnd2sbuycHrnsDLyr67xhml072mpBcVe/GlFqw3HI5lezW
        7164r2YWK6DlF9wUeUVykVU=
X-Google-Smtp-Source: AOwi7QD7Sk8LGhd4dGs2TTN5a5IuWWmp/8VJu3yu3fl/H8u2ygNJPuSKHdAjeAP1OupjzIWy7LBedw==
X-Received: by 10.28.58.136 with SMTP id h130mr4717616wma.56.1506123456616;
        Fri, 22 Sep 2017 16:37:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id b47sm1053276wra.73.2017.09.22.16.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 16:37:35 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     David Turner <David.Turner@twosigma.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 08/12] fsmonitor: add a test tool to dump the index extension
Date:   Sat, 23 Sep 2017 01:37:07 +0200
Message-Id: <20170922233707.25414-2-martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
In-Reply-To: <20170922163548.11288-9-benpeart@microsoft.com>
References: <20170922163548.11288-9-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22 September 2017 at 18:35, Ben Peart <benpeart@microsoft.com> wrote:
> Add a test utility (test-dump-fsmonitor) that will dump the fsmonitor
> index extension.
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  Makefile                       |  1 +
>  t/helper/test-dump-fsmonitor.c | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 t/helper/test-dump-fsmonitor.c

You forget to add the new binary to .gitignore. (In patch 12/12, you
introduce test-drop-caches, which you _do_ add to .gitignore.)

Martin

diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index 6f07de62d..0fe2e0440 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -6,6 +6,7 @@
 /test-delta
 /test-drop-caches
 /test-dump-cache-tree
+/test-dump-fsmonitor
 /test-dump-split-index
 /test-dump-untracked-cache
 /test-fake-ssh
-- 
2.14.1.727.g9ddaf86

