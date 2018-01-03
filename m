Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C20C31F42B
	for <e@80x24.org>; Wed,  3 Jan 2018 16:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbeACQe7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:34:59 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:38181 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbeACQe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:56 -0500
Received: by mail-wr0-f174.google.com with SMTP id y9so2153453wrb.5
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1+koBSb1GKq2T3Jg1cWsMNJ0iN+8MQ2CjlSXzSZQf0s=;
        b=CMFiN1uKXx+4qd8KUoJLQRDHnKpZ/Hs1j48biCr+hmFen7jnlbNPt5vjBvFC9N708i
         W4k6KaUQWM8uELNvlwPWtluD7O4a1oXrpuORKs/viLFfqdvkK5I5UC7RwxoQOFK3QAFA
         H6uzhSbycQmh7D8M0ceYlpeVfRL6OgtjMFv4UDoUIbMiFb4EYPZL583NYfTlwtQF+3YV
         m38XqT/kFZngOpFl6GQWxhqVxIM03Gf+1oMnaDRZxxAXUXWLDz3BZnDtl2xapu6LgQhd
         V1Ybf03CwVaZDJq0Qevz/tMxKFEnx3dj0aCYfkr9IMjdDhBib1oiY7XHnGD+l9Lzq2CD
         aYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1+koBSb1GKq2T3Jg1cWsMNJ0iN+8MQ2CjlSXzSZQf0s=;
        b=Xem9oELgB3W4Nw85bScl5l8P6UOxJlmNlhvdOOuU5Bkk67af7icPcwIOWwcHMUyuu5
         hVWBCXnczryxJoS7eupRmzl+AefXB0tN0UD5AbPAiO2kCYOp89ETjMyOdOk06qeTp3PF
         DXQy6R6pR0NSMLi6pqDIHKwUJnz+WVb/k9uEMjhcvKWgISqQqzOsig/iKoBQnw3w5hSA
         HWnFYD6ZzLAllo0XhoclzYcwAUNv0q05AmESgOHDkq0UOXuGFZVDotqnomtmYFs8LteA
         LrdATcPANfZG0mWrkX0C52LbuHTWM1HtAt2oE1JwGbk8zN/sXZXPrLaiURXFFI729ZUP
         lanQ==
X-Gm-Message-State: AKGB3mJ8cpMN0eYk+AX/mMIc4f83BtbG+pGMWAx+qLSaX7GgC6uAVGFd
        kocIuA8nK261aJSow9xeKEl3ZaJB
X-Google-Smtp-Source: ACJfBougRcEgJSjZHs9QQHxV78SRZmG66sW0ps/5h3mE0DgB6FarI8MHQ401d2vLcL+4zaQk6ydgcQ==
X-Received: by 10.223.152.129 with SMTP id w1mr2233044wrb.20.1514997295154;
        Wed, 03 Jan 2018 08:34:55 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:54 -0800 (PST)
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
Subject: [PATCH 25/40] lib-httpd: add list.sh
Date:   Wed,  3 Jan 2018 17:33:48 +0100
Message-Id: <20180103163403.11303-26-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This cgi script can list Git objects that have been uploaded as
files to an apache web server. This script can also retrieve
the content of each of these files.

This will help make apache work as an external object database.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/lib-httpd.sh      |  1 +
 t/lib-httpd/list.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 t/lib-httpd/list.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index d80b004549..f31ea261f5 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -133,6 +133,7 @@ prepare_httpd() {
 	install_script broken-smart-http.sh
 	install_script error.sh
 	install_script upload.sh
+	install_script list.sh
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
diff --git a/t/lib-httpd/list.sh b/t/lib-httpd/list.sh
new file mode 100644
index 0000000000..b6d6c29a2f
--- /dev/null
+++ b/t/lib-httpd/list.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
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
+	*) echo >&2 "unknown key '$key'" ;;
+	esac
+
+	shift
+done
+
+if test -d "$FILES_DIR"
+then
+	if test -z "$sha1"
+	then
+		echo 'Status: 200 OK'
+		echo
+		ls "$FILES_DIR" | tr '-' ' '
+	else
+		if test -f "$FILES_DIR/$sha1"-*
+		then
+			echo 'Status: 200 OK'
+			echo
+			cat "$FILES_DIR/$sha1"-*
+		else
+			echo 'Status: 404 Not Found'
+			echo
+		fi
+	fi
+fi
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

