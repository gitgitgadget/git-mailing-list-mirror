Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 824DA1F576
	for <e@80x24.org>; Tue,  6 Mar 2018 10:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932071AbeCFKQ2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 05:16:28 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37617 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeCFKQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 05:16:27 -0500
Received: by mail-pg0-f66.google.com with SMTP id y26so8088480pgv.4
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 02:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=edyG/xTj6hXkCEXNgfjwyap31K4ITCwDJR7U4ZSaSIk=;
        b=KbLY+Ea3U1Vh7dw0r5ZsUZ+15kofrdal120HXqja8bEg8oPTaqncwpbcPY6QTV7fAQ
         Q5sik1PT6BMB7fKSCSuVpJnjvKYYa5ILXgtWP3P5X0vhZL6ssGo1M5EHEc2s94fTenK9
         FSNQ35/qwW7KbQF2Ci0MHoxnkD27Ddu5K76vhD3G5XrKYs+6kmAPZxQ8iBdlwZ+3LmW9
         I+zzfbYJgy7baR9LzwIME20PMN9p5fF3Pl6AO20uolzv325UL0wIrbzBIIoy+yc63czO
         2T18b1xXltXRI/Y7Cksf2Ne1ABPEYXT518t+Ur+MDQHC1/wXYD4Y/d9gKJ2fWzI5lwzf
         vi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=edyG/xTj6hXkCEXNgfjwyap31K4ITCwDJR7U4ZSaSIk=;
        b=YzSprv1nCBtBXrb6n5+a6Ch+BT6XtbfV8jbyAf2sWdZqXSVzp5OefufggU3uecanLi
         kP7IuMJalkQpD599Gtwtgyqv+RQTZZ741Zh0OTpJqT02c0LIpYoeVEtiZ+ByAzC/pbnH
         xd19ZdK3H5UCkfGuv+jBMqNqgOluh+EXNfMtPzyHqUyurvPfQOXkDJXea2+xt7h2PD++
         Pyp5rc2ZWcxuyUFf/a/Nar26+2K7j32Qu5+2LuH4H341rX+YZ8rRHBbSkdktRDi8t7D4
         vPS6cFotFAFOi/1jlkn59r3t72se1ZongVy0PvTEt7V/TcCQYfbD8cCscIXn9Nf5oba9
         zaUQ==
X-Gm-Message-State: APf1xPDNNAOFB/jf0aexTGrxkDOjWHd5pQLQOEIXYScBZZalvAYtR+d0
        HiQJkWVu+YweA95LimM5KKzwhA==
X-Google-Smtp-Source: AG47ELsG6fOQC1ebW9h/LaXRyq3V4Bhj4lY+eUdzut1ov8np7oZYsoV8ARoyXRC000an4lgv2lfacg==
X-Received: by 10.101.74.135 with SMTP id b7mr14788370pgu.260.1520331387045;
        Tue, 06 Mar 2018 02:16:27 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id p6sm29481454pfg.183.2018.03.06.02.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 02:16:26 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 06 Mar 2018 17:16:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/2] object.h: realign object flag allocation comment
Date:   Tue,  6 Mar 2018 17:16:15 +0700
Message-Id: <20180306101615.5173-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.784.gb291bd247e
In-Reply-To: <20180306101615.5173-1-pclouds@gmail.com>
References: <20180306101615.5173-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some new path names are too long and eat into the graph part. Move the
graph 9 columns to the right to avoid this.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 object.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/object.h b/object.h
index 15901d2901..6f56a86937 100644
--- a/object.h
+++ b/object.h
@@ -28,22 +28,22 @@ struct object_array {
 #define TYPE_BITS   3
 /*
  * object flag allocation:
- * revision.h:      0---------10                                26
- * fetch-pack.c:    0----5
- * walker.c:        0-2
- * upload-pack.c:       4       11----------------19
- * builtin/blame.c:               12-13
- * bisect.c:                               16
- * bundle.c:                               16
- * http-push.c:                            16-----19
- * commit.c:                               16-----19
- * sha1_name.c:                                     20
- * list-objects-filter.c:                             21
- * builtin/fsck.c:  0--3
- * builtin/index-pack.c:                            2021
- * builtin/pack-objects.c:                          20
- * builtin/reflog.c:          10--12
- * builtin/unpack-objects.c:                        2021
+ * revision.h:               0---------10                                26
+ * fetch-pack.c:             0----5
+ * walker.c:                 0-2
+ * upload-pack.c:                4       11----------------19
+ * builtin/blame.c:                        12-13
+ * bisect.c:                                        16
+ * bundle.c:                                        16
+ * http-push.c:                                     16-----19
+ * commit.c:                                        16-----19
+ * sha1_name.c:                                              20
+ * list-objects-filter.c:                                      21
+ * builtin/fsck.c:           0--3
+ * builtin/index-pack.c:                                     2021
+ * builtin/pack-objects.c:                                   20
+ * builtin/reflog.c:                   10--12
+ * builtin/unpack-objects.c:                                 2021
  */
 #define FLAG_BITS  27
 
-- 
2.16.2.784.gb291bd247e

