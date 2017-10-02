Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 439D5202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750806AbdJBFZd (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:25:33 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:44478 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbdJBFZc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:25:32 -0400
Received: by mail-pg0-f43.google.com with SMTP id b1so946862pge.1
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 22:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4r4ADamLpjX+9P2ip1BqKbp1Bmmwq8VytfEGfzhUsx0=;
        b=iZwfiSQlVyaPZBvqJFUHjesPwswDzyDCP/af5p9WRu7kOD7FZ/pnYBxQGG/QtmAEPH
         SKSE1D11JoH0dTdK5K5Rf169u2ODKhpgr1RmrfndWohP+HE6qfQziL0xUSv6mugjwhtO
         2PJgBg3o+1xoW0ubpzfpLVYfYcfgJmnl2ES+0Prdn3CWGmtR8lMBegxlsj0CuCWGqkRu
         glLs6hRh5D6qIU2ohpJzeMjKBe+7r/Cw79+RPVk0lcj21AQIEiff6tzeU3p/B8Eca0tc
         qVXwYriYC6sVZAoEKPj6N31jrDnCJ1eUBJiObvCyNJT+kP/VNCiQD6n8v9bCipc5O/Nr
         vRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4r4ADamLpjX+9P2ip1BqKbp1Bmmwq8VytfEGfzhUsx0=;
        b=ZCYDa3sfX0E3xmBNWXTgzqEZOZiSkEDkgZMJJzaQzgSjIFvD0pwu9i513WQiD/ENc+
         KNuMRoGDw/Ij6nDJtRdZHZslTbOPpTxOA/q3OEvm+YFQzvxsr1IhCtPgNe7TTkBnYDRJ
         4R233vB49C1x3stDtUHfS2bfkmR7kdOvX5YdoL8zCmIasvp8ccCkSCnJtfjv3dJMyjs5
         gCn0XfF/7Z3cd3F3U+fo5UbqhgDI1OQxZtFjso46+EOoW1eEp9m0tpXaj4iXA0Ev2Obb
         q9DtoofnYCFM0yYEVy3TrEyZ4LQBTeCCQys+D0xCuy/HuMEdPpWkx49muLU7JOC1OO5J
         xxpg==
X-Gm-Message-State: AMCzsaWF90707hzC7hECr0tmm8ZWttINZIew1kfG8zU4sPT2L1vDZ0Gh
        CvMMGXea92Ez9tzGFmj1HuEY2CbTp/M=
X-Google-Smtp-Source: AOwi7QBb8NiRaSttYLHDPNnmyniUgBIHU/F2lcj3Iy56FfmOsR+WJTfSSasi9YV7VBV4F1I+LCNZlw==
X-Received: by 10.84.215.216 with SMTP id g24mr1231535plj.417.1506921931412;
        Sun, 01 Oct 2017 22:25:31 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id w134sm15419189pfd.186.2017.10.01.22.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 22:25:30 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v6 2/7] t4205: unfold across multiple lines
Date:   Sun,  1 Oct 2017 22:25:19 -0700
Message-Id: <20171002052524.12627-2-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171002052524.12627-1-me@ttaylorr.com>
References: <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
 <20171002052524.12627-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests in t4205 test the following:

  git log --format='%(trailers:unfold)' ...

By ensuring the multi-line trailers are unfolded back onto the same
line. t4205 only includes tests for 2-line trailers, but `unfold()` will
fail for folded trailers on 3 or more lines.

In preparation for adding subsequent tests in t6300 that test similar
behavior in `git-for-each-ref(1)`, let's harden t4205 (and make it
consistent with the changes in t6300) by ensuring that 3 or more
line folded trailers are unfolded correctly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t4205-log-pretty-formats.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 977472f53..591f35daa 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -544,7 +544,7 @@ Signed-off-by: A U Thor
 EOF
 
 unfold () {
-	perl -0pe 's/\n\s+/ /'
+	perl -0pe 's/\n\s+/ /g'
 }
 
 test_expect_success 'set up trailer tests' '
-- 
2.14.1.145.gb3622a4ee

