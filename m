From: arQon <arqon@gmx.com>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 18:56:14 +0000 (UTC)
Message-ID: <loom.20111013T203610-130@post.gmane.org>
References: <loom.20111013T094053-111@post.gmane.org> <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com> <20111013145924.2113c142@ashu.dyn.rarus.ru> <loom.20111013T130924-792@post.gmane.org> <4E96D819.20905@op5.se> <loom.20111013T152144-60@post.gmane.org> <1318517194.4646.30.camel@centaur.lab.cmartin.tk> <loom.20111013T171530-970@post.gmane.org> <1318525486.4646.53.camel@centaur.lab.cmartin.tk> <loom.20111013T193054-868@post.gmane.org> <7vzkh44ug1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 20:56:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REQSM-0000hj-Cz
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 20:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929Ab1JMS4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 14:56:34 -0400
Received: from lo.gmane.org ([80.91.229.12]:44105 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab1JMS4d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 14:56:33 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1REQSG-0000dD-Dg
	for git@vger.kernel.org; Thu, 13 Oct 2011 20:56:32 +0200
Received: from 24-180-45-63.dhcp.crcy.nv.charter.com ([24.180.45.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 20:56:32 +0200
Received: from arqon by 24-180-45-63.dhcp.crcy.nv.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 20:56:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.180.45.63 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Ubuntu/10.04 (lucid) Firefox/3.6.23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183515>

Junio C Hamano <gitster <at> pobox.com> writes:
> Perhaps you can prepare a documentation patch to make it clear that git
> WILL preserve the LOCAL CHANGES to the working tree?

Or to put that another way, git WILL NOT "rewind" those local changes when
switching branches (which I still think is the more common case for new users
than failing to branch before editing files). Or refuse to switch if you have
some. Except for when it does.

I'll give a shot, though I don't know how good it'll be. Off the top of my
head, I don't see any good way to explain the inconsistency with LOCAL CHANGES
sometimes preventing switches and sometimes not, based on what is to the user
an arbitrary set of rules that has nothing to do with the *current state* of
the worktree, but rather the state of those files in prior commits.

But sure, I'll see if I can come up with something. If nothing else, having the
manpage at least explain what "M" means; that it can be potentially disastrous;
and what you need to do to avoid it, would be a definite plus.
