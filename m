From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Replacing the system call pread() with
 lseek()/xread()/lseek() sequence.
Date: Tue, 09 Jan 2007 19:59:49 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701091958170.4964@xanadu.home>
References: <11683766521544-git-send-email-@videotron.ca>
 <45A40C15.1070200@shadowen.org>
 <Pine.LNX.4.63.0701100041310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andy Whitcroft <apw@shadowen.org>,
	"Stefan-W. Hahn" <stefan.hahn@s-hahn.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 01:59:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Rop-0000aB-Dp
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbXAJA7x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbXAJA7x
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:59:53 -0500
Received: from relais.videotron.ca ([24.201.245.36]:44921 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932609AbXAJA7w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:59:52 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JBM001Q4O3QK9P0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 09 Jan 2007 19:59:51 -0500 (EST)
In-reply-to: <Pine.LNX.4.63.0701100041310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36453>

On Wed, 10 Jan 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 9 Jan 2007, Andy Whitcroft wrote:
> 
> > Stefan-W. Hahn wrote:
> >
> > > +        if (current_offset != lseek(fd, current_offset, SEEK_SET))
> > > +                return -1;
> > 
> > How likely are we ever to be in the right place here?
> 
> You mean something like
> 
> 	if (current_offset != offset + count &&
> 			current_offset != lseek(fd, current_offset, SEEK_SET))
> 		return -1;
> 
> instead? Seems cheap enough.

In the index-pack case it simply will never happen.


Nicolas
