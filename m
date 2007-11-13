From: Sergei Organov <osv@javad.com>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 18:39:15 +0300
Message-ID: <87ve86889o.fsf@osv.gnss.ru>
References: <874pfq9q8s.fsf@osv.gnss.ru> <fhcdpv$9u3$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 16:39:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irxrh-0002wn-T1
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 16:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560AbXKMPjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 10:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755344AbXKMPjY
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 10:39:24 -0500
Received: from javad.com ([216.122.176.236]:4260 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617AbXKMPjX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 10:39:23 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lADFdL022609;
	Tue, 13 Nov 2007 15:39:21 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Irxr9-0003NT-O0; Tue, 13 Nov 2007 18:39:15 +0300
In-Reply-To: <fhcdpv$9u3$1@ger.gmane.org> (Jakub Narebski's message of "Tue\, 13 Nov 2007 15\:53\:52 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64810>

Jakub Narebski <jnareb@gmail.com> writes:

> [Cc: Sergei Organov <osv@javad.com>, git@vger.kernel.org]
> Please CC git mailing list, git@vger.kernel.org
>
> Sergei Organov wrote:
>
>> Hello,
>> 
>> I want to get rid of origin/pu remote tracking branch. What do I do? I
>> RTFM git-branch. What does it suggest?
>> 
>> git branch -d -r origin/pu
>> 
>> So far so good. However, it doesn't seem to work in practice:
>  
>
>> $ git branch -d -r origin/pu
>> Deleted remote branch origin/pu.
>> $ git remote show origin
>> * remote origin
>>   URL: git://git.kernel.org/pub/scm/git/git.git
>>   Remote branch(es) merged with 'git pull' while on branch master
>>     master
>>   New remote branches (next fetch will store in remotes/origin)
>>     pu
>>   ^^^^^^^^^^^^^^^^^^^ What???  
>>   Tracked remote branches
>>     html maint man master next todo
>
> Check out what do you have in .git/config file, in the [remote "origin"]
> section. Most probably (if you cloned this repository using new enough git)
> you have wildcard refspec there, which means that git would pick all new
> branches when fetching / pulling from given repository.

Sure, I've cloned git.git using rather recent git, so .git/config has:

      fetch = +refs/heads/*:refs/remotes/origin/*

> The wildcard refspec is not documented adequately, so I'm not sure if
> adding
>
>         fetch = !refs/heads/pu
>
> would help, or do you have to replace wildcard refspec by explicit list of
> branches you want to fetch.

Isn't "git branch -d -r" supposed to do whatever magic is required to
get rid of the remote branch? Currently it seems like a bug introduced
by addition of wildcards refspecs, right?

-- 
Sergei.
