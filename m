Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3723207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954706AbdDYVGN (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:06:13 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32874 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948415AbdDYVGL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:06:11 -0400
Received: by mail-wr0-f195.google.com with SMTP id w50so22366069wrc.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 14:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NnqYVO826eWrlvWUsC/g7ecfgD1WkegPIgXns1skrYU=;
        b=EaMQ/jMjz/h4qroxa/41+mHSwnRT4DxiskKqGpm+uJumUpbqV+jC4u4UnBNLgYQ4Qu
         1lOr8UQTPjigArOrBB7aPGmaT/KIUKu8Kxt/OOvSit24GG1U3gEX1PWJzaevgOGa6XkS
         fklV3D8p5t1my4e35rJJBiAY5KW/P5p/vbMW2tgEO8knRmrPmRWuMV+UR8JiNdTdC3AD
         CnvS7NrsI9/D3gex0r42il/8/aVMaS0lAMuAejuLSvqOX8ICHRnl0pC6K4bRO8XFNV0f
         658kf6/TJK5ICFUfe1UuLKcDuAthbt/mZf8LxtEyv16tnkADlhcznG1VS4uR/lwTAXIY
         Vguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NnqYVO826eWrlvWUsC/g7ecfgD1WkegPIgXns1skrYU=;
        b=H90wZr2hR8JOiU5Tm5BCWtCMOy/6pkaqA417iqHt5oKo9nBKLEWzQt9ADz57FSALjv
         ncMNHc52eHJyrFJ3GNktKN+ebcXoV1Ilo8TjAzCZNC4WssSXIJHeIHmYI32NmAQHhTTn
         KL1KhhHTQodvneNwQcrwXJzygY+KrEJdIriT3kRb/DT0q4necp1R5NSBZdblNtoWIbas
         Tm16ux+xPO2Kx/1Icyvfk06Hw2cwgBvXvTJefHlQJbcKwBo95CNp5+T+MmZ3dgAIbb2g
         3vBJ2rrC7ARftZFCR73HAYU3Gp15xVfWtswuUN7jjM899F7kD2caZeba+Lraf+jW/CDa
         zCgQ==
X-Gm-Message-State: AN3rC/4EW2CQmsZKHXu3niK5y1W1Qdx57vT441WcZhLSYRG3IhE9PTSV
        LAD2iPvVVegXyQ==
X-Received: by 10.223.142.35 with SMTP id n32mr12993129wrb.131.1493154370236;
        Tue, 25 Apr 2017 14:06:10 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i71sm27519917wri.0.2017.04.25.14.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 14:06:09 -0700 (PDT)
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
Subject: [PATCH v4 03/19] grep: submodule-related case statements should die if new fields are added
Date:   Tue, 25 Apr 2017 21:05:32 +0000
Message-Id: <20170425210548.24612-4-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170425210548.24612-1-avarab@gmail.com>
References: <20170425210548.24612-1-avarab@gmail.com>
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

