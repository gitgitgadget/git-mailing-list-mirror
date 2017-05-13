Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2061220188
	for <e@80x24.org>; Sat, 13 May 2017 23:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758873AbdEMXQv (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:16:51 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35495 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758798AbdEMXQr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:16:47 -0400
Received: by mail-qk0-f196.google.com with SMTP id k74so12532231qke.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oUn0WyVA2mU3hdDIltdKqRoUGnTrLqgz7fRoA80mlL8=;
        b=Z7ELke5bVWoeVu8Er1vhJnsBQPYtCWyrMaZtTYWeSRBUOhelHgo39aeezyjvsFVi/a
         lDtqhFhRuxDSE2eST8UCB0j8CRx3z8SeIGBKqL7sN7J9xSRsn/gpbm0/1zZGwb8wiQtS
         YsXI6PmQsqVhoIS0jW3hlWxkLLfAvSaMC0bmN1D0KUhnUOVK8o54Cs1uyFEAO2ocspEA
         2umN1gjV6B0nhAkbBjlr2MWv1fk/T9JiGAMlNGWGVGE25Xo7JXGRPR3dCyumXBIHaMUJ
         3FulATg3FzbaPedwKB9YDjg/NJYK0u6IvTyU2p0TyFa3KBJUj9vGtndF9VInW3EZV4Gb
         vQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oUn0WyVA2mU3hdDIltdKqRoUGnTrLqgz7fRoA80mlL8=;
        b=ogJP3vjcsNbElPK9dw76GFOyvQ9HsybxZvKBtKagPKyR9SXJfPZmG8q9L1aoRyrANO
         n1wc9eXTTeMM7EYR50ovpfw8R6vk+GemuyqlXvwWFtKlumFbx0f3O+ofJsIpu4l++i3j
         6EReOd8qAQUqHNRJS34KFcZg4d1/MUhBsuoiCcz1rXfWXa32QiX/MHHQ/LpYTrXREuoU
         IXj3BILDED4c8lsEC2+AfwMeLg/vS5x+KtmJFirhfjPgBbymTHTi9w2cuNL9ziR6UaaG
         YlIpO7RGUli6kZlSWB9zE3gMW7BP92gC65GkR4d4N2O4JgRKhcDpLITPAyD5OxfWqjBs
         +UGg==
X-Gm-Message-State: AODbwcBK89T8U5PHZc60PAINjGpZh7bUxY38vAMcNMFVHWLmv4/7ocgK
        /OhDtPpVrWNm+A==
X-Received: by 10.55.83.70 with SMTP id h67mr9378053qkb.287.1494717406608;
        Sat, 13 May 2017 16:16:46 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:16:45 -0700 (PDT)
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
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 18/29] grep: catch a missing enum in switch statement
Date:   Sat, 13 May 2017 23:14:58 +0000
Message-Id: <20170513231509.7834-19-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
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

Thus catching this at runtime is the least worst option. This won't
ever trigger in practice, but if a new pattern type were to be added
this catches an otherwise silent bug during development.

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
2.11.0

