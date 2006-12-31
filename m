From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Use /dev/null for update hook stdin.
Date: Sat, 30 Dec 2006 22:03:34 -0800
Message-ID: <7vtzzciouh.fsf@assigned-by-dhcp.cox.net>
References: <a0aecffe21074288c911c396f92901bfb558d591.1167533707.git.spearce@spearce.org>
	<20061231025522.GC5530@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 07:04:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0tnY-0002cg-EK
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 07:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933026AbWLaGDg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 01:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933029AbWLaGDg
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 01:03:36 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:56254 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933026AbWLaGDf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 01:03:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231060335.COCW29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 Dec 2006 01:03:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5J2o1W00Y1kojtg0000000; Sun, 31 Dec 2006 01:02:49 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20061231025522.GC5530@spearce.org> (Shawn O. Pearce's message of
	"Sat, 30 Dec 2006 21:55:22 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35677>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Currently the update hook invoked by receive-pack has its stdin
> connected to the pushing client.  The hook shouldn't attempt to
> read from this stream, and doing so may consume data that was
> meant for receive-pack.  Instead we should give the update hook
> /dev/null as its stdin, ensuring that it always receives EOF and
> doesn't disrupt the protocol if it attempts to read any data.

Both 2 and 3 look sane, but can we have a few new tests too?
