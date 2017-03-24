Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 354AC1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965678AbdCXSmZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:42:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35133 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965619AbdCXSmL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:42:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id z133so2299419wmb.2
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=67yRCUy0PzOxJteSU3WD/j2N5/3P2JJYY9EYajRR1ek=;
        b=ONACfqZ+Fw5rgIkb0eGGON6LVJEXa0o5uA+WuXalMujT+8FGQLMaTAlDdifFtEylM8
         UaDZxPMhXBU0S6xlWjnmgCv+/t3+emns7fnGPnc1lec9gBmRssvYszY4fITbUD68Uawy
         vihI6vJu2EkZebMCTamJ0rrXj1hck7Cugw0e2rCsieVpkkkmycfRsZ3WYOGvNrbsSzxp
         0BUEJIZgiMQm+tUIAtrE37RDhC+xK1AaiNc6qiDosnbxZqSD6Sreq7lrxG8f5ylAvFKW
         7Yf0Tyd7aQS5OdgWHZ6YAtyYPQbaNEULZs3gMPlFgbkc80QjKafzqKYRn3hRsAR7h8wQ
         kzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=67yRCUy0PzOxJteSU3WD/j2N5/3P2JJYY9EYajRR1ek=;
        b=KHYLB2TD3Dqg/F0tDxHNzX7joPX4Bri/7se8IO5CADdnUCgoo2CFojGJKVl9CmC+SS
         FJdXLh1Vf4AsGiGExZ9KQtXzrMwp1txcmBVDGHl5AZlqy0Vc1Wx/yXAkBDw/RNdZZKAn
         W+pxtteiabylE71XVJdRv2+zK1w2rJ9gs3rYIB/6zGO24T26iGdscSYYpqQV96ePz4SE
         ktgox6W+GWVwh1RdhQNMY4BIEOtRLm72Z+AJ9kBa2pWDs44ri+U+wyLDUY6sDAPQoiyP
         Ux3aoQO4c0N5Lkxlcmy6T2tSSRDeZ9ufSLVb+5NAF3POua3M1k0qF9N7NnIECtx+ogud
         MGmg==
X-Gm-Message-State: AFeK/H2GxIUBPshP0W38vLsptS+w4ioWJdad77+VPyuRjeQWBeNDhGFW0xiuQv/TMVC4yA==
X-Received: by 10.28.128.147 with SMTP id b141mr4412476wmd.45.1490380914582;
        Fri, 24 Mar 2017 11:41:54 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j77sm3440560wmj.3.2017.03.24.11.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 11:41:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 13/16] tag: change --point-at to default to HEAD
Date:   Fri, 24 Mar 2017 18:40:56 +0000
Message-Id: <20170324184059.5374-14-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170324184059.5374-1-avarab@gmail.com>
References: <20170324184059.5374-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the --points-at option to default to HEAD for consistency with
its siblings --contains, --merged etc. which default to
HEAD. Previously we'd get:

    $ git tag --points-at 2>&1 | head -n 1
    error: option `points-at' requires a value

This changes behavior added in commit ae7706b9ac (tag: add --points-at
list option, 2012-02-08).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-tag.txt | 3 ++-
 builtin/tag.c             | 3 ++-
 t/t7004-tag.sh            | 9 ++++++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 4d289f5dd5..d5cdb18d96 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -139,7 +139,8 @@ This option is only applicable when listing tags without annotation lines.
 	commit (`HEAD` if not specified), incompatible with `--merged`.
 
 --points-at <object>::
-	Only list tags of the given object. Implies `--list`.
+	Only list tags of the given object (HEAD if not
+	specified). Implies `--list`.
 
 -m <msg>::
 --message=<msg>::
diff --git a/builtin/tag.c b/builtin/tag.c
index 3c686961db..8bf6d85176 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -431,7 +431,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			     N_("field name to sort on"), &parse_opt_ref_sorting),
 		{
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
-			N_("print only tags of the object"), 0, parse_opt_object_name
+			N_("print only tags of the object"), PARSE_OPT_LASTARG_DEFAULT,
+			parse_opt_object_name, (intptr_t) "HEAD"
 		},
 		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 5823de16aa..3529c3009c 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1534,7 +1534,8 @@ do
 	"
 	test_expect_success "Doing 'git tag --list-like $option <commit> <pattern> is permitted" "
 		git tag -n $option HEAD HEAD &&
-		git tag $option HEAD HEAD
+		git tag $option HEAD HEAD &&
+		git tag $option
 	"
 done
 
@@ -1546,6 +1547,12 @@ test_expect_success '--points-at can be used in non-list mode' '
 	test_cmp expect actual
 '
 
+test_expect_success '--points-at is a synonym for --points-at HEAD' '
+	echo v4.0 >expect &&
+	git tag --points-at >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--points-at finds lightweight tags' '
 	echo v4.0 >expect &&
 	git tag --points-at v4.0 >actual &&
-- 
2.11.0

