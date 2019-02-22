Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5323020248
	for <e@80x24.org>; Fri, 22 Feb 2019 14:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfBVOlt (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 09:41:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35360 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfBVOls (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 09:41:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id y15so2207124wma.0
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 06:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3WBUa1TE5gamyCovPOyfFRU8Id2fs7o4hGbhQcyBIvo=;
        b=fe9irlNVWf9aX4ZraLbskUyiSFI6t7J4/ZI9qj+8p4LIEQWWfkc7ATi7ikhKKnKhjH
         0fzWkIYH5bdQCyRmRPal4Tgvpor5Pt/TZW6hi28O1bjrd9OB0OYp0Q9tkfrp9QgyTykx
         RpXY8gH3D1SXXBpaccpRoVrWYW2jamDn6uPh4k8j+nNY3xuQ3PSYFZ/MCE0VNtcC8jrC
         lu9XXzHAdEdiTbx1SwgK1Xm1+al7/o5rJyGKFCgUNY/TFnIOuqNPKrWj4d8vd1jnelU9
         CnWpHWfF6lKCpK7w5qJvMTfwM7G0wzOHbw1vvYaXgxoi6zbJO8FQS+u3t16a/yi9C3lO
         V2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3WBUa1TE5gamyCovPOyfFRU8Id2fs7o4hGbhQcyBIvo=;
        b=gk7fKAgP+yd75hBavtV7dOhQ3GMbldby22TXSvWC3K9l1Umaa4IuxlTP5kF7nZqHZS
         DFWlGwsIC/3b2hxP/fHD95kRMWR8lhEOKrmndqgMkpQsy5CGqsW2cOJN0nhgdyHAr5wT
         OFKhmNP9j27c/ZjPC8OAbgTRk4q0wTRA6LMtbYvswLpTrfeaxJ4LI+bMIXf93MrEfEkm
         Usw/5ecTaGtI3enlsTqg2Rfx8GM83srGypG3wTWf6kt3iJkKycx9PSZEvs/+27nV2aAt
         vhy+PuZrAKTemO7nVWLazRYvMRKLGQOBH6d+3FVv3/nqJ7otNF/ZzoNpGJmm9+Hwl6oi
         gD0Q==
X-Gm-Message-State: AHQUAuaeSDVXkLu3QVi4Z5WM6vNnY7McIuYlqXxyKb3GJu+S8CYMm3o8
        ICGfpaI1BicF+p6j6vEUs0wxtYx6fF0=
X-Google-Smtp-Source: AHgI3IbY9CCvaMXjfKWSfnO6MwUW8UTlpYDKpFRnU+M7Z9vP6en40oxrbbRed/l4rOim35WSDjk6Bg==
X-Received: by 2002:a1c:a104:: with SMTP id k4mr2685353wme.54.1550846506135;
        Fri, 22 Feb 2019 06:41:46 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z15sm1481689wmi.46.2019.02.22.06.41.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Feb 2019 06:41:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Lars Schneider <larsxschneider@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/6] Makefile: Move *_LIBS assignment into its own section
Date:   Fri, 22 Feb 2019 15:41:25 +0100
Message-Id: <20190222144127.32248-5-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
In-Reply-To: <20190222105658.26831-1-avarab@gmail.com>
References: <20190222105658.26831-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now the only other non-program assignment in the previous list is
PTHREAD_CFLAGS, which'll be moved elsewhere in a follow-up chang.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0870fd4651..59674ce9d7 100644
--- a/Makefile
+++ b/Makefile
@@ -572,7 +572,6 @@ TCLTK_PATH = wish
 XGETTEXT = xgettext
 MSGFMT = msgfmt
 CURL_CONFIG = curl-config
-PTHREAD_LIBS = -lpthread
 PTHREAD_CFLAGS =
 GCOV = gcov
 STRIP = strip
@@ -580,6 +579,9 @@ SPATCH = spatch
 
 export TCL_PATH TCLTK_PATH
 
+# Set our default LIBS variables
+PTHREAD_LIBS = -lpthread
+
 # user customisation variable for 'sparse' target
 SPARSE_FLAGS ?=
 # internal/platform customisation variable for 'sparse'
-- 
2.21.0.rc2.1.g2d5e20a900.dirty

