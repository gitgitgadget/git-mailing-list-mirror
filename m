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
	by dcvr.yhbt.net (Postfix) with ESMTP id 049531F404
	for <e@80x24.org>; Thu,  6 Sep 2018 12:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeIFRCJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 13:02:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43384 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbeIFRCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 13:02:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id k5-v6so11171039wre.10
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 05:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9wr/IK/G0Fqz9ZDBYHYuOSQgzm/jmfWzzEGqTWCqfXc=;
        b=HzEIMLnCcb444DcwNLEA3mS06KVkCa/MQathdJ5I0UAexfcT4ApWzXSt+IJyRcKAxc
         oAWxOn5PNbRN+KsU+4Rl/lZfkbSloB+mzARlPhau7dVhqbjGTmwqXJbfo3LUbpN1uU/5
         V7vnW8HBjaf5Ju5VI2ca54ORs9Vlc4GhzAF7ezDM0X2vzvqneVLIQSm9PBO1waNz6kwQ
         203bVqJo+erKyVTVJljJ8fJPjRUpf17q+WeKa4DZGACwgLTDfnLxwZC5rbNApq7XSnHA
         t3dh73fD6bC3qq+QcDCqxWwilcjvWJERwALMu+uoYFS5IlqfCOyFagGz8q3Kr/ttOvHN
         OGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=9wr/IK/G0Fqz9ZDBYHYuOSQgzm/jmfWzzEGqTWCqfXc=;
        b=nbrsWdKFwZ/iSszWETiXEJfIF2OXKRsAr0WJyBp6YKKRp3Q5tWxBv0WR+ifYt2NKY3
         DZ4XRBTtN/Nc06xa9ji44dRsTaD0RSQIyRcOykaHcws0WQl6ltXdvofIoo0UDwcqpZn1
         hDVU70AJAD2iP9NwZKVNfuVn6pUVB2dzoCaFMO+sGpaVTb9ZnDf964vO9r1PSyFJrIb/
         XZIwWMmId012fVPl/1lscaM+rVp2sHyMi7UxL3O1fc/E7bXQ9b8tyARXMxXoDtmaNKuv
         5V+gtHxzeJxsvpzIPAKyqP9ym4qZ11yYxvVTaYJtwWU5cxUe7cFwNMQGH+ZeF5w0Sld4
         PUsQ==
X-Gm-Message-State: APzg51BzE2P6YP4i4mv4WxOaFGtmhRy8dYVRU1jjalYoov+ipmZD9Jhw
        HW0NC2RLGdIbaaJwLyB2NuZcLZaW
X-Google-Smtp-Source: ANB0VdY5oWxuYe1DgVGQk2CvuO4QsCpi0POkjPM4qwFzqVxpP101+6dkd3HtNHOjMCeHZmOYpxW0+g==
X-Received: by 2002:a5d:6150:: with SMTP id y16-v6mr2236103wrt.141.1536236811805;
        Thu, 06 Sep 2018 05:26:51 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id w18-v6sm10021667wrc.38.2018.09.06.05.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 05:26:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [RFC PATCH 5/5] split-index: smudge and add racily clean cache entries to split index
References: <20180906024810.8074-1-szeder.dev@gmail.com> <20180906024810.8074-6-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180906024810.8074-6-szeder.dev@gmail.com>
Date:   Thu, 06 Sep 2018 14:26:49 +0200
Message-ID: <87va7ireuu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 06 2018, SZEDER Gábor wrote:

> Ever since the split index feature was introduced [1], refreshing a
> split index is prone to a variant of the classic racy git problem.
>
> Consider the following sequence of commands updating the split index
> when the shared index contains a racily clean cache entry, i.e. an
> entry whose cached stat data matches with the corresponding file in
> the worktree and the cached mtime matches that of the index:
>
>   echo "cached content" >file
>   git update-index --split-index --add file
>   echo "dirty worktree" >file    # size stays the same!
>   # ... wait ...
>   git update-index --add other-file
>
> Normally, when a non-split index is updated, then do_write_index()
> (the function responsible for writing all kinds of indexes, "regular",
> split, and shared) recognizes racily clean cache entries, and writes
> them with smudged stat data, i.e. with file size set to 0.  When
> subsequent git commands read the index, they will notice that the
> smudged stat data doesn't match with the file in the worktree, and
> then go on to check the file's content.
>
> In the above example, however, in the second 'git update-index'
> prepare_to_write_split_index() gathers all cache entries that should
> be written to the new split index.  Alas, this function never looks
> out for racily clean cache entries, and since the file's stat data in
> the worktree hasn't changed since the shared index was written, it
> won't be replaced in the new split index.  Consequently,
> do_write_index() doesn't even get this racily clean cache entry, and
> can't smudge its stat data.  Subsequent git commands will then see
> that the index has more recent mtime than the file and that the (not
> smudged) cached stat data still matches with the file in the worktree,
> and, ultimately, will erroneously consider the file clean.
>
> Modify prepare_to_write_split_index() to recognize racily clean cache
> entries, and mark them to be added to the split index.  This way
> do_write_index() will get these racily clean cache entries as well,
> and will then write them with smudged stat data to the new split
> index.
>
> Note that after this change if the index is split when it contains a
> racily clean cache entry, then a smudged cache entry will be written
> both to the new shared and to the new split indexes.  This doesn't
> affect regular git commands: as far as they are concerned this is just
> an entry in the split index replacing an outdated entry in the shared
> index.  It did affect a few tests in 't1700-split-index.sh', though,
> because they actually check which entries are stored in the split
> index; the previous patch made the necessary adjustments.  And racily
> clean cache entries and index splitting are rare enough to not worry
> about the resulting duplicated smudged cache entries, and the
> additional complexity required to prevent them is not worth it.
>
> Several tests failed occasionally when the test suite was run with
> 'GIT_TEST_SPLIT_INDEX=yes'.  Here are those that I managed to trace
> back to this racy split index problem, starting with those failing
> more frequently, with a link to a failing Travis CI build job for
> each.  The highlighted line shows when the racy file was written,
> which is not always in the failing test (but note that those lines are
> in the 'after failure' fold, and your browser might unhelpfully fold
> it up before you could take a good look).

Thanks for working on this. When I package up git I run the tests
under a few different modes, in the case of split index I've been
doing:

    GIT_TEST_SPLIT_INDEX=true GIT_SKIP_TESTS="t3903 t4015.77"

Since those were the ones I spotted failing under that mode, but
I still had occasional other failures, I don't have a record of
which, maybe some of these other tests you mention, maybe not.

To test how this this series improves things, I've been running
this on a 56 core CentOS 7.5 machine:

    while true; do GIT_TEST_SPLIT_INDEX=yes prove -j$(parallel --number-of-cores) t3903-stash.sh t4024-diff-optimize-common.sh t4015-diff-whitespace.sh t2200-add-update.sh t0090-cache-tree.sh && echo "OK $(date) $(git describe)" >>log2 || echo "FAIL $(date) $(git describe)" >>log2; done

While, in another window to get some load on the machine (these seem to
fail more under load):

    while true; do prove -j$(parallel --number-of-cores) t[156789]*.sh; done

The results with this series applied up to 4/5. I.e. without the actual
fix:

     92 OK v2.19.0-rc2-6-ged839bd155
      8 FAIL v2.19.0-rc2-6-ged839bd155

I.e. when running this 100 times, I got 8 failures. So 8%.

With this patch applied:

    389 OK v2.19.0-rc2-5-g05a5a13935
     11 FAIL v2.19.0-rc2-5-g05a5a13935

This time I ran the tests 400 times, and got 11 failures, i.e. a
~2.8% failure rate. I don't have a full account of what stuff
failed (this was just scrolling past in my terminal), but most
were:

    t0090-cache-tree.sh          (Wstat: 256 Tests: 21 Failed: 3)
      Failed tests:  10-12
      Non-zero exit status: 1

I.e. these tests:

    ok 10 - commit --interactive gives cache-tree on partial commit
    ok 11 - commit in child dir has cache-tree
    ok 12 - reset --hard gives cache-tree

Then I saw two of these fail, and no other failures:

    t3903-stash.sh               (Wstat: 256 Tests: 90 Failed: 1)
      Failed test:  55
      Non-zero exit status: 1

I.e. this:

    ok 55 - stash branch should not drop the stash if the apply fails

I don't have output from those under -x -v. I'm running them in a loop
now to try to make them fail like that, no luck yet, maybe one of those
options "fixes" the race condition, or I'm just unlucky.

[Side note: All of the above is just assuming that running the tests in
 a loop without GIT_TEST_SPLIT_INDEX=yes will work, but I haven't
 actually tested that, but I've never seen one of these transitory
 failures in the past without GIT_TEST_SPLIT_INDEX=yes, so I'm fairly
 sure that works]

So this definitely seems like an improvement, i.e. the transitory
failure rate is much lower now, but it looks like there's still some
race condition related to split index left to solve.

However, one thing that makes me paranoid is that without your patch I
do get failures on t3903-stash.sh, but it's a *different* failure than
the (much less likely to happen) failure after your patch. I.e. I've
only seen it fail like this before:

    t3903-stash.sh               (Wstat: 256 Tests: 90 Failed: 1)
      Failed test:  60
      Non-zero exit status: 1

That's this test, i.e. #60, not the #55 test that occasionally fails
after these patches:

    ok 60 - handle stash specification with spaces

This series doesn't change t3903-stash.sh at all, so this really is a
different failure.

You *do* modify t0090-cache-tree.sh, but the 10-12 tests failing with
your patch are earlier in the file than the new test you added, so I
believe that's a new failure as well. It could just be sampling bias /
bad luck, but I don't have a single failure for t0090-cache-tree.sh
without this patch, and with the patch it's the most common failure.
