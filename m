Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBDB320A25
	for <e@80x24.org>; Sat, 16 Sep 2017 08:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbdIPIIP (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:08:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33576 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbdIPIIL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id 187so4514772wmn.0
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+t2R4+soqsc8Yi537tnW3L7SOx6hKhVsYq7cgcHAVvg=;
        b=t/W56oJeyhhtDQJ+siTaUO9yHMb8732IFQsQaNPoM3icSH8m486jAke+RyySxijozL
         ckO4YWmp8D/Pfu19cBk9z/9cFyGsBMNo648qEsXMz3cHMQrPJFp441CWGt1bGw0VkOFA
         fuD8V3Ies0fc6l232E3FajYIsc0tpa2UYCnS+rSLDAEDlQH2b9cA7eL7v6Hidvd+JfGH
         Jq9Ztlev2ET97sx9cfp9Xu7c1SSqMt4sM6IoHSOB7u4lYFWShxoj5lcqIJuIY/Qb2FAA
         eW20T1TLjXP8atK7xfgiAAILX+qpoaolf0hFORpozeGUqsKwjZeyphFVIABQA96NrcKL
         iBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+t2R4+soqsc8Yi537tnW3L7SOx6hKhVsYq7cgcHAVvg=;
        b=YoecrRxhFMhYBmVr/Hly+S6GM26FQkSHkJBdtzLh5EGbPAvBgNTYxZt/RREGe8Onsw
         b42kjXZkRWvRcgyEmCgoBR672v3lbz7v/Js1dHZQgYQSY5U2masiqBRgXlBSZ9IY1qmq
         jaV4t5gVTY04Bbp9spWcnQfvvDhxLXoKUyJ349cMdFzPHVt5HT5giuRxnqL0qTG7aWI1
         1Ctfm2YIQ88tOY4wb3C2OPbbR9GhJ3OS64SUjbxP6Z3A6eC8D8UbD5fJ6chK1GVg49yf
         uHjJ6KnyCnwGIavYM3+84jb9BwhEFyGGwwoPLGOgGekhx2UkFpdUiuHal8OTqyzaKGB4
         Q0Kw==
X-Gm-Message-State: AHPjjUgNTiryO2iYmlJoq3C/xfSeDh3UkuYopp1yj325RfzdizKUiBAe
        lA66DwIC1sQBfMfR
X-Google-Smtp-Source: AOwi7QD3C7qjhoDHuzrZE7kX62rRUEhA8HEc87fr/HK3JMqLQe2g09HwjLCoDsaH0xWK3kiysURaiQ==
X-Received: by 10.28.87.147 with SMTP id l141mr4867973wmb.144.1505549289843;
        Sat, 16 Sep 2017 01:08:09 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:09 -0700 (PDT)
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
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 19/40] lib-httpd: add list.sh
Date:   Sat, 16 Sep 2017 10:07:10 +0200
Message-Id: <20170916080731.13925-20-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
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
2.14.1.576.g3f707d88cd

