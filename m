Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 180B41F404
	for <e@80x24.org>; Sat, 24 Feb 2018 03:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752942AbeBXDex (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 22:34:53 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45713 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752927AbeBXDew (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 22:34:52 -0500
Received: by mail-pf0-f195.google.com with SMTP id j24so4304853pff.12
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 19:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VjBuujGFkFRxhrZfH7bzsFY4cLnSvp2Z+zMU3GH6ZSk=;
        b=dR7HiANYKWYf+EX+997L79WdmZyZ8ParNViSTJSps0nrGNC5vAI4a3hF0ZKIAyxcnP
         VLayJyTL8Dbc8pm+d7rA6Xc+2sLiZQjaTI4kpwD4WW3+tVJq8sCp5hClS+eQmqFD5xUO
         NFPpXpUEw4j3rC/dbYqJ0efxu7PCD/QH/yFD+npq+MCOuhzM1jOHjBcjZwtcK4QTa2bn
         BVJlGsVNZJ62dcgBNtbMpuai4c1fkPWq+pujMWe8pb5DCLSk6Hpdew+AQOOxISpwc6ht
         n5Ke/nd+9PEnTkwf6lAKQ1F1xRKD6QViOHPQ5g2Exhhc4GRKhNZQIq8pGcmt6EEvzZ8y
         pOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VjBuujGFkFRxhrZfH7bzsFY4cLnSvp2Z+zMU3GH6ZSk=;
        b=fZmd/VGz24ddReK093YduXwXPK/bAp9DjrSYmWL2ECAftCeEp+W+GDCLnlQkx52SfS
         xD5riCF4Eezz7J9KsrlyNbLkGzVaqUEisoM9+ghABnen6YbnYR19tvmUf4BAergGkAJF
         zRPy+0r0u6KpWnG52L1dq2w43mKlhBNBpWc6b4DKImDKV7SZVoyq6xBkL3NNj3WHTsDe
         Av7BgylCsR1FdBS+GQSwJZqS9JtrGlJzblnTZNlVEI9DIHqQCtf6BHIHbyYIoD2TD2JM
         wo1My3j6Re0yknlB92xzqe/msUAbXGhfRIevr8qeT84yM08MaYbO+DXbxcgiCKJs03TT
         MA/g==
X-Gm-Message-State: APf1xPA9Fzv8tUbplI4/1XYPCKEQLlG10kPvo4qdANAR3tufwXFBJloH
        2Ov1rqeBY9e6aVjQKvi5avxF3A==
X-Google-Smtp-Source: AH8x226Z1wzeELMneEonXh0o1ahT2Aix7lED/Lr/PlByPibpzBoFpFQhMlJ3OvWMKjWexjv86h6IRg==
X-Received: by 10.101.86.198 with SMTP id w6mr3026210pgs.434.1519443291683;
        Fri, 23 Feb 2018 19:34:51 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id x26sm6525022pfi.141.2018.02.23.19.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 19:34:51 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 24 Feb 2018 10:34:46 +0700
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
Subject: [PATCH v2 2/5] sha1_file.c: keep a good name for "unknown" hash_algos[UNKNOWN]
Date:   Sat, 24 Feb 2018 10:34:26 +0700
Message-Id: <20180224033429.9656-3-pclouds@gmail.com>
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

This is mostly for displaying the hash algorithm name when we report
errors. Printing "unknown" with '%s' is much better than '(null)' in
glibc printf version (and probably could crash if other implementations
do not check for NULL pointer)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 826d7a0ae3..4b266b1c68 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -71,7 +71,7 @@ static void git_hash_unknown_final(unsigned char *hash, git_hash_ctx *ctx)
 
 const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	{
-		NULL,
+		"unknown",
 		0x00000000,
 		0,
 		0,
-- 
2.16.1.435.g8f24da2e1a

