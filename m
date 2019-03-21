Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E43720248
	for <e@80x24.org>; Thu, 21 Mar 2019 20:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfCUUvQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 16:51:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37508 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfCUUvO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 16:51:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so78541wrm.4
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 13:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x4QaktJ3nM883Fcn9N598BG5hLdRnIVKhJi7568eurU=;
        b=nF1LZhGQRw25EsvGTLoO2bJL0BymK0ApzqXPomCJ2SSAn8NFtCs5ll0yiinB5JVa72
         gDsBxSHSNo9zwrlANUPleNck0uyxlQSel3LSSEFOCHuawGcyYL/7CnDhnlhrlUcFxMbL
         UZUi4ELQAhJ/ewWG87J1b3KGn/R19DIpHElMpzYQpFDOlvJdJaJT22VWxoQlUwK2WNbV
         pEyZ+gSVnm0DOhDLayKIVxUUAExGdO8QeVhcqHAUVqPNo+f8DJyylFJ9bt8LxkuTAlnh
         9EnJf8N1Oji0IhMtpJWUo9wloI7Q9WukNDPPdQZofxm/Rw/Jf2NrKeuBN+b4RSpnx1WR
         nd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x4QaktJ3nM883Fcn9N598BG5hLdRnIVKhJi7568eurU=;
        b=TXhtPTy4tnszd31aoOXk4XBh9/ZnT4AZ/JyPVlwbFYJh9Z7eK2GbPZPC2TwXsLnzkC
         RiLBSYxBadV2XhL6ahERRrSR4F+86ylyTpjOp2oaKJJSjnpU1hAGzoa7fwfI9NfRu2O/
         Kow84BptGhIq1W7qF534ydCMCDOfl+VxASrjUm+vIVTZX0MQ3zSNOL6NoFRnvWSnv6q4
         n36D7lQRdTsQ7KAn7cTrHNeaT0g8zf1op0tMif+SzlpTmBZyovQvGy6qL9WuXVFhQbfZ
         w/unxXaWDEWAPq7PENpFQElw54nCXDoFxuW0oT4VK+nun89qVHCAKfBJvC9QKguh7Roy
         EgZQ==
X-Gm-Message-State: APjAAAX4q99qpUD+EPQvepjHknYvdH6egXCa6NMA4tf0Kt6TB/Gw7TU1
        xnBwEgcfDE3iyaboH0SYUIAhWQk2
X-Google-Smtp-Source: APXvYqxrZM6s0CffPtKg5t5J7vK58ztGtGzFC/w7KRuPtvjCuqEsYiwQ1kWISkqLo2QNXjRNQtfO3g==
X-Received: by 2002:a5d:6887:: with SMTP id h7mr4174371wru.122.1553201471924;
        Thu, 21 Mar 2019 13:51:11 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b4sm6053978wmj.3.2019.03.21.13.51.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Mar 2019 13:51:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/10] gc docs: note how --aggressive impacts --window & --depth
Date:   Thu, 21 Mar 2019 21:50:50 +0100
Message-Id: <20190321205054.17109-7-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190318161502.7979-1-avarab@gmail.com>
References: <20190318161502.7979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 07e7dbf0db (gc: default aggressive depth to 50, 2016-08-11) we
somewhat confusingly use the same depth under --aggressive as we do by
default.

As noted in that commit that makes sense, it was wrong to make more
depth the default for "aggressive", and thus save disk space at the
expense of runtime performance, which is usually the opposite of
someone who'd like "aggressive gc" wants.

But that's left us with a mostly-redundant configuration variable, so
let's clearly note in its documentation that it doesn't change the
default.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/gc.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 3e7fc052d9..0daa4683f6 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -1,7 +1,8 @@
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
-	to 50.
+	to 50, which is the default for the `--depth` option when
+	`--aggressive` isn't in use.
 +
 See the documentation for the `--depth` option in
 linkgit:git-repack[1] for more details.
@@ -9,7 +10,8 @@ linkgit:git-repack[1] for more details.
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
-	to 250.
+	to 250, which is a much more aggressive window size than
+	the default `--window` of 10.
 +
 See the documentation for the `--window` option in
 linkgit:git-repack[1] for more details.
-- 
2.21.0.360.g471c308f928

