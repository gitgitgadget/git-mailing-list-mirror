Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDBEC1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933393AbeCSNeQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:34:16 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:55852 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933334AbeCSNcl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:41 -0400
Received: by mail-wm0-f51.google.com with SMTP id t7so2356453wmh.5
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DF4NSeXugIjgqs6bAsx2KCmP21weo43XLPvPfVyX1UQ=;
        b=uJPwVsTQDnX36t5qGnmcG6Tdi4iSNlNrs0aslAz/tyhRWd2npSvc/VdNAbImRh5xmj
         J7HSL4/CuqcsA7rAKojq1wltuaXYcvkGaJ7wehTBR4DU0LSZtKQcHfkE0ubgUaoT2DdF
         4DSRf8kGC1Nzs2HlQE/rFi5e4F+vfG+cJA01QneeNGTY4/WBGX7ayMNdSi50kTy3TKM3
         qaRuKGDMxG7F+cN5/7vN94ru/CSg0FmrMMRDkl8B4j/fqJDyS4ZycoSH8wh+r/xNJ96Z
         8lQ/WNzCAmsN+1h4Y/DFwHuQGC56tx5cq2GWrUjhy3baJAxqO4KyYdfxzGyLWvSKl9Ct
         z0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DF4NSeXugIjgqs6bAsx2KCmP21weo43XLPvPfVyX1UQ=;
        b=JPenOVZmsxlVQk3YuIL5ThxqGird4G0hrqtK7pgJdeOMWL9fKVV5KETIArx2SKw4ob
         D6q+lWf2bYHI0X+xE7f6vFQ7VBOdBqeorpossntX3Q2iQKtq4YxjUB0DNK6YBuuTg6NL
         EefpfK9MJneN1qPXAt+zrHmmxshQOnHEAOviBPb7YMLHHZ/uvaZ2zmv/x40HrAKhC8qh
         n5JBQlNDLFss8a9C9TODTGkkcHygBsmmlz+LObYVfISDmnC3nNsvDglzEwI6w4Le6sJu
         eCK2u/YyVyui8WGW1lExivrBkeRlQVE/Uav/BEeF9watghqQ5NtKmf8olXrEC34Ws1Cy
         fcBQ==
X-Gm-Message-State: AElRT7FrnSGv1s1LLTGwyQ1mUtezFhOit58HaLCwt2Kl5/1/yFFNQC1j
        nyMxASrnB5DC4l9muFy9vVNLRtUL
X-Google-Smtp-Source: AG47ELtLh2gBsP8d6z5D24XoFiZ4nBGhCwJeIoyfQHbvRZpl8GujJxOvCQT8jOG1o+tPjNXw6CFHSw==
X-Received: by 10.28.232.89 with SMTP id f86mr9356048wmh.72.1521466359716;
        Mon, 19 Mar 2018 06:32:39 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:39 -0700 (PDT)
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
Subject: [PATCH v2 23/36] lib-httpd: add list.sh
Date:   Mon, 19 Mar 2018 14:31:34 +0100
Message-Id: <20180319133147.15413-24-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
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
2.17.0.rc0.37.g8f476fabe9

