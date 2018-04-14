Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28121F404
	for <e@80x24.org>; Sat, 14 Apr 2018 19:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbeDNTUG (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 15:20:06 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35788 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbeDNTUG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 15:20:06 -0400
Received: by mail-wr0-f196.google.com with SMTP id o3so15850302wri.2
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 12:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=76XvvYh9v/pa9caESykgIyqPlzx1OR0OCveIY3e8YQc=;
        b=ElVn2p5Ls2KN/gdh8LLm2tOegYKD7z+s8Y5mS5rKSwwppjLEHs9da1k4EVpChBHKd1
         ydRWZukaw2YugJR1O/otiWR/gsU6PhviH+kcxfkmfyEHN+u6u2pXYmoDA6cFVnAziXpE
         QxNdKKLzam9yQpFlPYWUeCeTe2H2ptw4YldYwT9/D/cmJerAbN4mmCv+0GVWZURJksEV
         cKlbtpmsykexl8t+ZbMkA731TtbgbQNF9u9knKpCoQ34DoYnmVitXZ0x5QzWl53wmR42
         4MEUawgrtzAzDM2IfmzufcUyiaonjLSIy+XKEVBJWJa8w8FTBX6AHTD1LfRwq2sO1UBf
         YqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=76XvvYh9v/pa9caESykgIyqPlzx1OR0OCveIY3e8YQc=;
        b=QGUuabxFahdZX3tmH7cFjTaZyg3kT16lR/B0DR6kAT29wbuXuIMvXBYzZG7sYUwCUI
         h6sXSiTqIJISLHBz2z0ChLJulWx2rPMBDMR7l1yRxhn9/4tR1W1bo8ibD8ULHNEoJ5LL
         inWrLcNMpv87It1FLqnRN6xdhJ0ZpAftHnDOVGzbBbEMvqzRQdfvsGJUdFwCMB3yu2Db
         v7FXV/RjldfVr2zYJ9FWkLzOwMk6S655oe98L0Wzst1qo5SPY5i6LDMfCqbW7BSdsmr1
         x6Bef66FlS3U55Vfpk0M+VoUB8hW3qA8sUdSy29+AiqfADbOGzM1im//NIHw4dOKp6zV
         Q5dg==
X-Gm-Message-State: ALQs6tB5n5K+YEHc1m8ZnMhSPlcxV0yKDrQQNVVGN+k4ywfzGGCMmINz
        qflKHKrhJLul4Iv3C5zTxWmYaY4k
X-Google-Smtp-Source: AIpwx4+qRe4RfaTkJdCdHEDlUh7FDp1RciAZ6fjH6uhphHU0PrehxcRJDUU4/iJAIQd/41kmJq0H4Q==
X-Received: by 10.28.216.148 with SMTP id p142mr6917386wmg.72.1523733604309;
        Sat, 14 Apr 2018 12:20:04 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 31sm8610644wrm.68.2018.04.14.12.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 12:20:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>, larsxschneider@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 1/4] connect.c: mark die_initial_contact() NORETURN
Date:   Sat, 14 Apr 2018 19:19:43 +0000
Message-Id: <20180414191946.30674-2-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180414191946.30674-1-avarab@gmail.com>
References: <20180414191946.30674-1-avarab@gmail.com>
In-Reply-To: <20180329150322.10722-1-pclouds@gmail.com>
References: <20180329150322.10722-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

There is a series running in parallel with this one that adds code
like this

    switch (...) {
    case ...:
        die_initial_contact();
    case ...:

There is nothing wrong with this. There is no actual falling
through. But since gcc is not that smart and gcc 7.x introduces
-Wimplicit-fallthrough, it raises a false alarm in this case.

This class of warnings may be useful elsewhere, so instead of
suppressing the whole class, let's try to fix just this code. gcc is
smart enough to realize that no execution can continue after a
NORETURN function call and no longer raises the warning.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index c3a014c5ba..49eca46462 100644
--- a/connect.c
+++ b/connect.c
@@ -46,7 +46,7 @@ int check_ref_type(const struct ref *ref, int flags)
 	return check_ref(ref->name, flags);
 }
 
-static void die_initial_contact(int unexpected)
+static NORETURN void die_initial_contact(int unexpected)
 {
 	if (unexpected)
 		die(_("The remote end hung up upon initial contact"));
-- 
2.17.0.290.gded63e768a

