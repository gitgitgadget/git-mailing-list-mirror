From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/5] autoconf: Preliminary check for working mmap
Date: Tue, 05 Sep 2006 01:43:01 +0200
Organization: At home
Message-ID: <edidlp$d3d$1@sea.gmane.org>
References: <200609050054.24279.jnareb@gmail.com> <200609050056.52590.jnareb@gmail.com> <7vy7szjjal.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Sep 05 01:43:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKO5l-00081v-K9
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 01:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWIDXm7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 19:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWIDXm6
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 19:42:58 -0400
Received: from main.gmane.org ([80.91.229.2]:56514 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965049AbWIDXm6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Sep 2006 19:42:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GKO5e-00080T-Pv
	for git@vger.kernel.org; Tue, 05 Sep 2006 01:42:54 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Sep 2006 01:42:54 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Sep 2006 01:42:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26456>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> This patch sent earlier in other patch series and dropped,
>> as git uses private mapping, not private fixed. I think
>> that this check is better than no check at all...
> 
> I think the next major change that is needed fairly soon is to
> be able to mmap parts of a large pack file (even with 32-bit
> offset).  I haven't loooked into it deeply enough but it may or
> may not turn out to be beneficial if we map at fixed location so
> the requirements of "working mmap()" might change.  I'd be
> happier if you held onto this part of the patch before that
> happens.

Well, this patch perhaps not always would set NO_MMAP when it should 
(some broken mmap that does private+fixed but not private), but I guess that
if it would set NO_MMAP then mmap is broken (or doesn't exist at all).

I have noticed AC_FUNC_MMAP test, and thought why not to use it?
The simplest check if mmap exist would be to check libc for mmap function.


BTW the patch was reworked from previous version to reflect changes
in the compilation variables management (ability to unset variable).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
