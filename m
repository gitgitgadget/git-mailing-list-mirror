From: arQon <arqon@gmx.com>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 13:58:06 +0000 (UTC)
Message-ID: <loom.20111013T152144-60@post.gmane.org>
References: <loom.20111013T094053-111@post.gmane.org> <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com> <20111013145924.2113c142@ashu.dyn.rarus.ru> <loom.20111013T130924-792@post.gmane.org> <4E96D819.20905@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 15:58:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RELnl-0008DG-14
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 15:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094Ab1JMN6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 09:58:20 -0400
Received: from lo.gmane.org ([80.91.229.12]:56652 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753213Ab1JMN6U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 09:58:20 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RELne-000878-P8
	for git@vger.kernel.org; Thu, 13 Oct 2011 15:58:18 +0200
Received: from 24-180-45-63.dhcp.crcy.nv.charter.com ([24.180.45.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 15:58:18 +0200
Received: from arqon by 24-180-45-63.dhcp.crcy.nv.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 15:58:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.180.45.63 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Ubuntu/10.04 (lucid) Firefox/3.6.23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183486>

Andreas Ericsson <ae <at> op5.se> writes:
> there's no reason to refuse the branch change.
> Partly because nothing will be lost

Actually, this isn't true either, because of the second bug: doing a revert
in branchA causes the changes in branchB to be lost. This can't possibly be
the intended behavior: again, it completely violates the integrity of branches
by allowing changes on one branch to impact a different branch.

Your interpretation of the manpage doubtless matches the actual behavior of git,
but I find it staggering if that truly is what was intended. It basically means
that if you have local modifications, git will Break Your Entire Tree. That
makes changing while you *do* have local mods more than a little undesirable,
to put it mildly, which is something that a literal reading of the manpage would
suggest is exactly what the "refuse to switch" is for. I guess only Linus knows
what he actually meant.  :)

Anyway, I guess it's all moot: call it a feature or call it a bug, this cross-
branch destruction is a deal-breaker for me, especially given the bug above that
actually loses data outright, rather than "only" putting multiple branches into
an incorrect state.

Thanks for your time and help.
