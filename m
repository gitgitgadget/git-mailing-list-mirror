Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD5651F453
	for <e@80x24.org>; Mon, 15 Oct 2018 10:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeJOR7Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:59:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39444 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJOR7X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:59:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so8944763pgv.6
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 03:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hjNH3ZBYt3VXbSPVi8UvKCrNSYNtxKAXi7oTFKAk98Q=;
        b=Xd27Rps60r05FxEEKubpi4Z79MnZZN8phjbXy1AhcriTnt3Hq8emxVHBw4oUGdbNrT
         pkFIUn2dC6XRbslyF1B6O2GnrQePIVrPmfy7naaK8Ibrt1+IFMuxYCpGW36SN/OCbQul
         26J59RqNSIhxFnO5s1Bnc7p3b8jKvlQ8s3gVbkrYym+0TSpPTM/krhoIe3Tn3B4gekMj
         0NzVodXcbBXcFYKT1pYSnmP0+hupOCWMkLwH742915Ka7szM/IFQ1lFOUyIO41F76pBx
         XhO9VHJGFQL7tL3E8qugDjUJbGYqi/95Eqb1VvIt+BXKtxq2XSET9igW5LSw7icSaGtf
         tauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hjNH3ZBYt3VXbSPVi8UvKCrNSYNtxKAXi7oTFKAk98Q=;
        b=IMlJ3PZnNfl2hzxzhDtBW1en1kPMyofglCZ+38e4i+Y5q4LKMw0R/jWUGOSRfaSb++
         qkgI+uuNDzPRkDohPHAWN6OzvtSuAjvlkE524mpjvdlOsCOhttAKPMHPRq6V3MSm+oWk
         G4UFxfOos3YNa8FgXxn9GbQ63tucTtHJiD8pHOPKjBzi0ur8tEMeOsW77UrVVcZ1ZI4H
         kU3N0z6k/RObLnco3LBwpObjuEGrSpw3jh2CY77kUimS0CV/yFaekhI+TCuiqAeQ4+BQ
         czFyH39kId1+nPviSdBZoR1tQvQ4ttEeHAWE5Uwk5NM1cAgVcXmZTLkE3KM/utG6J1SY
         czGg==
X-Gm-Message-State: ABuFfojpGm9NGSb1nlFF5Ui0SHikktE/xwXRgCcGCnRLNpg/UuXvuk/y
        zjrd/dH+pUMxbam46029/Jo3dNdf
X-Google-Smtp-Source: ACcGV60CUKWfC1scEya8Kg8wdfdZTjV3DG4H4UGgTx7ajILSE/+ueM/6kJH30qnLycQeexYnCZIaZQ==
X-Received: by 2002:a62:7a81:: with SMTP id v123-v6mr17289106pfc.240.1539598487288;
        Mon, 15 Oct 2018 03:14:47 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id i5-v6sm11578913pfo.107.2018.10.15.03.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:14:46 -0700 (PDT)
Date:   Mon, 15 Oct 2018 03:14:46 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 10:14:40 GMT
Message-Id: <9927e4ce628df99f7a8e88dba1df54244e2fa158.1539598481.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.46.git.gitgitgadget@gmail.com>
References: <pull.46.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] http: when using Secure Channel, ignore sslCAInfo by
 default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As of cURL v7.60.0, the Secure Channel backend can use the certificate
bundle provided via `http.sslCAInfo`, but that would override the
Windows Certificate Store. Since this is not desirable by default, let's
tell Git to not ask cURL to use that bundle by default when the `schannel`
backend was configured via `http.sslBackend`, unless
`http.schannelUseSSLCAInfo` overrides this behavior.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |  8 ++++++++
 http.c                   | 19 ++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d569ebd49e..1f6a6a4a6f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1997,6 +1997,14 @@ http.schannelCheckRevoke::
 	certificate. This option is ignored if cURL lacks support for
 	setting the relevant SSL option at runtime.
 
+http.schannelUseSSLCAInfo::
+	As of cURL v7.60.0, the Secure Channel backend can use the
+	certificate bundle provided via `http.sslCAInfo`, but that would
+	override the Windows Certificate Store. Since this is not desirable
+	by default, Git will tell cURL not to use that bundle by default
+	when the `schannel` backend was configured via `http.sslBackend`,
+	unless `http.schannelUseSSLCAInfo` overrides this behavior.
+
 http.pinnedpubkey::
 	Public key of the https service. It may either be the filename of
 	a PEM or DER encoded public key file or a string starting with
diff --git a/http.c b/http.c
index 8998056b60..a0a8b93785 100644
--- a/http.c
+++ b/http.c
@@ -158,6 +158,12 @@ static char *cached_accept_language;
 static char *http_ssl_backend;
 
 static int http_schannel_check_revoke = 1;
+/*
+ * With the backend being set to `schannel`, setting sslCAinfo would override
+ * the Certificate Store in cURL v7.60.0 and later, which is not what we want
+ * by default.
+ */
+static int http_schannel_use_ssl_cainfo;
 
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
@@ -317,6 +323,11 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp("http.schannelusesslcainfo", var)) {
+		http_schannel_use_ssl_cainfo = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp("http.minsessions", var)) {
 		min_curl_sessions = git_config_int(var, value);
 #ifndef USE_CURL_MULTI
@@ -869,7 +880,13 @@ static CURL *get_curl_handle(void)
 	if (ssl_pinnedkey != NULL)
 		curl_easy_setopt(result, CURLOPT_PINNEDPUBLICKEY, ssl_pinnedkey);
 #endif
-	if (ssl_cainfo != NULL)
+	if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
+	    !http_schannel_use_ssl_cainfo) {
+		curl_easy_setopt(result, CURLOPT_CAINFO, NULL);
+#if LIBCURL_VERSION_NUM >= 0x073400
+		curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, NULL);
+#endif
+	} else if (ssl_cainfo != NULL)
 		curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
 
 	if (curl_low_speed_limit > 0 && curl_low_speed_time > 0) {
-- 
gitgitgadget
