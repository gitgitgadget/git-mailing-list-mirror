Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB1B5201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932336AbdETVn6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:43:58 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35546 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753903AbdETVny (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:43:54 -0400
Received: by mail-wr0-f195.google.com with SMTP id g12so5761340wrg.2
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fO0avBZSlefSdPICPn7L/RdXOefPOca+Hygd7v6vvtE=;
        b=MwH1XBnmlLtmYw2Cl/UVVb6kMJuTrzwyw4k3lnsd7yJpiSEPDapIxm+QhZQUWLOUiL
         IljjluqHoWQ+YXXV7OFKr9zaLoeZ7/8IJ98rtjvvR/ZQYmgZN+4Q9Qg+s4pZ27zh3lyW
         1U1joi3GgTw1WDwThmE2TwiQPJuLZU9GimhP/t2o67e5szoFO6rkllYN/IpCnCRNPW0D
         uLbTIh4jBQv92t8HiLRTPmT2INMIQtO+H/13QMekdJlDGpwaRYtKo5b7JyPUDKf+Ifcf
         ceh/89vTBi/ff3qWZor8GwkJsQY//rz43Wki0OMW1NTcxFr8ASEvzoQIK6EfU/rp8yFE
         j2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fO0avBZSlefSdPICPn7L/RdXOefPOca+Hygd7v6vvtE=;
        b=lC4GN7kzgVUh9Kyupya99IrniAVCcWzEPsnehd/epQ7noQT0/nO3jvT+J4bGDOfc4N
         IGx2v8sIVRjBnKi0aciaBIpw9f7dXH/xjzb1dvlL4eOyhb4c7h2SIxv7adkBbz22kwbr
         5vE9eXL4jUEyzByGpU5ZsqUX1qDmxsvm2Fh7fhGqKVyWdjhfO+YxusgW+9Qn9qRagwcY
         puUeAA/r4kncPKd5Ioieog1Ei6In5U27BDTF5MhnDvKq4LZLkhw8Ww9effTMYOSxl7RD
         rrRtxkaes8hmB3vslupD5GjuLYkU4NVEf+ZsISO3U5lFbrAcVj2Kmp+0e5JfSk5/byHD
         CPoQ==
X-Gm-Message-State: AODbwcAnICY1HxmQ8VWdoaF2WNxfc9fXBsUAbZ5+g8iqYJbNiLEFb0Ez
        xk9jTrg/0fvbOg==
X-Received: by 10.223.135.84 with SMTP id 20mr7922528wrz.141.1495316632859;
        Sat, 20 May 2017 14:43:52 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:43:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 25/30] grep: move is_fixed() earlier to avoid forward declaration
Date:   Sat, 20 May 2017 21:42:28 +0000
Message-Id: <20170520214233.7183-26-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170520214233.7183-1-avarab@gmail.com>
References: <20170520214233.7183-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the is_fixed() function which are currently only used in
compile_regexp() earlier so it can be used in the PCRE family of
functions in a later change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/grep.c b/grep.c
index 07512346b1..1157529115 100644
--- a/grep.c
+++ b/grep.c
@@ -321,6 +321,18 @@ static NORETURN void compile_regexp_failed(const struct grep_pat *p,
 	die("%s'%s': %s", where, p->pattern, error);
 }
 
+static int is_fixed(const char *s, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (is_regex_special(s[i]))
+			return 0;
+	}
+
+	return 1;
+}
+
 static int has_null(const char *s, size_t len)
 {
 	/*
@@ -402,18 +414,6 @@ static void free_pcre1_regexp(struct grep_pat *p)
 }
 #endif /* !USE_LIBPCRE1 */
 
-static int is_fixed(const char *s, size_t len)
-{
-	size_t i;
-
-	for (i = 0; i < len; i++) {
-		if (is_regex_special(s[i]))
-			return 0;
-	}
-
-	return 1;
-}
-
 static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	struct strbuf sb = STRBUF_INIT;
-- 
2.13.0.303.g4ebf302169

