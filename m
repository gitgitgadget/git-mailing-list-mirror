Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7BD11F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeCCLhb (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:37:31 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42374 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeCCLha (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:37:30 -0500
Received: by mail-pl0-f67.google.com with SMTP id 93-v6so7183630plc.9
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sN+th4/meLi1Deqo+oiGZNL7dwTbqC4QTWkln15Ae7k=;
        b=fU58w5lfluSAyguysZQ0Uroxzo65Q60OCcPK9fLxTuesRfktXHgTUZc+0Qs6mL2hxe
         jto+ePh2/p2H7S713W9jl5APg0gl94B0KFi2amBzOhw3ZctCXeVztJ4aoXUrcHPY5wML
         Xt/1HeF+XHJR0py5vgegdR61mlVsb53OPaA59kQwGVw9ok7MOmNpvd5OksI0s7h5z1Yu
         bQ5J+WAN26oK4sIIqyQJ+52ZuAuFLaOqmz5lxHQsKO3/HWYLHDzbh3wLquo33yqWpSBC
         uak/oUwL9SJ8j7ng4t1hmV2hjJEnUAb/JuMC3wjtEkW7zwMCLf6j2dvRrAQ5hswjVNr8
         JXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sN+th4/meLi1Deqo+oiGZNL7dwTbqC4QTWkln15Ae7k=;
        b=JiKhnNliHTzTXJMiXhW6JLcGzj4ylHXf0cffcmh9+TpX0C2Bpzu1V8FVe4x1G8Thi7
         HChbXRwVJ00dz6vhrJHytkMkav+7fWGOUdhR6mYePwikEePNj2T0In3L/qhoHGymXoaZ
         EBu7YrqlbOG5bG+NwXwcUSYE1w6CQ7kDWEOfrpEpl5AEkGc0UyuEhszkvXRxcMIoSJLu
         SdNhYQwBk10+j/ZVcIuroTWmHB/L8hYsrxCUkMZwxIaxzWG5n8+tlEkEalSydboWtD2r
         +xd6hb0/2F/M2Cu6lAuFc2nWmSCj3MQdMtUBpgWozHAyC0b8K2IXPtnDlK4PO7/GZvt4
         /3Rw==
X-Gm-Message-State: APf1xPCdzEa/+D1dlEs3mI20MnjMqgIR9IHhREnoYXVrkhWu9E9ptFB5
        l9ZO8NDsVY8m0ibHxGbml6k6Tg==
X-Google-Smtp-Source: AG47ELuyYxUg5ihfwjZvSk7nVMdGMhwC8NK/DyhoTzvtNjYmE5DiwpNcbh3S+fb/WZzYDN+L96ExCg==
X-Received: by 2002:a17:902:6d0f:: with SMTP id s15-v6mr7885020plk.375.1520077050253;
        Sat, 03 Mar 2018 03:37:30 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id b6sm19451442pfe.85.2018.03.03.03.37.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:37:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:37:25 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/44] object-store: free alt_odb_list
Date:   Sat,  3 Mar 2018 18:36:02 +0700
Message-Id: <20180303113637.26518-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Free the memory and reset alt_odb_{list, tail} to NULL.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 object.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/object.c b/object.c
index e91711dd56..a71ab34e69 100644
--- a/object.c
+++ b/object.c
@@ -450,8 +450,26 @@ void raw_object_store_init(struct raw_object_store *o)
 {
 	memset(o, 0, sizeof(*o));
 }
+
+static void free_alt_odb(struct alternate_object_database *alt)
+{
+	strbuf_release(&alt->scratch);
+	oid_array_clear(&alt->loose_objects_cache);
+}
+
+static void free_alt_odbs(struct raw_object_store *o)
+{
+	while (o->alt_odb_list) {
+		free_alt_odb(o->alt_odb_list);
+		o->alt_odb_list = o->alt_odb_list->next;
+	}
+}
+
 void raw_object_store_clear(struct raw_object_store *o)
 {
 	FREE_AND_NULL(o->objectdir);
 	FREE_AND_NULL(o->alternate_db);
+
+	free_alt_odbs(o);
+	o->alt_odb_tail = NULL;
 }
-- 
2.16.1.435.g8f24da2e1a

