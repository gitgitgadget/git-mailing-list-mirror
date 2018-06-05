Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F1281F517
	for <e@80x24.org>; Tue,  5 Jun 2018 19:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbeFETyz (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 15:54:55 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37076 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbeFETyy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 15:54:54 -0400
Received: by mail-wr0-f193.google.com with SMTP id d8-v6so3707445wro.4
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 12:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AopLXcbByy/MiHrT3wzXJny9/g++5a0kFUa9dshBEi0=;
        b=HqLnZxch2nvfpI4wV1H7GpSp2/yE3LIRjF/8FlMeyyNImXTaVIdP2ESKKsN6LHw0fW
         6OWR/Mf/NyppPCwJuKDo54QrDhsc3zoqWPT1zQMMZOQF2G+gfQKFtqlATObULxDzT4Ct
         tNR1KiWNo1nvmDbPSzviE3XtsbYSdTRHnPD4I7l/gf0HJPk8yrKwjI2Kp6mHffILPUr/
         fkYdfMNKq5v0bW2HURAW7QpIclezo7Z/ceWEw1k1veWZNpKgzelKqpuW+DxIm45Iqt6v
         i5OBzVPiVH87zwGc76Up9Fy3UQn1yJtVJNd9nDt78ScybrYHli1sWdzhjXR7xnCPt2DU
         jdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AopLXcbByy/MiHrT3wzXJny9/g++5a0kFUa9dshBEi0=;
        b=kjbFiaKgwJf29aIsBy25BKw1g/ntb42FTtmueyb8KW+BbTc234Qdgrt6mCd4ts6PTr
         pwWcErDzmqTMrmRyAzd9wWr+ZuL4Kp4+Jmdn5x1Iik81IJiJa4z1fmPPXPQ4igiY35Pd
         vcb+AgGFBA4zLFrPKHyecjlv+AOxOSJ82qs6Fd/XiB0PCP+GjztcNzY7mdaQv+7N6pF4
         6c/SWS2tTEEdDvYreovMJOMe9aa18EUc9oXgwsDk0n/RCj9YChC2ynZEMA0bSl7HETy1
         CyqSl6v7GcjkUdf1pxgJaXgw/SQWRDSPc2wn/TakfGSyCleYJM57bPNxFBsZCtquZssE
         J7GQ==
X-Gm-Message-State: APt69E31gl7elLyY2J6iufDcUkn45z0hC7ZHTUhe3wstV0r477Dj1Ov8
        AO6LEXBly5kq1eacRgQOnukuxXET
X-Google-Smtp-Source: ADUXVKIYhATXSRs3AIEc46WJE0r5g9V5utXD585j6TGV+Hyc393YFGTDGiXWTO6D0OgRBPaU6Rxnqg==
X-Received: by 2002:adf:d204:: with SMTP id g4-v6mr7567wri.229.1528228492263;
        Tue, 05 Jun 2018 12:54:52 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o2-v6sm2252533wmo.24.2018.06.05.12.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 12:54:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] refspec: add back a refspec_item_init() function
Date:   Tue,  5 Jun 2018 19:54:39 +0000
Message-Id: <20180605195440.8505-3-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180605195440.8505-1-avarab@gmail.com>
References: <20180605195440.8505-1-avarab@gmail.com>
In-Reply-To: <20180605162939.GA158365@google.com>
References: <20180605162939.GA158365@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-add the non-fatal version of refspec_item_init_or_die() renamed
away in an earlier change to get a more minimal diff. This should be
used by callers that have their own error handling.

This new function could be marked "static" since nothing outside of
refspec.c uses it, but expecting future use of it, let's make it
available to other users.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refspec.c | 10 +++++++---
 refspec.h |  2 ++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/refspec.c b/refspec.c
index 0fd392e96b..a35493e35e 100644
--- a/refspec.c
+++ b/refspec.c
@@ -124,12 +124,16 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 	return 1;
 }
 
-void refspec_item_init_or_die(struct refspec_item *item, const char *refspec,
-			      int fetch)
+int refspec_item_init(struct refspec_item *item, const char *refspec, int fetch)
 {
 	memset(item, 0, sizeof(*item));
+	return parse_refspec(item, refspec, fetch);
+}
 
-	if (!parse_refspec(item, refspec, fetch))
+void refspec_item_init_or_die(struct refspec_item *item, const char *refspec,
+			      int fetch)
+{
+	if (!refspec_item_init(item, refspec, fetch))
 		die("Invalid refspec '%s'", refspec);
 }
 
diff --git a/refspec.h b/refspec.h
index 4caaf1f8e3..9b6e64a824 100644
--- a/refspec.h
+++ b/refspec.h
@@ -32,6 +32,8 @@ struct refspec {
 	int fetch;
 };
 
+int refspec_item_init(struct refspec_item *item, const char *refspec,
+		      int fetch);
 void refspec_item_init_or_die(struct refspec_item *item, const char *refspec,
 			      int fetch);
 void refspec_item_clear(struct refspec_item *item);
-- 
2.17.0.290.gded63e768a

