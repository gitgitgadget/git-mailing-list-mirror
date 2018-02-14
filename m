Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AB901F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162599AbeBNTC1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:02:27 -0500
Received: from mail-io0-f201.google.com ([209.85.223.201]:38058 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162565AbeBNTCU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:02:20 -0500
Received: by mail-io0-f201.google.com with SMTP id q195so20922681ioe.5
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=5ZrdlIDw8sfKWBCh5rwT57qc8Z1TgBydBXYaoIfownE=;
        b=mA0PRDvrk/nE4X37/V4psaaYx4/lMRna5IfSEfVXNGmWadY2yN6RUSnjau5sIMtadM
         X4TW3Guvohm0VH546UKzFvwjfqFQI4AqAwKriMC2vdlJiyBG/HZsqyUD2TC3YMzkpSKV
         ZU8ZfNmtiYJMsmh/esd6BD/BXqvW+lxEL5pI1cUclNtx0ixE7NXkyNO3nMSUCshZjVqv
         jr9rBXTCxYolcbI6k8fsUi+j7iNQ/CqBQ2UoXVjV2sN6VdBw1rvNZW0UBRPzUpcI9uT6
         P3dYr70GifpMbQ0tVVmlzPS4TvBIP2+XRxZxE+Q5WtINWsK3FWyJ0M23OszeaGOYWHHa
         zRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=5ZrdlIDw8sfKWBCh5rwT57qc8Z1TgBydBXYaoIfownE=;
        b=TmjGa0AACBBwM4150LvoeHJIyYALNMDbgoEwYinMtN7FciqHwqTKBpRQkFu2r6BpiC
         mzse+IZOYtlszxr8Ep310cYZ3NIaJMaKK2HEz765DYB+ooQEt6MHuW7qxU34d/EhfsQM
         hwSWaWfypbkuXAq7s374vEs8FTBhRxTCRIjlwcjzteLb3KX5MPJgBkZk0D8S2K0KRZPf
         FLGOdNMsx/ZNRLJ2sjbRph+Dw34MV4vFKeni0ZXct/Ao0QDGpXENWUX1DH4oYKmHsNTu
         GvtfKBO26+8hF+hYkoGKChjEqLyc+ocrw4sMIBcKZHsiYzMOsEN15jkFNfIY5ZzUEci7
         LDbA==
X-Gm-Message-State: APf1xPB2kasKUAvIiKAj0l74bdH7N/CFiitU0Xg2bGwgSjV38Zd/vj5P
        ClQhEjrlsHbWMCj/tYb8GA8w6Fe8tEGMPD/e5F/8SsLszkzk3jf/+hvV08nXeTHF+k+wwQofUTO
        FcZDSQJG2rVHdFk+jImT5PIm4xeeuKRutVJjgr0TnnN//Y8lBHM7FiI4NAg==
X-Google-Smtp-Source: AH8x226/pKwq9AkGmi1Ro9DwodLJlMRDrlF8hmPoE1LIzUsyBk5Jy20BXqNBFcL1nxT5KRcbLGi7TMLZ7Xc=
MIME-Version: 1.0
X-Received: by 10.36.66.203 with SMTP id i194mr6554itb.46.1518634939225; Wed,
 14 Feb 2018 11:02:19 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:58 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-37-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 36/37] trailer: rename 'template' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 trailer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/trailer.c b/trailer.c
index 5a4a2ecf9..c508c9b75 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1000,7 +1000,7 @@ static struct tempfile *trailers_tempfile;
 static FILE *create_in_place_tempfile(const char *file)
 {
 	struct stat st;
-	struct strbuf template = STRBUF_INIT;
+	struct strbuf filename_template = STRBUF_INIT;
 	const char *tail;
 	FILE *outfile;
 
@@ -1014,11 +1014,11 @@ static FILE *create_in_place_tempfile(const char *file)
 	/* Create temporary file in the same directory as the original */
 	tail = strrchr(file, '/');
 	if (tail != NULL)
-		strbuf_add(&template, file, tail - file + 1);
-	strbuf_addstr(&template, "git-interpret-trailers-XXXXXX");
+		strbuf_add(&filename_template, file, tail - file + 1);
+	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
 
-	trailers_tempfile = xmks_tempfile_m(template.buf, st.st_mode);
-	strbuf_release(&template);
+	trailers_tempfile = xmks_tempfile_m(filename_template.buf, st.st_mode);
+	strbuf_release(&filename_template);
 	outfile = fdopen_tempfile(trailers_tempfile, "w");
 	if (!outfile)
 		die_errno(_("could not open temporary file"));
-- 
2.16.1.291.g4437f3f132-goog

