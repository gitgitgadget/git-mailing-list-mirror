Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 091E01FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755260AbdEKJTo (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:19:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33660 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755241AbdEKJTl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:19:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id y10so5505523wmh.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJWecwsThp5xAti5ImkyUUcdjAqHoz3l3lQY7VChp2Y=;
        b=JKibAJI6mnHWmJHNz8lFglHsXc+KOY9EWOCdbQaJbWR6oHDBrQ+Rp/Idgcj+Aw+ujX
         mS8FcVD5nrx6JomI2GufPUxKbcsKCfh9k2SxwDVmcPrVJD3TaE53Ofm6+615026Lfe0i
         uZch2iHeh0CjX7Vt7POq7orFDZuuFJ1yDdVq7ksKBRR7yOa6b8qMps8zocqOlprxdd35
         +8yogw8zJRnSi5hVT0ovFb8ckDuHlmBaOni+72Y36o8jPF7fPbXMJ7YWD8Ez/mNhWT13
         9Vl5BN2iH0sTND9tmCMuzJ3IPYLClpERkGGSUVtxVrxjek3DrTVM1Zjz+l1HWDu6dBjg
         0VXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJWecwsThp5xAti5ImkyUUcdjAqHoz3l3lQY7VChp2Y=;
        b=YGioL7IqxHN50xkFiIRBF//JenN8y9P2GecwihbHJzwIK7ok3MvWlD1mU7hlJveV3R
         fBnz8wr0edqp1KnXqjtNSscChVgM2Xphj3vXwXKC3RJUIdDX27sIu1DBu37aGUnS954L
         Abz3eWkukJgT8+rUJDEBksUhhmNTXkLygdAnzEWDe+JBrCCvke1+NclNckk06URwIKa2
         eyvlexNp54X5fyUD+aJfvmThWPuqStJUkibOCdWVo36WSNO8zoyYkgzA9OiX+4U1nwq8
         yDX8qeNLVfL6j1bFkeBL1N8/VvG/aNQgK5dxEynOmzitfzQU2imtgilDu52PbTbhoc79
         EJCg==
X-Gm-Message-State: AODbwcDMHxb5ezUCw8YH2+X86oDdbXjVSLbFyF4AWFM23FV+/v4/v0Wz
        mLUkxDRaZ5pVnw==
X-Received: by 10.80.170.13 with SMTP id o13mr530edc.117.1494494379852;
        Thu, 11 May 2017 02:19:39 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:19:39 -0700 (PDT)
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
Subject: [PATCH 18/29] grep: catch a missing enum in switch statement
Date:   Thu, 11 May 2017 09:18:18 +0000
Message-Id: <20170511091829.5634-19-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511091829.5634-1-avarab@gmail.com>
References: <20170511091829.5634-1-avarab@gmail.com>
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
the value will just get coerced.

Thus catching this at runtime is the least worst option. This won't
ever trigger in practice, but if a new pattern type were to be added
this catches an otherwise silent bug during development.

See commit 0281e487fd ("grep: optionally recurse into submodules",
2016-12-16) for the initial addition of this code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 3ffb5b4e81..1c0adb30f3 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -495,6 +495,12 @@ static void compile_submodule_options(const struct grep_opt *opt,
 		break;
 	case GREP_PATTERN_TYPE_UNSPECIFIED:
 		break;
+	default:
+		/*
+		 * -Wswitch doesn't catch this due to casting &
+		 * -Wswitch-default is too noisy.
+		 */
+		die("BUG: Added a new grep pattern type without updating switch statement");
 	}
 
 	for (pattern = opt->pattern_list; pattern != NULL;
-- 
2.11.0

