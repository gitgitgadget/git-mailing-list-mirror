Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D55CD1FAE2
	for <e@80x24.org>; Mon, 19 Mar 2018 13:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755564AbeCSNc5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:57 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:54995 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933333AbeCSNck (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:40 -0400
Received: by mail-wm0-f46.google.com with SMTP id h76so15212553wme.4
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bBoqaB7a5lQ4lpYMAaVsUOFGmyZp+4tImQ0J5sSkKQo=;
        b=IrUpMDqvLl6+g5MF4R+bflk72vuDmATXlYk9zr9Q+utjCj1LirjH8SfwwT9T/8XYOo
         VMgb8fMrCrCaFIlDok3BUZqxCmixE7eH5kBDtoYcVd3ECmXmriRQylT7PAZsdYNuveYM
         fb/UeVJVAlDN+OHKRzL50WiYDktJGHxWEfPQ/b1oWikIzDvUqV8GRm1fHgEpz8rOUuCE
         bdc90UZw/dcjbjv4dCA6UpZdxlc/Vy+7J9EZ65JPKCUMts4d1SHLjMddH9BK5zUWRzgy
         CgUc+OVc12FJYQqKc5gNLvsHZo37+lqnrVcy9Bkq6M/P4RIC6U8UnmTRhAcbu58ueqAA
         ZwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bBoqaB7a5lQ4lpYMAaVsUOFGmyZp+4tImQ0J5sSkKQo=;
        b=E4JtoMq9ujfDRaVcS87av/gWDoIvbvYCXI26pTfofHPgG0DeB0DkZGWF/6v2gtfhR4
         QPAaG8uABY1HCM3zqJeDjE4D9MV0TgN9x3Jallx+6FMmEojbavb/Iru5vcmHPCmDPOnA
         u5yvaoFwMpXpT5KYh2pRbA8Xv4rKlxK7neTkZkk/LJZp5pN6qMQfNvOQ3d1gCpK+wgDy
         r1Bw3UehmM/oba5V36H4xbSAM5p+1kjz0xpp6hOTAWHvnb1BMHZZRMtuVLL+rOxBO5wj
         juKkmGfGTwp6Ao8JUY4Xxd0kOqBNH/uphq3TSkhUB5SeorN7hDaPKuVMT8c+FUF9qc4j
         glgA==
X-Gm-Message-State: AElRT7GZO/xMaIUzUJmzRfUFRLhqd4udGWEcu/hJOWoK8aNS260GRbs8
        bMNpo3c51aI6ZBPtOrI7hBdHdf0D
X-Google-Smtp-Source: AG47ELvxKOGm0gSMew9IyNKWQF9h9r0AcO4w7XsGPfCZLGSY210QnhwdpMI0nDRTsYiXRoP/E2fLKw==
X-Received: by 10.28.185.208 with SMTP id j199mr9246727wmf.9.1521466358435;
        Mon, 19 Mar 2018 06:32:38 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:37 -0700 (PDT)
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
Subject: [PATCH v2 22/36] lib-httpd: add upload.sh
Date:   Mon, 19 Mar 2018 14:31:33 +0100
Message-Id: <20180319133147.15413-23-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
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
 t/lib-httpd/upload.sh | 45 +++++++++++++++++++++++++++++++++++++++++++
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
2.17.0.rc0.37.g8f476fabe9

