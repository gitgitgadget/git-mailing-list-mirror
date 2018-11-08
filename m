Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8FD21F453
	for <e@80x24.org>; Thu,  8 Nov 2018 23:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeKIIxJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 03:53:09 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:45474 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbeKIIxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 03:53:09 -0500
Received: by mail-pg1-f178.google.com with SMTP id y4so9069522pgc.12
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 15:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wCYfvNc3nhz+tVYyK3NsB05td4etoZ5HCcZTdSBcqFs=;
        b=eVuXshmmsGKMG76x64lNAzhiDDnCHWLLxZKJlXBHM3qeWuAA508gk0uq8KB5lDunLJ
         OCw+duW/8mIMpyBv+T3wevmszlxmBHLt2MXj+deH1xdF+o4ohgegkDiQRC3zRoNv3LGs
         ZgYswZN3skqY7d9fEGY/CS+JJUMh1v/LRHvrwbD8LEf5sXs+3RLnGOdW6jwBay0rThCm
         UjtDAaOMbXngd6C4UCPIhCB3WwXlTRxIj/oFV0agjbjbQstYjokcEZignNYYF0tzYYt7
         5YAWthRB3xJLTU8qafAVRS2DK51LXXEVdNIe+IIyq/+YT6AFGP1R1RjCiyDWerm409yC
         x2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wCYfvNc3nhz+tVYyK3NsB05td4etoZ5HCcZTdSBcqFs=;
        b=fOIsBzWKUgq/4ZzliGqWfJDW6KhEs2U9ILz0Qjz8mKeGz7gpZb9mWSNuyLMpIK9Zie
         DP1l0qC2VXUGVCwMWb9Ahxln2oFz1UWRy4FBp898ddjJFQibDRCFYx/yJcvk26RDs3vM
         /B/f+uPdTcv9cWZW/sRKXi71lkzesjJIbi+wn/sw+D/EHkvHQEBCesN0SGMm9L7IQSyf
         tgrVDTR3ul053NKLlEC6fzbNw4qbKm9WFsi456kVcS3yqze52stkTnLK2O/F8XgojFyh
         LvWEBCbik9FI2IosJZQXWdou8Sjf2GQ9mjg4eVQ9lGPr4AyE2H0VZxJGOvj3Z4gQPapT
         BzJw==
X-Gm-Message-State: AGRZ1gIylQuz1pGxTZ2ok5Vc3zlu4Vsmu/nRocvdJdkkAlWyTKKnTi8p
        10GC+lArKYFULSqKIVL9ekUN1J2v
X-Google-Smtp-Source: AJdET5cv+NkltMMRV1uplcdTMpK4B5taXSOOB9V2YE0h2Nq7EhLfPuckGfGHcwcSJNtXpdEGGJDhJQ==
X-Received: by 2002:a62:b9b:: with SMTP id 27-v6mr3283792pfl.235.1541718918765;
        Thu, 08 Nov 2018 15:15:18 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id p7-v6sm4985229pfb.101.2018.11.08.15.15.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 15:15:17 -0800 (PST)
Date:   Thu, 08 Nov 2018 15:15:17 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 23:15:14 GMT
Message-Id: <pull.69.v7.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v6.git.gitgitgadget@gmail.com>
References: <pull.69.v6.git.gitgitgadget@gmail.com>
From:   "Force.Charlie-I via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v7 0/1] http: add support selecting http version
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Usually we don't need to set libcurl to choose which version of the HTTP
protocol to use to communicate with a server. But different versions of
libcurl, the default value is not the same.

CURL >= 7.62.0: CURL_HTTP_VERSION_2TLS CURL < 7.62: CURL_HTTP_VERSION_1_1

In order to give users the freedom to control the HTTP version, we need to
add a setting to choose which HTTP version to use.

This patch support force enable HTTP/2 or HTTP/1.1. 

example: 

GIT_CURL_VERBOSE=1 git2 -c http.version=HTTP/2 ls-remote https://bitbucket.org/aquariusjay/deeplab-public-ver2.git

Force Charlie (1):
  http: add support selecting http version

 Documentation/config.txt |  9 +++++++++
 http.c                   | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-69%2Ffcharlie%2Fmaster-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-69/fcharlie/master-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/69

Range-diff vs v6:

 1:  93fda67198 ! 1:  e26fc0d8c7 http: add support selecting http version
     @@ -49,7 +49,7 @@
       
       static int http_options(const char *var, const char *value, void *cb)
       {
     -+	if (!strcmp("http.version",var)) {
     ++	if (!strcmp("http.version", var)) {
      +		return git_config_string(&curl_http_version, var, value);
      +	}
       	if (!strcmp("http.sslverify", var)) {
     @@ -95,7 +95,7 @@
      +		long opt;
      +		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
      +			/* Set request use http version */
     -+			curl_easy_setopt(result, CURLOPT_HTTP_VERSION,opt);
     ++			curl_easy_setopt(result, CURLOPT_HTTP_VERSION, opt);
      +		}
      +    }
      +#endif

-- 
gitgitgadget
