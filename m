From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug: update hook failure doesn't prevent local deletion of a branch
Date: Thu, 26 Jul 2007 22:00:41 -0700
Message-ID: <7v3aza5tl2.fsf@assigned-by-dhcp.cox.net>
References: <200707251250.08166.andyparkins@gmail.com>
	<7vk5sm5vrd.fsf@assigned-by-dhcp.cox.net>
	<20070727042606.GE20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 07:00:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEHwU-0003FH-Qs
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 07:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbXG0FAo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 01:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbXG0FAo
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 01:00:44 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:47655 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbXG0FAn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 01:00:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727050043.PGKV1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Jul 2007 01:00:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UV0h1X00C1kojtg0000000; Fri, 27 Jul 2007 01:00:42 -0400
In-Reply-To: <20070727042606.GE20052@spearce.org> (Shawn O. Pearce's message
	of "Fri, 27 Jul 2007 00:26:06 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53886>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> We should make our repository state reflect the user's internal
> mental view of what just happened, especially here, because the
> user's mental view is probably correct.

Fair enough.  At least if we correct git-push so that when it
exits with failure it would not touch the local refs, I would
think that would make what happens to match user's mental model
much better.  The user would be _told_ that it failed, and then
can fetch back if he cares where the remote heads are too
deeply.
