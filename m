From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: kompare won't parse git diffs
Date: Wed, 02 Aug 2006 20:12:07 +0200
Organization: At home
Message-ID: <eaqpt2$ots$1@sea.gmane.org>
References: <200608021107.43485.andyparkins@gmail.com> <Pine.LNX.4.64.0608021006150.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Aug 02 20:12:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8LCu-0001aM-V3
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 20:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWHBSMb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 14:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWHBSMb
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 14:12:31 -0400
Received: from main.gmane.org ([80.91.229.2]:57490 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932114AbWHBSMa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 14:12:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G8LCR-0001Ss-C3
	for git@vger.kernel.org; Wed, 02 Aug 2006 20:12:07 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 20:12:07 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 20:12:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24662>

Linus Torvalds wrote:

> On Wed, 2 Aug 2006, Andy Parkins wrote:
>>
>> Kompare just shows blank for diffs redirected from git. [ snip ]
>> 
>> As you can see, it's a simple addition of the line "blah".  Kompare shows this 
>> diff as blank.  Now if I modify the file so that the "---" and "+++" lines 
>> both have "<tab>(something)" added:
> 
> I'd definitely call this a pure kompare bug.
> 
> Not only is the git patch format perfectly standard and accepted by other 
> tools, it's much better designed than the brain-damaged syntax that GNU 
> patch uses (which adds a tab and a timestamp after the filenames). In 
> particular, with git patches it is easy to get filenames that have spaces 
> and tabs in them right. 

What about filenames with end-of-line character in them? Is it quoted?

BTW. It should be not that hard to get filename with spaces and tabs even
in GNU diff format: everything up to last <tab> is filename.

> Now, if the kompare people can show that every single other patch 
> generator adds the stupid tab + date format, I guess we could do it too, 
> but
>  (a) there is no valid date in general to use, so it's a fundamentally 
>      broken notion and

Meaning we don't save timestamp in git ;-) Well, we could use date of the 
commit which created given file contents (first commit from root, or last
from head which contains given version)... but the same contents might be
introduced independently in different commits. And different clones of the
same repository might have different commit dates...


-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
