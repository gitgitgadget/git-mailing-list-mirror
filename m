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
	by dcvr.yhbt.net (Postfix) with ESMTP id 184F11F404
	for <e@80x24.org>; Thu,  6 Sep 2018 17:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeIFWaV (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 18:30:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34007 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbeIFWaU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 18:30:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id g33-v6so12356719wrd.1
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 10:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0u3+Tf6gxH+2lVPkF1D6hwa4GpVVi+t2djrf0cBYAQs=;
        b=Kd/yIN2yEsR3MnQ6sawndI8QUgYso1UVTvbmsdtKAzMggqC3CXyV/qgSRIVkqYgkcj
         BizfgQcMnzHVfqcs02ecsynb2DDvSl/mnxo7WdsmpXptRzrBNaNk64SfBjbS2Pjw/UlT
         Z4pmpdzae8X6Ksg9AV2qgzOUgzb7uf84LLJHy6FIZxkZzsedS47Jj3KN6aBMO3Pw1G8F
         EX1/EVscYvR237qnhZaIpwq8vtFsLKsdF6UZ5vX4dyoZFj7EO/tHxOQ4AVo8AfG7loTG
         O0y7OXCxzPVlQAtGuPoN+QqSEF4cyEhn28yGwWriG63VzdI+SmyJAOX9ISUi0RyAHWdZ
         W9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=0u3+Tf6gxH+2lVPkF1D6hwa4GpVVi+t2djrf0cBYAQs=;
        b=ZkOfJXoswp10A+ph54MXSWiYAXxBR6hx9GbBMJi/eEX5F0ZtJ7DhnlI4Z78svQjl/5
         WD+4SdeK7eC2R7WrbGK7+WLDU8MygYddyzKj+/Ud1ekH0+d/a76GcE41w5AVy+lvarr+
         GI2J6jUIEpjPcqhGX9k4uu7Q4a8UtvLheZHIqoKZO8IukvlpOQRJnPgeVM8rr2P735HP
         D7fgeN7UYuXkefqdJcAN2Fenkh5spKZtghNimjuAlZvPYLCOAh7fOID2SdzoIJ8+KEmE
         ERVJUvCXjUCtr7iKyl1YQ+NfpmwNfQhUBO/0X1NowKStGA9Mcz1sLzil0dLabftprFFd
         qUgg==
X-Gm-Message-State: APzg51BUzM6zG7BKIpGcd9zom73f9Gq9KCpQfbSiJJ9k58BDQDPDaQ+t
        PkR3dTC+1XgSSPJ50BgxjDaKfAr5
X-Google-Smtp-Source: ANB0VdaVrXkX10ZoLCO1/uPpqxEuDZiWEJg/f3odg4HETCTCEjL2eR1+0cgg9vf6besOusYr1YXA5A==
X-Received: by 2002:adf:c890:: with SMTP id k16-v6mr3406892wrh.6.1536256423617;
        Thu, 06 Sep 2018 10:53:43 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id t9-v6sm10982453wra.91.2018.09.06.10.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 10:53:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>
Subject: Re: [RFC PATCH 5/5] split-index: smudge and add racily clean cache entries to split index
References: <20180906024810.8074-1-szeder.dev@gmail.com> <20180906024810.8074-6-szeder.dev@gmail.com> <87va7ireuu.fsf@evledraar.gmail.com> <20180906151439.GA8016@localhost> <87lg8er6ir.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87lg8er6ir.fsf@evledraar.gmail.com>
Date:   Thu, 06 Sep 2018 19:53:41 +0200
Message-ID: <87k1nyqzq2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 06 2018, Ævar Arnfjörð Bjarmason wrote:

> On Thu, Sep 06 2018, SZEDER Gábor wrote:
>
>> On Thu, Sep 06, 2018 at 02:26:49PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Thu, Sep 06 2018, SZEDER Gábor wrote:
>>> > Several tests failed occasionally when the test suite was run with
>>> > 'GIT_TEST_SPLIT_INDEX=yes'.  Here are those that I managed to trace
>>> > back to this racy split index problem, starting with those failing
>>> > more frequently, with a link to a failing Travis CI build job for
>>> > each.  The highlighted line shows when the racy file was written,
>>> > which is not always in the failing test (but note that those lines are
>>> > in the 'after failure' fold, and your browser might unhelpfully fold
>>> > it up before you could take a good look).
>>>
>>> Thanks for working on this. When I package up git I run the tests
>>> under a few different modes, in the case of split index I've been
>>> doing:
>>>
>>>     GIT_TEST_SPLIT_INDEX=true GIT_SKIP_TESTS="t3903 t4015.77"
>>
>> Yeah, I noticed that you mentioned this in an unrelated thread the
>> other day, that's why I put you on Cc.  ... and that's why I pulled
>> this series from the backburner and cleaned it up for submission.
>> (Gah, most of these commits have an author date back in February...)
>>
>>> Since those were the ones I spotted failing under that mode, but
>>> I still had occasional other failures, I don't have a record of
>>> which, maybe some of these other tests you mention, maybe not.
>>
>> I poked around the Travis CI API, and managed to get the logs of all
>> build jobs that failed with 'GIT_TEST_SPLIT_INDEX=yes' but succeeded
>> without it.  Here is the list of failed test scripts, along with how
>> many times they failed:
>>
>>       1 t0027-auto-crlf.sh
>>       1 t0090-cache-tree.sh
>>       1 t3404-rebase-interactive.sh
>>       1 t5520-pull.sh
>>       1 t5573-pull-verify-signatures.sh
>>       1 t5608-clone-2gb.sh
>>       1 t7406-submodule-update.sh
>>       2 t2200-add-update.sh
>>       2 t4002-diff-basic.sh
>>       2 t5504-fetch-receive-strict.sh
>>       3 t0028-working-tree-encoding.sh
>>       4 t1000-read-tree-m-3way.sh
>>       6 t4015-diff-whitespace.sh
>>      10 t4024-diff-optimize-common.sh
>>      17 t3030-merge-recursive.sh
>>      17 t3402-rebase-merge.sh
>>      17 t3501-revert-cherry-pick.sh
>>      17 t6022-merge-rename.sh
>>      17 t6032-merge-large-rename.sh
>>      17 t6034-merge-rename-nocruft.sh
>>      17 t6042-merge-rename-corner-cases.sh
>>      17 t6043-merge-rename-directories.sh
>>      17 t6046-merge-skip-unneeded-updates.sh
>>      17 t7003-filter-branch.sh
>>      17 t7601-merge-pull-config.sh
>>      23 t3903-stash.sh
>>
>> I doubt that this racy split index problem is responsible for all
>> these failures; e.g. I looked at the failures of a few merge-related
>> test scripts, and these logs show that they tend to fail because of
>> memory corruption, i.e. with 'Aborted (core dumped)' or 'Segmentation
>> fault (core dumped)'.
>>
>>> To test how this this series improves things, I've been running
>>> this on a 56 core CentOS 7.5 machine:
>>>
>>>     while true; do GIT_TEST_SPLIT_INDEX=yes prove -j$(parallel --number-of-cores) t3903-stash.sh t4024-diff-optimize-common.sh t4015-diff-whitespace.sh t2200-add-update.sh t0090-cache-tree.sh && echo "OK $(date) $(git describe)" >>log2 || echo "FAIL $(date) $(git describe)" >>log2; done
>>>
>>> While, in another window to get some load on the machine (these seem to
>>> fail more under load):
>>>
>>>     while true; do prove -j$(parallel --number-of-cores) t[156789]*.sh; done
>>>
>>> The results with this series applied up to 4/5. I.e. without the actual
>>> fix:
>>>
>>>      92 OK v2.19.0-rc2-6-ged839bd155
>>>       8 FAIL v2.19.0-rc2-6-ged839bd155
>>>
>>> I.e. when running this 100 times, I got 8 failures. So 8%.
>>
>> Lucky you ;)
>>
>> I could only get t3903 to fail on me, but not the others.  That was
>> enough to eventually track down and fix the problem (fun! ;), and then
>> I looked at the logs of failed git/git Travis CI build jobs to see,
>> what other failures might have been caused by it.
>>
>>> With this patch applied:
>>>
>>>     389 OK v2.19.0-rc2-5-g05a5a13935
>>>      11 FAIL v2.19.0-rc2-5-g05a5a13935
>>>
>>> This time I ran the tests 400 times, and got 11 failures, i.e. a
>>> ~2.8% failure rate. I don't have a full account of what stuff
>>> failed (this was just scrolling past in my terminal), but most
>>> were:
>>>
>>>     t0090-cache-tree.sh          (Wstat: 256 Tests: 21 Failed: 3)
>>>       Failed tests:  10-12
>>>       Non-zero exit status: 1
>>>
>>> I.e. these tests:
>>>
>>>     ok 10 - commit --interactive gives cache-tree on partial commit
>>>     ok 11 - commit in child dir has cache-tree
>>>     ok 12 - reset --hard gives cache-tree
>>
>> But hey, 't0090 --verbose-log -x -i' just failed on me with the fix
>> applied while writing this email, yay!  In its logs I see the
>> following errors in all three tests you mention:
>>
>>   error: index uses ?½þA extension, which we do not understand
>>   fatal: index file corrupt
>>
>> Test 13 then starts with 'rm -f .git/index', and then all is well for
>> the remaining tests.
>>
>> There was a recent discussion about a similar error starting at:
>>
>>   https://public-inbox.org/git/20180901214157.hxlqmbz3fds7hsdl@ltop.local/
>>
>> and leading to a fix in 6c003d6ffb (reopen_tempfile(): truncate opened
>> file, 2018-09-04).  I certainly hope that not my fix is buggy, but
>> combined with 'GIT_TEST_SPLIT_INDEX=yes' it can occasionally trigger
>> the same error, and Peff's (Cc'd) fix will resolve it as well.
>>
>> Could you run your stress tests with Peff's fix merged with mine?
>> Apparetly your setup is much more capable of triggering these issues
>> than mine...
>
> I get the same sort of thing on t0090-cache-tree.sh with -v -x,
> i.e. failures due to:
>
>     error: index uses �)�? extension, which we do not understand
>     fatal: index file corrupt
>
> It turns out that my inability to reproduce that earlier was because I'd
> forgotten to set GIT_TEST_SPLIT_INDEX=yes in the environment for that
> while loop, so I wasn't testing the split index at all.
>
> I'm now running the tests in a lop with 6c003d6ffb cherry-picked on
> top. I'll report back when I have enough data to say if/how it helped.

I got 436 OK runs with that and 3 failures before I gave up and ctrl+c'd
it. And the 3 failures were:

    t3903-stash.sh               (Wstat: 256 Tests: 90 Failed: 1)
      Failed test:  55
      Non-zero exit status: 1

So it's back to failing on the same test as before your patches.

I did try merging in "pu" to get git-stash in C. There I had 2 failures
and 135 OK before I gave up. The C version failed tests 5 & 20, so there
may be some new regressions in the C version related to this.
