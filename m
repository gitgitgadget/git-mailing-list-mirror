From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 18:36:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701301835340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701292320.43888.johannes.sixt@telecom.at>
 <Pine.LNX.4.64.0701291944290.20138@iabervon.org> <45BF0098.8FF978CE@eudaptics.com>
 <Pine.LNX.4.64.0701301204400.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 18:36:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBwuC-0002pr-Mg
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 18:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965361AbXA3RgZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 12:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965449AbXA3RgZ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 12:36:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:42061 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965361AbXA3RgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 12:36:25 -0500
Received: (qmail invoked by alias); 30 Jan 2007 17:36:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 30 Jan 2007 18:36:23 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0701301204400.20138@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38173>

Hi,

On Tue, 30 Jan 2007, Daniel Barkalow wrote:

> On Tue, 30 Jan 2007, Johannes Sixt wrote:
> 
> > Daniel Barkalow wrote:
> > > 
> > > On Mon, 29 Jan 2007, Johannes Sixt wrote:
> > > 
> > > > (*) The reason is that on Windows read() and write() cannot operate on
> > > > descriptors created by socket(). A work-around is to implement a (threaded)
> > > > proxy, but that's almost the same as if netcat were used as
> > > > GIT_PROXY_COMMAND.
> > > 
> > > Can you do
> > > 
> > > #define read(fd, buffer, len) recv(fd, buffer, len, 0)
> > > #define write(fd, buffer, len) send(fd, buffer, len, 0)
> > > 
> > > in the appropriate file?
> > 
> > I doubt that recv and send can operate on regular file descriptors, as
> > opened by _pipe(), open(), can they?
> 
> I don't think so, but I think it should be possible to make 
> packet_write/packet_read always get a socket, by calling receive-pack and 
> upload-pack with a socket pair instead of a pair of pipes.

As I already mentioned in this thread, that would break inetd support.

Ciao,
Dscho
