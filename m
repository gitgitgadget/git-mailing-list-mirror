Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616E8C433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 15:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352674AbiDZQAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 12:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347456AbiDZQAu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 12:00:50 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C522638787
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 08:57:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso1786160wme.5
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LJpLF77D5XfsIhB24X/X1uC+v3/NiFG9hlIJNl1l2tk=;
        b=H5PwHSQq2/V5ahKpIiAIBJtFRYAWCg8Ebb3o6TFh7F8TNRAAaD+c7f93j1Hn6O19tR
         N8QUOSqvxeKmZ0Re4zbYiUtrGUj1iSPV197Sv0SY7rWYooieIce+6gwTrT/q2UeWzcDE
         69N/s9px2BXJjA69CA1NznHiuQs85ewkz1COTawRPrgyNVtNCwbSE6Dw11sIh5Z3bOqJ
         joIreHvJM2cocbUqFHqTQLWtm6eC49vUpGB1QN5AVRzAs8tePK9VCOLIYZw0rohKtKOM
         ntCPE1iQbdBsDexinq5wOwk9FO0UFnvAbHc0DMa5G/2Cio1ZpaCjsBSyYn9gFEU6E3n9
         wMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LJpLF77D5XfsIhB24X/X1uC+v3/NiFG9hlIJNl1l2tk=;
        b=hhQKXscelmKV9lBIGE2fCCDNRDJrhWHo/VdehVSVnyC9ibIHoldD70zsdTJDB8ZFNY
         f1Mz/+2c/g8QHqyUCBhd81zIsRpE88lfe5kt8QJ/mAoDx3NIQ9c3ZNZs3GhJM8VCTgso
         yWGZuzPueJA/C5zOzN4t7y6Hn0WVXE3Xhg51MahmJmXRVNu8cRmN+1RPgCDzHp17NWPw
         RcNYUzmSiIoKqVjhdeqiuGNtELLMt7vQJc2RPx2t0n1le85H2iCXMOAAxtQbDAWhLQyR
         YICxX8TuwVB5ur5TpCfibk1J9fBq3bQt8q/YCJH84uBRXwDFNx2paAVtjbP8rT+KN659
         9WqA==
X-Gm-Message-State: AOAM530OU/PJO2LC4K9F59CraZj7PIeS3yLwKUXO/3eOArDULoSYmWfg
        b4Y6To1bSpvRa56nJtbleoKsBBw5x4s=
X-Google-Smtp-Source: ABdhPJy6wru2PG6ZjqUKfMycgnIKg14bLF3J9cUcZUzaMUrlVGt7nVq/oXM98EgNJP6DGCJOi2m04Q==
X-Received: by 2002:a05:600c:20f:b0:38e:b5a6:7b01 with SMTP id 15-20020a05600c020f00b0038eb5a67b01mr31044027wmi.168.1650988660960;
        Tue, 26 Apr 2022 08:57:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11-20020a5d584b000000b0020a8d859e5fsm12430548wrf.10.2022.04.26.08.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 08:57:40 -0700 (PDT)
Message-Id: <pull.1225.v2.git.1650988659280.gitgitgadget@gmail.com>
In-Reply-To: <pull.1225.git.1650970894143.gitgitgadget@gmail.com>
References: <pull.1225.git.1650970894143.gitgitgadget@gmail.com>
From:   "Drew Green via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Apr 2022 15:57:39 +0000
Subject: [PATCH v2] Added Curl Option to Override Request Method v2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Drew Green <agreenbhm@gmail.com>, agreenbhm <agreenbhm@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: agreenbhm <agreenbhm@gmail.com>

Added support for environment variable "CURLOPT_CUSTOMREQUEST"
and config option "http.customrequest" to allow setting the Curl
option to override the default request method used by HTTP Git
operations.  Primary reason for this is to allow support for
cloning repositories where only GET requests
are allowed by a local web proxy but not POSTs.  When cloning
a repo first a GET is made to the server and then a
POST is made to the "git-upload-pack" endpoint.  In some
corporate environments with strong controls
only GET requests are allowed to known repository hosts (such
as GitHub) through a web proxy to prevent data leakage.  Using this
new setting, a user can set the "CURLOPT_CUSTOMREQUEST=GET" env at runtime
or "http.customrequest = GET" in their config file which will
change the second request from a POST to a GET, bypassing
web proxy restrictions on the type of requests allowed.
Tested with GitHub, changing the request from POST to GET still
results in the expected behavior of the repo successfully being cloned.

This is v2 of this patch, which refactored the placement of the env
and added the ability to set the config file option.

Signed-off-by: agreenbhm <agreenbhm@gmail.com>
---
    Added Curl Option to Override Request Method
    
    Added support for environment variable "CURLOPT_CUSTOMREQUEST" to allow
    setting the curl option to override the default request method used by
    HTTP Git operations. Primary reason for this is to allow support for
    cloning repositories where only GET requests are allowed but not POSTs.
    When cloning a repo first a GET is made to the server and then a POST is
    made to the "git-upload-pack" endpoint. In some corporate environments
    with strong controls only GET requests are allowed to known repository
    hosts (such as GitHub) to prevent data leakage by sending data. Using
    this new environmental variable, a user can set
    "CURLOPT_CUSTOMREQUEST=GET" which will change the second request from a
    POST to a GET, bypassing web proxy restrictions on the type of requests
    allowed. Tested with GitHub, changing the request from POST to GET still
    results in the expected behavior of the repo successfully being cloned.
    
    Signed-off-by: agreenbhm agreenbhm@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1225%2Fagreenbhm%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1225/agreenbhm/master-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1225

Range-diff vs v1:

 1:  8bf14c61c2a < -:  ----------- Added Curl Option to Override Request Method
 -:  ----------- > 1:  8734bf28344 Added Curl Option to Override Request Method v2


 http.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 229da4d1488..eaf269fc5a7 100644
--- a/http.c
+++ b/http.c
@@ -75,6 +75,7 @@ static const char *http_proxy_ssl_key;
 static const char *http_proxy_ssl_ca_info;
 static struct credential proxy_cert_auth = CREDENTIAL_INIT;
 static int proxy_ssl_cert_password_required;
+static const char *http_custom_request;
 
 static struct {
 	const char *name;
@@ -403,6 +404,9 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if(!strcmp("http.customrequest", var))
+		return git_config_string(&http_custom_request, var, value);
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
 }
@@ -1099,6 +1103,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 		    starts_with(url, "https://"))
 			ssl_cert_password_required = 1;
 	}
+	set_from_env(&http_custom_request, "CURLOPT_CUSTOMREQUEST");
 
 	curl_default = get_curl_handle();
 }
@@ -1212,7 +1217,7 @@ struct active_request_slot *get_active_slot(void)
 		curl_easy_setopt(slot->curl, CURLOPT_COOKIEJAR, curl_cookie_file);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
-	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, http_custom_request);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);

base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
-- 
gitgitgadget
