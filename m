From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: How can I do an automatic stash when doing a checkout?
Date: Mon, 19 Dec 2011 17:18:18 +0100
Message-ID: <4EEF63CA.4030201@dirk.my1.cc>
References: <jcki8u$oip$1@dough.gmane.org> <84ty4ycdcc.fsf@cenderis.demon.co.uk> <jckvpk$i8v$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: DeMarcus <demarcus@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 17:21:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcfxu-0001EL-J3
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 17:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206Ab1LSQVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 11:21:21 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:60309 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab1LSQVU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 11:21:20 -0500
Received: from [84.176.42.34] (helo=[192.168.2.100])
	by smtprelay04.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Rcfus-0002FR-Ug; Mon, 19 Dec 2011 17:18:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <jckvpk$i8v$1@dough.gmane.org>
X-Df-Sender: NzU3NjQ2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187456>

Am 18.12.2011 16:10 schrieb DeMarcus:
[...]

>>> With the git stash command I can clean the directory the way I want
>>> but the stash command is not connected to a particular branch.
>>>
>>> Is there a way to have git checkout do an automatic stash when doing a
>>> checkout to another branch, and then do an automatic git stash apply
>>> with the correct stash when changing back to the previous branch
>>> again?
>>
>> You probably don't want to use stash. Just commit whatever partial work
>> you've done.
>>
> 
> It feels strange doing a commit of partial work. Some of the files may
> not even be supposed to be checked in.
> 
>> You could also just checkout different branches in different
>> directories. Nothing wrong with doing that in git.
>>
> 
> Ok thanks, that would give me the same behavior as I have today.
> 
> However, I can see some benefits with have everything in the same
> directory as git allows compared to other VCSs. And since the stashing
> feature is already there in git, it would be nice if the git checkout
> with some flag could use stashing automatically.
> 
> 

DeMarcus,

probably a post-checkout hook could help you with autostashing, but that
would need some scripting. Have a look at "git hooks --help".
I sometimes use such a hook to auto-update submodules when checking out
a branch. To be fair: I don't know how to identify the "right" stash then.

And also have a look at the script "git-new-workdir". It comes with git
but in some contrib directory or so. It's not in the $PATH by default.
It allows different working dirs for different branches; some of my
co-workers use it and like it. It won't work with Windows, I guess,
because it makes use of symlinks.

    Dirk
