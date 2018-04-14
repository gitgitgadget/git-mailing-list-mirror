Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41BC41F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeDNPfm (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:35:42 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42412 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbeDNPfi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:35:38 -0400
Received: by mail-lf0-f67.google.com with SMTP id q9-v6so16389879lfk.9
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bz6WY+vcrnD2NAFMjT7c9tnLCI+q1+S2GO1J6v3UQxY=;
        b=ecVbPgZmhT2/bruJJwkF6hEB9B1Z4tvTTz7039dlTH7MW1XoAk5dPfemQ0Uizx7c+P
         8Ub01LHuhQc749vA3Jwv0z73A/01Rf1z5F39INCIl8tay0J3mdHXzp3KmGFLDi0ZDUdi
         YfTD202dYcK/Z70NA4O+ps7VAJXTvLl0EHcrHe7LPemia/a8ZUxkDdOHG+XDpr8WK1V/
         9sv/7t+aFjI7VCIH8o+Hws04tnpGQ9kuqGNmpQvDhf2zQQpzJ7HHVEEzg5WIw80nAy+0
         q/pAHIXdQjs/kIHSKHGbfe8+rIiZc73Ml2lc52mNnYi1ecoa3PSRr66bxfOmTP4QK05v
         4Adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bz6WY+vcrnD2NAFMjT7c9tnLCI+q1+S2GO1J6v3UQxY=;
        b=Sk+V/O+xWn/yL+geRPWtLoRTSJyvjqLFShx8iCJj8pTRWySVobibedSm4qpgLwU6T6
         m5FvrZkO8uvc5G7u585itb20JBgfiy95sglhDHMBxkD7+1kYlwKvCUqXlxobKWfkPqNo
         hXNK6w/7nkbFvw6YfXWVrNfG5vWaSxTIFsvqEDUMNh/FaZams4CJQaLA+eZEDJ3c62OM
         zP6KZmn4Pp3h2+s+6gAveFpCCW/jwijvO+eZHhxnfBYVvrsBUIsyouxPMEE+yQa9rHIc
         4/J+tlhHPIwCffUTK8P6aFizvZL87N1HtcLH6zEhK3+hq7eP4fUH33r+UgBdUpDw7jrS
         WyFQ==
X-Gm-Message-State: ALQs6tDYMQ+ihyn+Ab7YZgDcBDjqlFysWtuWVfulRQynutcOeJs6xv1X
        chKxT+u/bT1oOcS7Dx1HrRw0lQ==
X-Google-Smtp-Source: AIpwx4+Om3ToTwbDWHDcCEAtcHaTYdF4W8hsTT9yx9xtM5XZ5O5HEl+tGsnk5zZycqepLgZkAJApiA==
X-Received: by 10.46.58.26 with SMTP id h26mr1581894lja.108.1523720137104;
        Sat, 14 Apr 2018 08:35:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t8-v6sm1844074lfk.9.2018.04.14.08.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:35:36 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/15] pack-objects: don't check size when the object is bad
Date:   Sat, 14 Apr 2018 17:35:08 +0200
Message-Id: <20180414153513.9902-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180414153513.9902-1-pclouds@gmail.com>
References: <20180414153513.9902-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sha1_object_info() in check_objects() may fail to locate an object in
the pack and return type OBJ_BAD. In that case, it will likely leave
the "size" field untouched. We delay error handling until later in
prepare_pack() though. Until then, do not touch "size" field.

This field should contain the default value zero, but we can't say
sha1_object_info() cannot damage it. This becomes more important later
when the object size may have to be retrieved back from the
(non-existing) pack.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 211bb1ad0e..e75693176e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1742,7 +1742,7 @@ static void get_object_details(void)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = sorted_by_offset[i];
 		check_object(entry);
-		if (big_file_threshold < entry->size)
+		if (entry->type_valid && big_file_threshold < entry->size)
 			entry->no_try_delta = 1;
 	}
 
@@ -2453,7 +2453,7 @@ static void prepare_pack(int window, int depth)
 			 */
 			continue;
 
-		if (entry->size < 50)
+		if (!entry->type_valid || entry->size < 50)
 			continue;
 
 		if (entry->no_try_delta)
-- 
2.17.0.367.g5dd2e386c3

