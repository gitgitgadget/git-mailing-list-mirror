Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C27131F404
	for <e@80x24.org>; Sat, 11 Aug 2018 10:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeHKMm6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 08:42:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40714 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbeHKMm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 08:42:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so5944983edq.7
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 03:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eJZZQnclaEfEv9OQavyHneBM8QcAwf3AsFudX/5lsFU=;
        b=WWl2QXukUPrIJ49Dy4ggP8B0Py37dEd6D0eee2oYqU6PFdHusRYoerRbuKkf9jmeV5
         MJEgkpgTSeeEqNEsbi3yseDrY/DO5d0c4bOgKoXDNuemPv8NCRGETGdvqpGLdyrA48Ef
         mdk+20mP+42exDCrs2dykQmKiOxKp3O7jWYNXD49S8ZVfOMRKCJ3RzE2Z7O/5wLI2iHS
         3RSstlqOvg99lvVABDnOPnDCQoFsVs2D324hibfmugY76dYjLzyGnCkZUOZ0RC1QyPUl
         gV7gfpfIJEJcrsnqhXYaTf3UpuSUPyGQipS0aMS/TE4EKnBl82FJQvZRNmQCJ8j2AtjK
         r4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eJZZQnclaEfEv9OQavyHneBM8QcAwf3AsFudX/5lsFU=;
        b=CXGyyFcvcYNj/gqq13igXraySEuQD2CitekQ2FAxBhnfIfCYPUI9KA1cnTHzxIrFLe
         +3nrW7Or6skS7RMrJT1+0/tqzprxUEWR0fTWXD57KB/PTaJi8qjo+nh0V2atrvo2nB90
         QOiWvft4kSFliCXP3Cq7oS5Z7nE5TiZY3FsgE4FtJd+U1Th06Rzyub2JO7FggnrTdf8g
         PyDAECLdHaMray6fOZuWVbx5xexvTdlh61LqDd8clfEYOmuISaPRhYMmDyvQ/4QFZOhJ
         wr+06bwEUjLTtIwWwJ/3eGoslFxcwu+Pfwgc7hy25CNxnRN96pa2cFayzX4lZKaAz7LB
         ftqQ==
X-Gm-Message-State: AOUpUlGbAcEbfcEsNCav2tQWSGrF54VX3mgQiuC7SRcfZvU+fHstg3m7
        /XXrX85gFTfYk5+J4HlayBQ=
X-Google-Smtp-Source: AA+uWPzPAxJJRWjFwH+oio4hDgrtDHAomfEmGaR1EOEcbM221hMwZs1HIDEFcnTqpBuPlvUYrVy8ww==
X-Received: by 2002:a50:ec89:: with SMTP id e9-v6mr12721721edr.258.1533982153640;
        Sat, 11 Aug 2018 03:09:13 -0700 (PDT)
Received: from localhost.localdomain (x4db10f1c.dyn.telefonica.de. [77.177.15.28])
        by smtp.gmail.com with ESMTPSA id t44-v6sm6200417edh.18.2018.08.11.03.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Aug 2018 03:09:12 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, tboegi@web.de
Subject: Re: [PATCH v3 1/1] clone: report duplicate entries on case-insensitive filesystems
Date:   Sat, 11 Aug 2018 12:09:05 +0200
Message-Id: <20180811100905.1511-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <20180810153608.30051-2-pclouds@gmail.com>
References: <20180807190110.16216-1-pclouds@gmail.com> <20180810153608.30051-1-pclouds@gmail.com> <20180810153608.30051-2-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Paths that only differ in case work fine in a case-sensitive
> filesystems, but if those repos are cloned in a case-insensitive one,
> you'll get problems. The first thing to notice is "git status" will
> never be clean with no indication what exactly is "dirty".
> 
> This patch helps the situation a bit by pointing out the problem at
> clone time. Even though this patch talks about case sensitivity, the
> patch makes no assumption about folding rules by the filesystem. It
> simply observes that if an entry has been already checked out at clone
> time when we're about to write a new path, some folding rules are
> behind this.
> 
> This patch is tested with vim-colorschemes repository on a JFS partition
> with case insensitive support on Linux. This repository has two files
> darkBlue.vim and darkblue.vim.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

This patch makes 'clone http repository' in
't5551-http-fetch-smart.sh' fail with:

  --- exp 2018-08-11 02:29:45.216641851 +0000
  +++ actual.smudged      2018-08-11 02:29:45.264642318 +0000
  @@ -15,3 +15,5 @@
   < Pragma: no-cache
   < Cache-Control: no-cache, max-age=0, must-revalidate
   < Content-Type: application/x-git-upload-pack-result
  +> warning: the following paths have collided and only one from the same
  +> colliding group is in the working tree:


This highlights a few issues:

  - This test runs

      GIT_TRACE_CURL=true git clone --quiet <URL> 2>err

    i.e. the curl trace and any errors or warnings from 'git clone'
    end up in the same file.  This test then removes a lot of
    uninteresting headers before the comparison with 'test_cmp', but
    the warning remains and then triggers the test failure.

    Several other tests run a command like this, but those don't use
    'test_cmp', but only grep the output to verify the presence or
    absence of certain headers.

    I'm inclined to think that it would be prudent to change all these
    tests to send the curl trace to a dedicated file (and then
    '--quiet' can be removed as well).  Though, arguably, had that
    been already the case, this test wouldn't have failed, and we
    probably wouldn't have noticed that something is wrong.

  - But what triggered this warning in the first place?  'git clone'
    didn't print anything after the that warning, even when I re-run
    the test with that '--quiet' option removed.  Furthermore, the
    cloned repository contains a single file, so there could be no
    case/folding collision among multiple files.

    I also notice that this patch doesn't add any tests... :)

  - I didn't understand this warning, I had to read the corresponding
    commit message to figure out what it's all about.


