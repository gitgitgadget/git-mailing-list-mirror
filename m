Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98BBB20248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfCXIVN (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:21:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46001 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfCXIVM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:21:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so4328002pgk.12
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OikERAzzQlef93+BjHV4oLg4Cq3uLW9MQTA84rhXEns=;
        b=XN0meGnjxnshJk+sIX5cPkhK34INQQWNly9uZhUUjN/VR2DtFisfU1EGsTuehC7zj2
         Vi1PVn7zCZ44MXiHERvV1P0IwQp7Q4j1/aVOoKFoTN9pyTY/GKz7CmPXaveeTZJHqWWP
         fq1IFtT9X6H7fBGOwox8quRHDStnHYu/bw/ts6q+xYJMXwF0XeAlJLO95D+37VVI+ph0
         NqUG4eVtvxDsHpwuGq1m9fgNzzcwMm40OTtFJLd0086FcOtPOkDaF+4zR5VR+s3p846A
         u8TWd2CiMPDoNoDIXw6OTxlevWP1pLE2GPiYHF3AedEVXjM6A+9sPvAEyGIJGFTXosyv
         NAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OikERAzzQlef93+BjHV4oLg4Cq3uLW9MQTA84rhXEns=;
        b=aQhJVDxilab03SQT1jLq0YwF9VToxReCTO/MTyaV4n9MyZSJ/o0Z9ehZX47a4VRN62
         OfVG+Dmrpj4OLkXFDTu5paNEV5jyN21XfxF7qoDvugqA2OEQgJ5pHA4wunGZScwAlLnD
         3Y7HugSdv1ouG1yn7cVs7cKU6e7nVVe4kV7ZazLo8tYGkL6klzKAoWbmVRVAjI4o3hQf
         Ki0Wh+ggfvyq8JcnYm8rGNwqNL+3YbN11MFWW3Nqb4n2zKY/qzyRiW6tgUC8r/pX9RBN
         q3qF4gVIVGh5P1RYwdhUm26mo2atKkcYIcKoE1KYzUsG8Wi7Rod36il6E2iWdgam/8DK
         ppPw==
X-Gm-Message-State: APjAAAU9rmJoZlzn71CEtk+Kyn4M9tthQu/liH+fz50VBU8Go0L5TPIq
        LKbmqb8NcggB7d1xcyakAtA=
X-Google-Smtp-Source: APXvYqx5YeTfs7EfyDYhYxx6Wpt62tEa9DG+PpvO/ZOWVU9F0G00MNwrqilOberP76hRyYjnfrC27g==
X-Received: by 2002:a62:469a:: with SMTP id o26mr18619280pfi.251.1553415671844;
        Sun, 24 Mar 2019 01:21:11 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id r24sm14831577pfn.19.2019.03.24.01.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:21:10 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:21:05 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 00/20] nd/diff-parseopt the last part
Date:   Sun, 24 Mar 2019 15:19:54 +0700
Message-Id: <20190324082014.2041-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190320114703.18659-1-pclouds@gmail.com>
References: <20190320114703.18659-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 fixes some help text and commit messages. No major changes.

Nguyễn Thái Ngọc Duy (20):
  diff-parseopt: convert --ws-error-highlight
  diff-parseopt: convert --ita-[in]visible-in-index
  diff-parseopt: convert -z
  diff-parseopt: convert -l
  diff-parseopt: convert -S|-G
  diff-parseopt: convert --pickaxe-all|--pickaxe-regex
  diff-parseopt: convert -O
  diff-parseopt: convert --find-object
  diff-parseopt: convert --diff-filter
  diff-parseopt: convert --[no-]abbrev
  diff-parseopt: convert --[src|dst]-prefix
  diff-parseopt: convert --line-prefix
  diff-parseopt: convert --no-prefix
  diff-parseopt: convert --inter-hunk-context
  diff-parseopt: convert --[no-]color-moved
  diff-parseopt: convert --color-moved-ws
  diff.c: allow --no-color-moved-ws
  range-diff: use parse_options() instead of diff_opt_parse()
  diff --no-index: use parse_options() instead of diff_opt_parse()
  am: avoid diff_opt_parse()

 builtin/am.c             |   4 +-
 builtin/diff.c           |  21 +--
 builtin/range-diff.c     |  26 +--
 diff-no-index.c          |  49 +++---
 diff.c                   | 337 +++++++++++++++++++--------------------
 diff.h                   |   5 +-
 parse-options-cb.c       |   4 +-
 parse-options.h          |   6 +-
 t/t4053-diff-no-index.sh |   3 +-
 9 files changed, 219 insertions(+), 236 deletions(-)

Range-diff dựa trên v1:
 1:  676bba9a4c !  1:  ed9901217e diff-parseopt: convert --ws-error-highlight
    @@ -2,7 +2,7 @@
     
         diff-parseopt: convert --ws-error-highlight
     
    -    mark one more string for translation while at there.
    +    Mark one more string for translation while at there.
     
      diff --git a/diff.c b/diff.c
      --- a/diff.c
    @@ -38,7 +38,7 @@
      		OPT_COLOR_FLAG(0, "color", &options->use_color,
      			       N_("show colored diff")),
     +		OPT_CALLBACK_F(0, "ws-error-highlight", options, N_("<kind>"),
    -+			       N_("highlight whitespaces errors in the context, old or new lines in the diff"),
    ++			       N_("highlight whitespace errors in the 'context', 'old' or 'new' lines in the diff"),
     +			       PARSE_OPT_NONEG, diff_opt_ws_error_highlight),
      		OPT_CALLBACK_F(0, "output-indicator-new",
      			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 2:  94fb8a961b =  2:  3ad3991675 diff-parseopt: convert --ita-[in]visible-in-index
 3:  7b2c38485f !  3:  ea21fa9e03 diff-parseopt: convert -z
    @@ -7,7 +7,7 @@
      +++ b/diff.c
     @@
      		OPT_CALLBACK_F(0, "ws-error-highlight", options, N_("<kind>"),
    - 			       N_("highlight whitespaces errors in the context, old or new lines in the diff"),
    + 			       N_("highlight whitespace errors in the 'context', 'old' or 'new' lines in the diff"),
      			       PARSE_OPT_NONEG, diff_opt_ws_error_highlight),
     +		OPT_SET_INT('z', NULL, &options->line_termination,
     +			    N_("do not munge pathnames and use NULs as output field terminators in --raw or --numstat"),
 4:  470c29dfb6 =  4:  02b7116f53 diff-parseopt: convert -l
 5:  f950b910dd =  5:  2d43346824 diff-parseopt: convert -S|-G
 6:  a3d8dfbb9e =  6:  357b691470 diff-parseopt: convert --pickaxe-all|--pickaxe-regex
 7:  209794414b !  7:  adc09e748e diff-parseopt: convert -O
    @@ -33,7 +33,7 @@
      			  N_("treat <string> in -S as extended POSIX regular expression"),
      			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
     +		OPT_FILENAME('O', NULL, &options->orderfile,
    -+			     N_("override diff.orderFile configuration variable")),
    ++			     N_("control the order in which files appear in the output")),
      		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
      		  N_("Output to a specific file"),
      		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
 8:  11730d9a4a !  8:  ca34bbd042 diff-parseopt: convert --find-object
    @@ -2,7 +2,7 @@
     
         diff-parseopt: convert --find-object
     
    -    while at it, mark one more string for translation.
    +    While at it, mark one more string for translation.
     
      diff --git a/diff.c b/diff.c
      --- a/diff.c
    @@ -37,7 +37,7 @@
     @@
      			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
      		OPT_FILENAME('O', NULL, &options->orderfile,
    - 			     N_("override diff.orderFile configuration variable")),
    + 			     N_("control the order in which files appear in the output")),
     +		OPT_CALLBACK_F(0, "find-object", options, N_("<object-id>"),
     +			       N_("look for differences that change the number of occurrences of the specified object"),
     +			       PARSE_OPT_NONEG, diff_opt_find_object),
 9:  a70f80ffa5 !  9:  6a735031e0 diff-parseopt: convert --diff-filter
    @@ -2,7 +2,7 @@
     
         diff-parseopt: convert --diff-filter
     
    -    while at it, mark one more string for translation
    +    While at it, mark one more string for translation
     
      diff --git a/diff.c b/diff.c
      --- a/diff.c
10:  95f2d0e3b0 = 10:  646a5844f0 diff-parseopt: convert --[no-]abbrev
11:  58bbccd2df = 11:  20e050397a diff-parseopt: convert --[src|dst]-prefix
12:  4454256a15 = 12:  ae0d85b620 diff-parseopt: convert --line-prefix
13:  1b882aaeb1 ! 13:  288d4fd648 diff-parseopt: convert --no-prefix
    @@ -29,7 +29,7 @@
      			       N_("prepend an additional prefix to every line of output"),
      			       PARSE_OPT_NONEG, diff_opt_line_prefix),
     +		OPT_CALLBACK_F(0, "no-prefix", options, NULL,
    -+			       N_("no not show any source or destination prefix"),
    ++			       N_("do not show any source or destination prefix"),
     +			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_no_prefix),
      		OPT_CALLBACK_F(0, "output-indicator-new",
      			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
14:  3b1b06c51b ! 14:  753173f724 diff-parseopt: convert --inter-hunk-context
    @@ -58,7 +58,7 @@
      {
     @@
      		OPT_CALLBACK_F(0, "no-prefix", options, NULL,
    - 			       N_("no not show any source or destination prefix"),
    + 			       N_("do not show any source or destination prefix"),
      			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_no_prefix),
     +		OPT_INTEGER_F(0, "inter-hunk-context", &options->interhunkcontext,
     +			      N_("show context between diff hunks up to the specified number of lines"),
15:  afc89eb973 ! 15:  51cb7b3beb diff-parseopt: convert --[no-]color-moved
    @@ -2,7 +2,7 @@
     
         diff-parseopt: convert --[no-]color-moved
     
    -    mark one more string for translation while at there
    +    Mark one more string for translation while at there
     
      diff --git a/diff.c b/diff.c
      --- a/diff.c
16:  34a2457af1 = 16:  c1a0faa93b diff-parseopt: convert --color-moved-ws
17:  cc882ae588 = 17:  1e99596a25 diff.c: allow --no-color-moved-ws
18:  60ea27b58d = 18:  d7272ff0c9 range-diff: use parse_options() instead of diff_opt_parse()
19:  96e72eb330 = 19:  09c98fb8fd diff --no-index: use parse_options() instead of diff_opt_parse()
20:  d7273eff56 = 20:  59dbe880bc am: avoid diff_opt_parse()
-- 
2.21.0.548.gd3c7d92dc2

