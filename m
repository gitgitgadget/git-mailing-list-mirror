Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDB421F453
	for <e@80x24.org>; Thu, 25 Oct 2018 21:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeJZFqT (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 01:46:19 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:39602 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeJZFqT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 01:46:19 -0400
Received: by mail-ed1-f44.google.com with SMTP id e5-v6so9793046eds.6
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 14:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WzLw4kgZgKvFsTKZ8Dsvw2DSVtf8Bo5N3HYLaf/57OM=;
        b=f6LjH09zsX6flJRDqng2XSLciTYVCeMz6R8BH28wUjY43wOV3IIHXfIUT5XBow37yt
         Fo4CDhnheSU62DSgl3lH4Ctts1ZgTioyo3uuWqCx+VxyPCJpd5G5/3mV5E1jET9gob68
         VQLfcIjhdPJGncSQ3a+MMzMj6+dWmz5pLRpt9ioTYh1DYWyxDoFln9U+qG1PnyluQatW
         IroDI/W0oV/hEvzQxnmX/P5W9EkhZtgeXjA0GH3ePHvq06BjOdWo2f+qVUCZcbd+xe2k
         xL9iPPdu+qf6ssGRTGfgcLHY2L7nPNBhwyVIGcezfNN6liWRgSZt3g7Wmh00k4JO/J+W
         4s1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=WzLw4kgZgKvFsTKZ8Dsvw2DSVtf8Bo5N3HYLaf/57OM=;
        b=K3OvDLh4RBNV+bqTC85YRYP7wNX2YdNjPIeBK3W2HkXZjeKmLMjs4x52StBHMe8Zgj
         Sx6Mtc2ptiM3HPKZ+Q8+9zlZZIIulzC9WOi2X9YbxxPYIu5rhn8nwbTriD6CP+y/BXH+
         zcT/R0r7+i31PdMuDJ4mAbwoheJDpRRbSm1eyvilXAktoezKJ1tmqi63dnwpr6dNnmIS
         suhXmQc2w/MXvvg5kxkltqEnXs4MZ9cDxqRCY9DQaBjBOPXXA/fpTboJRO9NYHryZGmc
         SrQeiNXEqwmM7zP7WAW/2a+X9VgYQX4KvZBLaoWK9hGsOrmuPSL4Xx9Tp8wV1lOFtDoR
         A6lA==
X-Gm-Message-State: AGRZ1gIIcBWzLxw4xu38KnHUWckFuzxxYTNjXXbdRsdhvg+8ZABi54AI
        EPilUGo/qFnCWLK6o+uTs9E=
X-Google-Smtp-Source: AJdET5feW6PQb9yowXIM8+fPCBS24crhXhrmX9c4V8gMsGvg9DNbpZsLf/TuRlTQuz8Fod1/wJTVfA==
X-Received: by 2002:a50:9e2b:: with SMTP id z40-v6mr624955ede.90.1540501918018;
        Thu, 25 Oct 2018 14:11:58 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id x53-v6sm3489633edx.63.2018.10.25.14.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 14:11:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: 'ds/test-multi-pack-index' vs. 'ab/commit-graph-progress'
References: <20181025111557.GL30222@szeder.dev>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181025111557.GL30222@szeder.dev>
Date:   Thu, 25 Oct 2018 23:11:55 +0200
Message-ID: <87va5plois.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 25 2018, SZEDER Gábor wrote:

> when branch 'ds/test-multi-pack-index' is merged with
> 'ab/commit-graph-progress', IOW 'master', 'next', or 'pu',
> 'GIT_TEST_MULTI_PACK_INDEX=1 ./t6500-gc.sh' fails with:
>
>   expecting success:
>           git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
>           test_must_be_empty stdout &&
>           test_line_count = 1 stderr &&
>           test_i18ngrep "Computing commit graph generation numbers" stderr
>
>   + git -c gc.writeCommitGraph=true gc --no-quiet
>   + test_must_be_empty stdout
>   + test_path_is_file stdout
>   + test -f stdout
>   + test -s stdout
>   + test_line_count = 1 stderr
>   + test 3 != 3
>   + wc -l
>   + test 16 = 1
>   + echo test_line_count: line count for stderr != 1
>   test_line_count: line count for stderr != 1
>   + cat stderr
>   error: packfile .git/objects/pack/pack-c67996b982e718f8e3fa70c5ff7db3cecf688bbb.pack index unavailable
>   error: packfile .git/objects/pack/pack-d4f2632c6a37149bb546b8b0cfbc56b8183cd0f8.pack index unavailable
>   error: packfile .git/objects/pack/pack-d4f2632c6a37149bb546b8b0cfbc56b8183cd0f8.pack index unavailable
>   error: packfile .git/objects/pack/pack-c67996b982e718f8e3fa70c5ff7db3cecf688bbb.pack index unavailable
>   error: packfile .git/objects/pack/pack-c67996b982e718f8e3fa70c5ff7db3cecf688bbb.pack index unavailable
>   error: packfile .git/objects/pack/pack-c67996b982e718f8e3fa70c5ff7db3cecf688bbb.pack index unavailable
>   error: packfile .git/objects/pack/pack-c67996b982e718f8e3fa70c5ff7db3cecf688bbb.pack index unavailable
>   error: packfile .git/objects/pack/pack-c67996b982e718f8e3fa70c5ff7db3cecf688bbb.pack index unavailable
>   error: packfile .git/objects/pack/pack-d4f2632c6a37149bb546b8b0cfbc56b8183cd0f8.pack index unavailable
>   error: packfile .git/objects/pack/pack-d4f2632c6a37149bb546b8b0cfbc56b8183cd0f8.pack index unavailable
>   error: packfile .git/objects/pack/pack-d4f2632c6a37149bb546b8b0cfbc56b8183cd0f8.pack index unavailable
>   error: packfile .git/objects/pack/pack-d4f2632c6a37149bb546b8b0cfbc56b8183cd0f8.pack index unavailable
>   error: packfile .git/objects/pack/pack-d4f2632c6a37149bb546b8b0cfbc56b8183cd0f8.pack index unavailable
>   error: packfile .git/objects/pack/pack-d4f2632c6a37149bb546b8b0cfbc56b8183cd0f8.pack index unavailable
>   error: packfile .git/objects/pack/pack-c67996b982e718f8e3fa70c5ff7db3cecf688bbb.pack index unavailable
>   Computing commit graph generation numbers:  25% (1/4)   ^MComputing commit graph generation numbers:  50% (2/4)   ^MComputing commit graph generation numbers:  75% (3/4)   ^MComputing commit graph generation numbers: 100% (4/4)   ^MComputing commit graph generation numbers: 100% (4/4), done.
>   + return 1
>   error: last command exited with $?=1
>   not ok 9 - gc --no-quiet
>
>
> I suspect these "packfile index unavailable" errors are a Bad Thing,
> but I didn't follow the MIDX development closely enough to judge.
> Surprisingly (to me), 'git gc' didn't exit with error despite these
> errors.
>
> Anyway, this test seems to be too fragile, because that
>
>   test_line_count = 1 stderr

Yeah maybe it's too fragile, on the other hand it caught what seems to
be a bug under GIT_TEST_MULTI_PACK_INDEX=true, and the rest of the test
suite passes, so there's that.

> line will trigger, when anything else during 'git gc' prints
> something.  And I find it quite strange that an option called
> '--no-quiet' only shows the commit-graph progress, but not the regular
> output of 'git gc'.

It's confusing, but the reason for this seeming discrepancy is that
writing the commit-graph happens in-process, whereas the rest of the
work done by git-gc (and its output) comes from subprocesses. Most of
that output is from "git-repack" / "git-pack-objects" which doesn't pay
the same attention to --quiet and --no-quiet, instead it checks
isatty(). See cmd_pack_objects().
