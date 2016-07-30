Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 508F11F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbcG3R1T (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:27:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35913 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id x83so20019733wma.3
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:26:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2b48qItDXpyILzt7DE5hwkEO/kNYfQwREkoAvNis3OQ=;
        b=nK7RTFWxSnI2Q9goIEgKIl4gM2y4vlTpgD0CFKVhnEPYYOvxBbrnA32gwudy4Rvz7Q
         SVZWq2DRsFaaC52aj3oZmB8pxh0yxZH5LMak6PZStj1UoRUcy/7NzLwfBJx9WLsg51A7
         N9FA+iTISpDu4Lze69ehLQyHzrw7cfaPjt4xmSeQJoRSjlwq9jopVAYfecikQjUMLPGE
         S7+hcwDK6ReQEE5Jkp9hPUEPBeNtsPgFmXTj5O57nlnIZqWZ5V5FWyial6bhIZ4qTqB9
         CMxFdVyVvPFUregFY0bVrURaezsBoxUSBFKJdHO4oSJQY2Gc/rHin4l6TmNnOPxO52Ov
         D3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2b48qItDXpyILzt7DE5hwkEO/kNYfQwREkoAvNis3OQ=;
        b=hAFu8ROSQeM5k0LM+W/K7qhOkQTnun5HRQov9ugvuCX7Po8zbXe16xpz6hv2Z1ZkNc
         RkkkEHSEwRS27aSBP0Os0PJ7N3xaZOvrVReUn4FLz+7zNC1/MBhfJcA36fvgHcRSG1wn
         eoyPzdXjUCz+tGmx52I+f6YfMClFpdlmUlRHYdnvtfSUXlDM1jpGicQ8m4izxMzut0Q4
         0utWMX4InsLxJNphglmiLk5Ylp4N82jhb+YSelSFjHK5OXlEsJPrPW92MwixCNVpkvLK
         XWfCy/zaFo8XUkV6Ap3vs91x0H1h+OJzIOK+qWaUM628AeFPzTn6kWwBflqiXsO7zgf/
         Sqpw==
X-Gm-Message-State: AEkoouvxcAPun2oYowM2OkNxBRoraIOZY83tcORmCnJ2j3zP5kKXejkNhloBHzvVdJpHxg==
X-Received: by 10.194.115.4 with SMTP id jk4mr48425217wjb.109.1469899593008;
        Sat, 30 Jul 2016 10:26:33 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:26:32 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v9 36/41] apply: don't print on stdout in verbosity_silent mode
Date:	Sat, 30 Jul 2016 19:25:04 +0200
Message-Id: <20160730172509.22939-37-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When apply_verbosity is set to verbosity_silent nothing should be
printed on both stderr and stdout.

To avoid printing on stdout, we can just skip calling the following
functions:

	- stat_patch_list(),
	- numstat_patch_list(),
	- summary_patch_list().

It is safe to do that because the above functions have no side
effects other than printing:

- stat_patch_list() only computes some local values and then call
show_stats() and print_stat_summary(), those two functions only
compute local values and call printing functions,
- numstat_patch_list() also only computes local values and calls
printing functions,
- summary_patch_list() calls show_file_mode_name(), printf(),
show_rename_copy(), show_mode_change() that are only printing.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index e369f49..e109acd 100644
--- a/apply.c
+++ b/apply.c
@@ -4699,13 +4699,13 @@ static int apply_patch(struct apply_state *state,
 		goto end;
 	}
 
-	if (state->diffstat)
+	if (state->diffstat && state->apply_verbosity > verbosity_silent)
 		stat_patch_list(state, list);
 
-	if (state->numstat)
+	if (state->numstat && state->apply_verbosity > verbosity_silent)
 		numstat_patch_list(state, list);
 
-	if (state->summary)
+	if (state->summary && state->apply_verbosity > verbosity_silent)
 		summary_patch_list(list);
 
 end:
-- 
2.9.2.558.gf53e569

