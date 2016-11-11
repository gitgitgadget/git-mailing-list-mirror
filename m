Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F9C0203E2
	for <e@80x24.org>; Fri, 11 Nov 2016 17:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934921AbcKKRVH (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 12:21:07 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36226 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934889AbcKKRVF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 12:21:05 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so9173996wma.3
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 09:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3UZZVYIpQWZG+LoQ0IEIVOwkblQ/X8A7OZDvcO2ACwQ=;
        b=Lvm7IuFsRtITz7ho1D1LjGHFIW7sRjGySGMxel49nVgAlGqSCwef5bv5EFKsKGwWoK
         Ky12zLUwV5a3NaC8zGoUCog1XYAy5N8Ofyeh2ECobjmwm3ITfxTDtDQWClEjJPLn2swu
         s63I8xIOtkpOqT5S5D2a8fXQonhrx5Y2wROh2qxrOxvQ288i4moLgQHibSkoqIlgjF+C
         ZNXlUFYDLtg670qGimt2Y5KbR0XGIg8snGeAHpGiN03vSk9WzAlJkgAobYq/Q6e9OSll
         7l75CLWfFDOfbEbBAoqC+irA8fwwAv6+d0zyTvZWgBw/ty2g82PsdylIFPECLRe3Z9/t
         VLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3UZZVYIpQWZG+LoQ0IEIVOwkblQ/X8A7OZDvcO2ACwQ=;
        b=iGl4o2GgvUwGD7jDKxpG4/uY3/91+/Nr96yWwwBQW+61kfjrTS4ut9s04CrOLjQEUW
         dCncEBMA5+IaCeEXedebkBsxO2R5yQN4bD/d4m4YfNzW7B4C7WuBl8SbcW1tCF4BRpWE
         4PoDKc29GGb9W9ifLxrZH2qkbY3mMrhXW6v7NxuG0k4wUoVfTUNUtsNb3ih1xqp6mjJv
         ut6h6tdOIgk8lQmfNbUJosKD82HW2+m8st86jTS1VDCzFC1xpozfigZ/cqSzS8Ass/BT
         dw+Q4Zh61fA8EIouUnSdXjNYKuzsYcKLaji5INJciFL67ijZ2kr10DcPrN6shnnyu4mv
         x0jg==
X-Gm-Message-State: ABUngvfvXy0mC9pQSjaPewX/5NfIPTOd3lVC7gvBqYj2Nr3ypYGPnccdQSHEYX/5ukMx6Q==
X-Received: by 10.28.14.65 with SMTP id 62mr10128275wmo.3.1478884864378;
        Fri, 11 Nov 2016 09:21:04 -0800 (PST)
Received: from localhost (cable-86-56-26-140.cust.telecolumbus.net. [86.56.26.140])
        by smtp.gmail.com with ESMTPSA id k74sm13223444wmd.18.2016.11.11.09.21.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Nov 2016 09:21:03 -0800 (PST)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] fetch-pack.c: correct command at the beginning of an error message
Date:   Fri, 11 Nov 2016 18:21:00 +0100
Message-Id: <20161111172100.8028-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.11.0.rc0.151.gf7463a1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One error message in fetch-pack.c uses 'git fetch_pack' at the beginning
which is not a git command.  Use 'git fetch-pack' instead.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index cb45c346e..601f0779a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -240,7 +240,7 @@ static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 			return ACK;
 		}
 	}
-	die(_("git fetch_pack: expected ACK/NAK, got '%s'"), line);
+	die(_("git fetch-pack: expected ACK/NAK, got '%s'"), line);
 }
 
 static void send_request(struct fetch_pack_args *args,
-- 
2.11.0.rc0.151.gf7463a1

