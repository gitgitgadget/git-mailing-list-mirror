From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitk "parent information" in commit window
Date: Sun, 07 Aug 2005 17:29:20 -0700
Message-ID: <7vfytlnue7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0508071351150.3258@g5.osdl.org>
	<17142.37044.108962.189983@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 08 02:29:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1vWJ-00023o-Ij
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 02:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbVHHA3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 20:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753148AbVHHA3W
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 20:29:22 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:31122 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1753147AbVHHA3W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2005 20:29:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050808002919.VTMV19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 Aug 2005 20:29:19 -0400
To: git@vger.kernel.org
In-Reply-To: <17142.37044.108962.189983@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Mon, 8 Aug 2005 08:52:36 +1000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:

> Linus Torvalds writes:
>
>> This adds a useful "Parent:" line to the git commit information window.
>
> Cool!  Applied and pushed out.

Thanks.  Merged and pushed out.

> I have been thinking about adding dialog windows to allow the user to
> select which repository and which range of commits they want to look at.
> Do you think that would be useful for you?

"Which repository to look at" would be like restarting if you
need to lose history information, in which case it would not be
so useful at least for me (an extra command line option to limit
the range with specifying GIT_DIR environment variable would
work equally well).  If you can do that without losing history
when the new repository to look at is the same as the old one,
or similar to the old one, then that would be useful.

After starting up, without losing history information, if I can
tell it to re-read the refs, because I made some changes to the
repository while gitk was not looking, that would be very
useful.  But I hope your "switching repository" logic would do
exactly that when I tell it to switch to the same repository.

If there was an option, either runtime configurable or command
line, to cause gitk slurp not just refs/heads and refs/tags but
everything under refs/* recursively, that would help visualizing
the bisect status.  bisect creates bunch of commit object names
in refs/bisect.

If you can pop-up a transient window that shows the tag object
comments when I hover over a tag icon for 2 seconds, and remove
that transient window when stepping outside, that would be a
useful addition.  I do not currently see any way to inspect the
tag itself, not the commit that is pointed at by the tag.
