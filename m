Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79A9A20A10
	for <e@80x24.org>; Mon,  2 Oct 2017 00:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbdJBAdQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 20:33:16 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:46687 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbdJBAdO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 20:33:14 -0400
Received: by mail-pf0-f181.google.com with SMTP id r68so2140098pfj.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 17:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZRmm+WwLhr/arDluE0TLWR5xmjxtlWiyuLLS6qtlmC4=;
        b=1wCEd9y84TZ1ep3GSU4bzKGye5hDwSrIVCzWZJ43gbHlL6c0NvOvYuBK7CSgptFEfi
         cJ1Hu/pK4gHK12KDyZwAcac+x9Qb4gx5WNUW3+NpxcbuUr6Ium4zSJ4iA1aH1y3Zlt7h
         GE1d0Uf5wjH+0aBND62W/LHaobjHsptI0nTN1H916oaJsnWehhStjawYCzA3LOpfWH3Q
         wuSzBNT/hTDjjju5WYVl3FVQfzCQZhOtx8SR92H03Rz/27pK6L5wNbUTKypQopvPXFBV
         dur/XCzeo362Kp6zPYOVaNYzaGCBz8NNNInCXPwRj9pOhqA07mEmLqKi3TGkOx1OPTUA
         aYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZRmm+WwLhr/arDluE0TLWR5xmjxtlWiyuLLS6qtlmC4=;
        b=R3cV7Nk+sMv6zK+39CXzdzl6XlX017fCJywllT+8Ye2eNKsN2XRiLMYC8qltFBy9Si
         rt+/jrDrzTCtbKkfZ0rOJ5EIDysbwiQGG0x/rMrZXkzw4obVEN8L3slM+R2IbeQ5Yk/D
         Q09tjH3dfNVVOyQKxYduMuK/IjgQUyUh60R1OGYcjYTaunFqHCl9QLP84iAgeGIhyvop
         2mVK1ieflmWGIQniIxTch+MOEI4XAmGzQiCiJ9ZRw6pcEelA466tcw9AaWlVkXTSisnO
         RouXxCBHfYaBMx8DNiqXkGqclTy9E2wJB8Ue36S6bGKXpDX/Nq9BSLEocEnMOulzgfUU
         93Pg==
X-Gm-Message-State: AHPjjUjUV/VbpauI4Zi2zKNemoSZPy/zYZv58eOy+ogHJ0qX7I7zNdvi
        p/8mviZChbne1fKi+UZ4zKNdpRXJcDc=
X-Google-Smtp-Source: AOwi7QCYXRqLilYyZVry95f5uau6l3rMay5s+VWvktUs5t6WFQdb42ai3QkvIi/7hqyrREknhUkKFg==
X-Received: by 10.159.234.3 with SMTP id be3mr12857634plb.5.1506904393493;
        Sun, 01 Oct 2017 17:33:13 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id o17sm4779216pfj.93.2017.10.01.17.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 17:33:12 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v5 3/6] doc: 'trailers' is the preferred way to format trailers
Date:   Sun,  1 Oct 2017 17:33:01 -0700
Message-Id: <20171002003304.77514-3-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171002003304.77514-1-me@ttaylorr.com>
References: <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
 <20171002003304.77514-1-me@ttaylorr.com>
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

