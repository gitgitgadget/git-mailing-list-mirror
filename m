Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D19B21F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 10:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388357AbfJ1Kwt (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 06:52:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55448 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbfJ1Kwt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 06:52:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id g24so8900883wmh.5
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 03:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CX0eeutEi2DRSVOspQsHfjcaBIZxPrc5PfKR4YRgjxo=;
        b=Xm9OJWvDkLG+1BnTIVscukWlBXM2btl8Qf9IlCKkwNShTEh4hd8Yo8Fuz39pXwUVWw
         5WJRg677PJ1BpCQv7qRNg2v/Vb2B5eFOMi9smvkkA96G5YSqGM3VELR//Er5d9kLWmLJ
         09NYuorfQvnE6f7Ua1I0JkcInDPaXZUExceamjxAGvbrlt+H9hpEvKAqShhSS/3/vjS7
         7/l959vnvsvpG6NKVh9JlNTXSFhYgG41jII41c7KKITL0Ex3yTDtujvRTTjsnJUmUoKY
         VzRhdCjiNl+ZILV+EXJOvOx8ddPH7FxyvZdaeNVed9hPww2Flgs0QU8YkHbgXGdxEkB+
         piuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CX0eeutEi2DRSVOspQsHfjcaBIZxPrc5PfKR4YRgjxo=;
        b=Qzxjao9sp6rIowD87nhKpaBqcd6KEECDp9o0uFgQ6Saph3/6j1jGDts2tqkOr0D1XX
         hcdTYZBd3R3mDfCg6jPxI4x1KO3X4mAXwlkrVK4jbkUJP8CWxa68Ne7xp+QXO4S/xpzM
         DtAa+A64SgX3/JQGYvZO32WhI5FpMREdZGrjjB+HN5AZCSNCQYWtWEk3WMcsf2DNW8kG
         CLvAxMEPIE0a9327h63DiFexrvSnnvyck5yeFj0TIWXwMwplKW2F3o4T9JwzNMqm7dfD
         LS5OAaXaQ/DV+ZcY5qz8V6ToVHPG15vHGRl0kUO0YUfDIBaEq+OKbE0liBMpozk1/Piw
         urmg==
X-Gm-Message-State: APjAAAVMYytHzeF1A+mt/u7HCxv6HepJiDGkMk/wxzPy59FnUnix2uTl
        Wz4NfWyOw6FCEK1MIZJq4zw=
X-Google-Smtp-Source: APXvYqxCo1LwTN0sQhx7i3/0ZpNkY3S1kJU6FpAfhjyeONAlgrbV9X92mqjCoUEGaQo8g/GEH2hg6A==
X-Received: by 2002:a1c:9d13:: with SMTP id g19mr13996248wme.159.1572259966838;
        Mon, 28 Oct 2019 03:52:46 -0700 (PDT)
Received: from localhost.localdomain (x4db30d31.dyn.telefonica.de. [77.179.13.49])
        by smtp.gmail.com with ESMTPSA id h205sm12562866wmf.35.2019.10.28.03.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Oct 2019 03:52:46 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] builtin/blame.c: remove '--indent-heuristic' from usage string
Date:   Mon, 28 Oct 2019 11:52:41 +0100
Message-Id: <20191028105242.19260-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.538.gfb6e1f15ab
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The indent heuristic is our default diff heuristic since 33de716387
(diff: enable indent heuristic by default, 2017-05-08), but the usage
string of 'git blame' still mentions it as "experimental heuristic".

We could simply update the short help associated with the option, but
according to the comment above the option's declaration it was "only
included here to get included in the "-h" output".  That made sense
while the feature was still experimental and we wanted to give it more
exposure, but nowadays it's unnecessary.

So let's rather remove the '--indent-heuristic' option from 'git
blame's usage string.  Note that 'git blame' will still accept this
option, as it is parsed in parse_revision_opt().

Astute readers may notice that this patch removes a comment mentioning
"the following two options", but it only removes one option.  The
reason is that the comment is outdated: that other options was
'--compaction-heuristic', and it has already been removed in
3cde4e02ee (diff: retire "compaction" heuristics, 2016-12-23), but
that commit forgot to update this comment.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Looking at the places listed by 'git grep "indent[ -]\?heuristic",
this might be the last place where the indent heuristic was marked as
experimental.

In 'diff.c' we have the following option declaration:

  OPT_BIT(0, "indent-heuristic", &options->xdl_opts,
          N_("heuristic to shift diff hunk boundaries for easy reading"),

Here we could perhaps mention that it's the default; OTOH this help is
never shown anywhere (there are just too many diff options to list).

 builtin/blame.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 6386fbf189..b184cde4b7 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -861,14 +861,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_list, N_("file"), N_("Ignore revisions from <file>")),
 		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
 		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
-
-		/*
-		 * The following two options are parsed by parse_revision_opt()
-		 * and are only included here to get included in the "-h"
-		 * output:
-		 */
-		{ OPTION_LOWLEVEL_CALLBACK, 0, "indent-heuristic", NULL, NULL, N_("Use an experimental heuristic to improve diffs"), PARSE_OPT_NOARG, NULL, 0, parse_opt_unknown_cb },
-
 		OPT_BIT(0, "minimal", &xdl_opts, N_("Spend extra cycles to find better match"), XDF_NEED_MINIMAL),
 		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("Use revisions from <file> instead of calling git-rev-list")),
 		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("Use <file>'s contents as the final image")),
-- 
2.24.0.rc1.538.gfb6e1f15ab

