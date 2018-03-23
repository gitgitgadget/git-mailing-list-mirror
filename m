Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C5C41F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeCWRWc (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:32 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45182 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbeCWRWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:22:09 -0400
Received: by mail-lf0-f65.google.com with SMTP id l4-v6so15049848lfg.12
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HRwy3wOiM6vvMz/Bx4Tkyq0VqhZvqsICbAGhZtxi/IU=;
        b=oC2lvd8aq0ZRvj7UYi/YOjQ+Y6jMwoAX7aUAS/T7dobXY3Rg6nPdTlHKDMrcRzU0UB
         cnvwLVwjKyRky2/RimQWDeWy0uV0o7Embo0TVgRNdv9YEfi+TI3R5gBOMigJkP1VQYYJ
         930xobhZNNlcfNvMU3o48XJkh9lZdKQAx3KnPIHxX7OM5xsKb28uq5YteMv8E2W7tQZE
         RCRprfzwDgrxAuEcxZz+HkiOphV1tiahPLBXYWVTHnZTDIousZ3W/S5giJ4dnkK8V0zZ
         VXaW9QmiPmJR4r6ps4d4ZqoAViG5SXTcr6doQU/XmBXMujhyfOg3gh6uSMMmT4pL7G1R
         tmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HRwy3wOiM6vvMz/Bx4Tkyq0VqhZvqsICbAGhZtxi/IU=;
        b=CGZwQOqynfOelniHntv/O8fbMrDu+jqnseinATzXD+FAzDcs7pZ9YFhdD12ZTVxzvE
         cwfzLveoEXYIK0YwXnj5h2tiUFZYhrn7/wTbo/fHcaLAKdYHP77EpK/3CylbIXsWZ251
         dGn0ghwHWx4jpWEpPE2Gcv4EmRkxLZgCLMjOiktRmd5SEL+OuJgkL8hs5ZNFm2VcxlI6
         CTBPlGCWyohj34TgAilxu9RHbCWFMvUr1ZHY+ZeIKWNqhOMdSaxbLO9VerOJTa9WeABa
         OOfgVXJBc+e3qs8mkrwbrr9yUcIHtq03pi9U0HH2YpqPZzwRfCZPIP7BcTrKixKcFzjZ
         gJaw==
X-Gm-Message-State: AElRT7GCLl54fBV11Cg8dc6OYcCuF13ppqCl8z2WheUF27777EP+rSw0
        E5WboOKNcVxDbiXOz72E8Pk=
X-Google-Smtp-Source: AG47ELvoLPalVbdiZVExD88nd1gHohVj5lNlvoewSaCFTcVoxqmGlD5ZyO4sMNQd97mU1t+KWFef0Q==
X-Received: by 2002:a19:5c84:: with SMTP id u4-v6mr19723219lfi.14.1521825727940;
        Fri, 23 Mar 2018 10:22:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:22:07 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 21/27] sha1_file: add repository argument to sha1_loose_object_info
Date:   Fri, 23 Mar 2018 18:21:15 +0100
Message-Id: <20180323172121.17725-22-pclouds@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index f968f67a14..74c68ea776 100644
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
2.17.0.rc0.348.gd5a49e0b6f

