From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fixup no-progress for fetch & clone
Date: Fri, 23 Feb 2007 21:47:46 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702232141040.29426@xanadu.home>
References: <Pine.LNX.4.63.0702232002480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy8w3add.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702240217550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702232046300.29426@xanadu.home>
 <Pine.LNX.4.63.0702240314250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702232123110.29426@xanadu.home>
 <Pine.LNX.4.63.0702240336130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 24 03:47:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKmwy-0006Fn-LZ
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 03:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933352AbXBXCrt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 21:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933355AbXBXCrt
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 21:47:49 -0500
Received: from relais.videotron.ca ([24.201.245.36]:25633 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933352AbXBXCrs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 21:47:48 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDY009DJ53M1VP0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 23 Feb 2007 21:47:47 -0500 (EST)
In-reply-to: <Pine.LNX.4.63.0702240336130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40501>

On Sat, 24 Feb 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Fri, 23 Feb 2007, Nicolas Pitre wrote:
> 
> > And I would do that and _only_ that to supress progress.  No messing 
> > around with protocol extensions.  Just filter out the unwanted messages 
> > locally and be happy.
> 
> This is easier, but I'd feel dirty about it. I mean, you set up a signal 
> every so often, have a side band, demultiplex the side band, and for what? 
> To just ignore it?

Yes sir.  But of course this isn't the default.  

And it isn't even the common case either.  So I think a bit of cheating 
to keep the common case simple isn't that bad.

And it is not like if the whole thing was thrown away.  For example I 
think messages like

	remote: Writing 1234 objects.

are good messages to have in a log file even when progress display is 
filtered out.  So the sideband demultiplexing is useful in that case as 
well.


Nicolas
