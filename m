Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B9EC20284
	for <e@80x24.org>; Thu, 25 May 2017 19:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970190AbdEYTre (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:47:34 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34485 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036736AbdEYTrU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:47:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id d127so55399452wmf.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VAyUFqWR6te10cyXip2D28oUwTmslMOK+fArvTImb1Y=;
        b=krTW1MQ57uyzpKnRPZKBCiFdilu/DVvySuHal5Z9eRYye0cs5aV5ZJWhIq6Qn0Hnoy
         2lcjConUlADcheGKsDaBCTZyy3QpNhGY/zf5MQ1uLNZOIfDJEU+DaBSvsMN6bca0Ip3A
         uTGJUwtgWWJOGXRInFshw+7krQcrMNIOZ5+aqEw0DOa6ml53TZD75TVd9EADWWtkd/UL
         vwu8juEfqrrgLpv5sJS/bCC5P5xiQV5TzYCssKceHbbe7xB1zrjSB37UpbOsuFpRU4iJ
         1D3Yhc89B7ukg/2MwbOPpaBmJOeqeHTzP21B+nRLKvSWmwgE4GcJkuaF6c7YcuLWnw3l
         ZJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VAyUFqWR6te10cyXip2D28oUwTmslMOK+fArvTImb1Y=;
        b=RNveEiCLDrdtvzAync27qfVTONC1+6Zb/zCBZHN6HSOvzYlW1EcRw5o9YEOQ/rt3ru
         4TURANumvj3rQQc/122K1dklMao9fA1QuI6uthsTLlr+e6oZDVswj/Z9BG9TDJElj/Ly
         +m3g5L1sR/E90EyzFo50hXbyAcFGSVVoIQE55/1SBkxegPRpL8B5Xma4y//htppH4z0Y
         cW1y2PDdTeLPdFU3TK+F2VFDbjv4AP8VAGywkRCq7lTcfKRXF+d8CjuncyOVuWPNnVkQ
         okfcAEyCgR6F/FuB9HO1BiKH8cMDFK31slRx+oiuRKNut8Bhwfmh0ax4DfsYsfJTRZus
         WGgg==
X-Gm-Message-State: AODbwcB5RdiSrZIZAk4u1drHXFA/4G3B3qJdf/5PGnConPVM5I4MGUj7
        l9AjnujZqF9nf4BjC2E=
X-Received: by 10.28.157.14 with SMTP id g14mr11538161wme.114.1495741627958;
        Thu, 25 May 2017 12:47:07 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:47:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 21/31] grep: catch a missing enum in switch statement
Date:   Thu, 25 May 2017 19:45:25 +0000
Message-Id: <20170525194535.9324-22-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a die(...) to a default case for the switch statement selecting
between grep pattern types under --recurse-submodules.

Normally this would be caught by -Wswitch, but the grep_pattern_type
type is converted to int by going through parse_options(). Changing
the argument type passed to compile_submodule_options() won't work,
the value will just get coerced. The -Wswitch-default warning will
warn about it, but that produces a lot of noise across the codebase,
this potential issue would be drowned in that noise.

Thus catching this at runtime is the least bad option. This won't ever
trigger in practice, but if a new pattern type were to be added this
catches an otherwise silent bug during development.

See commit 0281e487fd ("grep: optionally recurse into submodules",
2016-12-16) for the initial addition of this code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 3ffb5b4e81..a191e2976b 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -495,6 +495,8 @@ static void compile_submodule_options(const struct grep_opt *opt,
 		break;
 	case GREP_PATTERN_TYPE_UNSPECIFIED:
 		break;
+	default:
+		die("BUG: Added a new grep pattern type without updating switch statement");
 	}
 
 	for (pattern = opt->pattern_list; pattern != NULL;
-- 
2.13.0.303.g4ebf302169

