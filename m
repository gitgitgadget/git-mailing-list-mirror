Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D611F406
	for <e@80x24.org>; Fri, 22 Dec 2017 16:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755906AbdLVQBL (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 11:01:11 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39819 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753347AbdLVQBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 11:01:09 -0500
Received: by mail-wm0-f65.google.com with SMTP id i11so22410037wmf.4
        for <git@vger.kernel.org>; Fri, 22 Dec 2017 08:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ahJuudVCr6vKbdAmBMvHYXW+lShw8+wonMjre0G0GrM=;
        b=VSJmS7w4W6imAq4fcz5MSrBMSFSBQY8TIS5R+ILqYdqShKUepTPK8AFl/OHnH/5snW
         kalxBgJ658L26mHPJneiE73+u1BbghMUsbtUUCNTsj0lmT8LYMlZZN1wYZvqUV4KGDu5
         KAVNOchTaNSQ+Jrg18Mk7bKjAv2EU4n0eIJwlRKkVSi8chsEI+gXQb4ycksjyZv3rnr4
         gZytC/en1Ro6e3L+eFhvP+3Rc6D1RXRRhJQQX6lg/tcC+QBicQgtpb+2j1R5SYDXQ0GD
         Qf17IO3AdpCzZp8TnBROj51S4cHcE1LLs0RJyyZd0aQB8chnf3VtI28RkM5x7wdonBlU
         1RgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ahJuudVCr6vKbdAmBMvHYXW+lShw8+wonMjre0G0GrM=;
        b=TuqiS4nem2wGp1cxxDOuQwxau/50Ix1mGe0/UEH0oX4ohFC+RS61Qsjt7mlLf65yRV
         SHKjCHYiQzXoPuKFGS3DOm1vfJ5q5+JjyCyqgkzwoHksUHuaVIf2xIcfH9Eu1828EHwB
         XU9NhvBXIw2YqZPnPosXoFuP5vwJ9kHwE5e3w5RjkpOejDB5xnmcmEERjenErHU0+7Xy
         X4C0ufd0FOH7l3Hrm7C8dtZnEZqTnMWYhIYQiLRs8ig68ePo/NYoMmImlT+5UEZDoWG5
         PWaJPWdjdzQ4t1Fse2XquLGg32+caJYh9wgD7JfpG6dxGQozUTB8ovjOQses5sXVECLZ
         hU/w==
X-Gm-Message-State: AKGB3mI1vdH1z2KSqn5lyg57chdnpd2ctOgzKiQwkvdgE0xnKa0pjIuD
        o5f3IFAZHKCCFg+2NZgCEtxvvyIL
X-Google-Smtp-Source: ACJfBosJjTIdY5OaibD4PyPqkM4GrMDWbKu2SmmRRFoF94EPPmpKw6AtQs815WMke+xE4jQ+x/SsBg==
X-Received: by 10.80.187.99 with SMTP id y90mr15460603ede.154.1513958467349;
        Fri, 22 Dec 2017 08:01:07 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g45sm20886254eda.88.2017.12.22.08.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Dec 2017 08:01:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Pat Notz <patnotz@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] support -m"<msg>" combined with commit --fixup
Date:   Fri, 22 Dec 2017 16:00:54 +0000
Message-Id: <20171222160056.10102-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <CAPig+cRDi14Rez+6ZJAEdxHpo0Mw7JQFkcuG2oVqv2pP_ZbvhQ@mail.gmail.com>
References: <CAPig+cRDi14Rez+6ZJAEdxHpo0Mw7JQFkcuG2oVqv2pP_ZbvhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a hopefully ready to apply v2 incorporating feedback from Eric
(thanks!). A tbdiff with v1 follows below.

Ævar Arnfjörð Bjarmason (2):
  commit doc: document that -c, -C, -F and --fixup with -m error
  commit: add support for --fixup <commit> -m"<extra message>"

 Documentation/git-commit.txt | 2 ++
 builtin/commit.c             | 8 +++++---
 t/t7500-commit.sh            | 9 ++++++++-
 3 files changed, 15 insertions(+), 4 deletions(-)

1: 7d5e2531ee ! 1: 82333992ec commit doc: document that -c, -C, -F and --fixup with -m error
    @@ -7,6 +7,7 @@
         explicitly since 0c091296c0 ("git-commit: log parameter updates.",
         2005-08-08), but the documentation was never updated to reflect this.
         
    +    Wording-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
     diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
    @@ -17,8 +18,8 @@
      	If multiple `-m` options are given, their values are
      	concatenated as separate paragraphs.
     ++
    -+Combining the `-m` option and any of `-c`, `-C`, `-F` or `--fixup`
    -+will result in an error.
    ++The `-m` option is mutually exclusive with `-c`, `-C`, `-F`, and
    ++`--fixup`.
      
      -t <file>::
      --template=<file>::
2: bd78a211ed ! 2: 780de6e042 commit: add support for --fixup <commit> -m"<extra message>"
    @@ -22,6 +22,21 @@
            In such a case you might want to leave a small message,
            e.g. "forgot this part, which broke XYZ".
         
    +    With this, --fixup <commit> -m"More" -m"Details" will result in a
    +    commit message like:
    +    
    +        !fixup <subject of <commit>>
    +    
    +        More
    +    
    +        Details
    +    
    +    The reason the test being added here seems to squash "More" at the end
    +    of the subject line of the commit being fixed up is because the test
    +    code is using "%s%b" so the body immediately follows the subject, it's
    +    not a bug in this code, and other tests t7500-commit.sh do the same
    +    thing.
    +    
         When the --fixup option was initially added the "Option -m cannot be
         combined" error was expanded from -c, -C and -F to also include
         --fixup[1]
    @@ -34,6 +49,7 @@
         1. d71b8ba7c9 ("commit: --fixup option for use with rebase
            --autosquash", 2010-11-02)
         
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
     diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
    @@ -43,10 +59,9 @@
      	If multiple `-m` options are given, their values are
      	concatenated as separate paragraphs.
      +
    --Combining the `-m` option and any of `-c`, `-C`, `-F` or `--fixup`
    --will result in an error.
    -+Combining the `-m` option and any of `-c`, `-C` or `-F` will result in
    -+an error.
    +-The `-m` option is mutually exclusive with `-c`, `-C`, `-F`, and
    +-`--fixup`.
    ++The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
      
      -t <file>::
      --template=<file>::

-- 
2.15.1.424.g9478a66081


