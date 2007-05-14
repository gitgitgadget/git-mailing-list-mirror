From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsserver: Don't send mixed messages to clients
Date: Mon, 14 May 2007 14:28:29 -0700
Message-ID: <7vmz07m6wy.fsf@assigned-by-dhcp.cox.net>
References: <1179078545517-git-send-email-frank@lichtenheld.de>
	<7vd514sg0g.fsf@assigned-by-dhcp.cox.net>
	<46a038f90705132338r12f70599m5845ffce31c945cf@mail.gmail.com>
	<20070514131528.GC5272@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon May 14 23:29:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hni6G-0000Xf-Aq
	for gcvg-git@gmane.org; Mon, 14 May 2007 23:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756659AbXENV2b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 17:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758523AbXENV2b
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 17:28:31 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:43681 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659AbXENV2a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 17:28:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070514212830.QHZW2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 14 May 2007 17:28:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id z9UV1W0061kojtg0000000; Mon, 14 May 2007 17:28:29 -0400
In-Reply-To: <20070514131528.GC5272@planck.djpig.de> (Frank Lichtenheld's
	message of "Mon, 14 May 2007 15:15:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47292>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> After looking through all the uses of
> 	die "something"
> and
> 	print "E something";
> 	exit;
> and
> 	print "error 1 something";
> 	exit;
>
> in the current code I fail to see a real pattern there, is there any?
> If yes, we should maybe document it in a comment somewhere...
>
> For the record, cvs (server side) does the following in this particular situation:
> 	buf_output0 (buf_to_net, "I HATE YOU\n");
>         buf_flush (buf_to_net, true);
>
>         /* Don't worry about server_cleanup, server_active isn't set
>            yet.  */
>         exit (EXIT_FAILURE);

Ok, I stand corrected.  If there is a pattern to emulate, that
should be found in the real cvs server.
