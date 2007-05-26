From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT on MinGW problem
Date: Sat, 26 May 2007 15:39:35 -0700
Message-ID: <7v4plzi508.fsf@assigned-by-dhcp.cox.net>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500>
	<464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com>
	<f3a2ke$9s7$1@sea.gmane.org>
	<Pine.LNX.4.64.0705262318190.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 27 00:39:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs4vH-0006Jd-Qu
	for gcvg-git@gmane.org; Sun, 27 May 2007 00:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbXEZWji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 18:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbXEZWji
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 18:39:38 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:34874 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbXEZWjh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 18:39:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070526223937.JMUJ6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 26 May 2007 18:39:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3yfc1X0071kojtg0000000; Sat, 26 May 2007 18:39:36 -0400
In-Reply-To: <Pine.LNX.4.64.0705262318190.4648@racer.site> (Johannes
	Schindelin's message of "Sat, 26 May 2007 23:26:48 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48499>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> In this, part of the pain is that Git tries to guess the version number
>> by itself in a complicated way.
>
> Yes, I never understood that myself why it has to be so complicated. But 
> then, it did not make _my_ life hard, so I did not care.

"echo "MyVersionNumber" >version && make"?

> OTOH, it _is_ a nice thing to protohype the new commands as shell or perl 
> scripts. When they stabilize enough, convert them to builtins.

Protohype is a nice word.  Throw out a half-working stuff and
advertise it as the best thing since sliced bread even before it
starts to being useful ;-)

> There are exactly 4 perl scripts left that I regularly use:
>
> add--interactive, cvsimport, remote and svn.
>
> I somehow have the feeling that it is not worth the effort to convert 
> cvsimport and svn. With add--interactive, I think it's better to leave it 
> as is before Junio goes on another "what have I done? why did I have to 
> add _this_?" spree.

I do not follow you here.

> But remote will soon be the center of my crosshairs.

I am afraid that it might be a bit premature.

I've been hoping that we can make git-clone a thin wrapper
around init/remote/fetch/checkout.  For one thing, we would want
to split the separate-remotes layout and bareness to create
"mirror" (I called it "pure" previously, but this is really a
mirror) layout for git-clone, among other things, and that kind
of enhancements would need to be done inside git-remote.
