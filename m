Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 263D71F406
	for <e@80x24.org>; Thu, 10 May 2018 19:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeEJTaS (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 15:30:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56314 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbeEJTaR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 15:30:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id a8-v6so5576847wmg.5
        for <git@vger.kernel.org>; Thu, 10 May 2018 12:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6agvAGMV+1crZYRGvejrES7lwq8SnEL2J9eQP7sWgdM=;
        b=BOEZN+E0G5cVkTaomLDABBSD3TEGN9eDqXcig9teJVskniFieQ1zUIx/DIICEuO0t4
         i95N/qu54ZaEYifosuodC3OC072HD9A9y8rKKtdhBP5jexqjCtx3CWYH/b6e1YG3ZcUs
         7qnBHQ0gtfWaljgDihK76TmZxca2m/vSWfo1BTAAcTdj9nFufZNfypmnRGBuhfWUdhIt
         UCLPFYUBxFwjGBcxl4Baus3ujb2pGeO67JjkgwceIU8wEs4gkPK65BAGrf8X4uT9LAA1
         Rynqg43EPyn+91hyNOpaT4/kMagUN8pmgOinCkFDi5xxanyrqAasgY8R4Vo3RMJZnscf
         o8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6agvAGMV+1crZYRGvejrES7lwq8SnEL2J9eQP7sWgdM=;
        b=Jcw5Ek9dKTpte4iO2c1+PttQMCN/sEECHY8iL/oOZ/Nl1BQ9AmHHtzegIQtGEFGHo5
         FBTEd8aQ+0ohkYt7epE47E+E4CyW8mFIgkrVGs4ZstHArSGb4kQt/sORZrzFWb9JfZiO
         4KPOxKc0moBzJ/oMpYPkiyd3btmT4yUz840eS2yQpYuZ04JEFaG5qA41Es17JTE3CRBQ
         qUYE9c8UnhcvDk8R0zEVXHzS98wkweaBRrPInT7DNxgjKpfNprAkTkLUZ5pecmAHr7FX
         bSZExBGZ/sFNTyGU6XYd8BvadAr+DYWqWm2mamE0JdwtAo2rL1iTdKR+5ypRk/hXsM8j
         3QiQ==
X-Gm-Message-State: ALKqPwdIjBffdrAPgV3ThIpWBixLxIuR8CAaGV9NwkYc9UM0yDOi4sev
        Go7xt6qb7q8bSs3a3IT9Xh+9hYeRga0=
X-Google-Smtp-Source: AB8JxZocOsC/ZO/ykdbzfgj7e1UvHKBZtlksF0eCTrcPzw3G7gPjPc+QeJ8N4JeLnyfcXetxWTGKzw==
X-Received: by 2002:a50:9dc8:: with SMTP id l8-v6mr3934430edk.234.1525980615954;
        Thu, 10 May 2018 12:30:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id z11-v6sm870817edh.60.2018.05.10.12.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 May 2018 12:30:15 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        David Turner <novalis@novalis.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 1/3] refs.c: refer to "object ID", not "sha1", in error messages
Date:   Thu, 10 May 2018 21:29:54 +0200
Message-Id: <076c6847d4f533103a8be5d9b6dd4dc3dfb8c83a.1525979881.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525979881.git.martin.agren@gmail.com>
References: <CAN0heSp-rxqAVJ3Q1KMD=eYqPUkcDP8xBTVTDtGfom6v5WpBLQ@mail.gmail.com> <cover.1525979881.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have two error messages that complain about the "sha1". Because we
are about to touch one of these sites and add some tests, let's first
modernize the messages to say "object ID" instead.

While at it, make the second one use `error()` instead of `warning()`.
After printing the message, we do not continue, but actually drop the
lock and return -1 without deleting the pseudoref.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
We could make error-reporting more consistent in general in this file,
but I'd rather not lose track of the original goal of this series.

 refs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 64aadd14c9..7820a52c4f 100644
--- a/refs.c
+++ b/refs.c
@@ -684,7 +684,8 @@ static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
 		if (read_ref(pseudoref, &actual_old_oid))
 			die("could not read ref '%s'", pseudoref);
 		if (oidcmp(&actual_old_oid, old_oid)) {
-			strbuf_addf(err, "unexpected sha1 when writing '%s'", pseudoref);
+			strbuf_addf(err, "unexpected object ID when writing '%s'",
+				    pseudoref);
 			rollback_lock_file(&lock);
 			goto done;
 		}
@@ -722,7 +723,8 @@ static int delete_pseudoref(const char *pseudoref, const struct object_id *old_o
 		if (read_ref(pseudoref, &actual_old_oid))
 			die("could not read ref '%s'", pseudoref);
 		if (oidcmp(&actual_old_oid, old_oid)) {
-			warning("Unexpected sha1 when deleting %s", pseudoref);
+			error("unexpected object ID when deleting '%s'",
+			      pseudoref);
 			rollback_lock_file(&lock);
 			return -1;
 		}
-- 
2.17.0

