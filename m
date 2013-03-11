From: Vadim Zeitlin <vz-git@zeitlins.org>
Subject: Re: Rewriting references to existing commits in commit messages with filter-branch
Date: Mon, 11 Mar 2013 12:23:45 +0000 (UTC)
Message-ID: <loom.20130311T131746-169@post.gmane.org>
References: <E1UF1Ag-0006m3-5k@smtp.tt-solutions.com> <87haki2la2.fsf@gmx.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 11 13:30:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF1rm-0005l8-Ja
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 13:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106Ab3CKM3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 08:29:44 -0400
Received: from plane.gmane.org ([80.91.229.3]:35415 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905Ab3CKM3o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 08:29:44 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UF1rg-0005eI-0A
	for git@vger.kernel.org; Mon, 11 Mar 2013 13:30:04 +0100
Received: from ip-208.net-89-3-60.rev.numericable.fr ([89.3.60.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 13:30:03 +0100
Received: from vz-git by ip-208.net-89-3-60.rev.numericable.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 13:30:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 89.3.60.208 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:19.0) Gecko/20100101 Firefox/19.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217872>

Lawrence Mitchell <wence <at> gmx.li> writes:

> Vadim Zeitlin wrote:
> 
> [...]
> 
> > git filter-branch --msg-filter svnmsg2git --tag-name-filter cat -- --all
> 
> git rev-list lists by default in chronological order.  Do you
> want to pass --topo-order as one of the rev-list options?

 Thanks, this looked like a good idea but reading git-filter-branch code it
seems to already do it, at
https://github.com/git/git/blob/master/git-filter-branch.sh#L269 you can see
that it does "git rev-list --reverse --topo-order ...".

 So this probably won't help (I could try it just in case I'm missing something
but the first errors appear after almost 2 hours of running...). Notice that I
could well be wrong in my explanation of what happens, perhaps it's not related
to the order of processing of the branches/trunk at all. All I know is that when
a chronologically later commit referring to preceding one on a different branch
is processed by git-filter-branch, sometimes (or perhaps even always) the file
corresponding to the previous commit is not yet present in .git-rewrite/map
directory.

 Thanks again for any help with this,
VZ
