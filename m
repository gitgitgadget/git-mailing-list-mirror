Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B8FE202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 21:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932106AbdCHVCz (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 16:02:55 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36342 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbdCHVBE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 16:01:04 -0500
Received: by mail-wr0-f194.google.com with SMTP id l37so5618057wrc.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 13:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qih3TfxlRmrmDv1nkFpREFyZw6ZOp1TzDj6L89pVhtk=;
        b=FLi3yUc+poTLjir25Xn7ZeCRx81rzs9xrhjPOW4HfaVd5LHOoj7p1psoGWnewdcIBD
         M5IVg2oEbrsT12MxkNPIfIeI8HQ0kmNgAJ0sGE/fCRgwh6L18hD5za2x6Q8E2f5+BgMd
         YECkbdTW2Ej8VFWDIhY3qIn0QeIXghhuhIAGeex23ERxaSwdq2crG4NnywggmjM97vuA
         evSNFTPgNls9PpvYNeai9wtVug8ncDjA+SusI8TzcIopwTS6byVGIG6k5mdCbjl5uwTq
         vMikphjlRXDy4pxmCock7qXIzsg7Kh3t+jsFNnj5WKsB1/blZL14Gd95OkQyh8UvF2zD
         1lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qih3TfxlRmrmDv1nkFpREFyZw6ZOp1TzDj6L89pVhtk=;
        b=N6KqS1C9V0J4VijbnnF5K8fPrjGXsxYi0Z4WD/ZdAW9rSoVbTCzr98lLAgxDEeOt6y
         sQgFCgbySjIpXtFLGXMR5S9hRAYAOKbtrXnhQhYME/xbbgnNW2BfWnNbckdrjzHGDf7E
         WZTxq1wPMokqvefp4DIFhU0MQAe0GaCv5gRuin6JWNUPnDt1TQ+9Glgauuc1XK+YXF1T
         G3/P/mnsoVM9iGQb85Pj2T5DRTZmk7blMGl3WyFnwSnkyzjKTimZVPTZ9r+R/M7Vwz28
         zq1ffVWxIBtKXlqXaB7pDJHqWrau29eavfQ8VIULrAJa8iz96u3qNg8TYp5kw1GluYoN
         Hf+w==
X-Gm-Message-State: AMke39kRql1X9c87df77me5TvKrJYUsY9OP90lMMgvcoTPjvybp9tzikeFrPwnYt8JC0nQ==
X-Received: by 10.223.175.238 with SMTP id y46mr6884672wrd.63.1489006404137;
        Wed, 08 Mar 2017 12:53:24 -0800 (PST)
Received: from localhost.localdomain (2a02-8388-0b40-0580-f50d-465b-b746-dc93.cable.dynamic.v6.surfer.at. [2a02:8388:b40:580:f50d:465b:b746:dc93])
        by smtp.gmail.com with ESMTPSA id 40sm5604065wry.22.2017.03.08.12.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Mar 2017 12:53:23 -0800 (PST)
From:   =?UTF-8?q?Florian=20Sch=C3=BCller?= <florian.schueller@gmail.com>
To:     paulus@ozlabs.org, git@vger.kernel.org
Cc:     =?UTF-8?q?Florian=20Sch=C3=BCller?= <florian.schueller@gmail.com>
Subject: [PATCH 4/4] ignore backup files
Date:   Wed,  8 Mar 2017 21:52:55 +0100
Message-Id: <20170308205255.18976-5-florian.schueller@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170308205255.18976-1-florian.schueller@gmail.com>
References: <20170308205255.18976-1-florian.schueller@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index d7ebcaf..a353270 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,2 +1,4 @@
 /GIT-TCLTK-VARS
 /gitk-wish
+*~
+po/gitk.pot
-- 
2.9.3

