From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Git svn rebase/dcommit break (index) if not run from directory
	containing ./.git
Date: Thu, 27 May 2010 21:04:19 +0000
Message-ID: <20100527210419.GB2291@dcvr.yhbt.net>
References: <4BCF2E27.1010906@gmx.de> <20100526185157.GB24211@dcvr.yhbt.net> <op.vdcugytd1e62zd@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 27 23:04:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHkFf-0005zW-KP
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 23:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526Ab0E0VEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 17:04:21 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58203 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932524Ab0E0VEU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 17:04:20 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDEBA1F50C;
	Thu, 27 May 2010 21:04:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <op.vdcugytd1e62zd@merlin.emma.line.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147899>

Matthias Andree <matthias.andree@gmx.de> wrote:
> Am 26.05.2010, 20:51 Uhr, schrieb Eric Wong:
>> Matthias Andree <matthias.andree@gmx.de> wrote:
>>> [resending this with new Subject since there wasn't a reply in 33 days,
>>> cc:ing Eric]
>>>
>>> === Reproduce ===
>>>
>>> 1. Use a git-svn checkout that has at least one subdirectory
>>>
>>> 2. cd to that subdirectory
>>>
>>> 3. run git svn rebase. It concludes successfully, then:
>>>
>>> 4. git diff-index HEAD -> output like the one shown above.
>>>
>>> This is on Cygwin 1.7.5 w/ Windows 7 32-bit professional German.
>>
>> Hi Matthias,
>>
>> I can't reproduce this on a GNU/Linux system, so I'm guessing this
>> is a weird Cygwin/Windows issue, and I don't know Windows.
>
> Do you deem it possible to have the workaround applied in code, i. e.  
> change to the top-level directory up front?

"git rebase" (invoked by "git svn") already does that.  This could
be a bug in "git rebase" itself...

> If not, any hints as to debugging facilities and procedures beyond  
> GIT_TRACE?

Well I usually use "strace -f", but that's Linux-only.  Maybe there's
something similar for Cygwin.

-- 
Eric Wong
