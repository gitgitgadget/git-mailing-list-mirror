Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 964901F97F
	for <e@80x24.org>; Wed, 10 Oct 2018 18:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJKCQr (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 22:16:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35773 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbeJKCQr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 22:16:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id f8-v6so2966269plb.2
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 11:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=SXKQ2sPk2gWsRhUz+uEBrvAaIdQcCkTrDhufh+Oa0HE=;
        b=tJgb4Mg2YYBdkU46KC3KcoMSUG10wQ6KaEf9/g0E3CyavZ7tugSV6zBjaH8Btk2lhp
         UBjHDU9NTdcvWHkHhd5TymewOwsjlV8lqSh2jiv1yfaJ/fejJFa0RKrr0uHczzk4vsxi
         6rhOB3b3aoGNh8l67FPTb/fuGgxBAKgTAq9O2iDil1fTTsWys45yeYd4VIx8FLWBwVNx
         QMA2ma1tySLK50LIrPBstjxW4Ln3cC5DGbT/OvJ+0Gow1t42GgRcsfIh9CFz3gyU1DzY
         VhOL4EsTaA1EaJDDeMUQp0giW3kx9lU8duvHQ+6NnSLpQZ0HWNooBq1zz1X5IIBnMSmI
         lEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:from:to:cc:message-id:in-reply-to
         :references;
        bh=SXKQ2sPk2gWsRhUz+uEBrvAaIdQcCkTrDhufh+Oa0HE=;
        b=pWE+1hOy4ZhfzX3khTHwU8KCzqNKm697xzp4/B+xVcMFjlKProBIGGoAE3Jh7Ke8Os
         UBL9W0oR7b253WGaEnBmFLuycH/fEFh2hcT+FY5Zew8dzUlOTrh8y8I3mGRR0y6O6iPd
         DwkVtrDe/J4sKogLb7kM5RXI1pXv4sZPDBx8DapqcwdCXKPV8yOdCbgM8OrdqHOk0Raa
         I9KWY70DVE8Qg7E+T6O8fsTiBzS6fitih9v9qV3Qy/8JLRqV22JxpYqDpA6XLWfE4Uwb
         sdEbXZv2CM3lLxRJcBb2juT479UUdJ3ezN73yjwYhtOlHTuLCADLrgx4x4oq38Cu2Nim
         6bcw==
X-Gm-Message-State: ABuFfoi4Gv39yBF0uOQcQqeaiHRmYm9GGWAy33cK4GfvgjFSK4BNZNqp
        tCgbKMdbfMUL60RqZhTgEmc=
X-Google-Smtp-Source: ACcGV62/BWZNC0RlH7rZ0btHjXQwQNseu/drSAHaOGmPNJe7Gp8D0VsLvWu4Hs9Hdpt9E9nnV24fBg==
X-Received: by 2002:a17:902:b08e:: with SMTP id p14-v6mr34415979plr.241.1539197600080;
        Wed, 10 Oct 2018 11:53:20 -0700 (PDT)
Received: from gmail.com ([109.236.90.209])
        by smtp.gmail.com with ESMTPSA id r65-v6sm34824161pfj.5.2018.10.10.11.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 11:53:19 -0700 (PDT)
Subject: `--rebase-merges' still failing badly
Date:   Wed, 10 Oct 2018 18:51:17 -0000
From:   Michael Witten <mfwitten@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Pratik Karki <predatoramigo@gmail.com>, git@vger.kernel.org
Message-ID: <645452fda0ae411d86487b76aaac8151-mfwitten@gmail.com>
In-Reply-To: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 10 Oct 2018 14:43:46 +0900, Junio wrote:

> We haven't seen  much complaints and breakages  reported against the
> two big "rewrite in C" topics  around "rebase"; perhaps it is a good
> time to merge  them to 'next' soonish  to cook them for  a few weeks
> before moving them to 'master'?

In my opinion, the `--rebase-merges' feature has been broken since the
beginning, and the builtin version should  be fixed before it is moved
ahead. In short: "labels" are brittle; see below for tests.

Also, here are some quick *additional* thoughts:

    * Labels should be simply "r0", "r1", ... "rN".

          * The current, long label names are just cumbersome.
          * The embedded comments are already more than enough.
          * "r" is short for "revision" or "reset" or "remember", etc.
          * "r" is  located on a  QWERTY keyboard such that  it's very
            easy to type "rN", where "N" is a number.

    * Why is the command "label" and not "branch"? Every other related
      command looks  like a normal  git command: "reset"  and "merge".
      Make it "branch".

    * In my experience, there's a lot of this boiler plate:

          pick 12345
          label r1
          reset r0
          merge r1

      How about instead, use git's existing ideas:

          pick 12345
          reset r0
          merge ORIG_HEAD

      Or, maybe git in general  should treat `-' as `ORIG_HEAD' (which
      would be similar to how `git checkout' understands `-'), thereby
      allowing a very quick idiomatic string of commands:

          pick 12345
          reset r0
          merge -

      In truth, I don't really know the semantics of `ORIG_HEAD', so
      maybe those should be nailed down and documented more clearly;
      I would like it to work as in the following:

          pick 12345
                     # label r1 (pretend)
          reset r0   # Store r1 in ORIG_HEAD
          pick 67890 # Do NOT touch ORIG_HEAD
          merge -    # Same as merge -C abcde r1

      Anyway, this  kind of unspoken  behavior would make  *writing* a
      new history by hand much more pleasant.

    * Why not just `--merges' instead of `--rebase-merges'? Or, better
      yet,  just make  it  the default  behavior;  the special  option
      should instead be:

          --flatten

      This option would simply tell `git rebase' to prepare an initial
      todo list without merges.

Thanks for this great feature.

I'm only complaining so much because it's such a useful feature, and I
want it  to be  even better, because  I'll  probably use it  A LOT; it
should have been available since the start as a natural consequence of
the way git works.

Sincerely,
Michael Witten

---------------

Unfortunately,   both  the   legacy   version  and   the  rewrite   of
`--rebase-merges'  display  a  bug  that  makes  this  feature  fairly
unusable in  practice; it tries  to create  a "label" (i.e.,  a branch
name) from a commit log summary  line, and the result is often invalid
(or just  plain irritating to work  with). In particular, it  fails on
typical characters, including at least these:

    :/\?.*[]

To see this, first define some POSIX shell functions:

    test()
    {
        (
            set -e
            summary=$1
            d=/tmp/repo ##### WARNING. CHANGE IF NECESSARY.
            rm -rf "$d"; mkdir -p "$d"; cd "$d"
            git init -q
            echo a > a; git add a; git commit -q -m a
            git branch base
            echo b > b; git add b; git commit -q -m b
            git reset -q --hard HEAD^
            git merge -q --no-ff -m "$summary" ORIG_HEAD
            git log --graph --oneline
            git rebase --rebase-merges base
        ); status=$?
        echo
        return "$status"
    }

    Test()
    {
        if test "$@" 1>/dev/null 2>&1; then
            echo '    good'; return 0
        else
            echo '    fail'; return 1
        fi
    }

Then, try various commit summaries (see below for results):

    test c
    test 'combine these into a merge: a and b'
    Test ab:
    Test a:b
    Test :
    Test a/b
    Test 'Now supports /regex/'
    Test ab/
    Test /ab
    Test /
    Test 'a\b'
    Test '\'
    Test 'Maybe this works?'
    Test '?'
    Test 'This does not work.'
    Test 'This works. Strange!'
    Test .git
    Test .
    Test 'Cast each pointer to *void'
    Test '*'
    Test 'return a[1] not a[0]'
    Test '[ does not work'
    Test '['
    Test '] does work'
    Test ']'

Here are the results of pasting the above commands into my terminal:

    $ test c
    warning: templates not found in ../install/share/git-core/templates
    *   1992d07 (HEAD -> master) c
    |\
    | * 34555b5 b
    |/
    * 338db9b (base) a
    Successfully rebased and updated refs/heads/master.

    $ test 'combine these into a merge: a and b'
    warning: templates not found in ../install/share/git-core/templates
    *   4202c49 (HEAD -> master) combine these into a merge: a and b
    |\
    | * 34555b5 b
    |/
    * 338db9b (base) a
    error: refusing to update ref with bad name 'refs/rewritten/combine-these-into-a-merge:-a-and-b'
    hint: Could not execute the todo command
    hint:
    hint:     label combine-these-into-a-merge:-a-and-b
    hint:
    hint: It has been rescheduled; To edit the command before continuing, please
    hint: edit the todo list first:
    hint:
    hint:     git rebase --edit-todo
    hint:     git rebase --continue

    $ Test ab:
        fail
    $ Test a:b
        fail
    $ Test :
        fail
    $ Test a/b
        good
    $ Test 'Now supports /regex/'
        fail
    $ Test ab/
        fail
    $ Test /ab
        fail
    $ Test /
        fail
    $ Test 'a\b'
        fail
    $ Test '\'
        fail
    $ Test 'Maybe this works?'
        fail
    $ Test '?'
        fail
    $ Test 'This does not work.'
        fail
    $ Test 'This works. Strange!'
        good
    $ Test .git
        fail
    $ Test .
        fail
    $ Test 'Cast each pointer to *void'
        fail
    $ Test '*'
        fail
    $ Test 'return a[1] not a[0]'
        fail
    $ Test '[ does not work'
        fail
    $ Test '['
        fail
    $ Test '] does work'
        good
    $ Test ']'
        good
