Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6DE4200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754958AbcLZKWh (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:22:37 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34684 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbcLZKWf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:35 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so14327206wmi.1
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1hDCe+4kZWo4pLmdintaRER0x8+o2qMc6XMc4w1q4MM=;
        b=hGOoQmJ4GpKqutFbDBcwtupUKtzC/KeFHVl9msnUhNdYqaAHGYnALmI8+dqxFlZyXH
         E9eG0fNE/YouE43+/orw/vS5TsE9MAE97TFijk9FEPloQ5QWEVeq0zjChW+x1KAV9D1d
         MoXRymH+ZMTbnkvOs4c6SdNcwS+ntvbp4lZTzaO/L5jeHK6hlov8GImknEJCS24yWyiX
         /EmqPFiua/wxh1CkOzQbUeN7VhQ4LMIRGLjnBGxPA2p69iB6kQLdPX60Ajty+ksQHtmL
         Ux8cVaRsJiQT92r7LvnFN9DqJY1wr/W6O3BzTMDeMeQad/3DK7DeLHLlHVbYOzWQbv3g
         WBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1hDCe+4kZWo4pLmdintaRER0x8+o2qMc6XMc4w1q4MM=;
        b=YRsqUWTGK8n7qfkx8yhbYElS27JKnI99h0qEb2ZErUWSjIO9P56qOJqOav+Eipi/39
         4YzM/E6EGCNEDyTaWJ+XwosKvDeh4KABbDHqjZ4V0sNMTnDrFsRi6NvPdMYvKWPjkRvC
         HHGfiU/lQVV0DU1Jk61wFuSMYxQw5dstJoVTa402O1q0+Yukow5Hv0f+dmqNuq8o3Rgr
         lCIWSefs5vxJ3X//2ue7jVXJYdCeoN+NwoYc3GB6hwGAf2CCR3n49GC/MlNSFmedeS4y
         PMtZYjrnU9Vd/LMfCq4wWFAU5owxPusjkaQZrd08SlMk/PYUk4raj3fLJErQKBa9EtHT
         CrRw==
X-Gm-Message-State: AIkVDXLKEbOKPKIX4dsaSneuANAuljEUtMxovCclJ+pLCGX0/3A+j19NViRNBB8fBlv7Iw==
X-Received: by 10.28.54.195 with SMTP id y64mr12800239wmh.10.1482747753821;
        Mon, 26 Dec 2016 02:22:33 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:33 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 01/21] config: mark an error message up for translation
Date:   Mon, 26 Dec 2016 11:22:02 +0100
Message-Id: <20161226102222.17150-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 83fdecb1bc..2eaf8ad77a 100644
--- a/config.c
+++ b/config.c
@@ -1701,8 +1701,8 @@ int git_config_get_untracked_cache(void)
 		if (!strcasecmp(v, "keep"))
 			return -1;
 
-		error("unknown core.untrackedCache value '%s'; "
-		      "using 'keep' default value", v);
+		error(_("unknown core.untrackedCache value '%s'; "
+			"using 'keep' default value"), v);
 		return -1;
 	}
 
-- 
2.11.0.209.gda91e66374.dirty

