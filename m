Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9283DC433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 22:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BAEA60F70
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 22:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbhJZWw2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 18:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhJZWw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 18:52:27 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC47C061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 15:50:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d3so807889wrh.8
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 15:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g5rQhbpF5py62LSveed+QUAz9n8Te0QXKOGpYTIaNbg=;
        b=jmS1tXPtmBgaXGf81tUE3WIJjWNqghdZKtFJ7c7sbaG3xMKTkYLtmpWLkERVzI7PMg
         8KkAn0xk8ipNRHdML7drIBEnMXRQH1xH7Bk1ogKwFzQMQfmT022LnjT66VntmzfmSM8M
         HCFnhCMO+Gpc06vSyusQkp0ev0mXxAHWnoh0rHJHVmD2+ro0Jhqk8/jt+/xCLm8xVYv6
         lY5D2dVL4MoskDiwvaQNTq7fzzAJtEMSWhI4jdcQnXdbRLevLbY8iaYnYxERHSq11B62
         1c8OAn3JDEIbWKa4pa4+mGopBoa0pR4npJ0ORrgisKNJOmw1KANYvrCa6pXZTNDzE//y
         jEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g5rQhbpF5py62LSveed+QUAz9n8Te0QXKOGpYTIaNbg=;
        b=Uu0yhxjgWXNJAcTF10a2p98xkXI9tGppuvh22SwJBK0I81/NjvWE7CPd/ej1HPdzZW
         qaa+QYVXlSyR/hnbGlTFDo1rdEHTeVYH6bV/xSd6DAgJ5XHEEE90QN30kqY5XO15xsrQ
         gG+SZwvq9AgSAVuu7Jpw9xER0p8VkjdXHD6W6SkkhSo33WqIbnRKjhPEHfzWvkMYXUnY
         vAAOQASo5TcoHxpC2zFyujheB2pvB1AkruDzCtfdJFQTrQss5j5f81JZUpLi6r2ob2Oy
         ROBgWPqLhHpd47MMDJCqXbmsXg8sLXMkL7DyEyogrgb9qoLRGYzKtfEA+hR4Ik9Occdm
         PVzA==
X-Gm-Message-State: AOAM531G32girHERbxvxdnG5YtTgQkSit7YhGweCbfq7OQqi/59Q6cBR
        9RPGR16BCylDaA3zNTW2WaRq9q5y5qo=
X-Google-Smtp-Source: ABdhPJwqWLXvOwhXVuw+8ijXfimk9H2LMcyHFVv/a5j8KHniMioIHZqSq261QXcEjJ9t9eSnsFMJqQ==
X-Received: by 2002:adf:9147:: with SMTP id j65mr35475309wrj.163.1635288601150;
        Tue, 26 Oct 2021 15:50:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm23373184wre.32.2021.10.26.15.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 15:50:00 -0700 (PDT)
Message-Id: <c7f0977cabd4ba7311b8045bc57e9e30198651fd.1635288599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com>
References: <pull.1052.v3.git.1634684260142.gitgitgadget@gmail.com>
        <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com>
From:   "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Oct 2021 22:49:59 +0000
Subject: [PATCH v4 2/2] http-fetch: redact url on die() message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ivan Frade <ifrade@google.com>, Ivan Frade <ifrade@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ivan Frade <ifrade@google.com>

http-fetch prints the URL after failing to fetch it. This can be
confusing to users (they cannot really do anything with it) but even
worse, they can share by accident a sensitive URL (e.g. with
credentials) while looking for help.

Redact the URL unless the GIT_TRACE_REDACT variable is set to false. This
mimics the redaction of other sensitive information in git, like the
Authorization header in HTTP.

Signed-off-by: Ivan Frade <ifrade@google.com>
---
 http-fetch.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index fa642462a9e..bbe09a6ad9f 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -4,6 +4,7 @@
 #include "http.h"
 #include "walker.h"
 #include "strvec.h"
+#include "urlmatch.h"
 
 static const char http_fetch_usage[] = "git http-fetch "
 "[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin | --packfile=hash | commit-id] url";
@@ -63,8 +64,18 @@ static void fetch_single_packfile(struct object_id *packfile_hash,
 	if (start_active_slot(preq->slot)) {
 		run_active_slot(preq->slot);
 		if (results.curl_result != CURLE_OK) {
-			die("Unable to get pack file %s\n%s", preq->url,
-			    curl_errorstr);
+			struct url_info url;
+			char *nurl = url_normalize(preq->url, &url);
+			if (!git_env_bool("GIT_TRACE_REDACT", 1) || !nurl) {
+				die("Unable to get pack file %s\n%s", preq->url,
+				    curl_errorstr);
+			} else {
+				char *schema = xstrndup(url.url, url.scheme_len);
+				char *host = xstrndup(&url.url[url.host_off], url.host_len);
+				die("failed to get '%s' url from '%s' "
+				    "(full URL redacted due to GIT_TRACE_REDACT setting)\n%s",
+				    schema, host, curl_errorstr);
+			}
 		}
 	} else {
 		die("Unable to start request");
-- 
gitgitgadget
