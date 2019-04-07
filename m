Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 021D220248
	for <e@80x24.org>; Sun,  7 Apr 2019 19:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDGTws (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 15:52:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44730 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfDGTwr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 15:52:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so13796144wrn.11
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 12:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+QZZxuA1szXKbodDI1ZS7sUwGQUn86iFE2+GzZpUnNM=;
        b=ffCOLZaF+fOFCSRGZhFHbuk7O2ns2gvW7h0yMKrVz0vDAwXQ3vcwb83uHAeUNt7TfL
         MPkGavIySWgZc/rODQ+l1I5jOkBEVLB6gpOi5/OYphO1MQbG4yS+by49D+tC1GSHD/Bf
         hUdbcw+Ux0e117a7jb9O2wtP0s4mV1F3W8jeVU7xJl6AZ17GiI/IbuPmYS622p9zjmUH
         cc0U2UZHljAzl5viI9xW+G7hg7gkYv7xaLtwAwZtAfo4eSNebHiA1T5+tFc91bkP3/Yy
         3//Msy4E2/r7LVen2ev0m8TiTc3jkRSERdlkhoKy8GNJAbUYJQ3LCsgw6sW7EMLGGyXJ
         /XrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+QZZxuA1szXKbodDI1ZS7sUwGQUn86iFE2+GzZpUnNM=;
        b=H3et2ZZC8K8JqR0SDmt62Nw6z6nBGphlss1Yv70oC6WBFOSBPLocg/Ju57rFR+J0rJ
         DuLpIgT+TjX/371+h50JMZ+Z1f+++cgp9zfUl7KiqOS7pjVM/M7LKZdsc22Y9e/S6Bg6
         PIbjKUYwpD5kXPWOJ0fdcrVNROvZfYVXvP4vD8Og1dISx4jLm8uofk0KCrtLuhnAGTt7
         Tdz7wi8PUtP4diX3H6oOTUeALuGQ4pOD1q2aQrxz8DTo08hW5zquMpi+7fEztn+y1Q9x
         UZbNTKlhp+38uVmFkW05g/bQciVS7X65KEyWmNX8SCSK4HyRA2jbSjc1ZCa5DeKENURz
         3qYg==
X-Gm-Message-State: APjAAAVw5QRA37NcznXWt9deP8nutfzTNQTy4c9sY2/VAu5BeXfiuw+9
        DBhFoxuYgrZsmcinwL9HBv8RmdY4uZ4=
X-Google-Smtp-Source: APXvYqwQ2t4ujku+IibT0IOb/BC2B1bt454iPLjKEquXKirMhmhAoVkPppZennsR07RW2Y0kJ56TCQ==
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr15028170wrq.242.1554666765043;
        Sun, 07 Apr 2019 12:52:45 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16sm41815402wrs.0.2019.04.07.12.52.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Apr 2019 12:52:44 -0700 (PDT)
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
        Johannes Sixt <j6t@kdbg.org>, Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 07/11] gc docs: note how --aggressive impacts --window & --depth
Date:   Sun,  7 Apr 2019 21:52:13 +0200
Message-Id: <20190407195217.3607-8-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
In-Reply-To: <20190322093242.5508-5-avarab@gmail.com>
References: <20190322093242.5508-5-avarab@gmail.com>
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
index 56918a5008..f732fe5bfd 100644
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
2.21.0.392.gf8f6787159e

