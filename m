From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links
Date: Wed, 26 Apr 2006 09:22:23 +0200
Organization: At home
Message-ID: <e2n72h$aqe$1@sea.gmane.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain> <7vwtde2q1z.fsf@assigned-by-dhcp.cox.net> <444EAE7C.5010402@vilain.net> <e2mv30$k08$1@sea.gmane.org> <e2n01t$m8j$1@sea.gmane.org> <7vzmi8sxt1.fsf_-_@assigned-by-dhcp.cox.net> <e2n4am$1vn$1@sea.gmane.org> <7vlktssudl.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Apr 26 09:22:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYeLz-00079x-GN
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 09:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWDZHWH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 03:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWDZHWH
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 03:22:07 -0400
Received: from main.gmane.org ([80.91.229.2]:7864 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751095AbWDZHWG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Apr 2006 03:22:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYeLZ-00075f-8O
	for git@vger.kernel.org; Wed, 26 Apr 2006 09:22:01 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Apr 2006 09:22:01 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Apr 2006 09:22:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19190>

Junio C Hamano wrote:

> (On topic again)
> 
> Link from subproject commit back to the toplevel might work for
> some kind of subprojects, but it would not work for the
> subproject support that frequently comes up on this list.  The
> development of an embedded Linux device, where a Linux kernel
> source tree is grafted at kernel/ subdirectory of the toplevel
> project.  The "prior" link would be placed in the commit that
> belong to the kernel subproject, but that would never be merged
> to the Linus kernel (why should he care about one particular
> embedded device's development history).  The link must go from
> the toplevel to generic parts reusable out of the context of the
> combined project.

Yes, I guess subproject support is most needed for the "third-party embedded
(sub)project", when one sometimes have to modify (sub)project files, and
perhaps have to watch for the (sub)project version. Hmmm... if one used
Tailor (to allow for projects not managed under GIT, though I wonder if it
would be possible to link up project without [externally available] SCM)
one could use this approach for managing distribution packages, like RPMS
or debs...

Do I understand correctly that toplevel (master project) commits have tree
which points to combined tree, and "bind" links which points to the
subprojects commits whose trees make up the overall tree, or does the
master tree points to tree containing only toplevel files (overall Makefile
for example, INSTALL or README for the whole project including
subprojects,...)?


BTW. I have lately stumbled upon (somewhat Vault and Subversion biased)
 http://software.ericsink.com/Beyond_CheckOut_and_CheckIn.html
Read about Share and Pin -- it's about subprojects (when you edit out the
flawed "branch as folder" approach of author). I wonder if it could be
easily implemented in "subprojects for GIT" proposal... Of course we can do
better, i.e. original subproject repository doesn't need to be on the same
machine, we can use remote repository.

-- 
Jakub Narebski
Warsaw, Poland
