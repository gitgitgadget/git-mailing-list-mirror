From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC,PATCH] Make git prune remove temporary packs that look like
 write failures
Date: Mon, 04 Feb 2008 11:06:39 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802041105170.2732@xanadu.home>
References: <e1dab3980802040610s27a54a9due3b42db5f59c0cd5@mail.gmail.com>
 <alpine.LSU.1.00.0802041512140.7372@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: David Tweed <david.tweed@gmail.com>,
	gi mailing list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 17:08:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM3r0-0008VJ-36
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 17:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755827AbYBDQGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 11:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755107AbYBDQGl
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 11:06:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:8358 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496AbYBDQGk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 11:06:40 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JVQ007QC22XZTC0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 04 Feb 2008 11:06:33 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LSU.1.00.0802041512140.7372@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72519>

On Mon, 4 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 4 Feb 2008, David Tweed wrote:
> 
> > +                       if(c>0 && c<4096 && stat(name, &status) == 0
> > +                          && status.st_mtime < now - 600){
> 
> Please have spaces after the "if" and before the "{" (just imitate the 
> style of the rest of the file).
> 
> Also, 10 minutes grace period for any ongoing fetch or repack seems a bit 
> arbitrary.  Maybe default to 10 minutes, and introduce 
> prune.packGracePeriod?
> 
> (Which reminds me that it might be useful to add a 
> prune.looseObjectsGracePeriod to avoid having to type --expire= all the 
> time?)

Please use the same parameter for both.  There is no need to have 
separate settings.


Nicolas
