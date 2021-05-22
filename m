Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE81C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 17:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBAD61132
	for <git@archiver.kernel.org>; Sat, 22 May 2021 17:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhEVROP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 13:14:15 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:46559 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231250AbhEVROP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 13:14:15 -0400
Received: from host-92-1-139-132.as13285.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lkVBB-00061E-Ay; Sat, 22 May 2021 18:12:49 +0100
Subject: Re: fast forward merge overwriting my code
To:     Andre Ulrich <andre.ulrich@smail.fh-koeln.de>, git@vger.kernel.org
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <8f3d4d1e-18f4-ccb2-9439-80a5812c2f36@iee.email>
Date:   Sat, 22 May 2021 18:12:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/05/2021 16:48, Andre Ulrich wrote:
>
> Hello community,
>
> I am new to git, and at the moment I am learning the basics. There are
> loads of good videos on the internet, but I have one specific
> question, I haven't found the answer yet:
>
> Let's say I have a .txt file on my master branch. I used
>
> git add .
>
> and
>
> git commit -m "blabla"
>
> so everything is staged and in the history. Now I check out a new branch
>
> git checkout -b testing
>
> and edit the .txt file. I add some new lines at the end, but I also
> change some of the already existing lines. Then again I add and commit
> everything. Then I use
>
> git checkout master
>
> and
>
> git merge testing
>
> I would expect git to tell me "hey, wait, you have changed some of the
> first lines in the .txt file. When you merge, your code on master will
> be altered". But git just merges everything in.
> Just imagine this was working code, and changing some of the first
> lines breaks everything in the following lines.
> I think I have found out what is the problem: git considers this a
> fast forward merge (since there were no commits on master between the
> creation and the merging of the test branch).

maybe `git merge --no-ff testing` for use of a command line option

or setup your .gitconfig e.g. `git config --global merge.ff no`,
but also `git config --global pull.ff yes` if you are using `git pull`
(=fetch + merge)

As always, check the manual to ensure understanding.

> But this is annoying. I want to be able to choose, what changes I want
> to keep, when I do the merge (just as in case of a 3way merge, when
> you can call a graphical merge tool to decide what lines to keep).
> I know, I could git diff the latest commits hashes of both branches
> and then fix the file on testing branch accordingly. But those are two
> separate steps, and I want everything to happen in one convenient step.
>
> Is there any possibility to do so?
>
> Many thanks for any help in advance!
> Many greetings
> André Ulrich
Philip
