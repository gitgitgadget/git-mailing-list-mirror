Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB44A20248
	for <e@80x24.org>; Wed, 13 Mar 2019 23:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfCMXzF (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 19:55:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54953 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfCMXzF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 19:55:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id f3so1058973wmj.4
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 16:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XX/jh7qLjwSXIk8Lrvs4uGkUb9EK2/I5dg5uY7163cM=;
        b=qCdCZhcZNe4aNcbUozc7yoqrAoYfOpSZ82hcE9Y9c7DuIOCugnCdKnOZ5du5fgGvK4
         VuKkcvNOkYpp5VZAhVpQ/H9lYLMXKL62eYF4oCMfviMOoKiTSF3XhM+Djv+zMQWxTTlT
         McBvZbhOxaDdHUeJQnOPCv9jTKdll+eiyrhOAswohlocSbstLU2t2dvYWh/w+/hcTBWl
         I2OxMRcSLAKdrGmNpGdYeLDoIKbhmULVN/m5uXvT/+bvkkH2M1dgYLbOsaLsReo2jLsE
         72PMPJj7vqo7a77dE3wDKmS+j/MPhKUPtr1XW1QSatu39cJjLpdPfk+5cCEhkWLNIYDZ
         t/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XX/jh7qLjwSXIk8Lrvs4uGkUb9EK2/I5dg5uY7163cM=;
        b=thOS/Ee62i+17epQVEFtd14JnRdnIt3RE2HtYptYSFn3C6OOniF7raBhMUT6f2i4xT
         4eDpXm26lKyqkC88Ri0EF23QGwPJSaetiNP8eBFaJ4fogW9Wr1qVmNYULwHuZooBsHRL
         QUgvzLg9GE/NetClFA+ObpMzo21zTAhlUeniLBksAdV8SSL6kalV4WOvFOqSHOPSr7W5
         Hkq9EmRVR/SEeNO6wdQqqZMeq9yKnIkZm4u8W6nk6CSNYSIbmdB2nt7aJ1t8SB/EoxUN
         rxglBhDLdK2iF+kFz5MOGUVYvT4VlQnzvpL4kecwiN1GsUwX1mywWlFE7bvGEJUrksZ+
         ZweQ==
X-Gm-Message-State: APjAAAVxnk292JCwPA4vMQ1B2A+enliDqN9PG3d5aLCA1rJPSXSE5Bhd
        rdR7llFa5BBQSPC874TZO1x4OJweL6M=
X-Google-Smtp-Source: APXvYqwj02YVzT24ia5qR/xemkuec9ELyfZkQxUnx06RftZy1vDWjn3cU6ZDrqL1hQShI5e9KYDIKw==
X-Received: by 2002:a7b:c929:: with SMTP id h9mr435281wml.106.1552521303269;
        Wed, 13 Mar 2019 16:55:03 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b10sm9998566wru.92.2019.03.13.16.55.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 13 Mar 2019 16:55:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] gc: refactor a "call me once" pattern
Date:   Thu, 14 Mar 2019 00:54:37 +0100
Message-Id: <20190313235439.30439-4-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <87imwmbv7l.fsf@evledraar.gmail.com>
References: <87imwmbv7l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an idiom we're using to ensure that gc_before_repack() only
does work once (see 62aad1849f ("gc --auto: do not lock refs in the
background", 2014-05-25)) to be more obvious.

Nothing except this function cares about the "pack_refs" and
"prune_reflogs" variables, so let's not leave the reader wondering if
they're being zero'd out for later use somewhere else.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 9c2c63276d..425d0fa830 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -490,14 +490,15 @@ static int report_last_gc_error(void)
 
 static void gc_before_repack(void)
 {
+	static int done = 0;
+	if (done++)
+		return;
+
 	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
 		die(FAILED_RUN, pack_refs_cmd.argv[0]);
 
 	if (prune_reflogs && run_command_v_opt(reflog.argv, RUN_GIT_CMD))
 		die(FAILED_RUN, reflog.argv[0]);
-
-	pack_refs = 0;
-	prune_reflogs = 0;
 }
 
 int cmd_gc(int argc, const char **argv, const char *prefix)
-- 
2.21.0.360.g471c308f928

