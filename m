Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87F241F597
	for <e@80x24.org>; Fri, 27 Jul 2018 14:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbeG0P7x (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 11:59:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46989 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730714AbeG0P7x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 11:59:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id h14-v6so5278631wrw.13
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 07:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uyL5s4EDibqrctmAqyproCSchBUywVPkEM7IfX6nBE4=;
        b=h53UVgLWRiAD1NTFcRO2SbyaMoPppVTDMHWLn6KRza60RIiM//z8wYISr6pPS2khKA
         i2pgQ4TzBb9QU82uuImllzlpbTE7D3X/LuYDkXwPKV4HV3o9PFx9NPFV/4Aj6byNLuAL
         gdawbAydfTohmjSsdu13qytP4eTBJYNxz8v+iNga3hyXeFPb8ol9CO/JqbVrKiJuz/Yg
         WRRYPVXpcbsmU9UKrJ1TO/usdVnMLFZAZb1IYHMTlr1c94abuXLT6OvugGLo1KL+Yywr
         kftQqVzOWX3wb+I5X0RC8sdzENvErto3tlNz4NdUBhQvPUaA92DdfHETDwt7U2D46RWa
         SuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uyL5s4EDibqrctmAqyproCSchBUywVPkEM7IfX6nBE4=;
        b=qEgDZYrQRIDw7qm2ttX9DZVKW1+Wm0iGvlD/nhFrXcqVkFM6L/NvhejUmSBmg/oCko
         VOXYNVqZUY4rhYflKYYdNtrxN08zF4l1aoDYLwAqS3tGOUr1TL2QMWkhC3WeFIPyJ4X7
         AnziqNkL3vcDmklhcvRRHWav9GKe0Oz7Pv8YRKVGQW5NS34n66EBvSsqDQXOLN2s+15W
         xS231cGZT13iqgtS40umb4WJaPpaELbGqnr3oqLTdxHsOipQu9WLf0bGld2I9zK1Jf3l
         8sPQkYfb5dmgnxdlN9CtVEhxL/DFeX04jDfUM19LceSl1b7Lv4WR8fEKB3o2mkMAEiNo
         De0w==
X-Gm-Message-State: AOUpUlFHTdGHJSyx9l9Fy3rFtPkyLab4Goly3+oSgm/RgeF1zywSsdP7
        1fIjpwO//l+nBYhd9CXYuKXcO/u7Bf4=
X-Google-Smtp-Source: AAOMgpeKUEW+sWMtonTE0xurQx5YrqMPpU/m/kBJ71g/fpSK7qWNZ5YQLT6G7tgUlLA2BrgEOfNsWg==
X-Received: by 2002:adf:a789:: with SMTP id j9-v6mr4689486wrc.277.1532702259184;
        Fri, 27 Jul 2018 07:37:39 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j16-v6sm3005479wme.8.2018.07.27.07.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 07:37:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/10] config doc: don't describe *.fetchObjects twice
Date:   Fri, 27 Jul 2018 14:37:12 +0000
Message-Id: <20180727143720.14948-3-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180525192811.25680-1-avarab@gmail.com>
References: <20180525192811.25680-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refer readers of fetch.fsckObjects and receive.fsckObjects to
transfer.fsckObjects instead of repeating the description at each
location.

I don't think this description of them makes much sense, but for now
I'm just moving the existing documentation around. Making it better
will be done in a later patch.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 43b2de7b5f..6b99cf8d71 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1463,10 +1463,9 @@ fetch.recurseSubmodules::
 
 fetch.fsckObjects::
 	If it is set to true, git-fetch-pack will check all fetched
-	objects. It will abort in the case of a malformed object or a
-	broken link. The result of an abort are only dangling objects.
-	Defaults to false. If not set, the value of `transfer.fsckObjects`
-	is used instead.
+	objects. See `transfer.fsckObjects` for what's
+	checked. Defaults to false. If not set, the value of
+	`transfer.fsckObjects` is used instead.
 
 fetch.unpackLimit::
 	If the number of objects fetched over the Git native
@@ -2889,10 +2888,9 @@ receive.certNonceSlop::
 
 receive.fsckObjects::
 	If it is set to true, git-receive-pack will check all received
-	objects. It will abort in the case of a malformed object or a
-	broken link. The result of an abort are only dangling objects.
-	Defaults to false. If not set, the value of `transfer.fsckObjects`
-	is used instead.
+	objects. See `transfer.fsckObjects` for what's checked.
+	Defaults to false. If not set, the value of
+	`transfer.fsckObjects` is used instead.
 
 receive.fsck.<msg-id>::
 	When `receive.fsckObjects` is set to true, errors can be switched
@@ -3389,6 +3387,10 @@ transfer.fsckObjects::
 	When `fetch.fsckObjects` or `receive.fsckObjects` are
 	not set, the value of this variable is used instead.
 	Defaults to false.
++
+When set, the fetch or receive will abort in the case of a malformed
+object or a broken link. The result of an abort are only dangling
+objects.
 
 transfer.hideRefs::
 	String(s) `receive-pack` and `upload-pack` use to decide which
-- 
2.18.0.345.g5c9ce644c3

