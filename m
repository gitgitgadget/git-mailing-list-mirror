Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9E3D1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 15:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeI2Vye (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 17:54:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41811 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbeI2Vye (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 17:54:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id f38-v6so10582263edd.8
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 08:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Uu3xuKgdj04HmaMejz9L7ZKLgF944fgv3RwBGZ31jWE=;
        b=B9qHWOFSXda+JduBPmkMcthTWW1K+kOJe04vv6qGrGtMDC4JN/TmwBT8rT2SXWUf1J
         xOp6Hi/GejURWmCvORr/OcoSxvf1plY9bYiPuV5h2SZhvkaxl8K71oEqOCRjvqlp598h
         fMFSYt+xY1/X4lzbTyG5JMvivxf0Tgo+xZjhn/eKWb2EDqkS0XI93vtzemsoAzeWrbRU
         9X3+X2ElCqldS/o5LbAh9V+3uacOV22LQaU9Gk8engjRJh7VdZMkXVhRu9As/7bguYIt
         1m88qJVTG8RnikY1NvwG9xSSOHUPsA5EoPqh/4jUP55tPXkMnWGc5fb2gUhJc6vL4zb/
         PmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Uu3xuKgdj04HmaMejz9L7ZKLgF944fgv3RwBGZ31jWE=;
        b=XxJJ98U9HdALeCoDS9Vfy+I1tpfcgc7ykKwuCdswKs5aMqYzMdpNkEUlJ/zaAOTHPT
         K0wFbkiInnXm024FAo7gPOr0QOv9iKdbL7YoOy0+fjVSgDGKcnYrWw5k0Hadom0NuQMD
         jvcB4TiIaSKTZrKNi8xcFkxHufRyAnDeZJuhuw1OHuBJwh2frN3GRKqNqLkoePClBLJm
         N+3lvArrWTbMwpV7NxdWfAjMDYbugTSaa4zw1IfBlfBc25Sy1XxeSlHrG3luUWYEovh5
         lcKPJBIGJSuBxmchchrIkr+qnX6t0kaEABm/jXN87okwvCY8gjyaMNVe/PeJokT7V/F1
         LAdA==
X-Gm-Message-State: ABuFfohJpV8eeNIoMxrXJAncezj0kazgnK2Y70K/HAjNX2l7tRQa/HBi
        YxAYGV+lUxZTt+NrbVvsEq0=
X-Google-Smtp-Source: ACcGV63IoNvseOnRf/74jiCl1zLdD9GMn70u5AZv9G2uVakzXHB0p3xvlzTRRJQEOYUWZcHqsbw+1Q==
X-Received: by 2002:a50:8e56:: with SMTP id 22-v6mr4186126edx.101.1538234743419;
        Sat, 29 Sep 2018 08:25:43 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id p21-v6sm2670545eds.32.2018.09.29.08.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 08:25:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, myon@debian.org
Subject: Re: [PATCH] grep: provide a noop --recursive option
References: <20180929140132.GA31238@msg.df7cb.de> <20180929145527.23444-1-avarab@gmail.com> <CACsJy8A6MqAmSZ=bhatX0MZTWRjR9Ci9h9NhJEshtpmqpHr4JA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8A6MqAmSZ=bhatX0MZTWRjR9Ci9h9NhJEshtpmqpHr4JA@mail.gmail.com>
Date:   Sat, 29 Sep 2018 17:25:42 +0200
Message-ID: <87d0swiavd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 29 2018, Duy Nguyen wrote:

> On Sat, Sep 29, 2018 at 4:58 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>> This --recursive (-r) option does nothing, and is purely here to
>> appease people who have "grep -r ..." burned into their muscle memory.
>
> GNU grep -r recurses infinitely but Git grep also has --max-depth. How
> do these interact? My knee-jerk reaction is -r equals --max-depth=-1
> (i.e. overriding previous --mex-depth options on command line, or from
> alias)

I didn't know about --max-depth, we could squash the following in to
deal with that, but that still leaves --max-depth=123 --no-recursive as
using depth 123, and we'd need different options parsing than OPT_BOOL
to deal with that.

diff --git a/builtin/grep.c b/builtin/grep.c
index 02d4384225..2e048d9b49 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -785,7 +785,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int use_index = 1;
 	int pattern_type_arg = GREP_PATTERN_TYPE_UNSPECIFIED;
 	int allow_revs;
-	int unused_recursive; /* this is never used */
+	int recursive = 0;

 	struct option options[] = {
 		OPT_BOOL(0, "cached", &cached,
@@ -803,7 +803,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			N_("show non-matching lines")),
 		OPT_BOOL('i', "ignore-case", &opt.ignore_case,
 			N_("case insensitive matching")),
-		OPT_BOOL('r', "recursive", &unused_recursive,
+		OPT_BOOL('r', "recursive", &recursive,
 			N_("does nothing, git-grep is always recursive, for grep(1) muscle memory compatibility")),
 		OPT_BOOL('w', "word-regexp", &opt.word_regexp,
 			N_("match patterns only at word boundaries")),
@@ -926,6 +926,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	grep_commit_pattern_type(pattern_type_arg, &opt);

+	if (opt.max_depth != -1 && recursive)
+		die(_("The --max-depth and --recursive options are incompatible"));
 	if (use_index && !startup_info->have_repository) {
 		int fallback = 0;
 		git_config_get_bool("grep.fallbacktonoindex", &fallback);
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index c48d1fa34b..ad25cd50f5 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1697,4 +1697,8 @@ test_expect_success 'grep does not report i-t-a and assume unchanged with -L' '
 	test_cmp expected actual
 '

+test_expect_success 'grep --recursive is incompatible with --max-depth' '
+	test_must_fail git grep --recursive --max-depth=1
+'
+
 test_done
