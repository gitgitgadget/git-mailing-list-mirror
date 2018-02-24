Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BF9F1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 03:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbeBXDe6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 22:34:58 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45162 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752949AbeBXDe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 22:34:57 -0500
Received: by mail-pl0-f66.google.com with SMTP id v9-v6so4021289plp.12
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 19:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dL/93X4C2NmD/cwvJ5pd98v5Arfsk03Eiklzo/xPx2U=;
        b=skBqbq5pq41RpZlhKcamtigDp2qvP/E65sdyQO0H1LoX7WmJSKjxTZ40NtWq5frTd5
         ywt7kcJRBbVUPmvGVdqusSpA3SKMQl9Mj8ak3HZNSTLiAmnC8AO8bqm+tOm2YszCR+nN
         1gQ2ReQEy9JyFV6BAY50vrsykcZG8EV72Kk7UBieKNvxwa1FM+3wXth4Y4+dsH2w6KQm
         L269cNEcdhBTPzU9YnB/A7arPiUAXgbfQCg/3/CEXDTbJ+kLyxnG0agyKN6F4IyLa0c+
         EwzlVpuv0eLgIyWRAkkASoLkRjY+JjwVFK7en+BxbJMIZqckqH0URcgdEZin91MEzIdm
         CLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dL/93X4C2NmD/cwvJ5pd98v5Arfsk03Eiklzo/xPx2U=;
        b=J8KBylQaleRIVfaCuZtvf1+QTKo4lqg4PE8mnu7T8psj5C1q0JguQrZi6Vc6duIxcv
         JE6o/Flrk2uwLO3FldfOkUYuRtjaPnXsTHPtIGwRufD6lQC9Rh54LmxmHQqci3UsoLqf
         sykW2XvUfSh+8izyv2EhLl6Arf8fkgNuMAL9aSmyjfpyqhu1EN03RFvpFsPWsRjChuys
         oj/kWgaFl/hNYS1HHL881UDRs8s0PbhEndCTd28QTjHicgTqASv3fFcI5AlPX2TFEKVQ
         rdx37SY3PB63hn01GvGU8QGXQc2/tG7rUN9rI9pNcPkAqffRzarJae9Iorppklzbb2Cs
         /Cuw==
X-Gm-Message-State: APf1xPAEuBGWE2YXD+pnRrhUvxtJovM1BoN0JhOrXkRRok5NAv5vN87Q
        mRjhdxLQS8sCG3scu0TxXE6sOw==
X-Google-Smtp-Source: AH8x226/wZ/hpi669+8oxdittLiHRELIx02ysUTkIAR/PVbvd7sJi+b8L8x6inmprgHc7orW8YqWdA==
X-Received: by 2002:a17:902:8a94:: with SMTP id p20-v6mr3739945plo.74.1519443297068;
        Fri, 23 Feb 2018 19:34:57 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id i4sm8430647pfa.40.2018.02.23.19.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 19:34:56 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 24 Feb 2018 10:34:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 3/5] index-pack: check (and optionally set) hash algo based on input file
Date:   Sat, 24 Feb 2018 10:34:27 +0700
Message-Id: <20180224033429.9656-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180224033429.9656-1-pclouds@gmail.com>
References: <20180223095640.25876-1-pclouds@gmail.com>
 <20180224033429.9656-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After 454253f059 (builtin/index-pack: improve hash function abstraction
- 2018-02-01), index-pack uses the_hash_algo for hashing. If "git
index-pack" is executed without a repository, we do not know what hash
algorithm to be used and the_hash_algo in theory could be undefined.

Since there should be some information about the hash algorithm in the
input pack file, we can initialize the correct hash algorithm with that
if the_hash_algo is not yet initialized. This assumes that pack files
with new hash algorithm MUST step up pack version.

While at there, make sure the hash algorithm requested by the pack file
and configured by the repository (if we're running with a repo) are
consistent.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/index-pack.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7e3e1a461c..1144458140 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -326,10 +326,31 @@ static const char *open_pack_file(const char *pack_name)
 		output_fd = -1;
 		nothread_data.pack_fd = input_fd;
 	}
-	the_hash_algo->init_fn(&input_ctx);
 	return pack_name;
 }
 
+static void prepare_hash_algo(uint32_t pack_version)
+{
+	const struct git_hash_algo *pack_algo;
+
+	switch (pack_version) {
+	case 2:
+	case 3:
+		pack_algo = &hash_algos[GIT_HASH_SHA1];
+		break;
+	default:
+		die("BUG: how to determine hash algo for new version?");
+	}
+
+	if (!the_hash_algo)	/* running without repo */
+		the_hash_algo = pack_algo;
+
+	if (the_hash_algo != pack_algo)
+		die(_("incompatible hash algorithm, "
+		      "configured for %s but the pack file needs %s"),
+		    the_hash_algo->name, pack_algo->name);
+}
+
 static void parse_pack_header(void)
 {
 	struct pack_header *hdr = fill(sizeof(struct pack_header));
@@ -341,6 +362,9 @@ static void parse_pack_header(void)
 		die(_("pack version %"PRIu32" unsupported"),
 			ntohl(hdr->hdr_version));
 
+	prepare_hash_algo(ntohl(hdr->hdr_version));
+	the_hash_algo->init_fn(&input_ctx);
+
 	nr_objects = ntohl(hdr->hdr_entries);
 	use(sizeof(struct pack_header));
 }
-- 
2.16.1.435.g8f24da2e1a

