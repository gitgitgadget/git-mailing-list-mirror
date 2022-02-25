Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACD9C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 05:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbiBYFYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 00:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbiBYFYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 00:24:09 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A4E278CAD
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 21:23:24 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j22so2697580wrb.13
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 21:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EQ/xTVvmF564PydLTzcBRxmgyW46QzXIpVF6CejWuHI=;
        b=mUWRLLdTS7pf6OICtSiY4Z1I+PBdM7tBqbo8W87Puk7DiGfFhX9pLwculTChI3QbH2
         f/U+2YwLW1a+5gM2EFixkDYn0JXNeNlLAoJaBoTFJ8K+uDLyj/gAyf2MuG20+lWS+U3n
         QRNskDM6HiJHftamrY3L28YdVB5CKzdaDl6iszsCil05En0XkseGOd/kyX7aBQSujMuQ
         B/9ypwiq2j/ILJ/Qjcv2uzT6uN9OaHViFpfs7PBsuwy2Pgm4g1JWv4jXjPfBWNr13bO2
         rHlpGjPz4XLjezerTJhBpyjLPstN+IkSb8lMCbZgpuozEOL9XW8DkFBv18T4qTdvaU+g
         xGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EQ/xTVvmF564PydLTzcBRxmgyW46QzXIpVF6CejWuHI=;
        b=s0pe3kNs1T8JaIydEjuBpmzo9Phi9blPMNzye1LCkFvcVKmx57s9MmJGuKNnblbFiy
         MCInuqafjfprrtroxv9+kDXtXJ+k7gyXa61H/ho6VSet+Edi6HczNdH62536l9f7sYdU
         MPryO9tmQtpB/bKdEyOtXn6EgivQAUM4ByzeF1CZR0sIsMxCJGfjSfg/wbR4M8Zd1JCO
         pakaFZ1weoBKck7w4SonJhAoglSzeYLLUqZ5Kun3gaNhoM6rUWRkQOcgVaxSXx0Iupt/
         yjUHhatY90YnjL9/tm6lhcY4yb2QAyFJQWbZMfAGGXCRVz1x936cm6kvVW/om7lyOn/i
         djYw==
X-Gm-Message-State: AOAM531pXYWWRv4z9DWrgWIBw8p8j1T2xeLXHOqzT6GNdOvlcEfp7jw5
        pi+uAVxQIBCaKdCMhkXYddCaYNJV0ko=
X-Google-Smtp-Source: ABdhPJzGFOEAwshWEDMYg1M7Qu/o9vBfmmSMKpM9Z7ihikfjPt3D/VC/u1xOummSRiE20uVC391ECA==
X-Received: by 2002:a05:6000:10d2:b0:1e3:e061:1172 with SMTP id b18-20020a05600010d200b001e3e0611172mr4555986wrx.195.1645766602395;
        Thu, 24 Feb 2022 21:23:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay30-20020a05600c1e1e00b0037fa9762d50sm4907114wmb.12.2022.02.24.21.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 21:23:21 -0800 (PST)
Message-Id: <e1c5a3258263d05530f236c247603c2f342dac85.1645766599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v4.git.1645766599.gitgitgadget@gmail.com>
References: <pull.1147.v3.git.1645626455.gitgitgadget@gmail.com>
        <pull.1147.v4.git.1645766599.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 05:23:19 +0000
Subject: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Lawall <julia.lawall@inria.fr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

`parse-options.c` doesn't check if the usage strings for option flags
are following the style guide or not. Style convention says, usage
strings should not start with capital letter (unless needed) and
it should not end with `.`.

Add checks to the `parse_options_check()` function to check usage
strings against the style convention.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 parse-options.c               | 11 +++++++++++
 t/t1502-rev-parse-parseopt.sh |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 2437ad3bcdd..acd9ddbb372 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -492,6 +492,17 @@ static void parse_options_check(const struct option *opts)
 		default:
 			; /* ok. (usually accepts an argument) */
 		}
+
+		// OPTION_GROUP should be ignored
+		// if the first two characters of the help string are uppercase, then assume it is an
+		// acronym (i.e. "GPG") or special name (i.e. "HEAD"), thus allowed.
+		// else assume the usage string is violating the style convention and throw error.
+		if (opts->type != OPTION_GROUP && opts->help &&
+			opts->help[0] && isupper(opts->help[0]) &&
+			!(opts->help[1] && isupper(opts->help[1])))
+			err |= optbug(opts, xstrfmt("help should not start with capital letter unless needed: %s", opts->help));
+		if (opts->help && !ends_with(opts->help, "...") && ends_with(opts->help, "."))
+			err |= optbug(opts, xstrfmt("help should not end with a dot: %s", opts->help));
 		if (opts->argh &&
 		    strcspn(opts->argh, " _") != strlen(opts->argh))
 			err |= optbug(opts, "multi-word argh should use dash to separate words");
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 284fe18e726..2a07e130b96 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -53,7 +53,7 @@ test_expect_success 'setup optionspec-only-hidden-switches' '
 |
 |some-command does foo and bar!
 |--
-|hidden1* A hidden switch
+|hidden1* a hidden switch
 EOF
 '
 
@@ -131,7 +131,7 @@ test_expect_success 'test --parseopt help-all output hidden switches' '
 |
 |    some-command does foo and bar!
 |
-|    --hidden1             A hidden switch
+|    --hidden1             a hidden switch
 |
 |EOF
 END_EXPECT
-- 
gitgitgadget
