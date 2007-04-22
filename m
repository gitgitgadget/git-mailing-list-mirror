From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] Add 'filter' attribute and external filter driver definition.
Date: Sat, 21 Apr 2007 19:15:09 -0700
Message-ID: <7vbqhhrw7m.fsf@assigned-by-dhcp.cox.net>
References: <11771520591529-git-send-email-junkio@cox.net>
	<11771520591703-git-send-email-junkio@cox.net>
	<20070422003929.GD17480@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 22 04:15:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfRbz-00034c-9H
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 04:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbXDVCPM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 22:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753989AbXDVCPL
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 22:15:11 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:55373 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982AbXDVCPK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 22:15:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422021511.FKDL1266.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 21 Apr 2007 22:15:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id q2F81W00Z1kojtg0000000; Sat, 21 Apr 2007 22:15:09 -0400
In-Reply-To: <20070422003929.GD17480@spearce.org> (Shawn O. Pearce's message
	of "Sat, 21 Apr 2007 20:39:29 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45209>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> ick.  What about something like this on top?  I moved the extra child
> process for the input pipe down into the start_command routine,
> where we can do something a little smarter on some systems, like
> using a thread rather than a full process.  Its also a shorter
> patch and uses more of the run-command API.

Well, I did not like start_command() that wanted to always
perform the full exec of something else for its inflexibility,
and this piles a specific hack on top of it...  Why not a
callback with void * pointer?

Or are you trying to make this interface as inflexible and
feature-limited as possible, perhaps to make it easier to
porting to Windows?
