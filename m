From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sat, 17 Mar 2007 22:03:36 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703172200060.18328@xanadu.home>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
 <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
 <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172136440.18328@xanadu.home>
 <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 03:03:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSkkP-0000hF-6v
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 03:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbXCRCDh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 22:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbXCRCDh
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 22:03:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47257 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbXCRCDh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 22:03:37 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF2009V2TQ0QX50@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 17 Mar 2007 22:03:36 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42468>

On Sat, 17 Mar 2007, Linus Torvalds wrote:

> 
> 
> On Sat, 17 Mar 2007, Nicolas Pitre wrote:
> > 
> > This is definitely an area where pack v4 will bring that cost down to 
> > zero.
> 
> Heh. I believe that when I see it. The thing is, unless you re-generate 
> the tree object data structures, you'll have to have totally different 
> tree walkers for different tree types, and it will all be quite ugly and 
> complex. And "ugly and complex" seldom translates into "zero cost".

Well... in my opinion it is the _current_ tree walker that is quite ugly 
and complex.  It is always messier to parse strings than fixed width 
binary fields.


Nicolas
