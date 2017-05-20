Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F97E2027D
	for <e@80x24.org>; Sat, 20 May 2017 21:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756506AbdETVnt (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:43:49 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36626 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753588AbdETVnq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:43:46 -0400
Received: by mail-wr0-f193.google.com with SMTP id v42so5741478wrc.3
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VAyUFqWR6te10cyXip2D28oUwTmslMOK+fArvTImb1Y=;
        b=YaD1rXawGBfkHZb8NR8SKw1lDSWeBt+wk348DFXJ5uTN6pChlkCI6RgxLHzBuXfA9F
         UofK8foTHn6l28tq3MPn6wKss0flS9no6lZoy0WkeinevGqNfW2YRdIzcf28dSF2Ljeh
         jgK5m7D6KV575DEaWUt/gl3DC4AU1vdLUYRXsXxrT/ZFGtJ6J/vkaYWWTWZHYyMeVbEa
         BD6txgfZdOYj4K28Iowv7kzvKIkniN+0rR9VqJ81PAsUTm6tH0CoRiNLG5RDaWV3NIsQ
         JoQNGTYqF937TTSba1voQxHUVy3OPQgV4mhGJ6W68JbsguQPCDintrV7xUTHeW7Twsvi
         is8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VAyUFqWR6te10cyXip2D28oUwTmslMOK+fArvTImb1Y=;
        b=rd5s2Ov3G6gWjOiOGcHiLI96DcdgIdZDkRqmCTkzjdw3zKj/qcc/DbkKOZhuO79+Kt
         Hk13qTGOuo6xvccGOfj6bcoAN1vlDZ0LZLqQ2tA6jefsnFdbMRU3qwIm0jEhwIDRV4ET
         tJKmhqWQ0YEMOSWTDEtG0vFCU8nIMkX5B2Rs/Kn/pEgr4OscSogONCwCSBvofVOp66nO
         Y0VJuN6/Nz67hekX6+3S/jgRGq5BBm/X14mHF2VDgHZdbki0r6jGJh79XPeNlCLi0FYo
         Zrdpm4i0YFaRZ5C+GvD2Eit9HUVvIBXaPCFmXTJe9m8GJ+7faCQ/W8HXX2a9E+MisP7E
         WttQ==
X-Gm-Message-State: AODbwcBvLPSaXlTuqT9H9G/ZhPWXmsxReyM44hIoJ0ZpSg8fextfTk9R
        ZoxNJHWDeAbNMQ==
X-Received: by 10.223.154.40 with SMTP id z37mr7556287wrb.136.1495316619718;
        Sat, 20 May 2017 14:43:39 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:43:38 -0700 (PDT)
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
Subject: [PATCH v3 20/30] grep: catch a missing enum in switch statement
Date:   Sat, 20 May 2017 21:42:23 +0000
Message-Id: <20170520214233.7183-21-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170520214233.7183-1-avarab@gmail.com>
References: <20170520214233.7183-1-avarab@gmail.com>
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

