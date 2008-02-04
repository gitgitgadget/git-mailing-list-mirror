From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7] safecrlf: Add mechanism to warn about irreversible
 crlf conversions
Date: Mon, 4 Feb 2008 15:01:52 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802041457190.7372@racer.site>
References: <4C024D67-9FA5-451D-BB91-CE9464C6F50D@zib.de> <1202053379677-git-send-email-prohaska@zib.de> <alpine.LSU.1.00.0802032222380.7372@racer.site> <86F2B863-6FE8-407E-B535-3F49782DA5F9@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 16:03:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM2qd-0000UG-QN
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 16:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbYBDPCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 10:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbYBDPCa
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 10:02:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:42173 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751574AbYBDPCa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 10:02:30 -0500
Received: (qmail invoked by alias); 04 Feb 2008 15:02:28 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp051) with SMTP; 04 Feb 2008 16:02:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19HgTpcsxdHGSOBTLGp9CtwjitX4PtzRIlX87deLt
	1MnT46QElObtCD
X-X-Sender: gene099@racer.site
In-Reply-To: <86F2B863-6FE8-407E-B535-3F49782DA5F9@zib.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72512>

Hi,

On Mon, 4 Feb 2008, Steffen Prohaska wrote:

> On Feb 3, 2008, at 11:29 PM, Johannes Schindelin wrote:
> 
> > However, safe_crlf != SAFE_CRLF_FALSE does not affect people who did 
> > not set core.crlf = input or core.crlf = true.  And for those who set 
> > core.crlf, the default makes sense, absolutely.
> 
> I add a comment to the commit message.
> 
> However, I don't fully agree with your comment.  If your Unix 
> environment is as sane as you assume and you never exchange any data 
> with the "cursed" people, you can safely set core.autocrlf=input and 
> core.safecrlf=warn and still should never see any warning.  Well you'd 
> spent some CPU cycles on verifying that your assumptions hold.

It is not only about spend CPU cycles.  It is about content-tracking.  
Personally, I have no single repository which munges data when putting it 
into the index.  That is what the crlf handling is: munging.  I want the 
data verbatim, and if I decide to check in a file with carriage return 
before line feed, then so be it.

Of course, the code paths in your patch would be less exercised, and 
bugs/interactions could be conveniently hidden for all those who decide 
not to activate safecrlf like me, but I do not see why Linux/Unix people 
should be punished for a shortcoming that affects only projects which 
partly work on Windows, and then only if non-POSIX tools are used.

Ciao,
Dscho
