From: James Peach <jamespeach@mac.com>
Subject: Re: git-svn "cannot lock ref" error during fetch
Date: Thu, 7 Jun 2007 08:37:29 -0700
Message-ID: <6C4E89FC-CE40-4A76-A297-E0AB7A1F2F75@mac.com>
References: <50C9688F-9C62-43AC-A84D-D84561671BAC@mac.com> <20070607063158.GA2809@muzzle>
Mime-Version: 1.0 (Apple Message framework v890.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jun 07 17:38:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwK3z-0005wX-UL
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 17:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760776AbXFGPiL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 11:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756155AbXFGPiL
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 11:38:11 -0400
Received: from smtpout.mac.com ([17.250.248.175]:50091 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760776AbXFGPiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 11:38:09 -0400
Received: from mac.com (smtpin04-en2 [10.13.10.149])
	by smtpout.mac.com (Xserve/smtpout05/MantshX 4.0) with ESMTP id l57Fc87M024918;
	Thu, 7 Jun 2007 08:38:08 -0700 (PDT)
Received: from [17.202.41.255] ([17.202.41.255])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin04/MantshX 4.0) with ESMTP id l57FbTY6007998
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 7 Jun 2007 08:37:43 -0700 (PDT)
In-Reply-To: <20070607063158.GA2809@muzzle>
X-Mailer: Apple Mail (2.890.1)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49374>

On Jun 6, 2007, at 11:31 PM, Eric Wong wrote:

> James Peach <jamespeach@mac.com> wrote:
>> Hi all,
>>
>> I'm new to git, and I'm experimenting with using git-svn to interact
>> with a large SVN repository with lots of branches.
>>
>> I initially did an init like this:
>>
>> git-svn init -t tags -b branches -T trunk svn+ssh://server/svn/ 
>> project
>>
>> Then I did a git-svn fetch, which started pulling all the branches.
>> After a while, however, it hit a branch that it couldn't pull:
>>
>> Found branch parent: (tags/project-92~9)
>> 767f1f1601a4deae459c99ea6c1d1b9ba8f57a65
>> Following parent with do_update
>> ...
>> Successfully followed parent
>> fatal: refs/remotes/tags/project-92~9: cannot lock the ref
>> update-ref -m r13726 refs/remotes/tags/project-92~9
>> 950638ff72acc278156a0d55baafbabb43f2b772: command returned error: 128
>>
>> Some amount of searching failed to turn up any hints on what this
>> error means or how I can work around it. I'd appreciate any  
>> advice ...
>
> Is there a tag actually named "project-92~9"?

unfortunately, there's more than one tag with this naming convention :(

>  If so, it's
> an invalid branch name for git.  I started working on a way
> around it by mapping new names to it, but haven't gotten around to
> finishing it....

Aha! I don't really need 90% of the tags - is there a way I can tell  
the "git-svn fetch" not to bother with particular tags?
