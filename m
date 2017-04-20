Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45EC9207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947787AbdDTVYT (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:24:19 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35928 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943485AbdDTVYR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:24:17 -0400
Received: by mail-wr0-f193.google.com with SMTP id v42so686258wrc.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NnqYVO826eWrlvWUsC/g7ecfgD1WkegPIgXns1skrYU=;
        b=uoE2lPAUm9aPbvLJXTevqcq5vxDsSx3tGUwGLOO9zwfheY+P5eXVkmgvRAz1m1iRif
         vSRTopUa8Ws6D01F8qrk035zx9DtD7JPoqOXWkF0LmeazhRxe9XH3lxyN802clszu5he
         eIjQBF4CrV8QQbAXhHycM+iWirToK6U5q5CU2f0nmqw1OxRk1dT4QKU/srJQ155zQrj+
         HkhVp2RXk4OslktFUj4ciNR86dltcPgMP2eBdIlU+5HDe10LACssDmQowb57N+bXRTBI
         ZcBAJqCY8Q0vVz2pZkGx4klURzAlWocZIZNCzMpZZct3bV77ICkpsNO0msBl9Z9pbrQY
         9piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NnqYVO826eWrlvWUsC/g7ecfgD1WkegPIgXns1skrYU=;
        b=l5spIE9xCHydb/De5FvkO65a+i7mV9pptYaTceiKIXq0XM3CZWHPJE+y1+gpJEn5Mq
         /kMjb6s9pjDRmVbAcpICNRRBbWpCAQG6EwXENqtZx3rEAPJ20DN67HhvDAbuIU9yaaEj
         rG9sjlXZ8iYiZkB5BIo+fZuAzF2cmSifQr/3sIOrbj83WEGEZ8DHH8vVDX70HgsxDzZ0
         2j3cWitzNm+n/DmvAr7L075ExLkjAYnFa3zb/dbQog2r4c/7xpAdVfO5Y7KI4BHfXwo1
         eEkOQkGjDKusnHp0jtXHGyHl3knJujlIM26ctx35Sw33Dcm5KZTJ/osYdANZ1ZalPB/T
         V5ZQ==
X-Gm-Message-State: AN3rC/4rR3PQOvGdmmz/qzQ6HTzx8tKSSSLeRLmGuIQbbq3DDkZWlDDQ
        m5nYwM9BelmJiA==
X-Received: by 10.223.176.184 with SMTP id i53mr4296051wra.53.1492723455916;
        Thu, 20 Apr 2017 14:24:15 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k63sm442322wmf.9.2017.04.20.14.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 14:24:15 -0700 (PDT)
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
        =?UTF-8?q?Zolt=C3=A1n=20Herczeg?= <hzmester@freemail.hu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/18] grep: submodule-related case statements should die if new fields are added
Date:   Thu, 20 Apr 2017 21:23:30 +0000
Message-Id: <20170420212345.7408-4-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170420212345.7408-1-avarab@gmail.com>
References: <20170420212345.7408-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change two case statements added in commit 0281e487fd ("grep:
optionally recurse into submodules", 2016-12-16) so that they die if
new GREP_PATTERN_* enum fields are added without updating them.

These case statements currently check for an exhaustive list of
fields, but if a new field is added it's easy to introduce a bug here
where the code will start subtly doing the wrong thing, e.g. if a new
pattern type is added we'll fall through to
GREP_PATTERN_TYPE_UNSPECIFIED, i.e. the "basic" POSIX regular
expressions.

This should arguably be done for the switch(opt->binary)
case-statement as well, but isn't trivial to add since that code isn't
currently working with an exhaustive list.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 3ffb5b4e81..be3dbd6957 100644
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
@@ -515,6 +517,8 @@ static void compile_submodule_options(const struct grep_opt *opt,
 		case GREP_PATTERN_BODY:
 		case GREP_PATTERN_HEAD:
 			break;
+		default:
+			die("BUG: Added a new grep token type without updating case statement");
 		}
 	}
 
-- 
2.11.0

