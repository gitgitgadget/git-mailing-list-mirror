Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 940CB1F4BD
	for <e@80x24.org>; Tue, 25 Jun 2019 13:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfFYNlP (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:41:15 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38427 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfFYNlO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so27259768edo.5
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VPLkInReMhBYY7H2msBeY0ml8DrmkLjlaT9/hjyg7ZY=;
        b=F/aesQk4tfwKEu5J3T55shp30WHx2B9Cjjcod5ic/vzUvPAXdBwy+5O9Przbop3QiS
         qBN+fjaf42f6r+6UbIWMmD8Y1UwGuBzcrU2fent9Zd1hQSET5u/FRe/cgjmtqw3SuvkH
         vcnRsQOeAfihm1q2t0GZSnD+2G7UwrJjvAVvtAPn7MXNegrJWTjsScxRhe5/aHvJq/ko
         zqp9R3v3v/uq4K9/g8Bvo1xvsRpKoNhmRgToD3V8cs24HQPXZEqImAs4N2neqsxj1c8n
         tNZ8R+LxGnq53VG1IeyjBlYH75TLSEjFq1wTpqo2RtyIANbLXZLtF11iA/oMShfJmlbu
         jDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VPLkInReMhBYY7H2msBeY0ml8DrmkLjlaT9/hjyg7ZY=;
        b=a3REhlpskmvBCPIqRXaglADAlqtAqqYtBhMHpq53LnSL7XcN/ms6RiGFk+ZcjKwPfx
         +C0EwnFStFlUsasQ3cHmACm9pqcJABgECYZXZx4mhLKXVYGwIoH8DG4C7uq8s/gWTewm
         3F/sLKeu4V1ZCcNQsMwizSOcVgeQTfn4L2FajocY2qUt1ojGBIzcgMw8huNlS661wG0T
         Svvt9R0MZGepTp+zcK1EBfAjItpDrFz9TMPM5uuDnBBDMMWw5rLqMR3oXEIgqEX33r1I
         UCY0tDDq51SdUox9xMrdoLWm6mtnF1KwlDDrCylgdHsyyx4ZnujYtL2hopsW/J1J9okT
         VhTw==
X-Gm-Message-State: APjAAAWLjtiQ1lZIQLXifU9Q1VVsFF9KxAZkqXVctZtjZgeE3bWz5r/Y
        YAnsFX+2dcmqpAcmFZKO3L8WZg3sC/U=
X-Google-Smtp-Source: APXvYqw/jsr9bx78/LHTEeDPb3Wa1nqJhg2eB7vUn33xtlrcNeEYZTFUc3zTSd/pfjBpsShY2dysBw==
X-Received: by 2002:a17:906:5008:: with SMTP id s8mr99228176ejj.308.1561470072228;
        Tue, 25 Jun 2019 06:41:12 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id v11sm2448445ejx.24.2019.06.25.06.41.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 06:41:11 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v6 06/15] promisor-remote: use repository_format_partial_clone
Date:   Tue, 25 Jun 2019 15:40:30 +0200
Message-Id: <20190625134039.21707-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.229.ga13d9ffdf7.dirty
In-Reply-To: <20190625134039.21707-1-chriscool@tuxfamily.org>
References: <20190625134039.21707-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A remote specified using the extensions.partialClone config
option should be considered a promisor remote too.

For simplicity and to make things predictable, this promisor
remote should be either always the last one we try to get
objects from, or the first one. So it should always be either
at the end of the promisor remote list, or at its start.

We decided to make it the last one we try, because it is
likely that someone using many promisor remotes is doing so
because the other promisor remotes are better for some reason
(maybe they are closer or faster for some kind of objects)
than the origin, and the origin is likely to be the remote
specified by extensions.partialClone.

This justification is not very strong, but one choice had to
be made, and anyway the long term plan should be to make the
order somehow fully configurable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index 763d98aedd..6a8856f475 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -40,6 +40,18 @@ static struct promisor_remote *promisor_remote_lookup(const char *remote_name,
 	return NULL;
 }
 
+static void promisor_remote_move_to_tail(struct promisor_remote *r,
+					 struct promisor_remote *previous)
+{
+	if (previous)
+		previous->next = r->next;
+	else
+		promisors = r->next ? r->next : r;
+	r->next = NULL;
+	*promisors_tail = r;
+	promisors_tail = &r->next;
+}
+
 static int promisor_remote_config(const char *var, const char *value, void *data)
 {
 	const char *name;
@@ -76,6 +88,17 @@ static void promisor_remote_init(void)
 	initialized = 1;
 
 	git_config(promisor_remote_config, NULL);
+
+	if (repository_format_partial_clone) {
+		struct promisor_remote *o, *previous;
+
+		o = promisor_remote_lookup(repository_format_partial_clone,
+					   &previous);
+		if (o)
+			promisor_remote_move_to_tail(o, previous);
+		else
+			promisor_remote_new(repository_format_partial_clone);
+	}
 }
 
 static void promisor_remote_clear(void)
-- 
2.22.0.229.ga13d9ffdf7.dirty

