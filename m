Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2F1C1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 08:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeKLSdI (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 13:33:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40466 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeKLSdI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 13:33:08 -0500
Received: by mail-pl1-f194.google.com with SMTP id q19-v6so3992575pll.7
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 00:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H4ycG+Rfpp5WmJkrPVgCd6ZfzOXPzOwTTc0H/ZYNSF4=;
        b=Xq2IP54cLGHsbGyeYuKGFdzBl3KdQGDQlIHFl9PMazXKOkJKmCzGeg+2DEh38vaBwV
         e/yl54WbSquzCJs40xHxN/7G6C9sWTdx19lQilLH7gN+OEdFBSHTnZVTYSbrqbdkqATZ
         sCSC8J01t91qFGhiAr92X9YBuwEnuAFb/IKGc8yULyTn5VjAVSBR9+3B31Ui6osH4Rh5
         /FYmvLnPmCFFjbQHRjpVpTwZbF+vQqUVljv869dmGCdplbv8q6OT1XwPMm8KCnCWmtSp
         rxrx3G0QOsDAwmpQBd0GH4Jpcthoba3dr/dZYi7Vcw/6YSj5AKIwselhCK3bO2VoESAQ
         omYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H4ycG+Rfpp5WmJkrPVgCd6ZfzOXPzOwTTc0H/ZYNSF4=;
        b=HZYDdy5eE2aSpMWZhotXBJNpMTZgy4ki6ZSeKqNAx+u3h3qyHyAdLyLcEUvl6x78WU
         qS5SgPTfCEwYJ0+5UkeShikOxNB9h83esXyOBhcMsfQqldLKhPlX23Xn26vCf+QOw4QU
         3oab2hTU8F/KHL7A78I3DKBQNeI38bxAC99rhRnywivjVox+Ymt246T/UviYm4Ld/+cY
         UbFKTrQMluxhuHEW1s8FZNhGqzvMx8qJwJmhoygiNFWFNN3EMwZf57IbcZTbhnWiSbTP
         ktOfUTcX+RzBVvVj7JyZ1ZDSWL81lhyIdlasMh/JgiE2aMTyRedhOCAEqRSzCfzOGtDh
         OjOQ==
X-Gm-Message-State: AGRZ1gLgeEGlyRLrZQH5TRW8+GtHTm/VbKjvVfe4q8sSQwqXoCGwXXD0
        j5aN5zqABtIBx7fMJlmL6z2KV7nv
X-Google-Smtp-Source: AJdET5c1+8Yci2rj4Pxt3QArUhVaOM4Z0a+8NlnfAVlqGuezEgs1h7bYlZvcGzuNe9WHP/+BMHgi7A==
X-Received: by 2002:a17:902:14e:: with SMTP id 72-v6mr37070plb.299.1542012058285;
        Mon, 12 Nov 2018 00:40:58 -0800 (PST)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id s186-v6sm35041337pfs.164.2018.11.12.00.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 00:40:58 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, johannes.schindelin@gmx.de,
        peff@peff.net
Subject: [PATCH 0/2] avoid unsigned long for timestamps 
Date:   Mon, 12 Nov 2018 00:40:29 -0800
Message-Id: <20181112084031.11769-1-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

specially problematic in Windows where unsigned long is only 32bit wide
and therefore the assumption that a time_t would fit will lead to loss
of precision in a 64bit OS.

 builtin/commit.c | 4 ++--
 read-cache.c     | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)


