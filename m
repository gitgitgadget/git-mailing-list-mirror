From: Robert Pollak <robert.pollak@jku.at>
Subject: Re: How to remove a git subtree and its history?
Date: Wed, 23 Mar 2011 10:01:40 +0100
Message-ID: <4D89B6F4.2050209@jku.at>
References: <4D88A1CB.2000500@jku.at> <AANLkTiktAUeOkX0MZh+JbQb1z-JiN=Qet6_AuWavsNk=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 10:01:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Jwr-0004bd-96
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 10:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289Ab1CWJBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 05:01:43 -0400
Received: from email.edvz.uni-linz.ac.at ([140.78.3.58]:56583 "EHLO
	email.uni-linz.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab1CWJBm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 05:01:42 -0400
Received: from [192.168.168.60] (unknown [140.78.223.2])
	by email.uni-linz.ac.at (Postfix) with ESMTP id DAF6CB890;
	Wed, 23 Mar 2011 10:01:40 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <AANLkTiktAUeOkX0MZh+JbQb1z-JiN=Qet6_AuWavsNk=@mail.gmail.com>
X-Enigmail-Version: 1.1.1
OpenPGP: id=ADDE9E08;
	url=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169805>

Am 22.03.2011 21:44, schrieb Avery Pennarun:
> On Tue, Mar 22, 2011 at 6:19 AM, Robert Pollak <robert.pollak@jku.at> wrote:
>> in the git repository of my project I have successfully replaced a git
>> submodule by a subtree, essentially by using
>>
>> $git subtree add --prefix=mySubtree mySubmodule/master
>>
>> with your git-subtree.sh .
>>
>> Before accepting my change, my project partners want to be sure that
>> removing this new subtree and its history at some later point in time
>> stays possible. How can I achieve this? I have unsuccessfully tried "git
>> filter-branch" as described by pgs and fmarc in
>> http://stackoverflow.com/questions/955793#955793 .
> 
> Well, you can certainly remove anything you want with git
> filter-branch.  Are you concerned about shrinking the size of your
> repo, or just getting files out of the way in your tree, or removing
> stuff from the git history?
> 
> If you want to avoid cluttering the git history, you should use git
> subtree with the --squash option.  That makes it quite painless.
> 
> If you want to just get the files out of your tree someday in the
> future (for example, to switch back to submodules), then simply 'git
> rm -r' the directory.  Rewriting history is massive overkill for this.
> 
> If you want to be able to shrink your repository size later, well,
> then you need git filter-branch.

Yes, I am aware of the other options and that's what I want to do.
(I never really want to use this, I only need a test run to convince my
partners to switch to git-subtree.)

> I've never tried to do this since
> the history rewrite you'd be doing in this case would completely
> invalidate all your old history: by removing the subtree in all past
> revisions, you make all those past revisions unbuildable, which seems
> like missing the point of version control.  Nevertheless, I'm sure you
> could make it happen if you wanted; you can do pretty much anything
> you want by filtering git history.

I see. As quite a git newbie I hoped you had done this already and could
help me with the necessary git filter-branch command line.

>> (Be free to CC git@vger.kernel.org if you reply, if you think that's
>> appropriate for archiving the info.)
> 
> I don't understand why you didn't cc: the git list yourself then.  But okay :)

I was not sure whether discussion of git-subtree belongs there, since it
is not part of git (yet?).

> Have fun,

I certainly do!

Thank you,
Robert
