Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4FEA1F461
	for <e@80x24.org>; Sat, 22 Jun 2019 06:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfFVGLG (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jun 2019 02:11:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45841 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfFVGLG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jun 2019 02:11:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so8454702wre.12
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 23:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pAu4zpP6Kw96JZgBbgh48lFQhwUTcVjfVvh4YTEc/64=;
        b=jnM7HOXJ8V7xjF0VD7mnvKybcPkfjjqMgLVre2SihRFshh6DSPmmlTDNCfU7lOSYoM
         tSBY1bgarmn4GJA935Uaz4hccqJ2ne68AZJw7V8CT2+EUWL9F0/foH371ZV28aIung0g
         UUFxJscmW4VgL4ZuID8+gqpIP/KmDj0ND6X0Uek256Xhb6gXOlBuCqNL1ItpiqirAlEd
         MgbMc1uQswTykP6SUwGqAJPLiSXMubLpjEHb69AqAWWmqenMTxyEungRDNGaT9B9d8EQ
         HUnbSvgzZNFe/EcOGUAbT5pyvRqMmMG7HoXSnvtcDDGaG5eGC12I7j/aLz9+nB3JE31W
         yLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pAu4zpP6Kw96JZgBbgh48lFQhwUTcVjfVvh4YTEc/64=;
        b=uly9KC7yFddb0Igfsv90at396hvBEsvZWDgnQEMZRr183N++/ebPZSXOfp8VlZ7nTj
         UNCgrmcTaGuswogn4v+EyLxBBFOWfqc/8Tn3krZTFgEa19n3EkprX7mfNOK3aGageadY
         +oMWRmTIuxstVpEkJiQh2O7UWLHJ0ORm71MJGIlQpxAAZPg5OmB+LzBzr/GvQzxQHBIb
         DviNzimt9b4W871bGzHgaFT4ZhVHgZcIx+vmuVevmjemUjGQoKBrgr8Wl+vB2+DpnjPA
         B7HUdJkDVEQOgWv3aj2hyPirylJeyVSY4oP18PgmNyza0TegdlyBMpQ6h3zZJzEMqT3V
         OKvg==
X-Gm-Message-State: APjAAAX2WZFDjrWS0/byt5o8AMUkk7RCAN0l1MjPQ8ctvYywKjjSOzbc
        7mIaSB7x5bH0fr478gJDPVWzEDuCADM=
X-Google-Smtp-Source: APXvYqyFhmYQoAye6yOmGrB+Om9CKlzIPUST0sbVyqF2HisNftpECYOXl4iVR5rIc3DY/GJgo6RwAw==
X-Received: by 2002:adf:e2c7:: with SMTP id d7mr43155806wrj.272.1561183863904;
        Fri, 21 Jun 2019 23:11:03 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:1162:99b7:a064:6e6d:d379:4b95])
        by smtp.gmail.com with ESMTPSA id d201sm3678213wmd.19.2019.06.21.23.11.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 23:11:03 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] doc: improve usage string in MyFirstContribution
Date:   Sat, 22 Jun 2019 08:10:35 +0200
Message-Id: <20190622061035.1612-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.206.geb73f2e638
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We implement a command called git-psuh which accept arguments, so let's
show that it accepts arguments in the doc and the usage string.

While at it, we need to prepare "a NULL-terminated array of usage strings",
not just "a NULL-terminated usage string".

Helped-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

The only change compared to he previous version is that "[<arg>...]" is
used instead of "<arg>..." in the synopsis and help message as discussed
with Emily, Eric and Junio.

 Documentation/MyFirstContribution.txt | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 895b7cfd4f..f8670379c0 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -428,7 +428,7 @@ git-psuh - Delight users' typo with a shy horse
 SYNOPSIS
 --------
 [verse]
-'git-psuh'
+'git-psuh [<arg>...]'
 
 DESCRIPTION
 -----------
@@ -491,14 +491,16 @@ Take a look at `Documentation/technical/api-parse-options.txt`. This is a handy
 tool for pulling out options you need to be able to handle, and it takes a
 usage string.
 
-In order to use it, we'll need to prepare a NULL-terminated usage string and a
-`builtin_psuh_options` array. Add a line to `#include "parse-options.h"`.
+In order to use it, we'll need to prepare a NULL-terminated array of usage
+strings and a `builtin_psuh_options` array.
 
-At global scope, add your usage:
+Add a line to `#include "parse-options.h"`.
+
+At global scope, add your array of usage strings:
 
 ----
 static const char * const psuh_usage[] = {
-	N_("git psuh"),
+	N_("git psuh [<arg>...]"),
 	NULL,
 };
 ----
-- 
2.22.0.206.geb73f2e638

