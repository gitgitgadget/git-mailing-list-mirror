Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B9481F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeA2Wic (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:38:32 -0500
Received: from mail-ot0-f201.google.com ([74.125.82.201]:49369 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752199AbeA2Wia (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:30 -0500
Received: by mail-ot0-f201.google.com with SMTP id h12so6368478oti.16
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=9pPI4Fjuff0eDel2pOsl+YTLcJEqDoa9H6AuL8YwJgU=;
        b=hUHci4F5BLEUOwPrVytaez1OLbgZ4YqXtK07h8WDYIkqzTYJqeW4OaaimWIStAVv4l
         IiLNwxZtauQLNr/x/zDppOEu2Q+0zjxWAvIdog/S3ABayW4dPcp/VHRw27sLEc74isZ7
         hx9HHKZWzoudSwzGUvinm5M4b3fUzI6GYsNuAakpW4gur3FWxzEWHVbPC8cFyS0ce2iO
         eGwGctyJtzFY1f8Qk9Ai/X9jMorp7wUOO+e7YADaefUUOq7VS58WLLMSxXRbxYfjdOX2
         43XjTopPdILaMymLaguRTvh8pJ9c0P6FYwRsC3bmq3/TxU+kCR+8vrVUBZf8w/NEqQgi
         f3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=9pPI4Fjuff0eDel2pOsl+YTLcJEqDoa9H6AuL8YwJgU=;
        b=Yu7Q6he30elgeUjLyzJpU2l+WXKsH8vm2EQWmBs8jwVRqgQQ1uoDPx98zR5ntEJSW8
         msyl/9JscO5JojYzjanErp/m/2tzeXG+cHAh5dQPufk8BqSvDqBoAogcjZGxceWW+cCK
         kYqAprukIf6b62AXJY3f2+1K7geSXzyCPOoj98P6Uz4WkkMmpepvhrYWB4jQ+MIqrWmv
         TJJo5nSFHSrGrBA1t4efX7b4fLnsQRnZTUNk/gq2p/rcZow0YJfMGARIsR0/ftZRY+ws
         3rl+vcNZF7IBekaPRz/SVri9c8kjjQJ0q+fZyqX+uZYy9MAdanVCSUg9ET5HQ+a43tns
         wS3Q==
X-Gm-Message-State: AKwxytekWUSsbaccbb/EzC5+X8bvjffaPB/PlkhBWLx1b+pSwoVqJYzQ
        v3QqbsWlPgOZolJ46LK07yCdOkdji/P1yaJKDH9fODdwvhYyo9A7eC4QbFjUdlcNaBtmfvpYaXn
        nMf0lLXEYPxEzh6HRzemExqnkRKajqbdypA76QWu5kufeGS9+KKgKpz9kgQ==
X-Google-Smtp-Source: AH8x225Jto1TbutOmxCfekFoNoBtUgHcOg92eT+U8YYqvqEhrUZWTsVdcRr3tM1iZoyspXK2EY1Pdgax85g=
MIME-Version: 1.0
X-Received: by 10.202.97.136 with SMTP id v130mr16238786oib.85.1517265509989;
 Mon, 29 Jan 2018 14:38:29 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:12 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-22-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 21/37] imap-send: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 imap-send.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 36c7c1b4f..ffb0a6eca 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1189,11 +1189,11 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *f
  */
 static void lf_to_crlf(struct strbuf *msg)
 {
-	char *new;
+	char *new_msg;
 	size_t i, j;
 	char lastc;
 
-	/* First pass: tally, in j, the size of the new string: */
+	/* First pass: tally, in j, the size of the new_msg string: */
 	for (i = j = 0, lastc = '\0'; i < msg->len; i++) {
 		if (msg->buf[i] == '\n' && lastc != '\r')
 			j++; /* a CR will need to be added here */
@@ -1201,18 +1201,18 @@ static void lf_to_crlf(struct strbuf *msg)
 		j++;
 	}
 
-	new = xmallocz(j);
+	new_msg = xmallocz(j);
 
 	/*
-	 * Second pass: write the new string.  Note that this loop is
+	 * Second pass: write the new_msg string.  Note that this loop is
 	 * otherwise identical to the first pass.
 	 */
 	for (i = j = 0, lastc = '\0'; i < msg->len; i++) {
 		if (msg->buf[i] == '\n' && lastc != '\r')
-			new[j++] = '\r';
-		lastc = new[j++] = msg->buf[i];
+			new_msg[j++] = '\r';
+		lastc = new_msg[j++] = msg->buf[i];
 	}
-	strbuf_attach(msg, new, j, j + 1);
+	strbuf_attach(msg, new_msg, j, j + 1);
 }
 
 /*
-- 
2.16.0.rc1.238.g530d649a79-goog

