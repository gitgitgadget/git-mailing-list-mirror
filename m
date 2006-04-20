From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] Add git-unresolve <paths>...
Date: Wed, 19 Apr 2006 17:33:02 -0700
Message-ID: <7vacah3x35.fsf@assigned-by-dhcp.cox.net>
References: <7vu08p72sn.fsf@assigned-by-dhcp.cox.net>
	<87acah6zk6.wl%cworth@cworth.org>
	<7v8xq16y31.fsf@assigned-by-dhcp.cox.net>
	<87wtdl2o5o.wl%cworth@cworth.org>
	<7vmzeh3ypu.fsf@assigned-by-dhcp.cox.net>
	<87r73t2jd3.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 02:33:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWN6a-0005um-1r
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 02:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWDTAdF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 20:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWDTAdF
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 20:33:05 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:8693 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751168AbWDTAdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 20:33:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060420003303.LFXU20694.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Apr 2006 20:33:03 -0400
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87r73t2jd3.wl%cworth@cworth.org> (Carl Worth's message of "Wed,
	19 Apr 2006 17:14:48 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18954>

Carl Worth <cworth@cworth.org> writes:

> Thanks for the careful explanation.

You're welcome.  You owe me a patch that typo-fixes and
pretty-prints my message, and drop it somewhere in
Documentation/howto hierarchy for future reference ;-).

> So there's the final piece I'd like here. I think "git status -a -v"
> should provide a multi-parent diff when merging, as should "git status
> -v" after manually doing an update-index while merging.

I'll keep that in mind, but honestly I am not very interested in
that particular use case, if only because you can already do
that by committing, and running "git show".

If you do not like how the resulting merge commit looks like, we
have "git commit --amend" and "git reset --hard HEAD^" for you
already.

I (or Linus) _may_ end up doing "git diff tree1 tree2 tree3..."
as part of the planned diff rewrite, but that would be only
if/when doing things in such a generic way is not much more
trouble than the current "we only do one of index-vs-files,
tree-vs-index, tree-vs-files-via-index or tree-vs-tree and
nothing else" model.
