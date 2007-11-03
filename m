From: Nicolas Pitre <nico@cam.org>
Subject: Re: That new progress meter
Date: Sat, 03 Nov 2007 10:53:25 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0711031042390.21255@xanadu.home>
References: <Pine.LNX.4.64.0711021836000.4362@racer.site>
 <20071103120953.GC13417@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 15:53:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoKNd-0008Di-TC
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 15:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbXKCOx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 10:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754050AbXKCOx3
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 10:53:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27790 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbXKCOx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 10:53:28 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQX00HEPQP13OL0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 03 Nov 2007 10:53:27 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071103120953.GC13417@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63277>

On Sat, 3 Nov 2007, Pierre Habouzit wrote:

> On Fri, Nov 02, 2007 at 06:36:35PM +0000, Johannes Schindelin wrote:
> > Hi Nico,
> > 
> > that new progress meter sure is amazing and useful!
> 
>   I do agree. There seems to be some glitches though, here is how my
> output looks after a git fetch I just did on git.git:
> 
>     remote: Generating pack...
>     remote: Done counting 310 objects.
>     remote: Deltifying 310 objects...           | Here we have a glitch |
>     remote:  100% (310/310) done                 `-------vvvv----------'
>     remote: Total 310 (delta 160), reused 178 (delta 112)iB/s
>     Receiving objects: 100% (310/310), 379.98 KiB | 136 KiB/s, done.
>     Resolving deltas: 100% (160/160), done.

I know.  This is why i TRIED TO KEEP THE "Receiving objects" line as 
short as possible.

> FWIW, maybe instead using spaces to erase lines we could use minimal
> vt100 codes[0] like:
> 
> Erase End of Line       <ESC>[K
>     Erases from the current cursor position to the end of the current line. 

I thought about that too, but this is not perfectly portable to all 
terminals according to a quick glance at /etc/termcap. Does the Windows 
console support it? Also we might prefer not to rely on termcap/terminfo 
library calls.

The other solution is to make the remote object summary line a bit 
longer, but this will be effective only when remote servers are 
upgraded.  Might that be good enough?


Nicolas
