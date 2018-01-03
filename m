Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 455031F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbeACQe4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:34:56 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:44354 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeACQey (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:54 -0500
Received: by mail-wm0-f52.google.com with SMTP id t8so3632662wmc.3
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aJIyEeuSTAXqm656jN1U390V0izGsHnHgt7zOkNjdB0=;
        b=r/MAgd7U7mxoYBS+RHWI4YlSQrgsWTnPx1lVC0/IPP3TDzar8wq3SbQm3Foc/ReZ0P
         aENJqoBeTD/NmND5XVn1m7XgSgD8WE+cGvu9m8Xa+2ebtQE4RFd4vrporBkbB4E9T2fw
         eshO5LVKWB36NrxFPBTXA6UFMB5roNkugSOb/L8QE/GbtGZOEoGlDTeXWKOzXbCUBAXS
         NDW0Lv2vFn47orrl+QL9bZ6vfEBhfebyvcV6I3Jkpkm87CKnmmxNymuuwYkrZq2uON5u
         IF+R6FvoHRLh+fGWgHUYRPKIeODcxKA13swR8jHPu4G9NyAf/rlWi3vvL9zKvb1HxOwJ
         187Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aJIyEeuSTAXqm656jN1U390V0izGsHnHgt7zOkNjdB0=;
        b=UaWwRZYrjPXSVIPuaZK6RN2R2KfOQLYySMDpyf2DQ9GovGF0XLoU+iHlq84Jyh1WF6
         X0v/nxERi+DXw1BWCmtGHZKO5bp+7lLsTjFp6ArsfyUC+A+iKGeZ7byngLtKWt6QKkog
         rcj1wLOx7HqZvnRymeBUeWZQZ3HmaDmjNqrPngQgBFmzAs9YO0pmCwFZNXCTm1pGHQ+C
         CCKkpfsphHa50YCWm3n3LKUBhhAJRsuXcwypG+flU7fDWt+IQmt1jAPWWhMlMOZtZUpt
         UM8nc4Ckf+d4bes5wckNGQ7rc9Q8LD2FrCcJ6Bt2cU7h/Z3u9Foyt4Jv1nS+S71Hxlz4
         UmdQ==
X-Gm-Message-State: AKGB3mLts2U/rvxnfOuh5iIyizAA2AqX2LoIgeJi4lzLmggFsqZBGn7W
        dUJS5g8IZgnM4I/6CTH9ahFpNMQU
X-Google-Smtp-Source: ACJfBot761ru5EbY7PnxXQdF449+EPmERQEM0QKFKDbUIVImYurbLQf3xDRgP4UUge4NrNLzTUGj9Q==
X-Received: by 10.28.229.213 with SMTP id c204mr2038498wmh.57.1514997293319;
        Wed, 03 Jan 2018 08:34:53 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:52 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 24/40] lib-httpd: add upload.sh
Date:   Wed,  3 Jan 2018 17:33:47 +0100
Message-Id: <20180103163403.11303-25-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This cgi will be used to upload objects to, or to delete
objects from, an apache web server.

This way the apache server can work as an external object
database.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/lib-httpd.sh        |  1 +
 t/lib-httpd/upload.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 t/lib-httpd/upload.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 2e659a8ee2..d80b004549 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -132,6 +132,7 @@ prepare_httpd() {
 	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
 	install_script broken-smart-http.sh
 	install_script error.sh
+	install_script upload.sh
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
diff --git a/t/lib-httpd/upload.sh b/t/lib-httpd/upload.sh
new file mode 100644
index 0000000000..64d3f31c31
--- /dev/null
+++ b/t/lib-httpd/upload.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+# In part from http://codereview.stackexchange.com/questions/79549/bash-cgi-upload-file
+
+FILES_DIR="www/files"
+
+OLDIFS="$IFS"
+IFS='&'
+set -- $QUERY_STRING
+IFS="$OLDIFS"
+
+while test $# -gt 0
+do
+	key=${1%%=*}
+	val=${1#*=}
+
+	case "$key" in
+	"sha1") sha1="$val" ;;
+	"type") type="$val" ;;
+	"size") size="$val" ;;
+	"delete") delete=1 ;;
+	*) echo >&2 "unknown key '$key'" ;;
+	esac
+
+	shift
+done
+
+case "$REQUEST_METHOD" in
+POST)
+	if test "$delete" = "1"
+	then
+		rm -f "$FILES_DIR/$sha1-$size-$type"
+	else
+		mkdir -p "$FILES_DIR"
+		cat >"$FILES_DIR/$sha1-$size-$type"
+	fi
+
+	echo 'Status: 204 No Content'
+	echo
+	;;
+
+*)
+	echo 'Status: 405 Method Not Allowed'
+	echo
+esac
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

