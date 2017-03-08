Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4803202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 21:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754513AbdCHVBM (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 16:01:12 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33654 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754284AbdCHVBL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 16:01:11 -0500
Received: by mail-wm0-f65.google.com with SMTP id n11so8026496wma.0
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 13:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wii7PFltH8PwqTO3VWap/SJIjbUWzsVhpvm8+x4LFjY=;
        b=c+4jhaZpl0wvIF0KqVztIJw2n8xhWlDje/d6Myta2aDuX53S7iazCOEnjGtANWX6J+
         7v/rg0bcE0jOP4ls1mqywClBY/JDgKh1cJE2bMQZ8sNg5rl5wg8K9X7QsrYCqjC/NDqH
         nU7CSWj0Qjv+efHIgA/AsRJVyNTTF9B7xCCDz+P7hA5aC+4k2KtA3VwOv8841w5ZgZp6
         DYyxyxoX60mNk+/mbTwFfx283J8FhVQuzMDIafThlo+lR9gPnGBkAU5g0CYcmKNm5XqK
         uCZrCGaWTnu8DIDVK2AmO5AAkZ3Reg4wXVKnOIe3FnEGlo95NEReRN5U/st9+zfo+E7N
         nHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wii7PFltH8PwqTO3VWap/SJIjbUWzsVhpvm8+x4LFjY=;
        b=RXqloORHmXfuezV8wWvHGXhGu9GNYqkmRV21mph0D6zQ8xXjbSDWg/6euYn02l+7FQ
         dwCgXSbblxdsX3iQtvWjzhz6iXML8N2/kEm+USPlSCV45U39W83NqFHvCTQQEIrx5R0Q
         n/SnwN7zKi3OYhjYRAAAg/NVRJByeR7jNwWkBmM6pCRZqbimLEjtKBrvqp6dw0MrJqrS
         5bgSqBgI2SnshADJbgCrozYLRTKQ28ycWDW/p1GwRhtDcqCKf5xCap0EyxQs16PI0kPD
         bqeYEyI6+XC4gSqsXm0E5mmQclocAHDnQ1CWRoGrQCnQBAv6xmrIKSt36P+REJhVoCi4
         mAVw==
X-Gm-Message-State: AMke39kIoCgyDVH1RW98c4HJ3v+UDIbHzX7oMxlaU3rKeso2kXeAYzazCDcKm0wSbVJu2g==
X-Received: by 10.28.96.194 with SMTP id u185mr7032010wmb.82.1489006401987;
        Wed, 08 Mar 2017 12:53:21 -0800 (PST)
Received: from localhost.localdomain (2a02-8388-0b40-0580-f50d-465b-b746-dc93.cable.dynamic.v6.surfer.at. [2a02:8388:b40:580:f50d:465b:b746:dc93])
        by smtp.gmail.com with ESMTPSA id 40sm5604065wry.22.2017.03.08.12.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Mar 2017 12:53:21 -0800 (PST)
From:   =?UTF-8?q?Florian=20Sch=C3=BCller?= <florian.schueller@gmail.com>
To:     paulus@ozlabs.org, git@vger.kernel.org
Cc:     =?UTF-8?q?Florian=20Sch=C3=BCller?= <florian.schueller@gmail.com>
Subject: [PATCH 3/4] Updated de-Translator
Date:   Wed,  8 Mar 2017 21:52:54 +0100
Message-Id: <20170308205255.18976-4-florian.schueller@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170308205255.18976-1-florian.schueller@gmail.com>
References: <20170308205255.18976-1-florian.schueller@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 po/de.po | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index ab90c34..193059b 100644
--- a/po/de.po
+++ b/po/de.po
@@ -4,13 +4,14 @@
 #
 # Christian Stimming <stimming@tuhh.de>, 2007.
 # Frederik Schwarzer <schwarzerf@gmail.com>, 2008.
+# Florian Schüller <florian.schueller@gmail.com>, 2017.
 msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2017-01-02 10:08+0100\n"
 "PO-Revision-Date: 2015-10-20 14:20+0200\n"
-"Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
+"Last-Translator: Florian Schüller <florian.schueller@gmail.com>\n"
 "Language-Team: German\n"
 "Language: \n"
 "MIME-Version: 1.0\n"
-- 
2.9.3

