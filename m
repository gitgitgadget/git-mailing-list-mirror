Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F30220248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfBXKLk (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:40 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38303 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbfBXKLe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:34 -0500
Received: by mail-ed1-f66.google.com with SMTP id h58so5218988edb.5
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lTET2oTpTgc0TvjdCTBHFo5OtJfPzLvrGW1271tCGDo=;
        b=IWasfszs8bFnsg6gPsqAeXNrmrlA3KP7TjbbX8VWIfa/1+PPPyIe39bYeGPYf6Rj6f
         amZnWH48dFLGlI3QZbq4oyJy1N78kd50foV9zMYHy4ikx+i+Z76a291+sAvo+V5zsLpK
         oKucu2aa/FKe0OZX16j3NZaI/Yv9wn2YN5ueVVGaCuBL7YMB2YXJOAGTW5IAfs38jLkl
         KL5UtWPJndDBXKRkXszZkMtEuYUhNHv16nEE6Y00yA8hDle2JYFJxYPXGzwmjNhWPgKk
         Whf5E/j8M3EvW5CTkNs49Q/8OTE8bULxLAfGHLuc2KM1tOArwtmqbQ5o39GEzi6buvj4
         +B6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lTET2oTpTgc0TvjdCTBHFo5OtJfPzLvrGW1271tCGDo=;
        b=UW9DfhY5m3n5U1f6Ap90GHW3mUFJYrKfgUwetyx2sR4yt9ejA2P91aKnAurJrbqWks
         u8kaFWmkGM5O06I0ZtLEFihwepP2yc7SRZeFYpLr5CQVxId7tdNWxLia4yZjqOfwfp4E
         hXg3jt4FjoF/vd9RFdVI9VRL8yQ9kCegrPs6bDCUcLs7BT8vicFDob3yi0mllTzL54sp
         dQkL5SuCjGzIhledsmAz6q3JePy2tAtu0rkYGLRP1KXkuPfSJ6k/lh++wxQciEef9pU/
         nv6ipFAn0as52M26v+OSr2LTNXSdzLLsPE5BRJmMGv24pgxMv1eQPTJlVZfk4BmnkAF0
         u7FQ==
X-Gm-Message-State: AHQUAube2ZpF38VwDr74aik6yvk+RSAqkmk5vmcD6WyENamG13aozAI3
        X0chQBqt5lITFIjZsxOttkhRxpMN
X-Google-Smtp-Source: AHgI3IboWFPbE/MRXoDk9UNl89jZkh1pH9uPC4YQOZOT727ukVDeBOGKMiufk/q6kYNW71mwLo+wLQ==
X-Received: by 2002:a50:86b3:: with SMTP id r48mr10361144eda.17.1551003092792;
        Sun, 24 Feb 2019 02:11:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12sm1789756edj.61.2019.02.24.02.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:32 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:32 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:11:10 GMT
Message-Id: <949c50dc7bcbba5a9bb6879678e490c274887b99.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 22/26] bisect--helper: retire `--bisect-autostart` subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--bisect-autostart` subcommand is no longer used in the shell
script and the function `bisect_autostart()` is called from the C
implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 6cd74049e8..848401094d 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -28,7 +28,6 @@ static const char * const git_bisect_helper_usage[] = {
 					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
 	N_("git bisect--helper --bisect-auto-next"),
-	N_("git bisect--helper --bisect-autostart"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
@@ -1020,7 +1019,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
-		BISECT_AUTOSTART,
 		BISECT_STATE,
 		BISECT_LOG,
 		BISECT_REPLAY
@@ -1041,8 +1039,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
-		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
-			 N_("start the bisection if BISECT_START is empty or missing"), BISECT_AUTOSTART),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_CMDMODE(0, "bisect-log", &cmdmode,
@@ -1103,12 +1099,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_auto_next(&terms, prefix);
 		break;
-	case BISECT_AUTOSTART:
-		if (argc)
-			return error(_("--bisect-autostart requires 0 arguments"));
-		set_terms(&terms, "bad", "good");
-		res = bisect_autostart(&terms);
-		break;
 	case BISECT_STATE:
 		if (argc == 0)
 			return error(_("--bisect-state requires at least one revision"));
-- 
gitgitgadget

