Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5CFC433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 12:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0251222C3
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 12:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbgJIM4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 08:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732923AbgJIM4a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 08:56:30 -0400
Received: from wp368.webpack.hosteurope.de (wp368.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8589::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19308C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 05:56:30 -0700 (PDT)
Received: from ip1f10fe5a.dynamic.kabel-deutschland.de ([31.16.254.90] helo=[192.168.178.62]); authenticated
        by wp368.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kQrwi-0006S5-R8; Fri, 09 Oct 2020 14:56:28 +0200
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Manuel_B=c3=a4renz?= <manuel@enigmage.de>
Subject: Feature request: Exponential search in git bisect
Autocrypt: addr=manuel@enigmage.de; prefer-encrypt=mutual; keydata=
 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
 b8akWy3qT7XiPOcNWZM=
Message-ID: <945ab20e-dcde-540e-83a5-83992c2187b1@enigmage.de>
Date:   Fri, 9 Oct 2020 14:56:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-bounce-key: webpack.hosteurope.de;manuel@enigmage.de;1602248190;f65d7ab5;
X-HE-SMSGID: 1kQrwi-0006S5-R8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This feature was requested 8 years ago and briefly discussed:
https://public-inbox.org/git/20120318212957.GS1219@chaosreigns.com/


  TL;DR

Before doing git bisect, I want to use exponential search to
automatically find a good commit, in logarithmic time.


  Scenario

  * I have a bug in HEAD.
  * I strongly suspect that it was introduced some time ago, but I don't
    know when exactly.
  * I have an automated test that will find the bug if the test can run
    properly.
  * Most of the commits in the repository are not testable, i.e. the
    test doesn't run properly. (E.g. because the feature it tests wasn't
    introduced yet, refactoring, etc.)
  * I have no idea what a good commit might be, because I don't know
    when the first /testable/ good commit is.

This sounds like a standard application for git bisect. No matter how
big the repo, with binary search we would expect to find the first bad
commit in logarithmic time.


  Failed attempt

The zeroth idea might be trying to find the good commit by hand, by
reading changelogs, by trying some commits, whatever. In some
situations, this is not feasible. In fact, such situations occur
frequently for me, for example for undocumented features, unversioned
rolling releases, incidental complexity leading to older commits not
being testable, etc.

The first idea that comes to mind - and it was recommended 8 years agos,
and I've tried it a few times already - is to simply mark the root
commit as good. (Now, there might be several roots, but that's a puzzle
you typically only have to figure out once per repo.) This sounds great
in theory because binary search should get through the good old commits
in logarithmic time.

The problem with this approach is that if most older commits are
untestable, I have to git bisect skip them. This basically kills the
logarithmic performance, because bisect skip doesn't do binary search,
but something rather random. Just yesterday I killed a bisect search
that took hours because it kept skipping and didn't find actual good
commits.

You might say that instead of skipping old commits, one should mark them
as good. That's problematic because then I might accidentally mark a
commit as good that was already untestable bad. Given that bisect has no
undo functionality, that can quickly mess up my search. Distinguishing
untestable good from untestable bad is really hard automatically. I
shouldn't have to do that.

Long story short: Going from the root commit typically isn't feasible.
I've tried it.


  Proposal: Exponential search

Instead of going from the root commit, what I do manually before
starting git bisect is this:

git checkout HEAD~10
./test.sh # Says: "Bug is present"
git checkout HEAD~20
./test.sh # Says: "Bug is still present"
git checkout HEAD~40
./test.sh # Says: "Bug is still present"
[...] # Proceed exponentially
git checkout HEAD~640
./test.sh # Says: "Bug is GONE!"
git bisect good

This technique is known as
https://en.wikipedia.org/wiki/Exponential_search, and it works very well
in practice. I find a good commit long before I enter the "untestable
good" region. But it's tedious to do this manually. In this example, I
needed to run the script 8 times manually, but of course it can be more
often, and compiling and running the test may take time. This is ok for
a one-off search, but it's tedious for regular usages.

Yes, I could wrap this up in a shell script, but I guess there are
caveats that I didn't think of when the history isn't linear. Maybe
someone even already has, and I'm unaware of that. But it feels like
this could be a proper git bisect feature, and a very useful one.
