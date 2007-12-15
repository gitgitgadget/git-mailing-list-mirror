From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git merge --no-commit <branch>; does commit
Date: Sat, 15 Dec 2007 11:18:07 -0800 (PST)
Message-ID: <m37ijfrcm5.fsf@roke.D-201>
References: <alpine.LSU.0.99999.0712132151080.5326@castor.milkiway.cos>
	<81b0412b0712131319h63609810m593f0e552d02a83c@mail.gmail.com>
	<alpine.LSU.0.99999.0712132224280.5606@castor.milkiway.cos>
	<20071214074925.GA3525@steel.home>
	<alpine.LSU.0.99999.0712151905280.4341@castor.milkiway.cos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Sat Dec 15 20:18:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3cX6-0003wn-AS
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 20:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404AbXLOTSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 14:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755705AbXLOTSL
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 14:18:11 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:48568 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545AbXLOTSK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 14:18:10 -0500
Received: by fg-out-1718.google.com with SMTP id e21so90657fga.17
        for <git@vger.kernel.org>; Sat, 15 Dec 2007 11:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=FH75EBqPOdesCY1xJZRv5oY0tbrpn0dQD/6gGlHgI1Q=;
        b=xJ7VGnS0Z0nR7Nfc3KVwT32j9tuqCF/URYklyVUcA/dGjTbcBwUaIDtEUfa88IuYRuxxECrIajJMZRO9vIpkMae+quUUdQRSMWtCJpoS+/eenHTJWnYx2z5l7iu+sJyGsE7QsoF3QgIoZO/Wnf+1PKDNfJYdCsQ9AiQspFMuN2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=paH6DSu/N822tENqipKGilmVfLuCT0vx+LWL1YuWvAOT3QejrDiOPwsAlyQM0nxeo6rDZFR3N/ENqMNVhZ+xDs/CErKI/9lmF8aPBfzdGTcJ8HldFZWD0V1TWnkOC8sGaMrCAADVZ7hs8NGaG4/YpyPlRdlejtvdAFAe7bfF8VA=
Received: by 10.86.99.9 with SMTP id w9mr4465550fgb.44.1197746288117;
        Sat, 15 Dec 2007 11:18:08 -0800 (PST)
Received: from roke.D-201 ( [83.8.240.142])
        by mx.google.com with ESMTPS id d4sm7427805fga.2007.12.15.11.18.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Dec 2007 11:18:07 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBFJHujr023166;
	Sat, 15 Dec 2007 20:17:57 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lBFJHt3T023163;
	Sat, 15 Dec 2007 20:17:55 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <alpine.LSU.0.99999.0712151905280.4341@castor.milkiway.cos>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68406>

Michael Dressel <MichaelTiloDressel@t-online.de> writes:

> On Fri, 14 Dec 2007, Alex Riesen wrote:
> 
>> Michael Dressel, Thu, Dec 13, 2007 22:28:30 +0100:
>>> On Thu, 13 Dec 2007, Alex Riesen wrote:
>>>> On 13/12/2007, Michael Dressel wrote:
>>>>> git merge --no-commit <branch> does "create" a commit. At lesat the
>>>>> head and index are moved to the new commit fetched from <branch>. Maybe
>>>>> that is because git was able to do a fast forward?
>>>>
>>>> Yes. Because fast-forward is what it called: fast-forward.
>>>> It does not do any commits at all.
>>>>
>>>
>>> It looks like I misunderstood the meaning of --no-commit. I have to use
>>> --squash in this case.
>>>
>>
>> Maybe. Or maybe you misunderstood the meaning of --squash, which also
>> is not a merge.
> 
> Since "git merge --squash <branch>" does a merge of <branch> into the
> working tree why would you not call it a merge?

A few illustrations. Commits A, B, C were made on 'trunk', commits
a, b, c were made on 'branch'. You are on 'trunk', running 
"git merge <options> branch". We assume that there are no conflicts.

1. A non fast-forward case

   1---2---3---A---B---C   <-- trunk    <-- HEAD
            \
             \-a---b---c   <-- branch

1.1. "git merge branch"

   1---2---3---A---B---C--M   <-- trunk  <-- HEAD
            \            /
             \-a---b---c/     <-- branch

M is _merge_ commits, with two parents: C and c. It was created
by "git merge branch".

1.2. "git merge --no-commit branch"

                        /-------- trunk  <-- HEAD
                       v
   1---2---3---A---B---C--*
            \            /
             \-a---b---c/     <-- branch
                       ^                           
                        \-------- MERGE_HEAD

The merge commit '*' is prepared, but not yet committed, just
as if there were merge conflict during merge. "git commit"
would commit a merge (and would tell you that it does a merge
commit).

1.3. "git merge --no-commit --no-ff branch"

Like in 1.2, because it is non fast-forward case.

1.4. "git merge --squash branch"

   1---2---3---A---B---C--[abc]'   <-- trunk <-- HEAD
            \
             \-a---b---c           <-- branch

"[abc]'" is a _single parent_ commit (it is not a merge commit!)
which incorporates changes made on branch as if it were made in
a single, large (!) commit.

1.5. "git rebase trunk branch" (or "git pull --rebase branch")

   1---2---3---A---B---C              <-- trunk    
                        \
                         \-a'--b'--c' <-- branch  <-- HEAD

Rebase is step-by-step process, replying commits a, b, c on top
of trunk, trying for the same _changes_. a', b', c' are newly
created commits, introducing the same changes as a, b, c if there
were no rebase conflicts.

I think that "git pull --rebase branch" goes a step further and
actually does after-rebase fast-forward merge, and does not change
branch, but I might be mistaken.

   1---2---3---A---B---C---a'--b'--c'  <-- trunk <-- HEAD
            \
             \-a---b---c               <-- branch


2. Fast forward case; there are no commits A, B, C, and we
start from the following situation:

   1---2---3               <-- trunk    <-- HEAD
            \
             \-a---b---c   <-- branch

2.1. "git merge branch"

   1---2---3            /----- trunk    <-- HEAD
            \          v
             \-a---b---c   <-- branch

Fast forward results in simply moving the head of trunk.
It does not create a commit, hence:

2.2. "git merge --no-commit branch"

Like in 2.1, because fast-forwarding does not create a commit.

2.3. "git merge --no-commit --no-ff branch"

   1---2---3               <-- trunk    <-- HEAD
            \
             \-a---b---c   <-- branch

(probably with some error message).


Test of understanding the concepts: what does 
"git merge --squash --no-commit" does?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
