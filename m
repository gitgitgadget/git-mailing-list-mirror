Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7834E1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 20:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeBYUfy (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 15:35:54 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44899 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbeBYUfu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 15:35:50 -0500
Received: by mail-wr0-f194.google.com with SMTP id v65so19116829wrc.11
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 12:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAQt/7rDrUEw/jjtv1IItHDhNMAxuoGXH9CSny4cY8Q=;
        b=e9fmBRvfKIjJnpAs2cmAsoRsMIXxC9bbr/7HmGfambE2IOcZEc7s0xX+/RayOpb6/D
         PMId77r0YBrTCzER1iRQu4tvq+j2Pe8b/Q6MwElX4/kVnoulHS4ha7qtb8UcaVTW15lw
         nZNLW0Af2o1/yrunzjj9Fmu8gUU4mzjPB6bNk/VEYih2UEmA/VR1Dmc2FTE/zuSMJF0K
         TSOemV1+mXub8LTt8Q+sCPKc7IWeH6tXY+6FlkyYOpYVPNJCTxdn7UkoP36wBLIy4HLE
         7Iz/By1nCoyQM/Cad4DyxoT2hqvYcmJ6UtIvUxjGrTOs8ft5X12xoJaguHtnh7JLFgEr
         OM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BAQt/7rDrUEw/jjtv1IItHDhNMAxuoGXH9CSny4cY8Q=;
        b=MY01GR7M04w3oobVXTEL/qpTWlddb2x2tcvvjrgxgEkNq0tDPOz4W4Buu3RwkVX4b2
         jGtPEIbAwmqzKd4AzQv8vujRZBskxeVk+abf9qdGOxMmgAEGWyZZgZKV0i8qaokN+SNv
         Irzwx4DhkfkfAaJQIdKcSHXG1RYFpLFwR0E+rTfvN9JN2JldG4GhJaevpqdoPrjycJpE
         wxSx0V/kH+ohjf4p1ZN8uILY9hb4Q25T5YPljwkJyWTACpdr/FCLwZEPywiLQP+ZT7jM
         boKPtTjQ31ylb664hpydhahZ2Aog33+fVWSTIboWji70h2lbHgauxEa3YAK/1vRPcYwT
         Jmug==
X-Gm-Message-State: APf1xPDP2NEoeWs2+jckuHFuZCNmTUmgp1lfj6WPfp1uWaC7lg1H0Z6C
        SWpN4ww0TAcmH+G8H+K4QbuxVKh1
X-Google-Smtp-Source: AH8x226A9+s6MEaVxNeZQJTXspgxAlGNfBNg8vuIG/PsCngAvgW4vfWHVKchxg0jE59XqvWCK3dYVw==
X-Received: by 10.223.186.206 with SMTP id w14mr7870652wrg.251.1519590948617;
        Sun, 25 Feb 2018 12:35:48 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 7sm6564268wmq.42.2018.02.25.12.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 12:35:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] wildmatch: add interface for precompiling wildmatch() patterns
Date:   Sun, 25 Feb 2018 20:35:36 +0000
Message-Id: <20180225203537.28318-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180225203537.28318-1-avarab@gmail.com>
References: <20180225203537.28318-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the scaffolding necessary for precompiling wildmatch()
patterns.

There is currently no point in doing this with the wildmatch()
function we have now, since it can't make any use of precompiling the
pattern.

But adding this interface and making use of it will make it easy to
refactor the wildmatch() function to parse the pattern into opcodes as
some glob() implementations do, or to drop an alternate wildmatch()
backend in which trades parsing slowness for faster matching, such as
the PCRE v2 conversion function that understands the wildmatch()
syntax.

It's very unlikely that we'll remove the wildmatch() function as a
convenience wrapper even if we end up requiring a separate compilation
step in some future implementation. There are a lot of one-shot
wildmatches in the codebase, in that case most likely wildmatch() will
be kept around as a shorthand for wildmatch_{compile,match,free}().

I modeled this interface on the PCRE v2 interface. I didn't go with a
glob(3) & globfree(3)-like interface because that would require every
wildmatch() user to pass a dummy parameter, which I got rid of in
55d3426929 ("wildmatch: remove unused wildopts parameter",
2017-06-22).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 wildmatch.c | 25 +++++++++++++++++++++++++
 wildmatch.h | 11 +++++++++++
 2 files changed, 36 insertions(+)

diff --git a/wildmatch.c b/wildmatch.c
index d074c1be10..032f339391 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -276,3 +276,28 @@ int wildmatch(const char *pattern, const char *text, unsigned int flags)
 {
 	return dowild((const uchar*)pattern, (const uchar*)text, flags);
 }
+
+struct wildmatch_compiled *wildmatch_compile(const char *pattern,
+					     unsigned int flags)
+{
+	struct wildmatch_compiled *wildmatch_compiled = xmalloc(
+		sizeof(struct wildmatch_compiled));
+	wildmatch_compiled->pattern = xstrdup(pattern);
+	wildmatch_compiled->flags = flags;
+
+	return wildmatch_compiled;
+}
+
+int wildmatch_match(struct wildmatch_compiled *wildmatch_compiled,
+		    const char *text)
+{
+	return wildmatch(wildmatch_compiled->pattern, text,
+			 wildmatch_compiled->flags);
+}
+
+void wildmatch_free(struct wildmatch_compiled *wildmatch_compiled)
+{
+	if (wildmatch_compiled)
+		free((void *)wildmatch_compiled->pattern);
+	free(wildmatch_compiled);
+}
diff --git a/wildmatch.h b/wildmatch.h
index b8c826aa68..2fc00e0ca0 100644
--- a/wildmatch.h
+++ b/wildmatch.h
@@ -10,5 +10,16 @@
 #define WM_ABORT_ALL -1
 #define WM_ABORT_TO_STARSTAR -2
 
+struct wildmatch_compiled {
+	const char *pattern;
+	unsigned int flags;
+};
+
 int wildmatch(const char *pattern, const char *text, unsigned int flags);
+struct wildmatch_compiled *wildmatch_compile(const char *pattern,
+					     unsigned int flags);
+int wildmatch_match(struct wildmatch_compiled *wildmatch_compiled,
+		    const char *text);
+void wildmatch_free(struct wildmatch_compiled *wildmatch_compiled);
+
 #endif
-- 
2.15.1.424.g9478a66081

