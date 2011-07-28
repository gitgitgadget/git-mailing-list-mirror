From: Luke Diamand <luke@diamand.org>
Subject: Re: the standard hotfix from production scenario not working for
 me in git...
Date: Thu, 28 Jul 2011 20:14:37 +0100
Message-ID: <4E31B51D.2080208@diamand.org>
References: <1311874508381-6630648.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: deanhiller <dhiller@ghx.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 21:15:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmW33-0001em-48
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 21:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606Ab1G1TNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 15:13:52 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63992 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485Ab1G1TNu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 15:13:50 -0400
Received: by wwe5 with SMTP id 5so2824506wwe.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 12:13:49 -0700 (PDT)
Received: by 10.227.142.141 with SMTP id q13mr414266wbu.114.1311880429495;
        Thu, 28 Jul 2011 12:13:49 -0700 (PDT)
Received: from [192.168.1.12] (ANantes-156-1-25-131.w90-12.abo.wanadoo.fr [90.12.16.131])
        by mx.google.com with ESMTPS id em16sm1092500wbb.67.2011.07.28.12.13.48
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 12:13:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110626 Iceowl/1.0b2 Icedove/3.1.11
In-Reply-To: <1311874508381-6630648.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178107>

On 28/07/11 18:35, deanhiller wrote:
> I am doing the typical scenario and have tried much of the documentation but
> must be getting something wrong.  I want to do something exactly like
> this...
>
> context: I am on branchBigFeature and a production hot fix comes in.  I
> would like to

0. Would it help to use 'git status' to make sure that you don't have 
untracked flies kicking around?

> 1. git stash --ALL_including_untracked_Files
> 2. git checkout master
> 3. git checkout -b newHotfix145

Can you just do 'git checkout -b newHitfix145 master' ?

> 4. work on hotfix, fix it
> 5. git addANDrm * (is there a way to do this??????)  I don't want to have to
> git rm each file to remove!!! or can I do git rm * ....does that work or
> will that delete everything....ugh.  Better yet, is there a way to git
> commit --skipStaging --includeUntrackedFiles --autoDeleteTheDeletions,
> ie...basically any change in the view I want applied(unless files are in
> .gitignore of course)
> 5. git checkout master
> 6. git merge newHotfix145
> 7. git push
> 8. git checkout branchBigFeature
> 9. git stash pop
> and I am back to seeing all my untracked files.
>
> I tried to do this with commit INSTEAD of stash like so but it failed
> miserably.  I basically tried commit instead of stash and then to get the
> files back to untracked, unversioned on the branchBigFeature, I used git
> revert HEAD and this reverted everything but then it was all in the staging
> area...maybe there is one more command I need to get it from the staging
> area.

Personally I would try to avoid having untracked files around, but maybe 
that's just me.
>
> and one last question, I 90% of the time want to apply all unstaged files
> deletes, adds, modifies...is there just one command I can use like git
> commit * --skipstaging or something.  I have been burned too many times by
> the build works with ALL the changes and then missing a checkin so I prefer
> to check it all in every time and stay in that habit.

I usually find I only have a few untracked files at any given time 
(after all, how fast can most people create new code?) so just keeping 
them tracked isn't a problem. Then 'git commit -a' will do the right 
thing won't it?

Luke
