From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Move the pick_author code to git-sh-setup
Date: Sun, 24 Jun 2007 04:14:00 -0700
Message-ID: <7vd4zlvc3r.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706240000340.4059@racer.site>
	<7v7ipt3lh6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0706241118250.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 24 13:14:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Q2o-0002Vm-TR
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 13:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbXFXLOH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 07:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754111AbXFXLOH
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 07:14:07 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:37292 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062AbXFXLOB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 07:14:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070624111359.KJGB17635.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 24 Jun 2007 07:13:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FPE01X0021kojtg0000000; Sun, 24 Jun 2007 07:14:00 -0400
In-Reply-To: <Pine.LNX.4.64.0706241118250.4059@racer.site> (Johannes
	Schindelin's message of "Sun, 24 Jun 2007 11:22:24 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50793>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> That is well possible. Quoting in shell is such a hassle, and I never seem 
> to get it right.
>
> Therefore I did a minimal test,...
>
> So I thought that it was okay.

Try the small test script in the message you are responding to.
It gives me:

        $ sh ./1.sh
        A= d e
        B= d  e

A quick rule of thumb is that the only place that you can get
away by not quoting is straight assignment to another variable,
like so:

	var='a  b c '
        another=$var	;# another="$var" is fine but unnecessary.

Similarly for

	another=$(some command)

which is Ok not to dquote.
