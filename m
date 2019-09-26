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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AF9D1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 08:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfIZIaS (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 04:30:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43032 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfIZIaS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 04:30:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id n14so1213555ljj.10
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 01:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PTJvnArUvKNsOxVEuhJbTo8k3kGB1/WAG8v2GjmdSbc=;
        b=enK5XlcoK5z0eyvh+UUNaqn4mqRzi51HsomZ6qwb/vEs1RtL1q+EoLQelsThCfRPld
         tsnQ2BN0A/utH7B84qUjDI7yU68DtzRh4nhgx4VZzcv97a6NJ8VhXGL71jeDSHjWRDyl
         bzwgN9cPPWB6NrsiIM0G6dzapssaT9nYVDNurndDVL3mAsbWs1aoPWhCeSMpfKqBTvE/
         TuZ7NCXlspDaVA/qwijiiKKhDQa0idKQ3xLdJDXF7PpsqHDTmuukQIO71ZLHqpUAbIni
         TDg/xWlx9zJP14S7hTHV/hoX50AOWXi70hb4sjDIBHY1CST7lfUndhLcRGtHZB7qCl/n
         l/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PTJvnArUvKNsOxVEuhJbTo8k3kGB1/WAG8v2GjmdSbc=;
        b=SFI6IOx51Eh08p8HHfrt0V9X5rql7DHLPrXYrCLL8Zh6vAlP9CE83eaw3gJkMUPfmd
         qGq6/n4sU8dgMPdbXYGpyk4fIkJg1DC6xt9p83efi/gHsvzGjxv0fZJSrbFwef615P5Q
         aWWOr7fg70S3ReuuyWj1hSk5nSkoldSBQVL6yzq+mP6f/hxgaJzy840ksXg7phAPQ5P9
         Ji1DCn8dmB3W5XLyy3LhfOsOeUyLoltoMagcs/aNVDsEaWWNEdva5MNSlVZ7p5xhaAQV
         cfbiNv+Iw0TvdiKADNjJxhhdh1w9oU8S1Sh8A8m4TwrzjaDYhhU8hGIeti3cBrWS71P9
         9Mwg==
X-Gm-Message-State: APjAAAWLhHi3thqb5Dep23nKhx+zFBdoILvW9HJXtuv4TTQnpiO3PsmK
        buUBQhT7fCUL5APjCISiFDg4IYs5
X-Google-Smtp-Source: APXvYqykGSYzHn69NnVzoslZgHrlFqACU6m1LOl0Chl3NSdnw44zujz7LCBUKSyPWe3B9vzZph748Q==
X-Received: by 2002:a2e:86d5:: with SMTP id n21mr1652919ljj.1.1569486616254;
        Thu, 26 Sep 2019 01:30:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3sm343153ljs.20.2019.09.26.01.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 01:30:15 -0700 (PDT)
Date:   Thu, 26 Sep 2019 01:30:15 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 08:29:59 GMT
Message-Id: <c978c7659909e21057cdbcaba7c1c8ea444867b9.1569486607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 06/13] msvc: handle DEVELOPER=1
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

We frequently build Git using the `DEVELOPER=1` make setting as a
shortcut to enable all kinds of more stringent compiler warnings.

Those compiler warnings are relatively specific to GCC, though, so let's
try our best to translate them to the equivalent options to pass to MS
Visual C++'s `cl.exe`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/vcbuild/scripts/clink.pl | 46 +++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index 00fc339cba..ec95a3b2d0 100755
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -70,6 +70,52 @@
 		push(@lflags, $arg);
 	} elsif ("$arg" =~ /^-[Rl]/) {
 		# eat
+	} elsif ("$arg" eq "-Werror") {
+		push(@cflags, "-WX");
+	} elsif ("$arg" eq "-Wall") {
+		# cl.exe understands -Wall, but it is really overzealous
+		push(@cflags, "-W4");
+		# disable the "signed/unsigned mismatch" warnings; our source code violates that
+		push(@cflags, "-wd4018");
+		push(@cflags, "-wd4245");
+		push(@cflags, "-wd4389");
+		# disable the "unreferenced formal parameter" warning; our source code violates that
+		push(@cflags, "-wd4100");
+		# disable the "conditional expression is constant" warning; our source code violates that
+		push(@cflags, "-wd4127");
+		# disable the "const object should be initialized" warning; these warnings affect only objects that are `static`
+		push(@cflags, "-wd4132");
+		# disable the "function/data pointer conversion in expression" warning; our source code violates that
+		push(@cflags, "-wd4152");
+		# disable the "non-constant aggregate initializer" warning; our source code violates that
+		push(@cflags, "-wd4204");
+		# disable the "cannot be initialized using address of automatic variable" warning; our source code violates that
+		push(@cflags, "-wd4221");
+		# disable the "possible loss of data" warnings; our source code violates that
+		push(@cflags, "-wd4244");
+		push(@cflags, "-wd4267");
+		# disable the "array is too small to include a terminating null character" warning; we ab-use strings to initialize OIDs
+		push(@cflags, "-wd4295");
+		# disable the "'<<': result of 32-bit shift implicitly converted to 64 bits" warning; our source code violates that
+		push(@cflags, "-wd4334");
+		# disable the "declaration hides previous local declaration" warning; our source code violates that
+		push(@cflags, "-wd4456");
+		# disable the "declaration hides function parameter" warning; our source code violates that
+		push(@cflags, "-wd4457");
+		# disable the "declaration hides global declaration" warning; our source code violates that
+		push(@cflags, "-wd4459");
+		# disable the "potentially uninitialized local variable '<name>' used" warning; our source code violates that
+		push(@cflags, "-wd4701");
+		# disable the "unreachable code" warning; our source code violates that
+		push(@cflags, "-wd4702");
+		# disable the "potentially uninitialized local pointer variable used" warning; our source code violates that
+		push(@cflags, "-wd4703");
+		# disable the "assignment within conditional expression" warning; our source code violates that
+		push(@cflags, "-wd4706");
+		# disable the "'inet_ntoa': Use inet_ntop() or InetNtop() instead" warning; our source code violates that
+		push(@cflags, "-wd4996");
+	} elsif ("$arg" =~ /^-W[a-z]/) {
+		# let's ignore those
 	} else {
 		push(@args, $arg);
 	}
-- 
gitgitgadget

