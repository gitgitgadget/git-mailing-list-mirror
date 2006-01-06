From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] update-hook: Major overhaul (handling tags, mainly).
Date: Fri, 06 Jan 2006 14:37:48 -0800
Message-ID: <7vd5j5rnib.fsf@assigned-by-dhcp.cox.net>
References: <20060104161729.7FD9C5BE85@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 06 23:38:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev0Dl-0007b1-BB
	for gcvg-git@gmane.org; Fri, 06 Jan 2006 23:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWAFWh7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 17:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWAFWh7
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 17:37:59 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:21380 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964867AbWAFWhv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 17:37:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060106223640.SCIY20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 Jan 2006 17:36:40 -0500
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14218>

Andreas Ericsson <ae@op5.se> writes:

> This is the update hook we use in all our git-repos.
>
> It has some improvements over the original version, namely:
> * Don't send every commit since dawn of time when adding a new tag.
> * When updating an annotated tag, just send the diffs since the last tag.
> * Add diffstat output for 'normal' commits (top) and annotated tags (bottom).
> * Block un-annotated tags in shared repos.
>
> I'm a bit uncertain about that last one, but it demonstrates how to
> disallow updates of a ref which we use, so I kept it.
>
> Note that git-describe is needed for the "changes since last annotated tag"
> thing to work.
>
> Signed-off-by: Andreas Ericsson <ae@op5.se>

templates/hooks--* is a good place to showcase these "best
current practices", but unfortunately we can have only one BCP
per script there.  If nobody objects I'd take this patch.

I have been wondering if we would want to have an "examples/"
directory in the source tree.
