From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Smart fetch via HTTP?
Date: Thu, 17 May 2007 14:47:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705171445100.6410@racer.site>
References: <20070515201006.GD3653@efreet.light.src> 
 <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com> 
 <Pine.LNX.4.64.0705161232120.6410@racer.site> 
 <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com> 
 <Pine.LNX.4.64.0705170152470.6410@racer.site>  <vpq8xbnlmdv.fsf@bauges.imag.fr>
 <46a038f90705170610mf9c9b0eu7b40af709469a601@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 15:48:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HogKz-0002Xn-UC
	for gcvg-git@gmane.org; Thu, 17 May 2007 15:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243AbXEQNsK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 09:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754914AbXEQNsK
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 09:48:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:50420 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754243AbXEQNsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 09:48:09 -0400
Received: (qmail invoked by alias); 17 May 2007 13:48:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp039) with SMTP; 17 May 2007 15:48:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18cZ0R+bSAc47k/W8UBvMXob24DW+voG8eyzRpruU
	4ntFERnPYnpKxT
X-X-Sender: gene099@racer.site
In-Reply-To: <46a038f90705170610mf9c9b0eu7b40af709469a601@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47522>

Hi,

[I missed this mail, because Matthieu culled the Cc list again]

On Fri, 18 May 2007, Martin Langhoff wrote:

> On 5/17/07, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>
> > FYI, bzr uses HTTP range requests, and the introduction of this
> > feature lead to significant performance improvement for them (bzr is
> > more dumb-protocol oriented than git is, so that's really important
> > there). They have this "index file+data file" system too, so you
> > download the full index file, and then send an HTTP range request to
> > get only the relevant parts of the data file.
> 
> That's the kind of thing I was imagining. Between the index and an
> additional "index-supplement-for-dumb-protocols" maintained by
> update-server-info, http ranges can be bent to our evil purposes.
> 
> Of course it won't be as network-efficient as the git proto, or even
> as the git-over-cgi proto, but it'll surely be server-cpu-and-memory
> efficient. And people will benefit from it without having to do any
> additional setup.

Of course, the problem is that only the server can know beforehand which 
objects are needed. Imagine this:

X - Y - Z
  \
    A


Client has "X", wants "Z", but not "A". Client needs "Y" and "Z". But 
client cannot know that it needs "Y" before getting "Z", except if the 
server says so.

If you have a solution for that problem, please enlighten me: I don't.

Ciao,
Dscho
