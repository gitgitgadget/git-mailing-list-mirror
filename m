From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix --cherry-pick with given paths
Date: Wed, 11 Jul 2007 15:00:17 -0700
Message-ID: <7vsl7u1tzi.fsf@assigned-by-dhcp.cox.net>
References: <469378AB.7030909@vilain.net> <4693800F.4010308@vilain.net>
	<Pine.LNX.4.64.0707101449220.4047@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 12 00:00:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8kER-0006RD-RX
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 00:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761088AbXGKWAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 18:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760585AbXGKWAU
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 18:00:20 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:45436 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756895AbXGKWAS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 18:00:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070711220019.HYMK1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 11 Jul 2007 18:00:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NN0H1X00G1kojtg0000000; Wed, 11 Jul 2007 18:00:17 -0400
In-Reply-To: <Pine.LNX.4.64.0707101449220.4047@racer.site> (Johannes
	Schindelin's message of "Tue, 10 Jul 2007 14:50:49 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52218>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	> Sam Vilain wrote:
> 	> > I'm interested in extending the cherry analysis to allow 
> 	> > specification of the diff options used when calculating diff 
> 	> > IDs, presenting the calculated diff IDs for analysis by 
> 	> > external tools, and even calculating and dealing with per-hunk 
> 	> > diff IDs.
> 	> 
> 	> On reflection I think so long as --cherry-pick works together 
> 	> with a file selection, it would probably be enough.
> 	> 
> 	> ie, if I have these commits:
> 	> 
> 	> A---B
> 	>  \
> 	>   \
> 	>    C
> 	> 
> 	> B changes a file foo.c, adding a line of text.  C changes foo.c 
> 	> as well as bar.c, but the change in foo.c was identical to 
> 	> change B.
> 	> 
> 	> I want this to show me nothing:
> 	> 
> 	>   git-rev-list --left-right --cherry-pick B...C -- foo.c

Thanks, both.
