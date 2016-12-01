Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E0B31FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756849AbcLAU01 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:26:27 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36015 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753543AbcLAU00 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:26:26 -0500
Received: by mail-pg0-f41.google.com with SMTP id f188so98195559pgc.3
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 12:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NmUlO+2/rlURQbj2j5D8sAugeeXGCp0rcWqUgALrmqY=;
        b=C2wHjSjgtorc+8Le1aSpG+i3PBt7Knz384zXKk3QyynncDy0PTFpJb8FAvYNuui2L6
         0xfQdcEr8Bcl71CB28kFzS22cfnRuewZdFQYuKTvinqxx3Rdp1I0H95NS/vv93Xk/wqf
         J0OBRrfkoQ1+bEACt3s0Xu/ojfWeJU8ssRxqr4f4I0w8DWqT+pRKWbw/AFNVFpQnySYv
         7AYRkdylU97M5IDpQhsBkQWuzFnm5U9KHn88U3Y03cvhBcamvxJBeEiKt3VyudkRoBI4
         3AMm3oQ1h+XeGVWtbuRR7gY5iKkGBwel1woXflexVoki3ij3S6q4bgCYxz1ejeSK+sLd
         NLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NmUlO+2/rlURQbj2j5D8sAugeeXGCp0rcWqUgALrmqY=;
        b=f/C7fAVUN+MHUZKyVhfIfXA/oFbMrsjoeKWjVpjdjGmD4r97pRb/bR18BspsLc6Zhz
         0ZsX5fug26iMGppq8LDjS9UTkqvs5QQUGfP2D5VBhvgDCt7cdjITuAaxxooIYbFOT3sA
         G+40/s1Br2hWbla/2ksha+M01Zlry3VxSRl2Rvy/pU0RS0GWX8628zItnuUYDQKhgjzw
         4UTn4c0K/S+VE2YTOrqYFH/2YUeUgejWXTW4DdDk/5mdcXgSFH9aiHgGd52+RLf5M2Gm
         rPXcoQA8eQEwBW5yLArhPBN4EOVQ1KXoPT0wrWevyk91burC+jKwF3qFPOi6SeBGkMyh
         T29w==
X-Gm-Message-State: AKaTC00WYlFoxphYM8RgkV1HjlYumPEjcdP4VrDN1vPDaTFobb7nQ6P97eBxz2jkTyDBRjxr
X-Received: by 10.99.235.10 with SMTP id t10mr71892878pgh.95.1480623985835;
        Thu, 01 Dec 2016 12:26:25 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id 16sm2230074pfy.4.2016.12.01.12.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 12:26:24 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v7 0/4] transport protocol policy configuration
Date:   Thu,  1 Dec 2016 12:25:55 -0800
Message-Id: <1480623959-126129-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480621447-52399-1-git-send-email-bmwill@google.com>
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changed the last patch in the series to use the parameter 'from_user' instead
of 'redirect'.  This allows us to use the same logic polarity and maintain use
of the same vocabulary.

Brandon Williams (4):
  lib-proto-disable: variable name fix
  transport: add protocol policy config option
  http: always warn if libcurl version is too old
  transport: add from_user parameter to is_transport_allowed

 Documentation/config.txt         |  46 +++++++++++++
 Documentation/git.txt            |  38 ++++-------
 git-submodule.sh                 |  12 ++--
 http.c                           |  13 ++--
 t/lib-proto-disable.sh           | 142 ++++++++++++++++++++++++++++++++++++---
 t/t5509-fetch-push-namespaces.sh |   1 +
 t/t5802-connect-helper.sh        |   1 +
 transport.c                      |  84 ++++++++++++++++++++---
 transport.h                      |  19 +++---
 9 files changed, 289 insertions(+), 67 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

