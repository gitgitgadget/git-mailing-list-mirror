Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D0BA1F576
	for <e@80x24.org>; Sun, 28 Jan 2018 11:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbeA1LTO (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 06:19:14 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50213 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbeA1LTM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 06:19:12 -0500
Received: by mail-wm0-f66.google.com with SMTP id f71so8886446wmf.0
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 03:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YOC1k++9Fg/tmmFijvvfxf1nP1dKLjN0IJYwPFgg14c=;
        b=hqmHITc2tW3428OSU4JiuX3Zavan38P6IilOSxnHGnDIDoT/vPweWLP6HNEkbCI7LW
         yMMUG38RF3nx+vdUW6vFBcFH54N7MRiOZEIwl9AVLfvTY85B9K27cj9JrO94//I3QSZ6
         LpsfE8Zl6Oa3AGWvZ/3obJnZ8xbq4GOl1b4vX5L7lcSQ0lrxINwZhsn8r47K12rdgu71
         Guc2m8IlM5fnocdxpBTKFILKeEO4qeQBHSY34i96EOyp0CRmqHLG6SZEUlvKP0u7xCZE
         Qe3nVG/zmgPnCSVPSN0xNxVgtdHljK7IgrJ0cbjyWfW0FtKbH+6czKDYDDj/1F/7a9Xn
         gRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YOC1k++9Fg/tmmFijvvfxf1nP1dKLjN0IJYwPFgg14c=;
        b=mdJ6wybQr7fAW7cxftQyTX7PDdlzyP9eYFLYPXSn8DtTdVTrqU2FQzQXHvbpAkgMR1
         08+60r/OZoHS2kuyntDVfzlSnNg9zBNppoS2HhVFwo1ovgSdgpdKcG3rG/Kx7pj6a5lD
         2yHJBssz1JUFMCxWrLPkYXFFy+Hwbe35uAGx+tmpkJscdZ9icYVYaEDQggeM3OCTFgNH
         XIRhXoK3fm1FWYlQBqBKUHSXWsfxz3FDujFzE54hRJapwcZmodLRoEhBoGkcY5hIEFOw
         YIccfEs2faBsrhl5WqfrLZV0e78LOu0UFiyGp6ofkt13Gl9N9Jfr7OnOhvLBR/oWSJf8
         /Z0Q==
X-Gm-Message-State: AKwxyte/GTvow/1JYQpG1WzJtKtuNE06YJQiyZYGnvgx80EDCBc7ujrx
        /Jd53JUXnnyYVsCk373kNit+IwVT
X-Google-Smtp-Source: AH8x227gcw35pDWpvLDNUu39/J55dBlLke8eZnAetxKC/y5CAhSEaSAQgs/Lmn/vrXJrzoGZM2GnjQ==
X-Received: by 10.28.154.141 with SMTP id c135mr16864919wme.82.1517138350674;
        Sun, 28 Jan 2018 03:19:10 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id 123sm8343306wmt.31.2018.01.28.03.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jan 2018 03:19:10 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 3/3] perf/aggregate: sort JSON fields in output
Date:   Sun, 28 Jan 2018 12:18:43 +0100
Message-Id: <20180128111843.2690-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc2.45.g09a1bbd803
In-Reply-To: <20180128111843.2690-1-chriscool@tuxfamily.org>
References: <20180128111843.2690-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is much easier to diff the output against a preivous
one when the fields are sorted.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index d616d31ca8..fcc0313e65 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -253,7 +253,7 @@ sub print_codespeed_results {
 		}
 	}
 
-	print to_json(\@data, {utf8 => 1, pretty => 1}), "\n";
+	print to_json(\@data, {utf8 => 1, pretty => 1, canonical => 1}), "\n";
 }
 
 binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
-- 
2.16.0.rc2.45.g09a1bbd803

