Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 499C620958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934540AbdCWNG7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:06:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34769 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932702AbdCWNG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:06:57 -0400
Received: by mail-wr0-f196.google.com with SMTP id y90so7322809wrb.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 06:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n36Xc8K8zQD/MpLKngoA6mztsSDOBFOyp4tHvS38KpA=;
        b=KHDCbCyEhqs2uX01CNaXC/R1D6/NpvPZrbwhnPo5e2qsXrHW7ygWp1BW0gGTnm4Wfp
         X5XK1kefgKcLphkHR13EH/BZzVkxIgqM5GM9UUn6C9uLIcgWbGZB62NXFiC2QzqDb6FK
         Ev1hE1XpCwqlw0Z9stzHggHiTBxzdW78pUCiP/r3K/uup5qUVMd4RkjhrSxhgk6bZ+xh
         OkjEcRurjBy3yJJyXmR/85VQoYm+9Pox042v3RR+hPNRfArwZPI6GFc9pFewp4Q6jJMn
         IRnGEQETxZFVx4Sws+OkwB55ssRw5+VXEegD9SORPoEWhbh7GfoBYWdoGfcirBKm4w29
         ULzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n36Xc8K8zQD/MpLKngoA6mztsSDOBFOyp4tHvS38KpA=;
        b=KjMXPMvs+VTdN0wGZ7VjB7yjlrPCfH9R6uZvmdjOLmWgArHWo1QvwKUwMjGuyDyrrz
         CySbGperkFw/9M+a/YgfSJd7A+Os2cCtzVpr20qjkG6+DBHCo7M9d3Ix/lIaxbGPUfYY
         0FLJxfdaG1mtkWluCrUnSjsUBeh2W0bsu4PWrjw1MRByI5TWiAb61zbvcfkWnM+bPtX9
         zG/3DYlV0aeMuRvJ/nLv9oBKUA+A65x4s44x959LZpLq7/6SRAD9j+OGYfAOlqKN6jDB
         QNLVyEexZxkvhogx+Km1wqtlQK8fKrvXc1nW43z4K+HsTDLQteywrTMGZEsRkzEiNfAB
         gzeA==
X-Gm-Message-State: AFeK/H1Dhxg6NpKdHgoUXZY50HypyXNnqYfBnp32yGLzQ5wNFrckBkxdM4q5bBbPW7QS2A==
X-Received: by 10.223.151.75 with SMTP id r69mr42193wrb.189.1490274415719;
        Thu, 23 Mar 2017 06:06:55 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h3sm5810071wrb.6.2017.03.23.06.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 06:06:54 -0700 (PDT)
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
Subject: [PATCH v3 13/16] tag: change --point-at to default to HEAD
Date:   Thu, 23 Mar 2017 13:05:26 +0000
Message-Id: <20170323130529.11361-14-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170323130529.11361-1-avarab@gmail.com>
References: <20170323130529.11361-1-avarab@gmail.com>
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
index 491dba065c..6de440f139 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -140,7 +140,8 @@ This option is only applicable when listing tags without annotation lines.
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

