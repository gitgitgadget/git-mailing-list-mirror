Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2623D20248
	for <e@80x24.org>; Sun, 17 Mar 2019 15:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfCQPYS (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 11:24:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41503 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfCQPYS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 11:24:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id d25so9524302pfn.8
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 08:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/9YxkcgV9//NBtm6RCq/LRCSCubZ8XFr8cm9lESRPg=;
        b=LL9lc5UaCKOPYOKm3Hl3staPwGE45nk3RZR3HVteVLCHmyw5j9h11lq3V9MyWAET/J
         9jCikCJsVOD8gCTyWwNy5oXPui4l7G3bSCAedrSwH6lDKdgAO8r0f7/xc88HyWivlwXq
         puG8mz80hSJa8HfPlipi9AkQAmAipRXoZ1M3wxlsyMBEIxxpGNxnWp0hRYjgz6zprMA9
         zFcSv2OQXXdtKLv5Hd5dxW12/1OCMO3qBF60YCm2Z59zFfhFG/4pvaGlOB4oLw+DGpsO
         VVSJhAAr7C4gjnJY1bssGwqG/TLCEiQDZ1v6CjiYuw/R48S9GGM5B34RTDjxaZkU2kit
         sW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/9YxkcgV9//NBtm6RCq/LRCSCubZ8XFr8cm9lESRPg=;
        b=cJE7yAQ58N2zoeKDV1tZiGNvOFe+iAIr+DtR8rFqF/YPL692dKaPFU414BQw3b9esG
         lkoyRb6FHnZH8HJ0GTfrXp5g0xvfzgIuo+9SC6Wd6tBpJhZDBKKpge5JE5nWRN8dpZrl
         Y7ebGzl35ciPKKYqA2rVwF5RCwa3XmTjY79jrjD9cEPyk1EPr52Aj4aqrpECIHs6wfh0
         5ll7ofOt9/nN2pQ+kVhZ20laT5agmcn7QZTFQf/j6fM+e1d4TI0g+wBaCMOJWB867AYt
         vIADTLWwGvP6XOb74D0cfccQXDME+/5HTh5jI+iEsqOQql9skx2Lu2QG4m40GN/7Hrzl
         kdOA==
X-Gm-Message-State: APjAAAVmgcy2gsMjcckMnVW7MzqOfFU1wLW/uVeeW+RpW5vI6DGzxJ2A
        +cWkzPF8JjvRd9goPwffx8pEbalJ
X-Google-Smtp-Source: APXvYqxH76/cnzDgX8kF9nvu05b5L/m4Jevqtu3QzkyQ1x+f8CeRdG31WqpAjF5BF+oWhqXl3mmFIg==
X-Received: by 2002:a65:6210:: with SMTP id d16mr13366920pgv.189.1552836257302;
        Sun, 17 Mar 2019 08:24:17 -0700 (PDT)
Received: from localhost.localdomain (cloudream.m3.ntu.edu.tw. [140.112.244.5])
        by smtp.gmail.com with ESMTPSA id z15sm10357978pgc.25.2019.03.17.08.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Mar 2019 08:24:16 -0700 (PDT)
From:   Jonathan Chang <ttjtftx@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jonathan Chang <ttjtftx@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [GSoC][PATCH v3 0/3] Avoid using pipes
Date:   Sun, 17 Mar 2019 23:23:35 +0800
Message-Id: <cover.1552835153.git.ttjtftx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This is my SoC 2019 Microproject: "Avoid pipes in git related commands
in test scripts".

Changes since v2:
	- drop changes to other 2 files as suggested by Christian Couder[1]
	- rename commit message from "t0000-basic:" to "t0000:"[1]
	- use better commit message suggested by Thomas Gummerer[2]
		and Christian Couder[3]
	- fix the incorrect transformation pointed out by Eric Sunshine[4]
	- rename commit message to "fix indentation" as seen in:
		25e3d28efd ("submodule.c: fix indentation", 2018-11-28)
		d4cddd66d7 ("worktree.c: fix indentation", 2016-01-18)

[v1]: https://public-inbox.org/git/20190309154555.33407-1-ttjtftx@gmail.com/
[v2]: https://public-inbox.org/git/20190310080739.63984-1-ttjtftx@gmail.com/

[1]: https://public-inbox.org/git/CAP8UFD274-iDkqPm8-WGXbUmcVqjDE7bSg2bwA-17TWJivn0jA@mail.gmail.com/
[2]: https://public-inbox.org/git/20190310175924.GF31533@hank.intra.tgummerer.com/
[3]: https://public-inbox.org/git/CAP8UFD09QZd=6HyB5Om1PfV=67+CvfyQkcpLU0tukT48QccD0Q@mail.gmail.com/
[4]: https://public-inbox.org/git/CAPig+cSMZrQFrLXoO5KE1uonUxmnYHikr-e6GAq_n6vx3+sPJA@mail.gmail.com/

Jonathan Chang (3):
  t0000: fix indentation
  t0000: avoid using pipes
  t0000: use test_line_count instead of wc -l

 t/t0000-basic.sh | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

Range-diff against v2:
1:  dd3e868436 ! 1:  c3c231d117 t0000-basic: fix an indentation error
    @@ -1,9 +1,11 @@
     Author: Jonathan Chang <ttjtftx@gmail.com>
     
    -    t0000-basic: fix an indentation error
    +    t0000: fix indentation
     
    -    This is a preparatory step prior to removing the pipes after git
    -    commands, which discards git's exit code and may mask a crash.
    +    Fix indentation of a line containing a pipeline to reduce the
    +    noise when refactoring the pipeline in a subsequent commit.
    +    This has been wrong since the refactoring done in 1b5b2b641a
    +    ("t0000: modernise style", 2012-03-02), but carries no meaning.
     
         Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
     
2:  5bc591e557 ! 2:  5a3c6e24eb t0000-basic: avoid using pipes
    @@ -1,6 +1,6 @@
     Author: Jonathan Chang <ttjtftx@gmail.com>
     
    -    t0000-basic: avoid using pipes
    +    t0000: avoid using pipes
     
         The exit code of the upstream in a pipe is ignored thus we should avoid
         using it. By writing out the output of the git command to a file, we can
3:  be6a218d83 < -:  ---------- t0003-attributes: avoid using pipes
4:  35564c86a1 < -:  ---------- t0022-crlf-rename: avoid using pipes
5:  17acadea53 ! 3:  bc3dee82a9 t0000-basic: use test_line_count instead of wc -l
    @@ -1,6 +1,6 @@
     Author: Jonathan Chang <ttjtftx@gmail.com>
     
    -    t0000-basic: use test_line_count instead of wc -l
    +    t0000: use test_line_count instead of wc -l
     
         Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
     
    @@ -13,8 +13,8 @@
      	git show --pretty=raw $commit2 >actual &&
     -	numparent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | wc -l) &&
     -	test $numparent = 1
    -+	sed -n -e "s/^parent //p" -e "/^author /q" actual | wc -l >numparent &&
    -+	test_line_count = 1 numparent
    ++	sed -n -e "s/^parent //p" -e "/^author /q" actual >parents &&
    ++	test_line_count = 1 parents
      '
      
      test_expect_success 'update-index D/F conflict' '
    @@ -24,8 +24,7 @@
      	git ls-files path0 >actual &&
     -	numpath0=$(wc -l <actual) &&
     -	test $numpath0 = 1
    -+	wc -l <actual >numpath0 &&
    -+	test_line_count = 1 numpath0
    ++	test_line_count = 1 actual
      '
      
      test_expect_success 'very long name in the index handled sanely' '
-- 
2.21.0

