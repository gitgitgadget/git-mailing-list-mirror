Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD80D1F453
	for <e@80x24.org>; Sat, 27 Apr 2019 12:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfD0MQN (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 08:16:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38382 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfD0MQM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Apr 2019 08:16:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so3022153pfo.5
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 05:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CW2mkt4s4gcM7+rjOTqExi0bmj6ACwwg9zunePsnu8w=;
        b=F962NGFtTxGdvSCW/Vq5w+jS34zjA27crPj5vYOWe83ruBZeaBBiTMbJtQoJUgOKrq
         KVUKLXjCmCboO/pCOSA1bOXPE53jNzxYtBanRGp5ARGiI/iqGrCK9glbwea6f29K0gNX
         YC+7e/iZnYbFmq+XJd/TxA+5Np/ojInFCDbuiPnlqddhxOIqwo8FdyYrm5nIRuTD4oML
         plmXluyk7+qvLoRybbtaskK9cdnEtPog4FfOU29/cffkxl2kLYbniT1akFG5ArIS0j2b
         5nmjYqS+CPfTJyuR1yEEfkb3iE6iy6145IT9thuC2CEt+EkFqV8S+DeF12gwrjSeTCER
         l0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CW2mkt4s4gcM7+rjOTqExi0bmj6ACwwg9zunePsnu8w=;
        b=rLngIH1HMa8xK61RbSsQJLUamQRP9mpXO7ZhQjF/8xjtAkHFfbhSv8+U10sM8n8S/U
         Pw+SfYYhUZZKqSbeastLhk8bSAU9JZwi5WKWTNdZAAcPtPJk7VPCyiDfu8q10hh0xnUw
         1l7jlCvHZhfYn1LIubvWTw/C8bzwY5oM/xIJVUiWpIcAqAbKqStDplB/dwQ+vIPB9Qkg
         dI8gdcBNzalz86LJw9EVGFQ9qZpEV+FjGe2R09/mnamy9zQKIVdnBVUArB/n5w4EHgVU
         8QbjYwvPWgV6rQoHMYVCq/xPcEooEPSFIZ3xJAnqH7Gf4Qn6lE8N4zqaWPBQ/6jT+J8X
         MrIQ==
X-Gm-Message-State: APjAAAWjer6AxsQmkiV7PVX2BR++REiDJTLelELB7ZjfFwofUIyhDNjN
        5xNAgro6Qza7v7zeUAyiWDcKVqW8
X-Google-Smtp-Source: APXvYqxe4ZDXwLg4hnvoOBfxEnrT+c5AoS7ksEWj133DUPQMEha62AmFg7umy3wYUsQRSC8kwLDCNw==
X-Received: by 2002:a62:2e02:: with SMTP id u2mr15257532pfu.1.1556367371903;
        Sat, 27 Apr 2019 05:16:11 -0700 (PDT)
Received: from archbookpro.localdomain ([216.9.110.7])
        by smtp.gmail.com with ESMTPSA id i68sm45056700pfj.96.2019.04.27.05.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 05:16:11 -0700 (PDT)
Date:   Sat, 27 Apr 2019 05:16:09 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] revisions.txt: mention <rev>~ form
Message-ID: <9012ebc23c1053bfa544b2805338304a7cfa9b99.1556367012.git.liu.denton@gmail.com>
References: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
 <cover.1556367012.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556367012.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In revisions.txt, the '<rev>^' form is mentioned but the '<rev>~' form
is missing. Although both forms are essentially equivalent (they each
get the first parent of the specified revision), we should mention the
latter for completeness. Make this change.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/revisions.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 68cce2ca06..372b286755 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -139,7 +139,9 @@ thing no matter the case.
   '<rev>{caret}0' means the commit itself and is used when '<rev>' is the
   object name of a tag object that refers to a commit object.
 
-'<rev>{tilde}<n>', e.g. 'master{tilde}3'::
+'<rev>{tilde}[<n>]', e.g. 'HEAD{tilde}, master{tilde}3'::
+  A suffix '{tilde}' to a revision parameter means the first parent of
+  that commit object.
   A suffix '{tilde}<n>' to a revision parameter means the commit
   object that is the <n>th generation ancestor of the named
   commit object, following only the first parents.  I.e. '<rev>{tilde}3' is
-- 
2.21.0.1000.g11cd861522

