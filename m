Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8695BC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 14:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbiBWO2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbiBWO2H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 09:28:07 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8833F4B425
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:27:39 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v21so4661936wrv.5
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0+N5xsfqc55jf6KHiNqi60QCC/m3RfVQDLsjUaMjvhs=;
        b=ExZDB/5ZhkLmA8OGU8aantl4Y9i3ts40ADOIkBCB8ZwW9U2DI7f6+glofv+Y/VIGm9
         /rMd6zDDbbXkDu/0XVUs2PCu9II+pPEDdBPlbu5LorJ7aboy4aRlx6Of1D54PSrOHide
         9nwCQKyhIPK9HLRtzyr633y1xPzadVfFlgNUl99XMukWg6OKQlGUB4CrsmaDoKHKUqVv
         ShdICkp9Ng0dv6XRWWWL7tUzChB9QmljoWbAm9EXDvM5LGSPgE0pFgbaFW/4bsDmaeZx
         FElV+fdUPqUno4GAMwZt7siMRp6aMMX022TUdct22xg63TfoBIbE3vBgElnjQpZGCPll
         Hb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0+N5xsfqc55jf6KHiNqi60QCC/m3RfVQDLsjUaMjvhs=;
        b=k+a6FgnvskujsKXmGI8tP9LKuY5BAcwHDDy+hXrD9vqlx/j2LcvbTYM/24mlzXhXZE
         nfT62MZqnqRCJNDFFhcqxTtm10fXGfivMyXFhfXv8BRzixcixBkeJknP50LAbNBJ7QQO
         k7MWtMHlT4HKSWUgl1GeCD00+V4NHYS7flr64No93OUO1HMvq9iRyw8Ux12supnPLFFn
         acUvXuGOX11MsA5q8mLKbdKUYlE4vMTq24RZ1dttiooIcqZjcIOBYPvR6yzwgHYgLwrk
         xzGLdEk7RmMDTXSHGKhtWN9GO8OwoFcPXbGIxXioJ5D2maTVsSgrZkO3+Z8vDZ7lkk/h
         FRLw==
X-Gm-Message-State: AOAM533sJ/vadZQ0/ADqYD9TQNFAjqbSiMC+pf+4AZiTndEDSJlOSKZk
        qF764FWcxeCWr1ZXkwPCuZ4jDiBlhow=
X-Google-Smtp-Source: ABdhPJw9rq3PIY7WDowO2QTPb7UnMOesaiCBYVnn6lrUTYQ5VaMoEqDUEOLyjlR1QhK9cDpUKlTldw==
X-Received: by 2002:a5d:6da3:0:b0:1e3:2f74:f025 with SMTP id u3-20020a5d6da3000000b001e32f74f025mr23896971wrs.59.1645626457938;
        Wed, 23 Feb 2022 06:27:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c410500b0037bc3e4b526sm5501911wmi.7.2022.02.23.06.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 06:27:37 -0800 (PST)
Message-Id: <9d42bdbff6ccaaf34952de9e6cc4ff2e7eef714d.1645626455.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v3.git.1645626455.gitgitgadget@gmail.com>
References: <pull.1147.v2.git.1645545507689.gitgitgadget@gmail.com>
        <pull.1147.v3.git.1645626455.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 14:27:35 +0000
Subject: [PATCH v3 2/2] parse-options.c: add style checks for usage-strings
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
 parse-options.c               | 6 ++++++
 t/t1502-rev-parse-parseopt.sh | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 2437ad3bcdd..eb92290a63a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -492,6 +492,12 @@ static void parse_options_check(const struct option *opts)
 		default:
 			; /* ok. (usually accepts an argument) */
 		}
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
