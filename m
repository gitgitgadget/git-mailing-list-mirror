Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72E2A20248
	for <e@80x24.org>; Mon,  4 Mar 2019 15:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfCDPdt (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 10:33:49 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:46391 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfCDPds (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 10:33:48 -0500
Received: by mail-ed1-f51.google.com with SMTP id f2so4574684edy.13
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 07:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aJOZHf/p/aziu0aYmJrn9O1ciLCMWVyUVISgA6pWtHY=;
        b=nnnHKwVtqxILC+BY1wv2SBMdS/q4K+TgJ1l3z+dDlPTDecXHSw89rBY0bCNfRaKqlD
         YI2tWdUOgCsWe17Mgw9v3XxOCD7wYAW1/nyp8dQAwUSSfSa2fuk05da8Iov1gUXGPEP1
         edJmf8vjden/fLT8o6rXXY3cgyUmiBVY5nj434K2PPO8i168GO0gO8I5pI3AO9CcJKDL
         v36/t8e90K6FKhOXfMUoNUdW9Iok+fon/S5ZNwqaKS9sQO6cHSEH2D9LddLJY48SrHIc
         M2DVyHLNRLzRkeau9Yc7wfzBxHweFgXW0ToT9l0H3F1CK5xnsbwcnWU5iXKixZFxPfXA
         mtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aJOZHf/p/aziu0aYmJrn9O1ciLCMWVyUVISgA6pWtHY=;
        b=XPt2XrqjThtr1cmd+6DDKJXKhlXfGhtx1rEeBgC2weSSlQMTKipA6yZFlyu0BSxZ7H
         +QBC3OCJcSSB7nLo/foST9NWvH7K7NO2sGNqoVClb3b1IEEPWC5dfXjC1ct4MBerr6N4
         MUEx08Vg1cz6ujnd5O/lFwDZW5PkfcFTyk4DmpxNUweoLUYRy2dhLto7iHWbQW47RPu1
         OYkRDtKF28h9x3BSb0bBhzREMPK12R9lCQ7BJ4dJkEbwejXcpqZXqzRBNbs+nu24wG17
         WrVtUr93SXLXIkdcvHG0Yjeuh8t0CE7El5L+qri7k3ISxtP5O02rKDtAanLSOh+bpC00
         ieMA==
X-Gm-Message-State: APjAAAWcV72BkpoCxbqxx25Efwqn9lY2zecNy6g3RLykWKSz2xX3llVg
        aKtXlvxuPQ9Lb4XH61KzhOClcJUG
X-Google-Smtp-Source: APXvYqwf9J0WlxkeU2AGc7ugpfmApK1XOi6pvgO53Z9vmPxET+ZlSAYiZvFE19G0t72EE8/FLKOe0g==
X-Received: by 2002:a50:b1ab:: with SMTP id m40mr15870600edd.268.1551713627125;
        Mon, 04 Mar 2019 07:33:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h22sm1248134ejj.43.2019.03.04.07.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 07:33:46 -0800 (PST)
Date:   Mon, 04 Mar 2019 07:33:46 -0800 (PST)
X-Google-Original-Date: Mon, 04 Mar 2019 15:33:44 GMT
Message-Id: <ab6f4032cb8cbbe77dbfad4660c30acd7ba688bb.1551713624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.156.git.gitgitgadget@gmail.com>
References: <pull.156.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] curl: anonymize URLs in error messages and warnings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Just like 47abd85ba0 (fetch: Strip usernames from url's before storing
them, 2009-04-17) and later 882d49ca5c (push: anonymize URL in status
output, 2016-07-13), this change anonymizes URLs (read: strips them of
user names and especially passwords) in user-facing error messages and
warnings.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote-curl.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index bb7421023b..e32359034d 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -16,6 +16,7 @@
 #include "send-pack.h"
 #include "protocol.h"
 #include "quote.h"
+#include "transport.h"
 
 static struct remote *remote;
 /* always ends with a trailing slash */
@@ -251,7 +252,7 @@ static struct ref *parse_info_refs(struct discovery *heads)
 		if (data[i] == '\n') {
 			if (mid - start != 40)
 				die("%sinfo/refs not valid: is this a git repository?",
-				    url.buf);
+				    transport_anonymize_url(url.buf));
 			data[i] = 0;
 			ref_name = mid + 1;
 			ref = alloc_ref(ref_name);
@@ -442,17 +443,23 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		break;
 	case HTTP_MISSING_TARGET:
 		show_http_message(&type, &charset, &buffer);
-		die("repository '%s' not found", url.buf);
+		die("repository '%s' not found",
+		    transport_anonymize_url(url.buf));
 	case HTTP_NOAUTH:
 		show_http_message(&type, &charset, &buffer);
-		die("Authentication failed for '%s'", url.buf);
+		die("Authentication failed for '%s'",
+		    transport_anonymize_url(url.buf));
 	default:
 		show_http_message(&type, &charset, &buffer);
-		die("unable to access '%s': %s", url.buf, curl_errorstr);
+		die("unable to access '%s': %s",
+		    transport_anonymize_url(url.buf), curl_errorstr);
 	}
 
-	if (options.verbosity && !starts_with(refs_url.buf, url.buf))
-		warning(_("redirecting to %s"), url.buf);
+	if (options.verbosity && !starts_with(refs_url.buf, url.buf)) {
+		char *u = transport_anonymize_url(url.buf);
+		warning(_("redirecting to %s"), u);
+		free(u);
+	}
 
 	last= xcalloc(1, sizeof(*last_discovery));
 	last->service = xstrdup(service);
-- 
gitgitgadget
