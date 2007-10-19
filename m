From: walt <wa1ter@myrealbox.com>
Subject: Re: git-merge: need a tap with the cluestick, please
Date: Thu, 18 Oct 2007 18:00:58 -0700
Organization: none
Message-ID: <ff8vj9$rs4$1@ger.gmane.org>
References: <ff80tr$hh1$1@ger.gmane.org> <20071018233518.GL14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 03:00:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IigER-0005Dj-R5
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 03:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759534AbXJSBAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 21:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759470AbXJSBAo
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 21:00:44 -0400
Received: from main.gmane.org ([80.91.229.2]:35744 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756665AbXJSBAo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 21:00:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IigE7-0003SS-RQ
	for git@vger.kernel.org; Fri, 19 Oct 2007 01:00:35 +0000
Received: from adsl-69-234-196-162.dsl.irvnca.pacbell.net ([69.234.196.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 01:00:35 +0000
Received: from wa1ter by adsl-69-234-196-162.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 01:00:35 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-196-162.dsl.irvnca.pacbell.net
User-Agent: Thunderbird 3.0a1pre (X11/2007101809)
In-Reply-To: <20071018233518.GL14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61588>

Shawn O. Pearce wrote:
> walt <wa1ter@myrealbox.com> wrote:
>> Now when I pull from Linus the merge stops in the middle because of
>> conflicts with my .gitignore file <sigh>.  Anything I try now with
>> git-merge tells me I can't do that in the middle of a conflicted
>> merge.  Yes, I know that now, but what should I do instead?
>>
>> I could move my 'obj' out-of-tree but then I wouldn't learn anything.
>> This has to be bone-head easy, but not for me :)
> 
> How about putting the ignore for your obj dir in your own private
> exclude file:
> 
>   $ echo /obj >>.git/info/exclude
> 
> will cause Git to ignore an "obj" directory if it is found in the
> top level of the repository.  And since this file is not actually
> tracked as part of the repository it will apply to all branches
> in this repository and won't cause merge conflicts when upstream
> makes changes to .gitignore.

Thanks to both you and Lars, who gave me the same advice off-list.
I will do exactly that.

Just to illustrate how much of life depends on blind luck, both good
and bad, I'll explain what really got me in trouble here.  On the
very first pull from Linus after I added my obj directory to
.gitignore -- I pulled this commit:

commit 9e447a7f1fd997bcb9266899e777c37469245365
Author: Denis V. Lunev <den@openvz.org>
Date:   Tue Oct 16 11:22:21 2007 +0400

     .gitignore update for x86 arch
     This patch: - makes .gitignore files visible to git

I'd like to think that if I'd made my changes on *any* other day
but yesterday I wouldn't have been so completely confused by what
happened.  (But perhaps I flatter myself :o)

Thanks again.
