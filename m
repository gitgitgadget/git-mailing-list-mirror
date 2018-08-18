Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FF8D1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 06:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbeHRJmL (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 05:42:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37615 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbeHRJmL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 05:42:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id n7-v6so4489101pgq.4
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 23:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=upG7VqI5Uk1evSHhU2mFpa+EnlFBGcCtyHmu0BQpSNw=;
        b=O7dTpeS0rwOxDXUE+uaW4ms9IDAKrNlomSeF/hQs6vRO17mX0XrAWForzTNDO6lfvl
         foI4psDmm5tGZU5JeTqFpTxx+09QNPdrW3OoEVBQtgKLxEJPin36yg/ifuRXESMO6QPG
         8lQJFGk2uT+IvyyrVGQ+zZFm553zBf8Yp+UMwNfkQKQ5l7iBzQqMbOpM6iOclYCZcsXx
         dWIuUy2yGQiwsZzHOnMguJJCMe/rmA5M/BkgtTnAlUoUynf1+St4ce4mUPaGSO7Qast/
         q+8hnKgsVA8YTn0BMOXdF9vg1p90FkQvqu3ivoeXAV2R1cMFfsX/Xf9cp/z9YpU+Xz+j
         OXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=upG7VqI5Uk1evSHhU2mFpa+EnlFBGcCtyHmu0BQpSNw=;
        b=ayiIQUGs3QPRJWid9JOm+f0FAAwMcEO/q1XFsss8fLVYzogQ4BHDo5AxX7gQAlEqZz
         R+QiKJtWKLf79CiyZd5xqAk97E1rAY6hPn4MTX2u0YKSEkry8mK3rvy2rZC2zkqkQ4PZ
         LgmbpUBY2qWAUlaSvfn/cq5QgAMyhF3Fk3kN6MviY35Q2Vo2SWpWCqokuwNONTqynQzE
         LWBgHICIi3olBsbSfTcmKZ8TUEZo5z6DMSPazoiX/LdxjQVoibF3jEinaychSz4Ike0Y
         QEbk1iI2dClplnNAWF/rN5JZRBy8HLr0ebb15yN4jCLZ8/FUUL6GNJdtbuIXErERMtcn
         v/Gw==
X-Gm-Message-State: AOUpUlFgGUoUJ8hGy2qpNheWzxs1EdTd3Uq0wvGzCTuuhWWtXXGZWTmf
        MRvFOwhOLnN57uzO/rsPYcyLC78r
X-Google-Smtp-Source: AA+uWPwn4fXL7oxWRMH7zqtbbRmEBNpLaeHJ5CDMJ3dNOBQBHl6ijAfliu/DK1zjAXMs1K1qL3qCug==
X-Received: by 2002:a63:d613:: with SMTP id q19-v6mr35390425pgg.327.1534574137091;
        Fri, 17 Aug 2018 23:35:37 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j22-v6sm4393897pfh.45.2018.08.17.23.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 23:35:36 -0700 (PDT)
Date:   Fri, 17 Aug 2018 23:35:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, sunshine@sunshineco.com,
        jrn@google.com, git@vger.kernel.org
Subject: Re: Re* [PATCH v7 1/1] sideband: highlight keywords in remote
 sideband output
Message-ID: <20180818063534.GD241538@aiede.svl.corp.google.com>
References: <20180807125108.104293-1-hanwen@google.com>
 <20180807125108.104293-2-hanwen@google.com>
 <xmqqd0ugc07x.fsf@gitster-ct.c.googlers.com>
 <xmqq8t54bzo4.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8t54bzo4.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> Subject: sideband: do not read beyond the end of input
>
> The caller of maybe_colorize_sideband() gives a counted buffer
> <src,n>, but the callee checked *src as if it were a NUL terminated
> buffer.  If src[] had all isspace() bytes in it, we would have made
> n negative, and then (1) called number of strncasecmp() to see if
> the remaining bytes in src[] matched keywords, reading beyond the
> end of the array, and/or (2) called strbuf_add() with negative
> count, most likely triggering the "you want to use way too much
> memory" error due to unsigned integer overflow.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  sideband.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

And here are some tests to squash in.

A sideband line consisting entirely of spaces causes us to overflow
our buffer and end up with a negative number of remaining characters,
ultimately resulting in the message

	fatal: you want to use way too much memory

when parsing it in order to add color.

We also forget to limit a strncasecmp and isalnum looking for keywords
to color in to the memory region passed in.  Fortunately all callers
put a delimiter character (\0, \r, or \n) after the end of the region
so this does not cause trouble in practice.  Add a test for
futureproofing to protect the new bounds checking code in case that
ever changes.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks again,
Jonathan

 t/t5409-colorize-remote-messages.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index eb1b8aa05df..f81b6813c03 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -15,6 +15,8 @@ test_expect_success 'setup' '
 	echo warning: warning
 	echo prefixerror: error
 	echo " " "error: leading space"
+	echo "    "
+	echo Err
 	exit 0
 	EOF
 	echo 1 >file &&
@@ -44,6 +46,12 @@ test_expect_success 'whole words at line start' '
 	grep "prefixerror: error" decoded
 '
 
+test_expect_success 'short line' '
+	git -C child -c color.remote=always push -f origin HEAD:short-line 2>output &&
+	test_decode_color <output >decoded &&
+	grep "remote: Err" decoded
+'
+
 test_expect_success 'case-insensitive' '
 	git --git-dir child/.git -c color.remote=always push -f origin HEAD:refs/heads/case-insensitive 2>output &&
 	cat output &&
@@ -58,6 +66,12 @@ test_expect_success 'leading space' '
 	grep "  <BOLD;RED>error<RESET>: leading space" decoded
 '
 
+test_expect_success 'spaces only' '
+	git -C child -c color.remote=always push -f origin HEAD:only-space 2>output &&
+	test_decode_color <output >decoded &&
+	grep "remote:     " decoded
+'
+
 test_expect_success 'no coloring for redirected output' '
 	git --git-dir child/.git push -f origin HEAD:refs/heads/redirected-output 2>output &&
 	test_decode_color <output >decoded &&
-- 
2.18.0.1017.ga543ac7ca45

