Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 114C51F5FB
	for <e@80x24.org>; Wed,  1 Mar 2017 11:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbdCAL1S (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 06:27:18 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35335 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbdCAL1R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 06:27:17 -0500
Received: by mail-pf0-f194.google.com with SMTP id y23so3385253pfk.2
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 03:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qz1aYMwdBv7OPrJrTCAl6921luIiLeXbr0DZrEOlL/w=;
        b=LaRPnE6KQiwFwjL8in3PTJLdO0Alou2opRAU6MA4J6ZnOOHqD6kd421r4+eO5LV4s7
         xKXh4/lK79y15JV3DEkuXYYFJ5E3jzUeZW8eTiv90e5jwLTJ82ntd1SucLL34wunX7zW
         S9eTLlYWEnV2Udz5p54od6R46Mi4KvkvAzUdAraBFfmLTO+S8xiD1Qr8v6qFTR2IgCfy
         tB/DbDvZaT+AG/NVYQBMJbhjx3d+K6ukgcP1lxmM4y/KpC3tCRxjH1Ib2bXADaMdiLA/
         40uLuEnDUUVUd0EpNK/dtuCqPcylrVAYgfDGTtqVKCst1TDgVFnI2CWS99PacPbTqle2
         6OGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qz1aYMwdBv7OPrJrTCAl6921luIiLeXbr0DZrEOlL/w=;
        b=aHkzSG4K8zpW01vwEfqGzelW4LQpjH3ByD0RTjUR4vriCLbb3celH88vwSLVPGxAWi
         OF6PDdtcjLcWfcdqMYimZHvIJxfdDKzUPG3CPzhI8Yv7pF15qw/zFAfW6YapFiWGzH3T
         6gGjmPZ2XdvLv4XQ/RpQk4PExWdIHv2BjQOwDBUqDcHmmcchgtFN9hFjMXD5VOJjPy2L
         dCbD5B6m2o55DRPpGPzFEz/bVUJAA67qfDDXEYinKDljCb8z7PeVvq8pZCRqk1p71je4
         JHYSlmnjcyy8iIhF2kOnh5a7kSHtNlMnTqIiszUmDYnJC1/XwDswk2HZ+jBDtKBTSB5r
         /R0A==
X-Gm-Message-State: AMke39mpkUra10tWUkqNU7/momxU2mRORMVk/X11a8E5t61IDFTZuMy6mQ4q9QwFtnDIFg==
X-Received: by 10.99.127.71 with SMTP id p7mr8158045pgn.125.1488367610810;
        Wed, 01 Mar 2017 03:26:50 -0800 (PST)
Received: from ash ([115.73.169.226])
        by smtp.gmail.com with ESMTPSA id a2sm10006295pfc.72.2017.03.01.03.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Mar 2017 03:26:50 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 01 Mar 2017 18:26:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Philip Oakley <philipoakley@iee.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 1/3] config.txt: clarify multiple key values in include.path
Date:   Wed,  1 Mar 2017 18:26:29 +0700
Message-Id: <20170301112631.16497-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170301112631.16497-1-pclouds@gmail.com>
References: <20170224131425.32409-1-pclouds@gmail.com>
 <20170301112631.16497-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The phrasing in this paragraph may give an impression that you can only
use it once. Rephrase it a bit.

Helped-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 015346c417..4748efbf36 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -79,10 +79,10 @@ escape sequences) are invalid.
 Includes
 ~~~~~~~~
 
-You can include one config file from another by setting the special
+You can include a config file from another by setting the special
 `include.path` variable to the name of the file to be included. The
 variable takes a pathname as its value, and is subject to tilde
-expansion.
+expansion. `include.path` supports multiple key values.
 
 The
 included file is expanded immediately, as if its contents had been
-- 
2.11.0.157.gd943d85

