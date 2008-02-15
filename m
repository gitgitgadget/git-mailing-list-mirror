From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Thu, 14 Feb 2008 20:41:28 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802142032030.2732@xanadu.home>
References: <200802081828.43849.kendy@suse.cz>
 <m3y79nb8xk.fsf@localhost.localdomain>
 <alpine.LSU.1.00.0802142054080.30505@racer.site>
 <200802142300.01615.jnareb@gmail.com>
 <alpine.LSU.1.00.0802142334480.30505@racer.site>
 <20080214235129.GU27535@lavos.net>
 <alpine.LSU.1.00.0802150007480.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Brian Downing <bdowning@lavos.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jan Holesovsky <kendy@suse.cz>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 15 02:42:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPpao-0003Y9-DJ
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 02:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbYBOBlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 20:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753061AbYBOBlr
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 20:41:47 -0500
Received: from relais.videotron.ca ([24.201.245.36]:48808 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbYBOBlq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 20:41:46 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW900EU3BD41C00@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 14 Feb 2008 20:41:29 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LSU.1.00.0802150007480.30505@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73937>

On Fri, 15 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 14 Feb 2008, Brian Downing wrote:
> 
> > On Thu, Feb 14, 2008 at 11:38:24PM +0000, Johannes Schindelin wrote:
> > > Heh.  I was too lazy to look up the usage, so I just did what I 
> > > thought would make sense...
> > > 
> > > So here it goes:
> > > 
> > > $ git verify-pack -v 
> > > objects/pack/pack-e4dc6da0a10888ec4345490575efc587b7523b45.pack | 
> > > ~/git/contrib/stats/packinfo.pl | tee packinfo.txt
> > >       all sizes: count 601473 total 2855826280 min 0 max 62173032 mean 
> > > 4748.05 median 232 std_dev 221254.37
> > >  all path sizes: count 601473 total 2855826280 min 0 max 62173032 mean 
> > > 4748.05 median 232 std_dev 221254.37
> > >      tree sizes: count 601473 total 2855826280 min 0 max 62173032 mean 
> > > 4748.05 median 232 std_dev 221254.37 tree path sizes: count 601473 
> > > total 2855826280 min 0 max 62173032 mean 4748.05 median 232 std_dev 
> > > 221254.37
> > >          depths: count 2477715 total 70336238 min 0 max 250 mean 28.39 
> > > median 4 std_dev 55.49
> > > 
> > > Something in my gut tells me that those four repetitive lines are not 
> > > meant to look like they do...
> > 
> > Do you by chance have repack.usedeltabaseoffset turned on?
> 
> Ouch.  That must have been a leftover from earlier attempts.  I did not 
> _mean_ to keep it, but now that I have a pretty packed repository, I think 
> I'll just keep it as-is.

I should really come around to fixing packed_object_info_detail() for 
the OBJ_OFS_DELTA case one day.


Nicolas
