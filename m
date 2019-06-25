Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFBFA1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbfFYOtp (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:49:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33972 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbfFYOtn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:49:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id s49so27593970edb.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VdLnT0ez1EMIfdC3FCjWfNOpGA2/FA1Og7dzu2n+60A=;
        b=CFAlAvHQsLYzEqIFBlIOPx3f4fpLyL26gdFRIpBKrvTfbBTSb6wC5Zxi46aBtu1LCE
         2NznWEufBnMQENT4t28MpRNqF9ejZUUyOxq4fCT7LI60wJCo0L/EelJOJYpb7vAP29/r
         IdydhPBMWZBwE4Zlkccd4AQ5eQTynWLLXWrAltcAzYJJZxCfonOwA0n38vUZEIWHFF0v
         05Y268OWjUyczxtL0qTs9Qur3GVPZmOYSYvA7Qjw/0nBCROhqz5ABzTmpyjblkQX/dSf
         4kFOLhyk4ppwW4FCzxx2J+UynaavJ89dEiCWGu5TQLlhAn1y08wpOyJaJf6PTV+pnh6J
         pF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VdLnT0ez1EMIfdC3FCjWfNOpGA2/FA1Og7dzu2n+60A=;
        b=QLau6Sk+j1IMHF6znMEQVmPLluvQTeCfMME6v4BrRWTErbGjEI/XA/FbJDrJ6VFgxZ
         m4CFcrPYJ71RXdJBS9I6gD4OWS/w+OCBUzzT/uufbQZ3Js0n14127MOtu0eI8y0MU0Yi
         ofJxVY4e+yyZv2L+bcS2MK9HU+vT1azvu14YXJWym1a8dunAXROIvAmA3GsO5ciq/oBn
         bHw+pxd6l/Uk6UVy0hY4NMwxAHWMK24Hoo6zbLgRWmudimflnUNJ7eibAM580sWWfoGO
         jSVojfS9704cys3LXfu7mkIq79EYUUN8gfVr2JPm1QlZeuf+1A5L1vDUbVxW7LVMpUq/
         lvlA==
X-Gm-Message-State: APjAAAUtspdVGaivLQhIEoX6OuzE4yRbNMIqOuAkBK1WDERPEA4lz250
        tm0ntJjg3S2JJ06NQj2mkhj86Bti
X-Google-Smtp-Source: APXvYqw+3prNQefnTo5hLioyDwygtcAvNuVCG61ub664oJXCuwu/Fimsc4nY2Cf/r9NWvw9sY1rn6Q==
X-Received: by 2002:a50:97ac:: with SMTP id e41mr115343561edb.27.1561474181846;
        Tue, 25 Jun 2019 07:49:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e12sm4958221edb.72.2019.06.25.07.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:49:41 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:49:41 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 14:49:24 GMT
Message-Id: <c9a6f6892c5ff0f24da0464895865eeea1240f42.1561474167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v3.git.gitgitgadget@gmail.com>
References: <pull.149.v2.git.gitgitgadget@gmail.com>
        <pull.149.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 18/20] msvc: do not pretend to support all signals
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This special-cases various signals that are not supported on Windows,
such as SIGPIPE. These cause the UCRT to throw asserts (at least in
debug mode).

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 667285887a..d01e88c2f8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2119,8 +2119,33 @@ int mingw_raise(int sig)
 			sigint_fn(SIGINT);
 		return 0;
 
+#if defined(_MSC_VER)
+	case SIGILL:
+	case SIGFPE:
+	case SIGSEGV:
+	case SIGTERM:
+	case SIGBREAK:
+	case SIGABRT:
+	case SIGABRT_COMPAT:
+		/*
+		 * The <signal.h> header in the MS C Runtime defines 8 signals
+		 * as being supported on the platform. Anything else causes an
+		 * "Invalid signal or error" (which in DEBUG builds causes the
+		 * Abort/Retry/Ignore dialog). We by-pass the CRT for things we
+		 * already know will fail.
+		 */
+		return raise(sig);
+	default:
+		errno = EINVAL;
+		return -1;
+
+#else
+
 	default:
 		return raise(sig);
+
+#endif
+
 	}
 }
 
-- 
gitgitgadget

