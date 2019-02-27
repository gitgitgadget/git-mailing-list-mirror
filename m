Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B97320248
	for <e@80x24.org>; Wed, 27 Feb 2019 08:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfB0InP (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 03:43:15 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:43308 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfB0InP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 03:43:15 -0500
Received: by mail-ed1-f52.google.com with SMTP id m35so13148085ede.10
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 00:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=N04Xb/FgfjCaPjGsez0VHn4zbJf6qZr1oNp0g1aMsUk=;
        b=HnGTxcsw3+C3qpqyGvdydpKfAQRVGpjcdQw8FP7eQeWmS4Gn8MLu+uKVfU2pOZC8fz
         cssPeUaQYl4eJ+5xUzDbMTT86U/t31PG3exVWoFUEEWGV4X5wtK5m11bWncFpgau8RS3
         GZ/f8R/VdtOy+dNo8PAl1AKESlie9avA6cP0QIv72gYaRbV/ORHeNKyxEhsta8rFofxb
         jlC7+hbq4So7a2UmiDFmnjL9TXoGMBUURbZugIgeF3+Wi8LW4JhkExMt1nuXeoeUAr6n
         gbTeILBqp+QlvyaYPJAYzPWVzkXzUe+u6kbOqPZ8JXzbUBy18dA9Yhvl3YFrceTtWHwz
         /qIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N04Xb/FgfjCaPjGsez0VHn4zbJf6qZr1oNp0g1aMsUk=;
        b=bafnLbhPko3pgKkczx9bmrYPWCf3fjotl/UIwzsjDdTMAB6lXd2Eb60U7ITRf3uscb
         MvdSeHnT0zMU92fkRFGKWA5M0leS0nDiigOKYjcwGA7L2RpU6C2X5FWZnPCqVxXGeQxV
         JTNf09Mq3iSIr1RrrJeZIeoDfEfJ9WvvDHI60lblwminaHxZhbDvT+KJoiFfRvocI2do
         KtN1gOL/caY1y48d12qMwGaoq2dcMCGzYkSeFLHZc7G9EGT8oOv+uIhmZ0+XL7KFsj+9
         pTqsefImEQZi9lgEqRkeyKJy/Db8erEyCoC9b/90H2dl6HjOdkV9Fn4kSwL5vOhFwE9q
         eWFg==
X-Gm-Message-State: AHQUAub+Ph1KL+8I72rERVPpcpBhBv2p2++O5SjUqs41A7iEl/31ZsqA
        zBXFN/3OmLS0GuieAtrROCnqDSYD
X-Google-Smtp-Source: AHgI3IabdmA6kzE2WuutainpTajtkZMsQDTgoPD3Yw1lPgslyPh+33wrtCQJdBCOs0YXprMCOI3AZQ==
X-Received: by 2002:a17:906:678a:: with SMTP id q10mr695634ejp.156.1551256993358;
        Wed, 27 Feb 2019 00:43:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h47sm4096092eda.47.2019.02.27.00.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 00:43:12 -0800 (PST)
Date:   Wed, 27 Feb 2019 00:43:12 -0800 (PST)
X-Google-Original-Date: Wed, 27 Feb 2019 08:43:11 GMT
Message-Id: <pull.144.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Drop Windows XP-specific code to support IPv6
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We no longer support Windows XP, and can therefore rely on API functions
that are available since Windows Vista.

Tanushree Tumane (1):
  mingw: remove obsolete IPv6-related code

 compat/mingw.c | 178 +------------------------------------------------
 compat/mingw.h |   8 ---
 2 files changed, 3 insertions(+), 183 deletions(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-144%2Fdscho%2Fremove-ipv6-fallback-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-144/dscho/remove-ipv6-fallback-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/144
-- 
gitgitgadget
