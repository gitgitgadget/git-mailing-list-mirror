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
	by dcvr.yhbt.net (Postfix) with ESMTP id B80B21F461
	for <e@80x24.org>; Thu, 11 Jul 2019 16:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfGKQJB (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 12:09:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38606 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKQJA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 12:09:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so6923227wrr.5
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2xXqebNTZyy/qKd0wKsFDUyNRx/QP5rWyLVrMPAhmVU=;
        b=DBpBNeH9XNdNcifRRR8Sog1RG3r7PC7yITUwEtDVuGHFScTtSNpZrcvHtnPs2xLT4T
         SCXAOl+rzkA/135G4AVuzpkU0uyfJhRLiPcgjJugWkmjMABj5eizwNceQq6bJcv940WB
         wcxvSNmsiijqmghydNDyE0kHoZ9lWlIFDA2GtDs4g3HCGsgFvTVyywA0OfaJDD3X8Zdm
         6ChgheU//B6T4O2tx/vcMJFUUXkgFzUK0k5x7N8TkyOp26lIFrHZp0lWdd1KxErueKTM
         2QelxT15Omr7VxqREXVooc1eWdz0DAqULyCMyIGw5p3Jcx9MA+4+4qW11IXW1OElof6K
         qesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2xXqebNTZyy/qKd0wKsFDUyNRx/QP5rWyLVrMPAhmVU=;
        b=QRyZP4E/ExghMBizEHKPhuUiqYAO/2s4obO850KlXzBvuZyA2t+iRD97TsN4PPh+Dh
         XWPb/CEvlcNUayAI7t+7zekvMBpz8tRzRbSP9wcPMf36QgTwBqQanql8y3BkCTJxGoiZ
         M1CnurelfoR6FQvvkJ5VQSQV0sxTUA+cXXhegGTP8OiqtvwAixvqpFR96iWNbxXPnvRw
         xZqBEKum2Sdz5pR80ldXCWbjEVL4Z9O4T6NInVLrMQ4Asj1bSoxbuefYJZnw2NwUASNM
         CAbmIYoM73nYNPN2Em+V1/MPKnMYsJzaCMC64EP1cof2zqyf4zNeJCfN6VJ26TjPICTm
         h9bQ==
X-Gm-Message-State: APjAAAXAhRNSQ9bQZIIhkgH1KRHy1bri8ulyVH9hdmWjetSPRb4FCuGb
        KLVHt8D05CVtTPfgutc5EqD8lWh1lwc=
X-Google-Smtp-Source: APXvYqyyzv9Fy6wMq6awAFclilZpiBJpxzfNs0Vr6av/0/zOP1K6MnGUedEmjbuv9KN3Z5YU752RAA==
X-Received: by 2002:adf:ec0c:: with SMTP id x12mr5921922wrn.342.1562861338906;
        Thu, 11 Jul 2019 09:08:58 -0700 (PDT)
Received: from localhost (host232-157-dynamic.24-79-r.retail.telecomitalia.it. [79.24.157.232])
        by smtp.gmail.com with ESMTPSA id h14sm6061663wrs.66.2019.07.11.09.08.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 09:08:57 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 01/14] apply: replace marc.info link with public-inbox
Date:   Thu, 11 Jul 2019 17:08:38 +0100
Message-Id: <20190711160851.14380-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190711160851.14380-1-t.gummerer@gmail.com>
References: <20190708163315.29912-1-t.gummerer@gmail.com>
 <20190711160851.14380-1-t.gummerer@gmail.com>
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

