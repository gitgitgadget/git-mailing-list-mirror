Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36A0D201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932690AbdBVOGl (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:06:41 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35988 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932365AbdBVOGk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:06:40 -0500
Received: by mail-pg0-f68.google.com with SMTP id z128so539416pgb.3
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TIw9PBTBHIyMZ9BkJC1y1YW/KkGDKKbAXzGJbN5i9r8=;
        b=c4Fa8uWJfc9O/w1lRRNUNo/dJEK/BJsAniIozQXy9g4OPWluI1ryrkkyOCsG/7tlBu
         AQr6qHj4maUOo2qLT4IT0D7yTJcaEMyFbQrcHy8nhHlT/rqo5jULxFeXqGPBn4wdHKlB
         DtiapZ3Z9PFg8EKaVUKRJQYn4mKJfnbuZUvwEU/Mv/lmXZW5Fv3U7+paeB/tQnk1CmiN
         8uv51LWAFTDwHNCUVebKWonOqwSNSCyy0wepqfV6XKUPLH5D9yfKv7sXsoQFOLhlDYEm
         b66WpvfHtqVts4j9RyhJGw7e390Oi4gxsprckHeEQy3ntd7Ya4eJV61IUUaB0ylb5+y4
         SgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TIw9PBTBHIyMZ9BkJC1y1YW/KkGDKKbAXzGJbN5i9r8=;
        b=WWup9DiXVdgutFBQ0K8CjnZstLtpx9cRdBOmmloIRD4sZVdgckxgc6WG7cYDIKb4/K
         5FTa8PCejF6T7flng+ppe27mR8OAy3nl9evvlfG8bsfaNPMFTLdZCNlFjiEH8gTwtBF8
         nGMMuxbnXJ8HEpnf5tQyPQT+4CVuXKTVr7BIUk8FIeaxLEgZLp7X+KTSme8cQKHD0+KS
         6h00KdGoF4yynyl01KpuSemiBx1jdUIJbYtnGBjFzG9jejTiVWeMqoC4R/wimmmQAK8M
         IamCmq27/fHlGKRpf3wYN9BwUNKasvvNx4je7gu72fF7zwNyzjOUZffOfmENal9Hsl5W
         OsHA==
X-Gm-Message-State: AMke39lyfBoL+A4Is11NM1FNiSAvdiy/ipJEeTroTZmJAHufMIqfY1QmIoOyjAfSMsZTng==
X-Received: by 10.84.214.150 with SMTP id j22mr48530139pli.23.1487772399637;
        Wed, 22 Feb 2017 06:06:39 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id r66sm4039831pfj.125.2017.02.22.06.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:06:38 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:06:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 09/24] refs.c: introduce get_main_ref_store()
Date:   Wed, 22 Feb 2017 21:04:35 +0700
Message-Id: <20170222140450.30886-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 81b64b4ed..dab1a21ac 100644
--- a/refs.c
+++ b/refs.c
@@ -1456,15 +1456,23 @@ static struct ref_store *ref_store_init(const char *submodule)
 	return refs;
 }
 
+static struct ref_store *get_main_ref_store(void)
+{
+	struct ref_store *refs;
+
+	if (main_ref_store)
+		return main_ref_store;
+
+	refs = ref_store_init(NULL);
+	return refs;
+}
+
 struct ref_store *get_ref_store(const char *submodule)
 {
 	struct ref_store *refs;
 
 	if (!submodule || !*submodule) {
-		refs = lookup_ref_store(NULL);
-
-		if (!refs)
-			refs = ref_store_init(NULL);
+		return get_main_ref_store();
 	} else {
 		refs = lookup_ref_store(submodule);
 
-- 
2.11.0.157.gd943d85

