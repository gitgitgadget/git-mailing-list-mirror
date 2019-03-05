Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB38720248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfCEMIw (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:08:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42489 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCEMIw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:08:52 -0500
Received: by mail-pf1-f195.google.com with SMTP id n74so5542065pfi.9
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+SpRpoyuCvPOUAW9J9c5ZDi9NaLC6SQncNkAuMgYlOE=;
        b=HzX8KTrOIih2V/1tNxEB9+S9HPeWcWcTZqcVw8HqDTJc+LyKVVSfbiZh5KOJeIvG6l
         8Rw94ZCnZteGB9jvgJpk3WrT5OUElNKH7s5y5OujV4RM3v+2t89AhfLgVtN+0iUjlU2S
         7U+ukEoDFRF9UbiaCHJMWC4aIs9sDA04/uvvFdP81DRWLu0M5rEenrm9PzkoKxi0zoRz
         7Kokfu3qCjmbmz2ZI/EiDMEnEMNIVpJmilypNuh7XyevTSefXz1qlTDk5vtkJu8LE4jU
         pzSRqB8RrkutIGGT3/k3H4nOKx11H97n9oN11Y19FA6qFTyFkz4ZJDnIW0iYs9Fj80bD
         /zwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+SpRpoyuCvPOUAW9J9c5ZDi9NaLC6SQncNkAuMgYlOE=;
        b=j7vI+WBS1MAkDWFt23TRv01c6dsjoW2VZuwicGblGId5xLJSFIY7QVja37aQ2t93ZW
         1ouhRgVdLoa9/6DBzUEQljyxTVQTZuaABdiFK7GfS64nwf7rvfqls6CEBsCZrVG2S66z
         PHIQXUffpTZBV+F7CcvPGoaXYOV7YoogWsJImH0ZfVWc5dPX9dsOXyyQgAfGxagHqnRG
         fVDQTaUUKisSGQ8vgk01dU2slPmDqW8WIYdg7jkgBWV1CRfSEtmFp0UEg5N6DxdKx0AE
         PEfs+ztzJkdXFuP5+mniC9Mwumla8LPTUPX4HOBc6edpKsaRGgBJAnvoIZZODRTQAhlU
         Am6A==
X-Gm-Message-State: APjAAAWhRRdmBqXCeVyPMQSGbCNVJLs4q0uGgHZVkZoTjZA3ERsCh12o
        EYXAjU8YiaCGTTF1PKM/JbI=
X-Google-Smtp-Source: APXvYqzqe7Xu2PST14tl2DWFqUkWXq/fFW1T9s8jgvVWyYCYw4uLiJ6y0KfFpOzHmyuhXWNLDgtPvA==
X-Received: by 2002:a17:902:59c1:: with SMTP id d1mr868479plj.324.1551787731416;
        Tue, 05 Mar 2019 04:08:51 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id y70sm12517300pgd.6.2019.03.05.04.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:08:50 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:08:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, hi-angel@yandex.ru, peff@peff.net,
        ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v4 1/2] refs.c: refactor check_refname_component()
Date:   Tue,  5 Mar 2019 19:08:33 +0700
Message-Id: <20190305120834.7284-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190305120834.7284-1-pclouds@gmail.com>
References: <20190226105851.32273-1-pclouds@gmail.com>
 <20190305120834.7284-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The core logic of this function is factored out to provide more
information when the refname is invalid: what part that is and exact
what is wrong with it. This will be useful for a coming function that
has to turn a string into a valid refname component.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 142888a40a..70c55ea1b6 100644
--- a/refs.c
+++ b/refs.c
@@ -57,10 +57,21 @@ static unsigned char refname_disposition[256] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
 };
 
+enum refname_check_code {
+	 refname_ok = 0,
+	 refname_contains_dotdot,
+	 refname_contains_atopen,
+	 refname_has_badchar,
+	 refname_contains_wildcard,
+	 refname_starts_with_dot,
+	 refname_ends_with_dotlock,
+	 refname_component_has_zero_length
+};
+
 /*
  * Try to read one refname component from the front of refname.
- * Return the length of the component found, or -1 if the component is
- * not legal.  It is legal if it is something reasonable to have under
+ * If the component is legal, return the end of the component in cp_out.
+ * It is legal if it is something reasonable to have under
  * ".git/refs/"; We do not like it if:
  *
  * - any path component of it begins with ".", or
@@ -71,11 +82,15 @@ static unsigned char refname_disposition[256] = {
  * - it ends with a "/", or
  * - it ends with ".lock", or
  * - it contains a "@{" portion
+ *
+ * in which case cp_out points to the beginning of the illegal part.
  */
-static int check_refname_component(const char *refname, int *flags)
+static enum refname_check_code do_check_refname_component(
+	const char *refname, int *flags, const char **cp_out)
 {
 	const char *cp;
 	char last = '\0';
+	enum refname_check_code ret = refname_ok;
 
 	for (cp = refname; ; cp++) {
 		int ch = *cp & 255;
@@ -84,18 +99,28 @@ static int check_refname_component(const char *refname, int *flags)
 		case 1:
 			goto out;
 		case 2:
-			if (last == '.')
-				return -1; /* Refname contains "..". */
+			if (last == '.') {
+				cp--;
+				ret = refname_contains_dotdot;
+				goto done;
+			}
 			break;
 		case 3:
-			if (last == '@')
-				return -1; /* Refname contains "@{". */
+			if (last == '@') {
+				cp--;
+				ret = refname_contains_atopen; /* @{ */
+				goto done;
+			}
 			break;
 		case 4:
-			return -1;
+			ret = refname_has_badchar;
+			goto done;
 		case 5:
-			if (!(*flags & REFNAME_REFSPEC_PATTERN))
-				return -1; /* refspec can't be a pattern */
+			if (!(*flags & REFNAME_REFSPEC_PATTERN)) {
+				/* refspec can't be a pattern */
+				ret = refname_contains_wildcard;
+				goto done;
+			}
 
 			/*
 			 * Unset the pattern flag so that we only accept
@@ -107,13 +132,34 @@ static int check_refname_component(const char *refname, int *flags)
 		last = ch;
 	}
 out:
-	if (cp == refname)
-		return 0; /* Component has zero length. */
-	if (refname[0] == '.')
-		return -1; /* Component starts with '.'. */
+	if (cp == refname) {
+		ret = refname_component_has_zero_length;
+		goto done;
+	}
+	if (refname[0] == '.') {
+		cp = refname;
+		ret = refname_starts_with_dot;
+		goto done;
+	}
 	if (cp - refname >= LOCK_SUFFIX_LEN &&
-	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN))
-		return -1; /* Refname ends with ".lock". */
+	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN)) {
+		cp -= LOCK_SUFFIX_LEN;
+		ret = refname_ends_with_dotlock;
+	}
+done:
+	*cp_out = cp;
+	return ret;
+}
+
+/* Return the length of the component if it's legal otherwise -1 */
+static int check_refname_component(const char *refname, int *flags)
+{
+	const char *cp;
+	enum refname_check_code ret;
+
+	ret = do_check_refname_component(refname, flags, &cp);
+	if (ret)
+		return -1;
 	return cp - refname;
 }
 
-- 
2.21.0.rc1.337.gdf7f8d0522

