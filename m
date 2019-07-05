Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A4311F461
	for <e@80x24.org>; Fri,  5 Jul 2019 17:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfGERG4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 13:06:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45446 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfGERGz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 13:06:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so10586165wre.12
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 10:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2xXqebNTZyy/qKd0wKsFDUyNRx/QP5rWyLVrMPAhmVU=;
        b=WIgjTdizL9iGzHSW+cnUg8yZlxh6CAkfEGEpz9UcWB1VAhsUZDocNjDVZJIID2ySGm
         KmmZP1Ynv7KMHF9d5NOOkAcfKNG5RTA8cxymotqHtBX50hs63vrDO1eR+yHCvYP3FZf8
         SzC6wri1xRMDdACeY5qN1EULeWqYIiSdD6S7m2lnI54+3FEtcxRP9uGN/xQ4nq+LRi/Y
         gfD1QiKsNBTn3/ZHp6m+ZLtb2ltS4oYf5ZkKdRKdWAzqpvTWe/FDa5evrj/h8QGbEW2r
         iefgVfNeB9Gb2lHqbJvnco+sG/rMnD8NJNwkt439EVLeWOQdsLsHo84hzvBdKAvw0Orj
         5KKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2xXqebNTZyy/qKd0wKsFDUyNRx/QP5rWyLVrMPAhmVU=;
        b=BuLLgRsBDCtRgBNwTnbv7knsgYBv3dhBQrVtGd+2kL19rgmHDXOgBE0SWFEs1EJ/m4
         dnRlPVpDGaHn/At/mt7AQzWPd7KWkBELXvtDWJnhGPiISZdn6qHrt8EZoaDfOaWE0COc
         /XIuiufkr4C/ig9UdUVQyKmowvUAV5Ow+wEXV/jkXV6123KojK/OW1m92O1CjSTdXqg+
         vYe8G97Xkw6GSx2wX37ewycRjz5TAjHadx5ZqoHq8brbDQ5NWehb4TeOUNhn2yc4uHld
         nuahWvjeefQNaLIMJGQXNQuh2Ft5YWncfuFiu2I4YBtI2VM/n2snkNfqzl6UO+yAcoxs
         cVsg==
X-Gm-Message-State: APjAAAV3jWXu0Bp+ga2IsG7w4zxAAeMIogPjpEiRORwAmOIoBrQkmMJ/
        Gfa1FeuZlc1/L1pRecfdxpjH62g9
X-Google-Smtp-Source: APXvYqwlV8+u0xpgxAsyoZ/BSE8vLYxboPJCWhYv6ol4iQMh+4Wazh1zN/Ugq3E/pvm2d01o5Fce4w==
X-Received: by 2002:adf:aa93:: with SMTP id h19mr4752163wrc.3.1562346413684;
        Fri, 05 Jul 2019 10:06:53 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id z2sm7674905wrt.41.2019.07.05.10.06.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 10:06:53 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 01/14] apply: replace marc.info link with public-inbox
Date:   Fri,  5 Jul 2019 18:06:17 +0100
Message-Id: <20190705170630.27500-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190705170630.27500-1-t.gummerer@gmail.com>
References: <20190414210933.20875-1-t.gummerer@gmail.com/>
 <20190705170630.27500-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

public-inbox.org links include the whole message ID by default.  This
means the message can still be found even if the site goes away, which
is not the case with the marc.info link.  Replace the marc.info link
with a more future proof one.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index f15afa9f6a..599cf8956f 100644
--- a/apply.c
+++ b/apply.c
@@ -478,7 +478,7 @@ static char *find_name_gnu(struct apply_state *state,
 
 	/*
 	 * Proposed "new-style" GNU patch/diff format; see
-	 * http://marc.info/?l=git&m=112927316408690&w=2
+	 * https://public-inbox.org/git/7vll0wvb2a.fsf@assigned-by-dhcp.cox.net/
 	 */
 	if (unquote_c_style(&name, line, NULL)) {
 		strbuf_release(&name);
-- 
2.22.0.510.g264f2c817a

