From: Junio C Hamano <junkio@cox.net>
Subject: Current Issues #3
Date: Mon, 22 May 2006 01:44:15 -0700
Message-ID: <7v8xoue9eo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 22 10:44:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi61U-0006uX-4w
	for gcvg-git@gmane.org; Mon, 22 May 2006 10:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWEVIoQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 04:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWEVIoQ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 04:44:16 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:36093 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750704AbWEVIoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 04:44:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060522084415.QPFW17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 22 May 2006 04:44:15 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20490>

[Third installment of the "Issues" series, but I've been half
 awake for the past week or so, and I suspect I have missed some
 topics that deserve further discussion.]

* Per branch configuration

  The [section "foo"] configuration syntax update by Linus, and
  git-parse-remote update to use remote.stuff.{url,push,pull} by
  Johannes are now both in the "master".  The stage is set to
  discuss what to actually do with per-branch configuration.

  We will use the [branch "foo"] section for configuration about
  local branch named "foo".  I do not think there is any
  disagreement about this.

  The ideas floated so far (I am forgetting many of them
  perhaps):

    1. "upstream" refers to the remote section to use when
       running "git-{fetch,pull,push}" while on that branch.

	[branch "master"]
		upstream = "origin"

	[remote "origin"]
        	url = "git://git.kernel.org/.../git.git"
		fetch = refs/heads/master:refs/remotes/origin/master

    2. "url/fetch/push" directly specifies what would usually be
       taken from a remote section by "git-{fetch,pull,push}"
       while on that branch.

	[branch "foo"]
        	url = "company.com.xz:myrepo"
		fetch = refs/heads/master:refs/remotes/origin/master
		push = refs/heads/master:refs/heads/origin

* reflog

  I still haven't merged this series to "next" -- I do not have
  much against what the code does, but I am unconvinced if it is
  useful.  Also objections raised on the list that this can be
  replaced by making sure that a repository that has hundreds of
  tags usable certainly have a point.
