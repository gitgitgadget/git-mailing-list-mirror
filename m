Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28E0B1F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932132AbeCCLi4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:38:56 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34380 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeCCLiz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:38:55 -0500
Received: by mail-pf0-f194.google.com with SMTP id j20so5145114pfi.1
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZU7cmxx+YlDvO47X4pIPtDyDOXtAgaTdhEZI/+hTrqU=;
        b=BKeFmqW+YeHlCcjZblKsoC+e0lTP7caCkFvwlw3ejTGxlxieLbYgkOab6kMbFEpKa9
         2w5V0zt4t8VVOzmck+nCjSS23YCfvBFFXz1/4u+ssg+eF16jc51/9c+qspOwgFoZRMnE
         hqfaZGg/ehLLkGtF0wFxPRE0I5LtsxDqT6B6qGEorLuqouXsX+rvxeRc3kKJ9CGEjLzz
         L3hR5umICR1ndHSqWq2OykE9qd26mY7rYL2SIZBR16X9xhy2F+s4UhXkeBuOwmz7NXv2
         FcmfVx+GPUnFP4cfhTZKBD0JipTxDwo4RX8sKx/tKKkniWzyI4YSmOsQoZwFrzzyMSG8
         2fPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZU7cmxx+YlDvO47X4pIPtDyDOXtAgaTdhEZI/+hTrqU=;
        b=Lpoe8GFybZ3oVcVf1wf39eioJeCZrgAI4nOv6Ai6XIWirUl/zpr41dW/z4yg3fwPJ9
         dmtw/7imEatLtQ2WROVk7Z5Lpb0m7pqIxLTWcd6ncKTVV77NyqXM41aQP0MWA6Wo+AY2
         KZKQOKO3wontVtUa4FxJU5Z1xTc09HShYE810dQZKwS2+UmGVbcfVntDxiWqE2uBRh7y
         wGInOvd7ilehbaC0eYmyfhCo3f/dThpeHeKWAp7Jx7EfrIB0446F7Zz3bGlu1Z41xe5+
         EJGXKpAFg2MdFFU52GI3oP6PCAIju2gn8CWF/NJ1hfqfLm6kHwzE0t1mBETdK666FQEZ
         GYGw==
X-Gm-Message-State: APf1xPC2G0xz7ja4coLSDdfJvJ6xSb1EutfvdyafnEBvA2yRq2r54tEZ
        y63QKXAkF2dC7L7Tx2mqH9JUjw==
X-Google-Smtp-Source: AG47ELtFcN/5qIKpZpeRwnDmGg+5Ngi5EY0+DdKj5jjjpk8f1Zzn3xDS9Rbm+Vy4mAbvGG6jkJ/i4w==
X-Received: by 10.98.64.73 with SMTP id n70mr8889383pfa.142.1520077134905;
        Sat, 03 Mar 2018 03:38:54 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id c129sm2250287pfa.105.2018.03.03.03.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:38:54 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:38:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 26/44] sha1_file: add repository argument to sha1_loose_object_info
Date:   Sat,  3 Mar 2018 18:36:19 +0700
Message-Id: <20180303113637.26518-27-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Add a repository argument to allow the sha1_loose_object_info caller
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1_file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 536c45589b..ecbf846f12 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1152,9 +1152,10 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-static int sha1_loose_object_info(const unsigned char *sha1,
-				  struct object_info *oi,
-				  int flags)
+#define sha1_loose_object_info(r, s, o, f) sha1_loose_object_info_##r(s, o, f)
+static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
+						 struct object_info *oi,
+						 int flags)
 {
 	int status = 0;
 	unsigned long mapsize;
@@ -1273,7 +1274,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 			break;
 
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi, flags))
+		if (!sha1_loose_object_info(the_repository, real, oi, flags))
 			return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
-- 
2.16.1.435.g8f24da2e1a

