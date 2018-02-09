Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D01641F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbeBIUcp (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:32:45 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56163 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeBIUcm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:32:42 -0500
Received: by mail-wm0-f67.google.com with SMTP id 143so17480520wma.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3uqBMSeJGt5aVACnS/d6hefrZCZrbS9j0DdqZ6VhFMo=;
        b=jqT43HVZ9AaXXd+3mhOxz0OrUMVopHUyFhAzX0CHEGr+RnG4SQgtVNR6WEY4X4X/PR
         CbuCKb4LKYIzFQ1WUgbJKrU42J6qA+YjLvP5lgccld5PsMlyOIg3v4fTdxszM3+qranM
         z2zZCIhks89TZYtlTYHaZBCK4arlxVZ7w19EsCH55o3Ase52w7Kb/CHl3ey3dSEukpxl
         EkiBj7ZXcw161FIS3NLUjOYVQ1vty1sz/ng6M/4/EcPp8oo/FGdb5PXtZjvtT6qDdMZ+
         ea+Ke91brRUHG2mWqks3Up/fKCa9CGHELdaLthRy4oPKOh8BAgd3Z7Ito0qIMM9fRedD
         BA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3uqBMSeJGt5aVACnS/d6hefrZCZrbS9j0DdqZ6VhFMo=;
        b=H2RdhjGdfsaJSLwb+RrfrQINDmZ+bvRRapnkRxwzt5gY7bekHERpZOQVZnMVw5aFRY
         NIZEKM4Bhtbh2Kf6q9m1RKJS7IxkNDWMwRCBLpSqn9MNDKw6+DEcIkgxYnDXP9kH4Xkl
         x9RGIIiMSn7zwy39aKmPIjaLyToFw1cypyuggVA+b8XJoMiCUzr2llDCHMf0d0sm0Ecm
         xXyu6NWv54OHtjxhTVsPRuc6Z5/Kr7di1KrNFBSr/jApm8ar12wFCvWit7eYEV/Rm2ZC
         d1f7IOkRDIQivmoS0qFiAfSajmTPgnO+w+F608CO2N9BNB/jQ43eXeH63gmEEddGhFmI
         K6cA==
X-Gm-Message-State: APf1xPAD8DE92fBLydzQVm7pJsXOFN7yTT+/MK3ZohKm34NOkdZxvpRF
        WmwnNYnjTpp1FCr3rV1b6XtjCnvb
X-Google-Smtp-Source: AH8x225TOAtjfRh3R7cCfaWPNOHEOuFekKey0UZhVpF7nKGOk3RFzLT6N95+zsZUAm1avE9XnYQe8w==
X-Received: by 10.28.140.1 with SMTP id o1mr2762612wmd.141.1518208361219;
        Fri, 09 Feb 2018 12:32:41 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y90sm5750233wrc.24.2018.02.09.12.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 12:32:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 04/17] remote: add a macro for "refs/tags/*:refs/tags/*"
Date:   Fri,  9 Feb 2018 20:32:03 +0000
Message-Id: <20180209203216.11560-5-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180209203216.11560-1-avarab@gmail.com>
References: <20180209203216.11560-1-avarab@gmail.com>
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a macro with the refspec string "refs/tags/*:refs/tags/*". There's
been a pre-defined struct version of this since e0aaa29ff3 ("Have a
constant extern refspec for "--tags"", 2008-04-17), but nothing that
could be passed to e.g. add_fetch_refspec().

This will be used in subsequent commits to avoid hardcoding this
string in multiple places.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote.c | 1 +
 remote.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/remote.c b/remote.c
index 4e93753e19..356c123e3e 100644
--- a/remote.c
+++ b/remote.c
@@ -22,6 +22,7 @@ static struct refspec s_tag_refspec = {
 	"refs/tags/*"
 };
 
+/* See TAG_REFSPEC for the string version */
 const struct refspec *tag_refspec = &s_tag_refspec;
 
 struct counted_string {
diff --git a/remote.h b/remote.h
index 1f6611be21..80fea6dd11 100644
--- a/remote.h
+++ b/remote.h
@@ -297,4 +297,6 @@ extern int parseopt_push_cas_option(const struct option *, const char *arg, int
 extern int is_empty_cas(const struct push_cas_option *);
 void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 
+#define TAG_REFSPEC "refs/tags/*:refs/tags/*"
+
 #endif
-- 
2.15.1.424.g9478a66081

