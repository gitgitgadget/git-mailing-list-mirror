Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 557961F454
	for <e@80x24.org>; Tue,  5 Nov 2019 21:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbfKEV7W (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 16:59:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40503 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbfKEV7W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 16:59:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id i10so2613431wrs.7
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 13:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GAgOrfIXPcNgXY5HNwvxTJLQuFx+2+WffMPYf7lhZPk=;
        b=Ki5ttaDeYymKar/2Jiu32CjIppSTvpnexuOvBf1jwuUZMxujJgnVbyHaxDGzmvM2im
         eeppDjvP69KHG67anKmrn9G36UV0XDyprDRGWGSA/Q1x4oNEsaX6oVETEGxn5GDTKqXV
         bv8U4JSFjovZ1ixDCf5nKr5x/Kj55ceDZ9PSWvUWrr9zdZryz5btScKzql2trkJGSibD
         w3DGnbtOyoOjpQ/1WX0mn8g/n7nkdKIE9rEPr9qT0GsajvYoeYvXIn8Kwz0KP9/mCGhF
         T9EOr9iwj8LfthFtP5R64ItK2dSoNrSSQnH+2fWfwTyYsSIhkfr8Ui4WGVzxbBnB654U
         MkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GAgOrfIXPcNgXY5HNwvxTJLQuFx+2+WffMPYf7lhZPk=;
        b=llAlWwbiUJyWFxjPjsnYEzruW3tqUebY/+LmuwrFVLedSkkmZM8eNZ4QDxJ0MyqRSF
         4w6Da2/Yx+V6m0N/p8Dc+1384hcEg57+DZPIuUQqAxaovCVKvei/+AuPRgDA7ZKp+AFP
         DWan87Nt3wf2SFCFsiqL5sANPXSP6uCPM4qELF910FlQmrIu3VdLxu+RL6nJBv8XUAOT
         Ho/gRxFj752rGRsXIjoO7Nhc8bkLkcZJrnl2OAAqdv5cMA3jcUJPK53itTXDAl2xetHd
         S7SsggGuKIYhGcSUYpG8vmX0pZdm8p6oZEDEZXdAchdBrXz7PL5dFZYHEf+zYv2mrrab
         2wng==
X-Gm-Message-State: APjAAAXkICIW+1IE33wa+6YBy3taaZ2PofhdEUK+knzKD7W1MCGvzV/0
        jcVs0bsPukhDyT+9q9gVx3xGP7dD
X-Google-Smtp-Source: APXvYqz9q2KoWfxFjJQQ1TG/d9HdgEzjOms6wDnG/ZsoGkoQ8+NM1vczRjpBlHs8rcvNHzxfj8o8QQ==
X-Received: by 2002:adf:da4a:: with SMTP id r10mr31405901wrl.356.1572991160083;
        Tue, 05 Nov 2019 13:59:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w18sm14122015wrl.2.2019.11.05.13.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 13:59:19 -0800 (PST)
Message-Id: <d47a2aa5949a5dd3a10b89d9a77ebb89af6ba57e.1572991158.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.453.git.1572991158.gitgitgadget@gmail.com>
References: <pull.453.git.1572991158.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 21:59:18 +0000
Subject: [PATCH 1/1] remote-curl: unbreak http.extraHeader with custom
 allocators
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 93b980e58f5 (http: use xmalloc with cURL, 2019-08-15), we started to
ask cURL to use `xmalloc()`, and if compiled with nedmalloc, that means
implicitly a different allocator than the system one.

Which means that all of cURL's allocations and releases now _need_ to
use that allocator.

However, the `http_options()` function used `slist_append()` to add any
configured extra HTTP header(s) _before_ asking cURL to use `xmalloc()`,
and `http_cleanup()` would release them _afterwards_, i.e. in the
presence of custom allocators, cURL would attempt to use the wrong
allocator to release the memory.

Let's fix this by moving the initialization _before_ the
`http_options()` function is called.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 27aa0a3192..13f50ba158 100644
--- a/http.c
+++ b/http.c
@@ -1062,6 +1062,9 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	char *normalized_url;
 	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
 
+	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
+		die("curl_global_init failed");
+
 	config.section = "http";
 	config.key = NULL;
 	config.collect_fn = http_options;
@@ -1101,9 +1104,6 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	}
 #endif
 
-	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
-		die("curl_global_init failed");
-
 	http_proactive_auth = proactive_auth;
 
 	if (remote && remote->http_proxy)
-- 
gitgitgadget
