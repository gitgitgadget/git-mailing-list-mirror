From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] cvsserver: Don't send mixed messages to clients
Date: Sun, 20 May 2007 03:10:48 +0200
Message-ID: <20070520011048.GG4085@planck.djpig.de>
References: <1179078545517-git-send-email-frank@lichtenheld.de> <7vd514sg0g.fsf@assigned-by-dhcp.cox.net> <46a038f90705132338r12f70599m5845ffce31c945cf@mail.gmail.com> <20070514131528.GC5272@planck.djpig.de> <7vmz07m6wy.fsf@assigned-by-dhcp.cox.net> <20070520004543.GF4085@planck.djpig.de> <7v646otizs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 03:11:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpZx2-0002Ac-HA
	for gcvg-git@gmane.org; Sun, 20 May 2007 03:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756529AbXETBK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 21:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756622AbXETBK5
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 21:10:57 -0400
Received: from planck.djpig.de ([85.10.192.180]:4337 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756529AbXETBK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 21:10:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 5492588060;
	Sun, 20 May 2007 03:10:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b1-XC+3lRkyJ; Sun, 20 May 2007 03:10:49 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 8115988105; Sun, 20 May 2007 03:10:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v646otizs.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47790>

On Sat, May 19, 2007 at 05:51:35PM -0700, Junio C Hamano wrote:
> Frank Lichtenheld <frank@lichtenheld.de> writes:
> 
> > On Mon, May 14, 2007 at 02:28:29PM -0700, Junio C Hamano wrote:
> >> Frank Lichtenheld <frank@lichtenheld.de> writes:
> >> > For the record, cvs (server side) does the following in this particular situation:
> >> > 	buf_output0 (buf_to_net, "I HATE YOU\n");
> >> >         buf_flush (buf_to_net, true);
> >> >
> >> >         /* Don't worry about server_cleanup, server_active isn't set
> >> >            yet.  */
> >> >         exit (EXIT_FAILURE);
> >> 
> >> Ok, I stand corrected.  If there is a pattern to emulate, that
> >> should be found in the real cvs server.
> >
> > Will you correct the patch then back to my version? master still has
> > your version of it AFAICT.
> 
> Will do, but then we would also have to vet all the error exit
> paths to match what the real cvsserver does, wouldn't we?

Sure. But it is nothing utterly important. It just so happens
that I already have a test for this one case and would like to
see it fixed before submitting the test patches again.

> We've survived without that so far, so while I'll apply the
> above change before 1.5.2, I think we do not have to have the
> release wait for fixes to the other error exit paths.

Agreed.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
