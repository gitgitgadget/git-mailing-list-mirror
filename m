Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0655AC04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 06:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A1360241
	for <git@archiver.kernel.org>; Mon, 24 May 2021 06:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhEXGP0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 02:15:26 -0400
Received: from lvs-smtpgate3.nz.FH-Koeln.DE ([139.6.1.49]:30831 "EHLO
        lvs-smtpgate3.nz.fh-koeln.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229733AbhEXGPZ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 May 2021 02:15:25 -0400
IronPort-SDR: DIVNvf6maUEdXflUwTfH/WG5NSAJJEJoG/JQbYsAA3IzWlkdui/WnEaEqios/TqjOmhA3Sum3w
 OF4VVUYearzsZvYZXTiaKl5Lc0C7ndGL/wycvnhMZ1DVITgpGCVNA7QP0PlnhFTZ7V3a3EyooX
 rOjT4IZAgbdTP59O9kB8ZAzUVkOjnPhDtO7x4XinIMP3C6qlDOB6+m7GBRDZkzdE6HgaSVY+Cq
 0xmnnmKHYEEObr5Elq0mn3Sl6QJsD1ag8KgJyjYVu/XdLnBRDS5Y4PPpJNhB3o2GcsaTH+xHkX
 VaW8qCEt+xcFYYleF3ZCGdMG
Received: from lvs-wm2.nz.fh-koeln.de (HELO lvs-wm0.nz.fh-koeln.de) ([139.6.1.39])
  by smtp.intranet.fh-koeln.de with ESMTP/TLS/ECDHE-RSA-AES128-SHA; 24 May 2021 08:13:56 +0200
Received: from p5de2bc2b.dip0.t-ipconnect.de (p5de2bc2b.dip0.t-ipconnect.de
 [93.226.188.43]) by webmail.th-koeln.de (Horde Framework) with HTTPS; Mon,
 24 May 2021 06:13:55 +0000
Date:   Mon, 24 May 2021 06:13:55 +0000
Message-ID: <20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de>
From:   Andre Ulrich <andre.ulrich@smail.fh-koeln.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: fast forward merge overwriting my code
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
 <4c1c3dbc-7a89-02db-3883-b7eea644cd83@kdbg.org>
 <YKrsC9CaG/KDvDBi@camp.crustytoothpaste.net>
In-Reply-To: <YKrsC9CaG/KDvDBi@camp.crustytoothpaste.net>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everybody, thanks for your help, I really appreciate it!

What I have described was only an abstract example, because I did not  
want to bother you with the whole story. I will try to explain my  
actual situation:
- first: there is no txt. file, it is jupyter notebooks (.ipynb) and  
they are not only about programming, there are also lots of markdown
- second: I am working with my professor over GitLab and I look for  
options to further improve these notebooks
- third: I have to develope a nice GitLab workflow

I know, diffing and merging of notebooks is another story (but we can  
handle that with nbdime).
And I know, there are lots of guides on git workflows on the internet  
(and that is pretty much just what I have adopted).

So this is how we proceed:
- my prof has a repo on GitHub
- I have forked the repo
- I have cloned the forked repo
- I have created a branch 'update' in my local clone
- I edit a notebook on the branch 'update' and commit
- I push 'update' to my forked repo on GitHub
- I create a merge request
- my prof reviews the changes and accepts them (if I have done  
acceptable work)

So the last point is where we still want to do some fine tuning. Right  
now this looks about: my prof fetches my edits and locally checks out  
a branch to compare the changes with git diff.
But in this diff view you can't edit the files. So you have to  
separately open up another window to edit the changes (lets say my  
prof only wants to keep some of my changes, but not all).

So my Question is: is there any possibility, to be able to view (and  
even edit, if necessary) the changed notebook in the merging process  
(as in my example with the 3way merge)?
Or is the only option to separately view the diff and edit the  
notebook (two seperate steps instead of one)?

The latter would also be acceptable, if it really is the only way. Bu  
it would be nice, if viewing and editing could be done in one  
convenient step during merging.

Many greetings
André Ulrich


Zitat von "brian m. carlson" <sandals@crustytoothpaste.net>:

> On 2021-05-23 at 09:48:55, Johannes Sixt wrote:
>> [resending, as I forgot to include git@vger]
>>
>> Am 22.05.21 um 17:48 schrieb Andre Ulrich:
>> > Let's say I have a .txt file on my master branch. I used
>> >
>> > git add .
>> >
>> > and
>> >
>> > git commit -m "blabla"
>> >
>> > so everything is staged and in the history. Now I check out a new branch
>> >
>> > git checkout -b testing
>> >
>> > and edit the .txt file. I add some new lines at the end, but I also
>> > change some of the already existing lines. Then again I add and commit
>> > everything. Then I use
>> >
>> > git checkout master
>> >
>> > and
>> >
>> > git merge testing
>> >
>> > I would expect git to tell me "hey, wait, you have changed some of the
>> > first lines in the .txt file. When you merge, your code on master will
>> > be altered". But git just merges everything in.
>> > Just imagine this was working code, and changing some of the first lines
>> > breaks everything in the following lines.
>> > I think I have found out what is the problem: git considers this a fast
>> > forward merge (since there were no commits on master between the
>> > creation and the merging of the test branch).
>
> Yes.  However, if Git did an actual merge, the result would be the same.
> In a three-way merge, if one side changes, and the other does not, the
> change is adopted.  A fast-forward merge just avoids the merge commit.
>
>> > But this is annoying. I want to be able to choose, what changes I want
>> > to keep, when I do the merge (just as in case of a 3way merge, when you
>> > can call a graphical merge tool to decide what lines to keep).
>>
>> But in a 3-way merge, you only get to choose which changes you take if
>> there is a conflict. If, in your example, you had committed a change to
>> a different file on master before the merge, you would get a
>> non-fast-forward (3-way) merge, and still no opportunity to choose which
>> changes you take because there would be no conflict.
>>
>> And why do you think we need a general warning "when you merge, your
>> code on master will be altered"? Why would I want to make a merge into
>> master if not to change the code on master?
>
> I suspect Andre has a goal here or a specific use case that we're not
> understanding.  If we got some more explanation about what's going on,
> we could probably offer a more useful response addressing that specific
> use case or goal.  It might not be a use case we support, but at least
> we could address it directly.
> --
> brian m. carlson (he/him or they/them)
> Houston, Texas, US


-- 
**********************************************************************
**  Fachhochschule Koeln / Cologne University of Applied Sciences
**
**  Andre Ulrich
**  E-Mail: andre.ulrich@smail.fh-koeln.de
**********************************************************************

