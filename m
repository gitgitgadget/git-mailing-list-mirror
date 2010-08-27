From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: git pull --rebase differs in behavior from git fetch +
 git rebase
Date: Fri, 27 Aug 2010 09:48:48 -0600
Message-ID: <4C77DE60.6020809@workspacewhiz.com>
References: <4C772A01.5030207@workspacewhiz.com> <alpine.DEB.2.00.1008270124450.20874@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 17:48:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op1Am-0004Mf-LL
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 17:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327Ab0H0Psv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 11:48:51 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:56041 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab0H0Pst (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 11:48:49 -0400
Received: (qmail 19257 invoked by uid 399); 27 Aug 2010 09:48:48 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.220.190.236)
  by hsmail.qwknetllc.com with ESMTPAM; 27 Aug 2010 09:48:48 -0600
X-Originating-IP: 75.220.190.236
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
In-Reply-To: <alpine.DEB.2.00.1008270124450.20874@narbuckle.genericorp.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154603>

  ----- Original Message -----
From: Dave Olszewski
Date: 8/27/2010 2:27 AM
> On Thu, 26 Aug 2010, Joshua Jensen wrote:
>
>> I have a case where 'git pull --rebase' does not do the Right Thing 
>> (according to me).
>>
>> If I run 'git rebase origin/master', that rebase does the right 
>> thing, perfectly reapplying my *single* commit on top of the upstream.
>>
>> 'git pull --rebase' ends up reapplying a bunch of much earlier 
>> commits and ends up with a conflict.
>>
>> The documentation for git pull --rebase states: "Instead of a merge, 
>> perform a rebase after fetching. If there is a remote ref for the 
>> upstream branch, and this branch was rebased since last fetched, the 
>> rebase uses that information to avoid rebasing non-local changes."  I 
>> do not understand
>>
>> I'm studying the git-pull script right now, but I have to admit this 
>> is beyond me.  I'm sure if I stare hard enough, I'll get it.
>>
>> I mistakenly have assumed 'git pull' = 'git fetch; git merge' and 
>> that 'git pull --rebase' = 'git fetch; git rebase'.  Does anyone want 
>> to clarify what is really going on?  Unfortunately, I can't publish 
>> the repository in question.
>
> Are you by any chance running a git with commit cf65426de?  If not, give
> it a try and see if it corrects your issue.
I was not, but now I am.
> The main difference between "git pull --rebase" and "git fetch && git
> rebase @{u}" is that "git pull --rebase" will attempt to use the reflog
> to find a suitable "upstream" candidate instead of assuming your
> tracking branch is the upstream itself.  This is intended to help
> recover from upstream rebases, but has adverse effects sometimes, which
> commit cf65426de should help with.
Unfortunately, commit cf65426de helps only a little.  The 'git pull 
--rebase' reports "Nothing to do" and moves the master branch to 
origin/master, leaving behind the commit needing to be rebased.

What else might there be to try?  I would like to help with a repro, if 
possible.

Josh
