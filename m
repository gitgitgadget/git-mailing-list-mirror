Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6592F208CB
	for <e@80x24.org>; Thu,  3 Aug 2017 09:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbdHCJUH (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:20:07 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36644 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbdHCJUD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:20:03 -0400
Received: by mail-wr0-f196.google.com with SMTP id y67so573134wrb.3
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zrPeaJfWbcDzi2HCKXxVoRzSFRr3vCXRdMSBygd1LhI=;
        b=fAfMwppMkwCsx6U2xFiRqUx0haIdRy2LSle3CjhC85IURKIO0XLsIC0r3p+4W9QI/0
         7K09Jd0TrLYjHw2pvw5f6HXwbyQCocTNCqegUni2y8RV16uDIFoF5LMBp5tfHH7lD53o
         FArgv4XximEH3DGuVKaY+09qegAlClAWjhIlpASya/WM2ubXGnI7sT+rnVm4n+76uUOW
         bJyIbs3+Umpr0LX3eStlUVpJKAXEq5tjhh1YOapI6qcLpt3X0T+Y2TlgLgxisQ3TZIgz
         eaRTylnTT/16sHoxcKmQLylQQrHECRpWlc6jfjYr1VeJ7AHU3d/YhpgEfZj8Glcn9rtL
         NtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zrPeaJfWbcDzi2HCKXxVoRzSFRr3vCXRdMSBygd1LhI=;
        b=lGUg767R+Tzl0JqoJrRnNRiVuHFDt79dx/RjlwezM1ThkJF7aDIcsCKEm5bVzveOXX
         Hm0XDRC78gxEwo4RH+S2CpawoUzlObhJeoQGos93zmcwoun5wQyS1IDPIMXiL5wtd20x
         ZUhA4urQxUh1LtzXhvaRfCwfLI7vLNo/TBhUhMmZccnxdNeD0UJlb8dBAVlhFEMInQaM
         L9T2hNNhJ0iv3fYGk47v1PL7iHiHT0H6M2yFXMYjXeauZp1wdpKMugNPtg5bZpySCnqU
         HH7zwddk5EcJkySyLl588EifsLSdGSvg9ALBfVnwdX76P9EhIQs5IB9t+Fsa/D8GcdEU
         OYxw==
X-Gm-Message-State: AIVw110NdcP8Ds20IlARny6yOjc1NR/s4LqE8T+k2zgF3Is/AWD4E/q6
        2nX04qRoEZnt58JH
X-Received: by 10.223.157.4 with SMTP id k4mr932612wre.270.1501752002033;
        Thu, 03 Aug 2017 02:20:02 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:20:01 -0700 (PDT)
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
Subject: [PATCH v5 20/40] lib-httpd: add list.sh
Date:   Thu,  3 Aug 2017 11:19:06 +0200
Message-Id: <20170803091926.1755-21-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
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
index 0000000000..7e520e507a
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
+    key=${1%=*}
+    val=${1#*=}
+
+    case "$key" in
+	"sha1") sha1="$val" ;;
+	*) echo >&2 "unknown key '$key'" ;;
+    esac
+
+    shift
+done
+
+if test -d "$FILES_DIR"
+then
+    if test -z "$sha1"
+    then
+	echo 'Status: 200 OK'
+	echo
+	ls "$FILES_DIR" | tr '-' ' '
+    else
+	if test -f "$FILES_DIR/$sha1"-*
+	then
+	    echo 'Status: 200 OK'
+	    echo
+	    cat "$FILES_DIR/$sha1"-*
+	else
+	    echo 'Status: 404 Not Found'
+	    echo
+	fi
+    fi
+fi
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

