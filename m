Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 208221F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeA2Wji (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:39:38 -0500
Received: from mail-vk0-f74.google.com ([209.85.213.74]:38308 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbeA2Wi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:28 -0500
Received: by mail-vk0-f74.google.com with SMTP id m190so5992785vkg.5
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=cPDbWNZodJ7k3goNfV3xYa3nUC1Dh3AK2YMUVjHrF6w=;
        b=hBXCha/EDTPPM1SjfkHylgxiWGh0EbAVY1fFwNPyuXU1Ci38YKZWpxZC4Qy8piHmNm
         WJc0vtNQqeRu3WYXx5yGb7k0+Gc/fpwE+futk9Uga35idNLNbvJalw9dfylmo84irtEY
         h/EGAFHzg6jZQ8xOo+D8QrPBOU+eXzg57eHmYOXkjLySMNzJESItRKDFCKXTejgi2AQN
         7zVNGdQTa/Pn8vUtH3wIlVd2/UsSrKfq56jE4R+gB4eUQywZ5fxdoRRNZBRr5eFUMWG8
         R85wvi/o9/i+baN2Mw49clgcMLgAAtH55n5s/TBskDTI8PG7dF24wQEdxPutiItC/79s
         otxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=cPDbWNZodJ7k3goNfV3xYa3nUC1Dh3AK2YMUVjHrF6w=;
        b=lPpg7oOLOaNv8LGKc5/qDXJFs6/w+sCSXbHa0wAqvxVBmL1URa23hiW1+fjWVaxGkM
         N9usFa6J8q6nBwJL6kKYa+OzY63ibEElxvSiqQmWCEx4LEs49iLZgwWhAq6jdVaZBlDe
         uT3nQVmyFPR1I7P8i+OpiojZMxP+gzXmOmZ2+OzdQGcwT5Itk/s3s3aED2cyunAcFXOM
         dU6ni+smcaslsJpNR06Gj34+4nOyq4sOlWDRW7I0DT3mZjX8MrpPI8xwYc0HCMqC6dD/
         gW27TrYW4Ni/6j2tnlKlOsZ9iz2kOONji4E4i2m/Kz5Fhs37/wVVA3dIMmEG/xtUGfV9
         wWgQ==
X-Gm-Message-State: AKwxytdgcpRRiktgDNzkkw9zbfqecMgvVrIQt8xp0CP9Ep6ae4iy5LbM
        Spok63zm4zH8UalLeWSwWkCF0ajnmZvQXsiv6i1fu1xMEngf/KVIRFVmL81fl2gq9ZT/fxiDDC1
        WYAPDmhXH/636G6vszdc1StZsKOOQ7ArFZ80+dxqadKsMUTAaR0hvWNfqkQ==
X-Google-Smtp-Source: AH8x2252tRAIkWeslH4+TSHOgUKunPGcpnbw/lZSH27FVralMjNih0E2YHnzeo66tVADI02RnFIySUqJ9ak=
MIME-Version: 1.0
X-Received: by 10.176.80.54 with SMTP id b51mr12757756uaa.125.1517265507818;
 Mon, 29 Jan 2018 14:38:27 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:11 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-21-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 20/37] http: rename 'new' variables
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
 http.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/http.c b/http.c
index 597771271..41cfa41a9 100644
--- a/http.c
+++ b/http.c
@@ -1194,14 +1194,14 @@ static struct fill_chain *fill_cfg;
 
 void add_fill_function(void *data, int (*fill)(void *))
 {
-	struct fill_chain *new = xmalloc(sizeof(*new));
+	struct fill_chain *new_fill = xmalloc(sizeof(*new_fill));
 	struct fill_chain **linkp = &fill_cfg;
-	new->data = data;
-	new->fill = fill;
-	new->next = NULL;
+	new_fill->data = data;
+	new_fill->fill = fill;
+	new_fill->next = NULL;
 	while (*linkp)
 		linkp = &(*linkp)->next;
-	*linkp = new;
+	*linkp = new_fill;
 }
 
 void fill_active_slots(void)
-- 
2.16.0.rc1.238.g530d649a79-goog

