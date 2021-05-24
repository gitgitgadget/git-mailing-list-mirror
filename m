Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81248C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 13:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5667261260
	for <git@archiver.kernel.org>; Mon, 24 May 2021 13:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhEXNSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 09:18:20 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:33918 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232401AbhEXNSU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 09:18:20 -0400
Received: from host-92-1-139-132.as13285.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1llARu-0009Gd-89; Mon, 24 May 2021 14:16:51 +0100
Subject: Re: fast forward merge overwriting my code
To:     Andre Ulrich <andre.ulrich@smail.fh-koeln.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
 <4c1c3dbc-7a89-02db-3883-b7eea644cd83@kdbg.org>
 <YKrsC9CaG/KDvDBi@camp.crustytoothpaste.net>
 <20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <e02cabf0-adb6-49bb-b379-b12f37ca6e1a@iee.email>
Date:   Mon, 24 May 2021 14:16:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi André, In-line and bottom posting is preferred.

On 24/05/2021 07:13, Andre Ulrich wrote:
> Hello everybody, thanks for your help, I really appreciate it!
>
> What I have described was only an abstract example, because I did not
> want to bother you with the whole story. I will try to explain my
> actual situation:
> - first: there is no txt. file, it is jupyter notebooks (.ipynb) and
> they are not only about programming, there are also lots of markdown
I've not used jupyter notebooks so below is more about the general process..

> - second: I am working with my professor over GitLab and I look for
> options to further improve these notebooks
> - third: I have to develope a nice GitLab workflow
GiLab noted here
>
> I know, diffing and merging of notebooks is another story (but we can
> handle that with nbdime).
> And I know, there are lots of guides on git workflows on the internet
> (and that is pretty much just what I have adopted).
>
> So this is how we proceed:
> - my prof has a repo on GitHub
but GitHub here..
> - I have forked the repo
> - I have cloned the forked repo
> - I have created a branch 'update' in my local clone
> - I edit a notebook on the branch 'update' and commit
> - I push 'update' to my forked repo on GitHub
> - I create a merge request

So this is using the on-line web UI?

There is some contention between the GitHub/GitLab pull/merge request
process (on-line) and the local command line (cli) approach to merging
as they can be at cross-purposes...

Most earlier responses have been about using the command line rather
than the web-UI.

The Git-for-Windows (GfW) development does use the GitHub PR approach,
leveraging the email notifications, and the ability (of the developer,
in response to maintainer comments) to force push an updated branch
(i.e. using the same branch name) to re-run the approval and on-line
merging.

> - my prof reviews the changes and accepts them (if I have done
> acceptable work)
i.e. the PR was/will be taken verbatim, (or with minor amendments if the
prof is the maintainer and you've allowed that), at least on GitHub..
>
> So the last point is where we still want to do some fine tuning. Right
> now this looks about: my prof fetches my edits and locally checks out
> a branch to compare the changes with git diff.
> But in this diff view you can't edit the files. 
Hmm, do you mean the prof is viewing your changes in the diff-view of
the web-UI? (likely as that's the notification link;-).
You/The prof can switch to views with more context if needed.

If the prof has truly fetched the branch from your remote e.g.
"Ulrich/testing" it can be checked out locally as a detached head for
testing, local changes made, etc, and then the prof can either create a
fresh branch to hold those comments, and push them to a place you can
see, or directly make the edits on the web-UI.

Often in the GfW PR reviews the comments are made via the web-UI, with
code suggestions, and the developer than updates & tests their local
branch, and force pushes the update for a follow up review.

> So you have to separately open up another window to edit the changes
> (lets say my prof only wants to keep some of my changes, but not all).
>
> So my Question is: is there any possibility, to be able to view (and
> even edit, if necessary) the changed notebook in the merging process
> (as in my example with the 3way merge)?

I'm not aware of such a mechanism (as simply described) but I'm sure
there are ways to use the "staging area" view (e.g. via the Git-gui) to
selectively pick out hunks and lines that are staged (and non-selected
hunk/lines stashed) to give a testable worktree during the 'merge'.
Merge is commonly seen/discussed as a single continuous step, rather
than being a fully uninterruptible process.

> Or is the only option to separately view the diff and edit the
> notebook (two seperate steps instead of one)?
>
> The latter would also be acceptable, if it really is the only way. Bu
> it would be nice, if viewing and editing could be done in one
> convenient step during merging.

The key here is probably to clarify which parts are being done on the
server's web-UI, and which parts are from a local fetch/checkout viewpoint.

Philip

>
> Many greetings
> André Ulrich
>
>
> Zitat von "brian m. carlson" <sandals@crustytoothpaste.net>:
>
>> On 2021-05-23 at 09:48:55, Johannes Sixt wrote:
>>> [resending, as I forgot to include git@vger]
>>>
>>> Am 22.05.21 um 17:48 schrieb Andre Ulrich:
>>> > Let's say I have a .txt file on my master branch. I used
>>> >
>>> > git add .
>>> >
>>> > and
>>> >
>>> > git commit -m "blabla"
>>> >
>>> > so everything is staged and in the history. Now I check out a new
>>> branch
>>> >
>>> > git checkout -b testing
>>> >
>>> > and edit the .txt file. I add some new lines at the end, but I also
>>> > change some of the already existing lines. Then again I add and
>>> commit
>>> > everything. Then I use
>>> >
>>> > git checkout master
>>> >
>>> > and
>>> >
>>> > git merge testing
>>> >
>>> > I would expect git to tell me "hey, wait, you have changed some of
>>> the
>>> > first lines in the .txt file. When you merge, your code on master
>>> will
>>> > be altered". But git just merges everything in.
>>> > Just imagine this was working code, and changing some of the first
>>> lines
>>> > breaks everything in the following lines.
>>> > I think I have found out what is the problem: git considers this a
>>> fast
>>> > forward merge (since there were no commits on master between the
>>> > creation and the merging of the test branch).
>>
>> Yes.  However, if Git did an actual merge, the result would be the same.
>> In a three-way merge, if one side changes, and the other does not, the
>> change is adopted.  A fast-forward merge just avoids the merge commit.
>>
>>> > But this is annoying. I want to be able to choose, what changes I
>>> want
>>> > to keep, when I do the merge (just as in case of a 3way merge,
>>> when you
>>> > can call a graphical merge tool to decide what lines to keep).
>>>
>>> But in a 3-way merge, you only get to choose which changes you take if
>>> there is a conflict. If, in your example, you had committed a change to
>>> a different file on master before the merge, you would get a
>>> non-fast-forward (3-way) merge, and still no opportunity to choose
>>> which
>>> changes you take because there would be no conflict.
>>>
>>> And why do you think we need a general warning "when you merge, your
>>> code on master will be altered"? Why would I want to make a merge into
>>> master if not to change the code on master?
>>
>> I suspect Andre has a goal here or a specific use case that we're not
>> understanding.  If we got some more explanation about what's going on,
>> we could probably offer a more useful response addressing that specific
>> use case or goal.  It might not be a use case we support, but at least
>> we could address it directly.
>> -- 
>> brian m. carlson (he/him or they/them)
>> Houston, Texas, US
>
>

