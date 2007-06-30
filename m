From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: most commonly used git commands?
Date: Sun, 1 Jul 2007 00:35:04 +0200
Message-ID: <20070630223504.GB2703@steel.home>
References: <20070625064017.GA2839@mellanox.co.il> <7vlke833wr.fsf@assigned-by-dhcp.pobox.com> <20070625071752.GB15343@mellanox.co.il> <Pine.LNX.4.64.0706250846200.4059@racer.site> <81b0412b0706280152g5cbd777y76757d9c608ea483@mail.gmail.com> <Pine.LNX.4.64.0706281408280.4438@racer.site> <4683BDA5.996874EF@eudaptics.com> <Pine.LNX.4.64.0706281506390.4438@racer.site> <20070630131428.GA2866@steel.home> <Pine.LNX.4.64.0706301531050.4438@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 01 00:35:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4lX5-0000v9-4f
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 00:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbXF3WfI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 18:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753571AbXF3WfI
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 18:35:08 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:51731 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbXF3WfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 18:35:07 -0400
Received: from tigra.home (Fa9ee.f.strato-dslnet.de [195.4.169.238])
	by post.webmailer.de (klopstock mo3) (RZmta 7.6)
	with ESMTP id g01a2fj5UMUJXr ; Sun, 1 Jul 2007 00:35:04 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 90C62277BD;
	Sun,  1 Jul 2007 00:35:04 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 68276C164; Sun,  1 Jul 2007 00:35:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706301531050.4438@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNrERwE=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51260>

Johannes Schindelin, Sat, Jun 30, 2007 16:31:48 +0200:
> On Sat, 30 Jun 2007, Alex Riesen wrote:
> > Johannes Schindelin, Thu, Jun 28, 2007 16:07:17 +0200:
> > > > No. It was meant as Alex said it. Windows (MinGW) doesn't understand
> > > > "chmod a+x blub".
> > > 
> > > Yes, I suspected that. But I don't see a need for it on Windows (MinGW) to 
> > > begin with.
> > > 
> > 
> > But it is necessary on Windows (Cygwin):
> 
> I thought that on Cygwin, filemode=1? I mean, Cygwin _never_ had problems 
> with chmod under my fingers.
> 

Try doing stat(2) on file.txt which contains "#!/bin/sh" in its first
line and for which you have issued a chmod yet. Like a new file, or
like every file in a git-tracked directory after you did a fresh
checkout. Cygwin actually opens the files when doing stat(2), looks
inside and tries to guess if they are executable.

You should have said: "Cygwin _never_ had problems with chmod because
it cannot and didn't make it work". It is not just chmod, the other
side, stat, matters as well.
