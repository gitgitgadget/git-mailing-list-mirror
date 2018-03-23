Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DC171F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeCWRWV (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:21 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40957 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbeCWRWS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:22:18 -0400
Received: by mail-lf0-f67.google.com with SMTP id e5-v6so19405346lfb.7
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ch3F8I4S+vByiDWlf3aOpJT3POtuXc1r/PdiQaQO7S4=;
        b=uH0AH5NuuHIlwGACaahHWvwiu8PkGHzyzIwxfKbXkr/E8D+ZnMJTgXnOJmraa/g+Y0
         M0/0DICdtWv8jB0ivKj2wqQN3E53rGeWpCdJ8M61lBvu+sa18wnIaZ7zcKlt6Bch1/H3
         uKKGKO5T++ghfsUZrJtmMUVFJCz+qd8rHD6AeY63KCvCKXUinoLk69UKTNxKS00jIiod
         6u4/5TSSPIE5+rtTB+rVM0QfZpCN2CHF3HvWEGkbRe29i/QzfkPPt02Fhyrp7oVhs7nh
         y7TlXaYjPLNcaTJmFY3h0/OOCi8xsTp/LJt4G2DMnn2AlKbnfGaFcRQDT6Ao6GdqyxuQ
         +v0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ch3F8I4S+vByiDWlf3aOpJT3POtuXc1r/PdiQaQO7S4=;
        b=Z0EEkT038nWStFEs3MVwaUqwp4HzEK9vT17aBDcJlJdngzfJeQiOCyVqIHFJ+RA9Og
         VBTqHcaS1ekRrDaqsCqGl1HTjsqmyX4HtW7HumzR/22AHsjL4g1FfwEeSFLh7qS/ejjI
         WJUMi2jfl2chWlSzWdewPIpbIJUqTdGX5IH16gNRWdC/P99o4fxk+TqDaCFbYS9cvcxy
         2ePBo9XE6t8R37FarhNqvk6QKH1SOUYfyp0/JuTHX1RPGiFhshIbRZYv5AqFxxhbD5xc
         w+asRRsl/7zbLaNBydc2BYDE7RTY1atDp26eU9CIn8Wk1Nct6SipSCA27s0qDjFdyVlc
         2CjQ==
X-Gm-Message-State: AElRT7GreI5Y7VJdfGYI9IlUm31LWcZK8BRub7P7gUb8EluWYumdOAAI
        klGSYvt8jP+DwB6jfSymEEM=
X-Google-Smtp-Source: AG47ELu2/PPtaKY8r/hYNbwBIBTqqjK1h0W27wkSmaWqoigTYMwQcvcMvsV9z+MRXE+ddm0alWDkjQ==
X-Received: by 2002:a19:e9cc:: with SMTP id j73-v6mr18008132lfk.99.1521825736747;
        Fri, 23 Mar 2018 10:22:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:22:15 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 27/27] sha1_file: allow sha1_loose_object_info to handle arbitrary repositories
Date:   Fri, 23 Mar 2018 18:21:21 +0100
Message-Id: <20180323172121.17725-28-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 9addad6887..0989bbd948 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1149,10 +1149,9 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-#define sha1_loose_object_info(r, s, o, f) sha1_loose_object_info_##r(s, o, f)
-static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
-						 struct object_info *oi,
-						 int flags)
+static int sha1_loose_object_info(struct repository *r,
+				  const unsigned char *sha1,
+				  struct object_info *oi, int flags)
 {
 	int status = 0;
 	unsigned long mapsize;
@@ -1176,14 +1175,14 @@ static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
 	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
-		if (stat_sha1_file(the_repository, sha1, &st, &path) < 0)
+		if (stat_sha1_file(r, sha1, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
 		return 0;
 	}
 
-	map = map_sha1_file(the_repository, sha1, &mapsize);
+	map = map_sha1_file(r, sha1, &mapsize);
 	if (!map)
 		return -1;
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

