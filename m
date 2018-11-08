Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91FAB1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 07:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbeKHQeK (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 11:34:10 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36695 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeKHQeK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 11:34:10 -0500
Received: by mail-pl1-f194.google.com with SMTP id w24-v6so9095908plq.3
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 23:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LIY49nEF0iFSXg5In0YoSbSeqUxaojG2mPWCoh74iU4=;
        b=hl3LfJ9AG6Hv9ZgrKWiFdOnTz56+mVEUfLKLvBreF5bi0NnmUINAXGM6Ul56AdyFX/
         S3ZRN+JAowWXMmQB+vQSd7xcUAUvulbbwiiVVLzIHbjWJSDEXj6rvTPnzwRhjf0mwaYg
         Kv3rBuBdS+NM1mCuMy6Cg8QQUD4UtelHpP1Vlkt8LTb9fPLlskwSaoEl4SkO5ESWrmMO
         ATvNewNqwSK2xPkl4qz0NkZT7NdBYss79BVfyJHhEFuw0VrdCzWq0fnhMvtwTY/rek3i
         QMLQpXpg3lQ1tjtgZr/sBeP3PH2NmTI3JWfvXduB0PxVxjQKmQTlC5It+y31meLndg0i
         yPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LIY49nEF0iFSXg5In0YoSbSeqUxaojG2mPWCoh74iU4=;
        b=r6t9k9V3UsahCxiM7okgd9/4m+XsyQDIrRezi+tMQp6nIEShcOVRrZ5/DZlEJ3pVzh
         st9R3rswa4Pc2NSmevskEGturhM0lmBanLP73pHvG/gcPnVtChB1tedk22CAba+oNIHi
         NScm2b9oLzmH1oEtlu8rkJuwE4BoTwRWtMYLHD9xS5C60rxXQwQLHyIf5ceekaviRAUA
         Va53IfhXl09imRRId758K9iAhVPubyCAI4Nukq00vx7VWmcEn0iwWj+Re8HmitcqcNJ5
         7J2OJaxahYvxY2uUkq0Ich0g9555NLV3+s13vCgunHsHB3bmc6gXSONw8/Asam53khpr
         5VKw==
X-Gm-Message-State: AGRZ1gJ4eYlneZ4LbbzSfSx6ywVoQTBBUIYxa27eQLlc8xjmAODw4ZwW
        Lhu7OoM6QCQGIN8ricIJSLBcuIHW
X-Google-Smtp-Source: AJdET5eVP77DZQjOHYN+6jBFBTgaMoTaEST4eKyFb/CJpCIE2qlo3ABB/JhpqYPQr2XwoMpHVmkGbA==
X-Received: by 2002:a17:902:b598:: with SMTP id a24-v6mr3403714pls.231.1541660407436;
        Wed, 07 Nov 2018 23:00:07 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id i12-v6sm3631249pfe.7.2018.11.07.23.00.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 23:00:06 -0800 (PST)
Date:   Wed, 07 Nov 2018 23:00:06 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 07:00:03 GMT
Message-Id: <pull.69.v6.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v5.git.gitgitgadget@gmail.com>
References: <pull.69.v5.git.gitgitgadget@gmail.com>
From:   "Force.Charlie-I via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 0/1] http: add support selecting http version
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
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-69%2Ffcharlie%2Fmaster-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-69/fcharlie/master-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/69

Range-diff vs v5:

 1:  cdd93048ba ! 1:  93fda67198 http: add support selecting http version
     @@ -2,8 +2,38 @@
      
          http: add support selecting http version
      
     +    Usually we don't need to set libcurl to choose which version of the
     +    HTTP protocol to use to communicate with a server.
     +    But different versions of libcurl, the default value is not the same.
     +
     +    CURL >= 7.62.0: CURL_HTTP_VERSION_2TLS
     +    CURL < 7.62: CURL_HTTP_VERSION_1_1
     +
     +    In order to give users the freedom to control the HTTP version,
     +    we need to add a setting to choose which HTTP version to use.
     +
          Signed-off-by: Force Charlie <charlieio@outlook.com>
      
     +diff --git a/Documentation/config.txt b/Documentation/config.txt
     +--- a/Documentation/config.txt
     ++++ b/Documentation/config.txt
     +@@
     + 	If set, store cookies received during requests to the file specified by
     + 	http.cookieFile. Has no effect if http.cookieFile is unset.
     + 
     ++http.version::
     ++	Use the specified HTTP protocol version when communicating with a server.
     ++	If you want to force the default. The available and default version depend
     ++	on libcurl. Actually the possible values of
     ++	this option are:
     ++
     ++	- HTTP/2
     ++	- HTTP/1.1
     ++
     + http.sslVersion::
     + 	The SSL version to use when negotiating an SSL connection, if you
     + 	want to force the default.  The available and default version
     +
      diff --git a/http.c b/http.c
      --- a/http.c
      +++ b/http.c

-- 
gitgitgadget
