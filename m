Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6ABB1F576
	for <e@80x24.org>; Tue,  6 Mar 2018 10:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbeCFKmr (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 05:42:47 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38473 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbeCFKmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 05:42:46 -0500
Received: by mail-pg0-f66.google.com with SMTP id l24so8105630pgc.5
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 02:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rZoB9eZMO/suhTeqW7WTyr0GwZ4iItrHUfCVeMyKIt4=;
        b=eMftRnZMIwKcnnEck21ttLaPX8uDUFMqfYaf72DSA5nozeXdxAJfurgPVXWdJL7mEs
         nDYwKLJDMt5ejE7P27WStlqpdNfNnFvY3pWmBH15wT6sbVNGaPhPVvTHbm/By43uDkeV
         QJqYkeIIAdXJiMzkMFXVJXjlVUD7vMkshd5J34l4Gett2A56f4IuY94Z4TGlclmAAJfb
         PLUnrDZU2LF7IW5PRGDvHBvxqOQFKCtjfn4G1JEEDHvbTEIalGKe7c1mySD8GOvDZdwh
         f5Q1e0P3qUe9rAcHFOa4mJxsKI9DEF5Z5JBFagqzQmsa9PkHSnuHB+NMLiXyYl1uGFCO
         3xKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZoB9eZMO/suhTeqW7WTyr0GwZ4iItrHUfCVeMyKIt4=;
        b=a2HXIlxOPoe65ZogpzVBe63co6+LD6OUgyKf2Q3IyTEMQzlS6rBWhBP6g2XWZe/W0Y
         m7l47MWM4ISk0Iiu6nD2ovBEfLKtwWCSJ8y0LaxCyPnU5faOU6Sjoery6UP8iGHQE0RU
         PFzQ/M/Y0uXJF70V6IWz3i7tKZaZe8TBgYJ9LKqzwt+h5hsMNcDJd7J1oVwpnXYQcka5
         oBcdWG8RqDi0XIjxnBYEek7UmE5+MJVyO+mnAeS461h3bp1/T4sBOkdi45KErJnWOHwP
         79DLVYCspe+90PdYoSEXy/aXcqgZBxvDcWcWFjf0jISa5kHxAR+AtdEkMydQVV0wGqJ2
         gS1g==
X-Gm-Message-State: APf1xPCbITH7Qlldw9zGXVDm3qXB2rl0hf30QL/D5EwWXR6BCJo322tp
        OCurqXnK8cAqaoyhNrElQTTdpQ==
X-Google-Smtp-Source: AG47ELtV8D5qPON7NIb08f3hyJc/HfewLcJMbAPePMFztlHvNW378eHpxZWG5t/v6u/AUIxHpa9plw==
X-Received: by 10.98.89.85 with SMTP id n82mr18261198pfb.233.1520332965704;
        Tue, 06 Mar 2018 02:42:45 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id s9sm26994080pfm.39.2018.03.06.02.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 02:42:45 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 06 Mar 2018 17:42:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     e@80x24.org, git@vger.kernel.org, peff@peff.net,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/5] pack-objects: display progress in get_object_details()
Date:   Tue,  6 Mar 2018 17:41:58 +0700
Message-Id: <20180306104158.6541-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.784.gb291bd247e
In-Reply-To: <20180306104158.6541-1-pclouds@gmail.com>
References: <20180301092046.2769-1-pclouds@gmail.com>
 <20180306104158.6541-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This code is mostly about reading object headers, which is cheap. But
when the number of objects is very large (e.g. 6.5M on linux-2.6.git)
and the system is under memory pressure, this could take some time (86
seconds on my system).

Show something during this time to let the user know pack-objects is
still going strong.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 24af4068a9..2ec911bf10 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1713,6 +1713,10 @@ static void get_object_details(void)
 	uint32_t i;
 	struct object_entry **sorted_by_offset;
 
+	if (progress)
+		progress_state = start_progress(_("Getting object details"),
+						to_pack.nr_objects);
+
 	sorted_by_offset = xcalloc(to_pack.nr_objects, sizeof(struct object_entry *));
 	for (i = 0; i < to_pack.nr_objects; i++)
 		sorted_by_offset[i] = to_pack.objects + i;
@@ -1723,7 +1727,9 @@ static void get_object_details(void)
 		check_object(entry);
 		if (big_file_threshold < entry->size)
 			entry->no_try_delta = 1;
+		display_progress(progress_state, i + 1);
 	}
+	stop_progress(&progress_state);
 
 	/*
 	 * This must happen in a second pass, since we rely on the delta
-- 
2.16.2.784.gb291bd247e

