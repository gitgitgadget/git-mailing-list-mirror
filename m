From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: put THEIR commits AFTER my commits with a single rebase command
Date: Thu, 18 Apr 2013 13:03:10 +0200
Message-ID: <516FD2EE.4040300@viscovery.net>
References: <1928280357.20130418091807@gmail.com> <516F9329.4060405@viscovery.net> <1949082828.20130418123321@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 13:03:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USmcb-0004Di-42
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 13:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967406Ab3DRLDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 07:03:17 -0400
Received: from so.liwest.at ([212.33.55.23]:64991 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967271Ab3DRLDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 07:03:16 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1USmcR-0000Xa-Bo; Thu, 18 Apr 2013 13:03:11 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1CAE21660F;
	Thu, 18 Apr 2013 13:03:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <1949082828.20130418123321@gmail.com>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221648>

Am 4/18/2013 10:33, schrieb Ilya Basin:
> 
> JS> Perhaps this one:
> 
> JS>    git merge origin/master
> JS>    git rebase ORIG_HEAD
> 
> JS> -- Hannes
> 
> Wouldn't I have to resolve conflicts twice?

Yes. But you did run 'git config rerere.enabled true' when you started
with git, didn't you? ;-)

Anyway, Johan's idea to use git cherry-pick is much better.

> BTW, during the rebase, can I tell git to rewrite a different branch
> upon rebase success or abort?
> 
>     git branch -f tmp origin/master
>     git rebase --onto master master tmp
>     if [ $? -ne 0 ]; then
>        # modify some file in .git/ ?

What do you expect here? Failure of git rebase means that it is not
complete, yet. So far, nothing has been rewritten. So what? Perhaps you mean:
	# never mind
	git rebase --abort

>     else
>         git branch -f master
>         git checkout master
>     fi

-- Hannes
