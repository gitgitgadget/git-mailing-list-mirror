From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] xdl_merge(): fix a segmentation fault when refining conflicts
Date: Tue, 02 Jan 2007 13:11:00 -0800
Message-ID: <7vk605t9qz.fsf@assigned-by-dhcp.cox.net>
References: <20061227041644.GA22449@spearce.org> <en6fj1$ji5$1@sea.gmane.org>
	<Pine.LNX.4.63.0612310208460.25709@wbgn013.biozentrum.uni-wuerzburg.de>
	<200701021418.48624.jnareb@gmail.com>
	<Pine.LNX.4.63.0701022144290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 02 22:11:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1qud-0005oz-0z
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 22:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908AbXABVLE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 16:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754921AbXABVLE
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 16:11:04 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:53223 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908AbXABVLB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 16:11:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102211100.GOFI97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jan 2007 16:11:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6MAD1W00C1kojtg0000000; Tue, 02 Jan 2007 16:10:13 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701022144290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 2 Jan 2007 21:58:45 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35816>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> That is certainly a possibility! But how would you specify it? If you 
> do it as a command line option, you'd have to add it to git-merge, 
> git-pull, git-merge-recursive and git-merge-file. Ugly.

Another thing to worry about is that this would make things
"works most of the time but when it fails it fails silently"
which would lead to very hard to detect problem in the project
managed by git.  I'd be very hesitant about this for this reason
alone.
