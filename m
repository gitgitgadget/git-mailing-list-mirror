From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsserver: Don't send mixed messages to clients
Date: Sat, 19 May 2007 17:51:35 -0700
Message-ID: <7v646otizs.fsf@assigned-by-dhcp.cox.net>
References: <1179078545517-git-send-email-frank@lichtenheld.de>
	<7vd514sg0g.fsf@assigned-by-dhcp.cox.net>
	<46a038f90705132338r12f70599m5845ffce31c945cf@mail.gmail.com>
	<20070514131528.GC5272@planck.djpig.de>
	<7vmz07m6wy.fsf@assigned-by-dhcp.cox.net>
	<20070520004543.GF4085@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sun May 20 02:51:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpZeA-0008UK-OR
	for gcvg-git@gmane.org; Sun, 20 May 2007 02:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199AbXETAvh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 20:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756529AbXETAvh
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 20:51:37 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:61064 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199AbXETAvg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 20:51:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520005136.RBYN12190.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 20:51:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1Cra1X00R1kojtg0000000; Sat, 19 May 2007 20:51:35 -0400
In-Reply-To: <20070520004543.GF4085@planck.djpig.de> (Frank Lichtenheld's
	message of "Sun, 20 May 2007 02:45:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47789>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> On Mon, May 14, 2007 at 02:28:29PM -0700, Junio C Hamano wrote:
>> Frank Lichtenheld <frank@lichtenheld.de> writes:
>> > For the record, cvs (server side) does the following in this particular situation:
>> > 	buf_output0 (buf_to_net, "I HATE YOU\n");
>> >         buf_flush (buf_to_net, true);
>> >
>> >         /* Don't worry about server_cleanup, server_active isn't set
>> >            yet.  */
>> >         exit (EXIT_FAILURE);
>> 
>> Ok, I stand corrected.  If there is a pattern to emulate, that
>> should be found in the real cvs server.
>
> Will you correct the patch then back to my version? master still has
> your version of it AFAICT.

Will do, but then we would also have to vet all the error exit
paths to match what the real cvsserver does, wouldn't we?

We've survived without that so far, so while I'll apply the
above change before 1.5.2, I think we do not have to have the
release wait for fixes to the other error exit paths.
