Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 603331F424
	for <e@80x24.org>; Mon, 23 Apr 2018 21:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932312AbeDWVcd (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 17:32:33 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41715 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932129AbeDWVcc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 17:32:32 -0400
Received: by mail-wr0-f194.google.com with SMTP id g21-v6so17643906wrb.8
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 14:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=13rOUpCrGurZSFqCc1oaKHcRLnFDGyzpFCITQ4Icm80=;
        b=Im2jzIKHP8DrThTyLts6lUT6eMB8NP7byFgJ7YAk4HblgNUbhEdCxbbGyVnhLXyFNL
         +JihJiYaP1wm2MgFdvy/fi45ailJ7vZ3f0z0gXnraDFl0LJz20eBJmGOqhQn7otF8Iml
         lO5Gya3ay0lHb8trkPH6IvQ6D70+YBfT6PHZcZC60jlsgPLctdYgJn0nla4ncz+r6xHG
         GeKtBl10UWEicn4eeRwcGkGav9FBN+vPPuDBFeI3TndHARJemRrFOX2H+1A71T0Iiyvw
         n4fGW8yxkr6G87ELax2c+0UOmZL1gyVdH/1EQepjGghsLUhMkNPcdB4Knynzp2a3/nQm
         gNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=13rOUpCrGurZSFqCc1oaKHcRLnFDGyzpFCITQ4Icm80=;
        b=fitDBFoD0og2O339tZGqUoZcL0ZiwJtJWZlWTRpGKiOvnHqDgaI45rmEHzSnYkgcrn
         CD5f8AeQhrIohYk5vj0V4vezrWoEHGT3shlsJKCd/J2WZM2IQLa9HiOUIQey/0V5C5D5
         R2LogMdciL167zh+kfpwSO8E6ZQi85dgNRYz17TQECyHUizmbTwEeNg/QK6cExiFY3hx
         l0F37AWSh/cPniq01XuXAPdylWxTYXwUcWIRz263Dfnbv5nlO7cP0qwt47Bp+vvHb9Rh
         pbdFVeVznuxo+XRe+yK6+bi1GT1ZyAr8dDIdGxm1Ns4tPKqIiNB0jm9Jjcl1CUPc0cMC
         kO5g==
X-Gm-Message-State: ALQs6tCp4XziYLH4wO6HQHTmDsL4Cw31eYEc55A+CHvsujBtrt0xLsnX
        /1xfg0r3CWEHwFy7byHjOvk=
X-Google-Smtp-Source: AIpwx48yV4Zaf+OwkRo57Kd5SoPbRmOs1ljrDKGab0BID770Wz5yhEKBdUHeFvnCEf4C5zAem5EOlg==
X-Received: by 10.28.131.211 with SMTP id f202mr11188549wmd.20.1524519151017;
        Mon, 23 Apr 2018 14:32:31 -0700 (PDT)
Received: from esm (ipbcc18eac.dynamic.kabel-deutschland.de. [188.193.142.172])
        by smtp.gmail.com with ESMTPSA id c50-v6sm25657814wrc.11.2018.04.23.14.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 14:32:30 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Mon, 23 Apr 2018 23:32:28 +0200
To:     Ben Peart <peartben@gmail.com>
Cc:     Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@googlemail.com>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v1 1/2] merge: Add merge.renames config setting
Message-ID: <20180423213228.GA20391@esm>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180420133632.17580-2-benpeart@microsoft.com>
 <CABPp-BFANBs=tOhS5BFfTMkdQsNYbUDExWK8QB0V=qD9YwZyWw@mail.gmail.com>
 <cd49481c-9665-124a-5f94-791f1a16657d@gmail.com>
 <CABPp-BFqj2TFiHUDsysafq0NHC4MV-QYZVxOZe1TNRrXMOQfng@mail.gmail.com>
 <20180422120718.GA29956@esm>
 <0eea1726-d511-6818-aa29-add6c13900da@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0eea1726-d511-6818-aa29-add6c13900da@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 09:15:09AM -0400, Ben Peart wrote:
> In commit 2a2ac926547 when merge.renamelimit was added, it was decided to
> have separate settings for merge and diff to give users the ability to
> control that behavior.  In this particular case, it will default to the
> value of diff.renamelimit when it isn't set.  That isn't consistent with the
> other merge settings.

However, it seems like a desirable way to do it.

Maybe let me throw in some code for discussion (test and documentation
is missing, mainly to form an idea what the change in options should
be). I admit the patch below is concerned only with diff.renames, but
whatever we come up with for merge should be reflected there, too,
doesn't it?

Greetings,
Eckhard

-- >8 --

From e8a88111f2aaf338a4c19e83251c7178f7152129 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Eckhard=20S=2E=20Maa=C3=9F?= <eckhard.s.maass@gmail.com>
Date: Sun, 22 Apr 2018 23:29:08 +0200
Subject: [PATCH] diff: enhance diff.renames to be able to set rename score
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Eckhard S. Maaﬂ <eckhard.s.maass@gmail.com>
---
 diff.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 1289df4b1f..a3cedad5cf 100644
--- a/diff.c
+++ b/diff.c
@@ -30,6 +30,7 @@
 #endif
 
 static int diff_detect_rename_default;
+static int diff_rename_score_default;
 static int diff_indent_heuristic = 1;
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
@@ -177,13 +178,33 @@ static int parse_submodule_params(struct diff_options *options, const char *valu
 	return 0;
 }
 
+int parse_rename_score(const char **cp_p);
+
+static int git_config_rename_score(const char *value)
+{
+	int parsed_rename_score = parse_rename_score(&value);
+	if (parsed_rename_score == -1)
+		return error("invalid argument to diff.renamescore: %s", value);
+	diff_rename_score_default = parsed_rename_score;
+	return 0;
+}
+
 static int git_config_rename(const char *var, const char *value)
 {
-	if (!value)
-		return DIFF_DETECT_RENAME;
-	if (!strcasecmp(value, "copies") || !strcasecmp(value, "copy"))
-		return  DIFF_DETECT_COPY;
-	return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
+	if (!value) {
+		diff_detect_rename_default = DIFF_DETECT_RENAME;
+		return 0;
+	}
+	if (skip_to_optional_arg(value, "copies", &value) || skip_to_optional_arg(value, "copy", &value)) {
+		diff_detect_rename_default = DIFF_DETECT_COPY;
+		return git_config_rename_score(value);
+	}
+	if (skip_to_optional_arg(value, "renames", &value) || skip_to_optional_arg(value, "rename", &value)) {
+		diff_detect_rename_default = DIFF_DETECT_RENAME;
+		return git_config_rename_score(value);
+	}
+	diff_detect_rename_default = git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
+	return 0;
 }
 
 long parse_algorithm_value(const char *value)
@@ -307,8 +328,7 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (!strcmp(var, "diff.renames")) {
-		diff_detect_rename_default = git_config_rename(var, value);
-		return 0;
+		return git_config_rename(var, value);
 	}
 	if (!strcmp(var, "diff.autorefreshindex")) {
 		diff_auto_refresh_index = git_config_bool(var, value);
@@ -4116,6 +4136,7 @@ void diff_setup(struct diff_options *options)
 	options->add_remove = diff_addremove;
 	options->use_color = diff_use_color_default;
 	options->detect_rename = diff_detect_rename_default;
+	options->rename_score = diff_rename_score_default;
 	options->xdl_opts |= diff_algorithm;
 	if (diff_indent_heuristic)
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
-- 
2.17.0.252.gfe0a9eaf31

