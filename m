From: arQon <arqon@gmx.com>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 13:09:00 +0000 (UTC)
Message-ID: <loom.20111013T144822-277@post.gmane.org>
References: <loom.20111013T094053-111@post.gmane.org> <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com> <20111013145924.2113c142@ashu.dyn.rarus.ru> <loom.20111013T130924-792@post.gmane.org> <4E96D819.20905@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 15:09:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REL2R-0004ph-Ur
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 15:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138Ab1JMNJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 09:09:16 -0400
Received: from lo.gmane.org ([80.91.229.12]:58996 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755124Ab1JMNJN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 09:09:13 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1REL27-0004e8-VP
	for git@vger.kernel.org; Thu, 13 Oct 2011 15:09:11 +0200
Received: from 24-180-45-63.dhcp.crcy.nv.charter.com ([24.180.45.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 15:09:11 +0200
Received: from arqon by 24-180-45-63.dhcp.crcy.nv.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 15:09:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.180.45.63 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Ubuntu/10.04 (lucid) Firefox/3.6.23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183478>

Andreas Ericsson <ae <at> op5.se> writes:
[snip]
> This means that if fileX on branchA is different from fileX on branchB and you
> *also* have local modifications to fileX, git will refuse to switch branches.
> If, on the other hand branchA:fileX == branchB:fileX and you have modifications
> to fileX in your work tree, there's no reason to refuse the branch change.

There's an EXCELLENT reason to refuse the branch change: once it happens, what
git is then telling is branchA, is not.

> It's not a bug. You just read the manpage a bit wrong.
[snip]
> So yes, this is a feature, and it's a handy one.

Thanks for the explanation. Unfortunately, I still can't see it as anything but
a critical bug. Consider this:

You're working on branchA and you have a bunch of uncommitted changes.
You can't remember some detail of the bug you're fixing, so you switch branches
to the master. You have to rebuild that branch, because your last build was from
your branch. git now builds the master with sources that were NEVER committed
to it. How is that not a total failure to maintain branch integrity?

If that's the way git is, then that's how it is; and if there isn't a setting
that can make it actually preserve branches properly, then there isn't. Which
sucks for me, because an SCCS that lies about what branch you're "really" on
is worse than useless, so I'm stuck with SVN.  :(

Thanks again for clearing it up for me though.
