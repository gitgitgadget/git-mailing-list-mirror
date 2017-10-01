Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FB5320A10
	for <e@80x24.org>; Sun,  1 Oct 2017 16:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbdJAQTD (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 12:19:03 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:44424 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdJAQTB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 12:19:01 -0400
Received: by mail-pf0-f181.google.com with SMTP id t62so661071pfd.1
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZRmm+WwLhr/arDluE0TLWR5xmjxtlWiyuLLS6qtlmC4=;
        b=grfU6tu5K40+KDmCMFPAqiSnfcuxRPNurBw5c720+e5bNnVEx5mD5Te6T0/eExoDlr
         CCJn9Ve+1SXhLS8Pm5CeNUuMZXg8vbue9NPTGF0ijq3wxxH2i51NzLb1WR7WVLDh+8ne
         VKmOJIIKBfnm+zkz9Qlt6uOtHiOYpYG95qzR20uhJ3JIk9U00FSc+v00ormq1JrYx7dR
         bzhS01YNZe53onzr37yJE7/T2kO0RQwMRNSBhUTgCaGBr5EtVeGn3jux5XI+E96OFYcl
         3ru2Kx5HoU8fNjucZLrJ1JfJxLILetHqZymeL/ykj70IE7xE/KPXvzFB1BeP6jI3mj36
         kLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZRmm+WwLhr/arDluE0TLWR5xmjxtlWiyuLLS6qtlmC4=;
        b=Zj3ddREoA4jJYVNDQ2VzC5Sb73hquUXO72hiZvR9WxxJEfoMA/AGpUD9cpSqerVcF/
         YxCfnrGDRQ9veNnSo6Y3CKsQe1+oWICuNOpJQo/ZiAWTNcJICfWsrVbug0UCz8VL9N3C
         7koFAx3HgqqfLm7LjW6gs7qAnJCjVQEUdhiHobudwQqqhkag/hRS0TUXQET/1aTx+1re
         QAUTMC++dySlNZiHyWm0FsqhcnAkH5sdiq5w1n6tqgCYMp6ULuSljZX3L/y6QUrfaCLQ
         DQaIQtRHaTQ4pBFg+jyTV4hhXsnRFn00VckQSm+DHxITlEGQr2JdJRlRjFe4Eh5fkVmT
         D8CQ==
X-Gm-Message-State: AMCzsaXBgK4wC/yERHWm1JUhbHtqeQSnS7TlffXK9yvsHH6bg727lo3/
        t5mepDvY121NgWInUdR+sNN0iC0XyRc=
X-Google-Smtp-Source: AOwi7QB+C+P1rWRiULFk+D1LYD3vNt3e9YwFxqv5Z2sXNi+MI52ShRiuwKVNIGNdk2wO8MCYploONA==
X-Received: by 10.98.31.4 with SMTP id f4mr3618611pff.282.1506874740285;
        Sun, 01 Oct 2017 09:19:00 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id u20sm13339007pfh.171.2017.10.01.09.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 09:18:59 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 3/6] doc: 'trailers' is the preferred way to format trailers
Date:   Sun,  1 Oct 2017 09:18:49 -0700
Message-Id: <20171001161852.84571-3-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171001161852.84571-1-me@ttaylorr.com>
References: <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
 <20171001161852.84571-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation makes reference to 'contents:trailers' as an example
to dig the trailers out of a commit. 'trailers' is an unmentioned
alternative, which is treated as an alias of 'contents:trailers'.

Since 'trailers' is easier to type, prefer that as the designated way to
dig out trailers information.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-for-each-ref.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 66b4e0a40..323ce07de 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -217,7 +217,8 @@ line is 'contents:body', where body is all of the lines after the first
 blank line.  The optional GPG signature is `contents:signature`.  The
 first `N` lines of the message is obtained using `contents:lines=N`.
 Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
-are obtained as 'contents:trailers'.
+are obtained as 'trailers' (or by using the historical alias
+'contents:trailers').
 
 For sorting purposes, fields with numeric values sort in numeric order
 (`objectsize`, `authordate`, `committerdate`, `creatordate`, `taggerdate`).
-- 
2.14.1.145.gb3622a4ee

