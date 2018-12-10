Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 175B220A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 22:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbeLJWt7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 17:49:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35848 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeLJWt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 17:49:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id a18so311075wmj.1
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 14:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VP1riIoKikMlsRiRJDx+fqlnXRJG0/d0mhsNvWKBfYQ=;
        b=Bec6iKFVCt01jIQ5woHC9ZztZ2+VxOrI1fiYucrsGAIS87NF1CADRU4IQK/yY1JTiK
         EXtnTx/nFKgKyf57QIGN18L1fgRGXVsgO+3VbQucpmh58mQRLg6zOVVKlzBVJPfOxavY
         HgzJXZX9KJg1RZ0lYpIJ1l4zt6Sv5qb+GFs4FDXgicEHJq6dqbrZnAD+mJ+ENPYfTdZn
         83tdXC1cVLUUUC/0XQ70CG15BcYwdziKzNOxKHG7/8QogUXp/96yyrNA4SJpXpqES71Y
         1CuRRiQqYz5WwVt7DbZE5YmsSsKvWiZAdbOiQ3aHcgF/hPnYI+2Aqmdg/3XkpW+hgnDS
         dNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VP1riIoKikMlsRiRJDx+fqlnXRJG0/d0mhsNvWKBfYQ=;
        b=K5VQHNmmz18Y6MzpjadIevT3S0jlKKgevXE/RJxshNHNmefssoA1pjA8xsqZ3GoxUI
         W8JxFjsZKF1KQfcblGPLID1KqV5ZHH5HFcaGJ1LuOvtXbHdgx6K3BMpm+XMnErOnHHxf
         6vncbOTSdzN1HZuuldo6xK0vmFW6fc9fIYjUs7v1D0ILEL+/Wstj39utmEMSq0Ae5xgF
         KoMbXFukFbdf+kszJm0bzlYs01HCbdwVOZ7DkoboFKuciRGyvbJLtz9jaHQM6sQm0OMV
         lUIWfL+pEzTNNX4P9IJ30DPhUCpQSkk/j5fisXWxwMkN0RagWJ9gW5Z94cubs8ryl39l
         C3Fw==
X-Gm-Message-State: AA+aEWY7L6fR5uhPh2ddjKRuT/xcKGmpA5+fbd3VRF4SpeNnjIz+r158
        PNHqgv6ohJ2cw7AUbHnbRyhJwoIv
X-Google-Smtp-Source: AFSGD/V8BTg4TZqLbbIJp7G6RZcuA4m7RvxsFB+L/MPNsiC6jRdOEX+BdBkbrRUR+CivTsFb5pELBg==
X-Received: by 2002:a1c:2686:: with SMTP id m128mr213117wmm.52.1544482195350;
        Mon, 10 Dec 2018 14:49:55 -0800 (PST)
Received: from localhost.localdomain ([2a02:8070:89b1:6700:be5f:f4ff:fe36:3eb6])
        by smtp.gmail.com with ESMTPSA id k15sm10116123wru.8.2018.12.10.14.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 14:49:54 -0800 (PST)
From:   Silvio Fricke <silvio.fricke@gmail.com>
To:     git@vger.kernel.org
Cc:     Silvio Fricke <silvio.fricke@gmail.com>
Subject: [PATCH] http: add http.version option to select http protocol version
Date:   Mon, 10 Dec 2018 23:49:14 +0100
Message-Id: <98295da2b5295795414eaf85a40b9ae62b1b2dca.1544482124.git.silvio.fricke@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HTTP has several protocol versions. By default, libcurl is using HTTP/2
today and check if the remote can use this protocol variant and fall
back to a previous version if not.

Under rare conditions it is needed to switch the used protocol version
to fight again wrongly implemented authorization mechanism like ntlm
with gssapi on remote side.

Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>
---

Notes:
    I hit a problem with a libcurl (Namely [this bug]). This bug looks
    like never get fixed and to just-use-git from my commandline I don't want
    compile a own libcurl with disabled gssapi or/and http/2.
    
    [this bug]: https://github.com/curl/curl/issues/876

 Documentation/config/http.txt | 10 ++++++++++
 http.c                        | 23 +++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git Documentation/config/http.txt Documentation/config/http.txt
index a56d848bc0..0d2840696b 100644
--- Documentation/config/http.txt
+++ Documentation/config/http.txt
@@ -68,6 +68,16 @@ http.saveCookies::
 	If set, store cookies received during requests to the file specified by
 	http.cookieFile. Has no effect if http.cookieFile is unset.
 
+http.version::
+	If set, use the specific http(s) protocol version.
+	Actually this versions are possible:
+
+	- 2.0 -> HTTP/2
+	- 2   -> HTTP/2
+	- 1.1 -> HTTP/1.1
+	- 1.0 -> HTTP/1.0
+	- 1   -> HTTP/1.0
+
 http.sslVersion::
 	The SSL version to use when negotiating an SSL connection, if you
 	want to force the default.  The available and default version
diff --git http.c http.c
index eacc2a75ef..99cdd327a5 100644
--- http.c
+++ http.c
@@ -83,6 +83,7 @@ static const char *ssl_cainfo;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
+static const char *curl_http_version;
 static const char *curl_http_proxy;
 static const char *http_proxy_authmethod;
 static struct {
@@ -355,6 +356,10 @@ static int http_options(const char *var, const char *value, void *cb)
 		curl_ftp_no_epsv = git_config_bool(var, value);
 		return 0;
 	}
+
+	if (!strcmp("http.version", var))
+		return git_config_string(&curl_http_version, var, value);
+
 	if (!strcmp("http.proxy", var))
 		return git_config_string(&curl_http_proxy, var, value);
 
@@ -926,6 +931,19 @@ static CURL *get_curl_handle(void)
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
 
+	if (curl_http_version) {
+		if (!strcmp(curl_http_version, "2") || !strcmp(curl_http_version, "2.0"))
+			curl_easy_setopt(result, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_2_0);
+		else if (!strcmp(curl_http_version, "2TLS"))
+			curl_easy_setopt(result, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_2TLS);
+		else if (!strcmp(curl_http_version, "1.1"))
+			curl_easy_setopt(result, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_1);
+		else if (!strcmp(curl_http_version, "1.0") || strcmp(curl_http_version, "1"))
+			curl_easy_setopt(result, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
+		else
+			warning(_("Use default http(s) protocol"));
+	}
+
 #ifdef CURLOPT_USE_SSL
 	if (curl_ssl_try)
 		curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
@@ -1169,6 +1187,11 @@ void http_cleanup(void)
 	curl_slist_free_all(no_pragma_header);
 	no_pragma_header = NULL;
 
+	if (curl_http_version) {
+		free((void *)curl_http_version);
+		curl_http_version = NULL;
+	}
+
 	if (curl_http_proxy) {
 		free((void *)curl_http_proxy);
 		curl_http_proxy = NULL;
-- 
2.19.2

