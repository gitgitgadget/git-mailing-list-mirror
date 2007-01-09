From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Mon, 08 Jan 2007 23:07:36 -0800
Message-ID: <7v3b6ksmo7.fsf@assigned-by-dhcp.cox.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	<87ps9xgkjo.wl%cworth@cworth.org>
	<7virfprquo.fsf@assigned-by-dhcp.cox.net>
	<87odphgfzz.wl%cworth@cworth.org>
	<7vbql9ydd7.fsf@assigned-by-dhcp.cox.net>
	<20070108131735.GA2647@coredump.intra.peff.net>
	<7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net>
	<87fyalyqqz.wl%cworth@cworth.org>
	<7v7ivxt3ft.fsf@assigned-by-dhcp.cox.net>
	<87d55pyp82.wl%cworth@cworth.org> <20070109032640.GB1904@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 08:08:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4B5Z-0005BW-3k
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 08:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbXAIHHy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 02:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbXAIHHy
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 02:07:54 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:33931 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbXAIHHx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 02:07:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109070752.MAOC7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Tue, 9 Jan 2007 02:07:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8v881W00K1kojtg0000000; Tue, 09 Jan 2007 02:08:08 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070109032640.GB1904@spearce.org> (Shawn O. Pearce's message of
	"Mon, 8 Jan 2007 22:26:40 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36321>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> The common case is probably going to be where the argument to
> `git checkout` is a fast-foward of the detached HEAD.  And that's
> pretty cheap to check.  So we perform that check, and if we fail
> that then we search through every ref to determine if the detached
> HEAD is fully contained in any of those.  Currently that would be
> pretty slow to do with the current tools, but a small modification
> of say git-merge-base (or git-describe) might make it cheap enough
> to run during this slightly less common case.

The needed change to merge-base is quite minimum.  Let me come
up with a patch...
