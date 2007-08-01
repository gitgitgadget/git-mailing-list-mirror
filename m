From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [NOT-SERIOUS PATCH] Make get_relative_cwd() not accept NULL for a directory
Date: Wed, 01 Aug 2007 09:58:07 -0700
Message-ID: <7vmyxb5h0g.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
	<Pine.LNX.4.64.0708010058130.14781@racer.site>
	<Pine.LNX.4.64.0708010129090.14781@racer.site>
	<7vy7gvdgtn.fsf@assigned-by-dhcp.cox.net>
	<7vwswfbywq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0708011624260.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, matled@gmx.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 01 18:58:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGHWb-0004TR-1P
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 18:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912AbXHAQ6K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 12:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753430AbXHAQ6K
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 12:58:10 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61684 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426AbXHAQ6J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 12:58:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801165809.SJDJ1349.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 1 Aug 2007 12:58:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Wgy71X00m1kojtg0000000; Wed, 01 Aug 2007 12:58:08 -0400
In-Reply-To: <Pine.LNX.4.64.0708011624260.14781@racer.site> (Johannes
	Schindelin's message of "Wed, 1 Aug 2007 16:26:04 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54451>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	Okay, I made up my mind.  Allowing "dir == NULL" is not
> 	only a matter of convenience.  It is the most natural
> 	way to say that "dir" is an invalid or non-existing
> 	directory.

That is also fine; it only needs to be clarified somehow to
people who might wonder what get_relative_cwd() function is used
for and how to use it in their programs.  The comment that says
"As a convenience" may need to become a bit more elaborate to
say why it is convenient for the callers to do so (e.g. "The
caller may have called another function that returns a directory
to obtain the 'dir', which may have returned NULL as a way to
say 'there is nothing applicable in your case', and in such a
case, your $(cwd) relative to that 'dir' is also something that
cannot be used, hence a NULL is returned").
