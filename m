From: Edgar Toernig <froese@gmx.de>
Subject: Re: Git 1.3.2 on Solaris
Date: Tue, 23 May 2006 17:20:53 +0200
Message-ID: <20060523172053.60ec1145.froese@gmx.de>
References: <8157.1148359875@lotus.CS.Berkeley.EDU>
	<Pine.LNX.4.64.0605230744350.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jason Riedy <ejr@EECS.Berkeley.EDU>,
	Stefan Pfetzing <stefan.pfetzing@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 23 17:21:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiYh4-0007Ig-NH
	for gcvg-git@gmane.org; Tue, 23 May 2006 17:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWEWPVA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 11:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWEWPU7
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 11:20:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:41100 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751252AbWEWPU7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 11:20:59 -0400
Received: (qmail invoked by alias); 23 May 2006 15:20:57 -0000
Received: from p509033FC.dip0.t-ipconnect.de (EHLO dialup) [80.144.51.252]
  by mail.gmx.net (mp019) with SMTP; 23 May 2006 17:20:57 +0200
X-Authenticated: #271361
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605230744350.5623@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20607>

Linus Torvalds wrote:
>
> >  -   printf ("access: %d\n", access("/etc/motd", X_OK));
> > [...]
> >  - will return 0 on solaris - when run as root, even though /etc/motd
> >  - is not executeable.
> > 
> > This is explicitly allowed by the SUS, even for non-root:
> 
>      New implementations are discouraged from returning X_OK unless at 
>      least one execution permission bit is set."
> 
> which clearly says "Solaris is CRAP" to me.

Just for the record: firefox's download manager performs exactly this
test to decide whether you can 'open with' a file (pretty silly because
the test is done on the freshly downloaded file in the temp dir which
never has an x-bit set).  But I was hit by this effect on my system
which is - surprise surprise - Linux :-)   Ok, it's a pretty old one
with a 2.0 kernel and libc 5.  But nevertheless, access(2) is not the
right function to portably test the x-bit.

Ciao, ET.
