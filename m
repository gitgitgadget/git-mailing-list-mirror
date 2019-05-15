Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 117511F461
	for <e@80x24.org>; Wed, 15 May 2019 08:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfEOIpS (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 04:45:18 -0400
Received: from mx3.uni-regensburg.de ([194.94.157.148]:53724 "EHLO
        mx3.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfEOIpS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 04:45:18 -0400
Received: from mx3.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 0692B600005F
        for <git@vger.kernel.org>; Wed, 15 May 2019 10:45:15 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx3.uni-regensburg.de (Postfix) with ESMTP id C28F3600004D
        for <git@vger.kernel.org>; Wed, 15 May 2019 10:45:14 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Wed, 15 May 2019 10:45:14 +0200
Message-Id: <5CDBD199020000A10003136F@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Wed, 15 May 2019 10:45:13 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <philipoakley@iee.org>, <git@vger.kernel.org>
Subject: Re: Antw: Re: Missing branches after clone
References: <5CDA8D37020000A100031319@gwsmtp.uni-regensburg.de>
 <CACsJy8AX9Wp3W=d1=ozF9nZXGE1muooMf7fKCtdOOi1g8QRmig@mail.gmail.com>
 <0c9ec78a-9245-e1df-7ec6-a5d77d1a5261@iee.org>
 <5CDAAB56020000A100031334@gwsmtp.uni-regensburg.de>
 <b75bd892-b216-3c7d-f9e7-4470300e02fc@iee.org>
In-Reply-To: <b75bd892-b216-3c7d-f9e7-4470300e02fc@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Philip Oakley <philipoakley@iee.org> schrieb am 15.05.2019 um 09:34 in
Nachricht <b75bd892-b216-3c7d-f9e7-4470300e02fc@iee.org>:
> On 14/05/2019 12:49, Ulrich Windl wrote:
>> Hi!
>>
>> The confusing part actually is for me:
>> "git clone" does NOT "Clone a repository into a new directory", but "clone

> the current branch into a new directory" (IMHO).
>> So I was surprised that I couldn't merge branches under the same name in
the 
> cloned "repository".
>> Only "git clone --bare" actually seems to clone "the repository".
>> I think this is very confusing to new users. At least I didn't quite get
the 
> reasoning for that.
> It's that you are missing the idea behind the "Branches that track the 
> remote", which are local copies, but not YOUR branches. see below.
> I clone the GitHub test repo. I get (a copy of) it all (the rtb's). Git 
> _creates_ a local branch 'master' for me. Git checks out the lead remote 
> branch into it. Command prompt returns. I cd into the new repo. I ask 
> what branches _I_ have - just 'master'. I ask about all the branches the 
> repo has - voila, I see all those rtb's in _my_ repo. They are all 
> perfectly valid branch refs.

Yes, I can mostly follow you there with one exception: In the cloned
repository the branches are not available under the same name as in the
original repository (unless I'm totally confused). Therefore a beginner would
simply assume "they are missing".
I knew that (which was my use case) git optimizes local copies by linking as
much as possible, but I don't understand why cloned branches are "soooo
complicated". (I could understand it as an optimization for network copies)

> 
> It will take a little while to appreciate this extra layer and how to 
> use it, and how Git can 'dwim' (do what I mean) the usage of shortened 
> refs and branch names, so it you try checking out 'change-the-title', 
> git will know to fall back to using the rtb if you haven't created a 
> local version.
> Hope That Helps.
> Philip
> 
> phili@Philip-Win10 MINGW64 / (master)
> $ cd usr/src
> 
> phili@Philip-Win10 MINGW64 /usr/src (master)
> $ git clone https://github.com/octocat/Spoon-Knife.git 
> Cloning into 'Spoon-Knife'...
> remote: Enumerating objects: 16, done.
> remote: Total 16 (delta 0), reused 0 (delta 0), pack-reused 16
> Unpacking objects: 100% (16/16), done.
> 
> phili@Philip-Win10 MINGW64 /usr/src (master)
> $ cd Spoon-Knife/
> 
> phili@Philip-Win10 MINGW64 /usr/src/Spoon-Knife (master)
> $ git branch
> * master
> 
> phili@Philip-Win10 MINGW64 /usr/src/Spoon-Knife (master)
> $ git branch -a
> * master
>    remotes/origin/HEAD -> origin/master
>    remotes/origin/change-the-title
>    remotes/origin/master
>    remotes/origin/test-branch
> 
> phili@Philip-Win10 MINGW64 /usr/src/Spoon-Knife (master)
> $
> 
> --
> PS What change to the [clone?] man page would have helped you here?

Maybe confirm this: At this state I could "checkout test-branch" (for
example), but I could not "merge test-branch", right?
(Another level of confusion is bash-completion which does not know those
hidden branches)

OK, reading git-clone again, the following might apply:
Explain (or refer to) what a "remote-tracking branch" is.

"checks out an initial branch that is forked from the cloned repository’s
currently active branch" could be simplified to "checks out the active branch
in the cloned repository"?

Maybe add a paragraph at the end of the DESCRIPTION starting like: "To use
another branch in the clones repository..."

Maybe also add a pointer to the meanings of "origin" and "remote" (I know that
the clone source becomes remote/origin)

I wonder whether "This default configuration is achieved by creating
references to the
remote branch heads under refs/remotes/origin and by initializing
remote.origin.url and remote.origin.fetch configuration variables." should
become "The original repository's URL will be visible as remote/origin in the
cloned reporitory"

Maybe point out the differences between a "default clone" mand a "--mirror
clone" in the DESCRIPTION.

The example "Clone from upstream while borrowing from an existing local
directory:" could benefit from a few explaining words (why would one want to do
that, i.e. what's the effect?)

None of the examples refers to using another branch than the default branch.
Maybe add two examples:
1: checking out a different branch, 2:merging a different branch to the
current one

That's what I think.

Regards,
Ulrich


> 
>>> Philip Oakley <philipoakley@iee.org> schrieb am 14.05.2019 um 12:33 in
>> Nachricht <0c9ec78a-9245-e1df-7ec6-a5d77d1a5261@iee.org>:
>>> Hi Ulrich,
>>> On 14/05/2019 11:12, Duy Nguyen wrote:
>>>>> Then I
>>> 
>
foundhttps://stackoverflow.com/questions/10312521/how-to-fetch-all-git-branch
>>> es  which handles the subject...
>>>>> But still the most common solution there still looks like an ugly hack.
>>>>> Thus I suggest to improve the man-pages (unless done already)
>>>> Yeah I expected to see at least some definition of remote-tracking
>>>> branches (vs local ones) but I didn't see one. Room for improvement.
>>> Yes, the 'remote tracking branch' name [RTB] is very 'French' in its
>>> backwardness (see NATO/OTAN).
>>>
>>> It is a 'branch which tracks a remote', and it is has the 'last time I
>>> looked' state of the branch that is on the remote server, which may
>>> have, by now, advanced or changed.
>>>
>>> So you need to have the three distinct views in your head of 'My branch,
>>> held locally', 'my copy of Their branch, from when I last looked', and
>>> 'Their branch, on a remote server, in a state I haven't seen recently'.
>>>
>>> Finding a better name for the "RTB", one with an easier cognitive load
>>> for those trying to understand Git, would be an improvement.
>>>
>>> Though there has been a similar issue with 'staging the index'.
>>> Ultimately it is a new way of thinking about artefacts (perfect
>>> duplicates, no originals, no master, no copies, just verification
>>> hashes) so needs new terms and a difficult learning experience.
>>> -- 
>>> Philip
>>
>>
>>



