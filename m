From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] Only show log entries for new revisions in hooks--update
Date: Tue, 13 Feb 2007 09:41:29 -0800
Message-ID: <7vbqjyymye.fsf@assigned-by-dhcp.cox.net>
References: <200702131424.06983.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 18:41:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH1eo-0005IT-0I
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 18:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbXBMRla (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 12:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbXBMRla
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 12:41:30 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:48487 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbXBMRla (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 12:41:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213174130.XEJO1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 13 Feb 2007 12:41:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id P5hV1W0031kojtg0000000; Tue, 13 Feb 2007 12:41:29 -0500
In-Reply-To: <200702131424.06983.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 13 Feb 2007 14:24:06 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39551>

I seem to recall that something like this was discussed recently
on the list.

While excluding commits on already updated branches works if the
same set of recipients receive e-mails for both branches by
eliminating the duplicates, I suspect that in more elaborate
settings people would want to do different notices for different
branches, and for that kind of usage people who subscribes only
to branch1 in your picture would miss what happened on branch2.

Or maybe branch1 is the main integration branch (e.g. 'master',
'next') while branch2 is a tentative topic that does not send
out notification e-mails.

If we want to take this example hook seriously, I suspect that
the existing mechanism based on hooks.* variables might need to
be made to allow finer grained, per-branch, control.  I dunno.

Post 1.5.0.
