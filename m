Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94C4F1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 11:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeJYTsV (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 15:48:21 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:45399 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbeJYTsV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 15:48:21 -0400
Received: by mail-ed1-f53.google.com with SMTP id t10-v6so8071011eds.12
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 04:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=s/28wtYtU7gagRXvdce6jpY7WQlfh50kGXNmHpoG7Gs=;
        b=PEiP0HfHXo9IWVfgCHnuYqPlkNpyJIiaKxd2WXXKZv7d4RuTa2za02CBE58StIWIOs
         4MPfdJi4s7uGzcFZDsJUibQbZFpzX6A8IUfhOgvP+TfzYTK9WBtRkzIDhPkXVhPMYICf
         ul0VskqBVwH7MPgz5jpbXEHis2TplcjUX4IxBXoisV5E/H18bCBzQYPNjrYa/6yj38jf
         rCqf4nEqDtzayATThqZ8VXvlrTpCs8KMycxVq9v32gr2uWKRVIjiPv5oKC8r8259xqNd
         7nfmVL/J7Pz+I2wbJ0zvnITvfBrp0DFV0Vi62W9Kj0djfdTmxaxgmj5nUwsPKSpQY1kq
         08XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=s/28wtYtU7gagRXvdce6jpY7WQlfh50kGXNmHpoG7Gs=;
        b=N01D+71b8CfGlcbKk8LNq3IpAdhLOAZeypcmdf4x612623D1anQf6v1i0IMCtuhsbP
         FBCNMO2NaEfipzC0nOrkWeismGX6fsHUzN+LOcrGtkMt8vi9PJSC+ZZf9vRluZw2nSwY
         BgcbUdU1/osV1egvXlyXwXCWQoSEbHxi9eXVA4vP22Wl/PeDypbhyley11ApvFPQApcG
         MREJt2CHbmbiuAIjg89vdTl/wpXf4bm+bVDBPWwoftcIqQPhcuWhLcKK/CZMGezVEYWI
         AIH8E+U5YOsgxpYldIaO5aIMaYiEbbYQScmY0+YiR9vkM8Sf503Osxmc4hHObrd55uyD
         woaA==
X-Gm-Message-State: AGRZ1gIU/LZu9sTYyhLhR8T4ULhbkbO2Fyz8u0ZLQfeLY35cr/6pWB0P
        jt5bsQSa1D07D2pOpwSXzmM=
X-Google-Smtp-Source: AJdET5cqYL0uK/sBoP5T/CF2Ca7jJhKRFcb/orlKMVASCj4oI/kyJGiRS0vL/xmvPXCRKP8TfSILSA==
X-Received: by 2002:a50:95b4:: with SMTP id w49-v6mr1281625eda.15.1540466161030;
        Thu, 25 Oct 2018 04:16:01 -0700 (PDT)
Received: from szeder.dev (x4db0730d.dyn.telefonica.de. [77.176.115.13])
        by smtp.gmail.com with ESMTPSA id z15-v6sm1554293ejq.60.2018.10.25.04.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 04:16:00 -0700 (PDT)
Date:   Thu, 25 Oct 2018 13:15:57 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: 'ds/test-multi-pack-index' vs. 'ab/commit-graph-progress'
Message-ID: <20181025111557.GL30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

when branch 'ds/test-multi-pack-index' is merged with
'ab/commit-graph-progress', IOW 'master', 'next', or 'pu',
'GIT_TEST_MULTI_PACK_INDEX=1 ./t6500-gc.sh' fails with:

  expecting success:
          git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
          test_must_be_empty stdout &&
          test_line_count = 1 stderr &&
          test_i18ngrep "Computing commit graph generation numbers" stderr
  
  + git -c gc.writeCommitGraph=true gc --no-quiet
  + test_must_be_empty stdout
  + test_path_is_file stdout
  + test -f stdout
  + test -s stdout
  + test_line_count = 1 stderr
  + test 3 != 3
  + wc -l
  + test 16 = 1
  + echo test_line_count: line count for stderr != 1
  test_line_count: line count for stderr != 1
  + cat stderr
  error: packfile .git/objects/pack/pack-c67996b982e718f8e3fa70c5ff7db3cecf688bbb.pack index unavailable
  error: packfile .git/objects/pack/pack-d4f2632c6a37149bb546b8b0cfbc56b8183cd0f8.pack index unavailable
  error: packfile .git/objects/pack/pack-d4f2632c6a37149bb546b8b0cfbc56b8183cd0f8.pack index unavailable
  error: packfile .git/objects/pack/pack-c67996b982e718f8e3fa70c5ff7db3cecf688bbb.pack index unavailable
  error: packfile .git/objects/pack/pack-c67996b982e718f8e3fa70c5ff7db3cecf688bbb.pack index unavailable
  error: packfile .git/objects/pack/pack-c67996b982e718f8e3fa70c5ff7db3cecf688bbb.pack index unavailable
  error: packfile .git/objects/pack/pack-c67996b982e718f8e3fa70c5ff7db3cecf688bbb.pack index unavailable
  error: packfile .git/objects/pack/pack-c67996b982e718f8e3fa70c5ff7db3cecf688bbb.pack index unavailable
  error: packfile .git/objects/pack/pack-d4f2632c6a37149bb546b8b0cfbc56b8183cd0f8.pack index unavailable
  error: packfile .git/objects/pack/pack-d4f2632c6a37149bb546b8b0cfbc56b8183cd0f8.pack index unavailable
  error: packfile .git/objects/pack/pack-d4f2632c6a37149bb546b8b0cfbc56b8183cd0f8.pack index unavailable
  error: packfile .git/objects/pack/pack-d4f2632c6a37149bb546b8b0cfbc56b8183cd0f8.pack index unavailable
  error: packfile .git/objects/pack/pack-d4f2632c6a37149bb546b8b0cfbc56b8183cd0f8.pack index unavailable
  error: packfile .git/objects/pack/pack-d4f2632c6a37149bb546b8b0cfbc56b8183cd0f8.pack index unavailable
  error: packfile .git/objects/pack/pack-c67996b982e718f8e3fa70c5ff7db3cecf688bbb.pack index unavailable
  Computing commit graph generation numbers:  25% (1/4)   ^MComputing commit graph generation numbers:  50% (2/4)   ^MComputing commit graph generation numbers:  75% (3/4)   ^MComputing commit graph generation numbers: 100% (4/4)   ^MComputing commit graph generation numbers: 100% (4/4), done.
  + return 1
  error: last command exited with $?=1
  not ok 9 - gc --no-quiet


I suspect these "packfile index unavailable" errors are a Bad Thing,
but I didn't follow the MIDX development closely enough to judge.
Surprisingly (to me), 'git gc' didn't exit with error despite these
errors.

Anyway, this test seems to be too fragile, because that

  test_line_count = 1 stderr

line will trigger, when anything else during 'git gc' prints
something.  And I find it quite strange that an option called
'--no-quiet' only shows the commit-graph progress, but not the regular
output of 'git gc'.


