From: Nicolas Pitre <nico@cam.org>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 12:50:47 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702281249430.29426@xanadu.home>
References: <17893.42063.186763.291346@lisa.zopyra.com>
 <20070228155412.GC5479@spearce.org>
 <17893.43522.511785.121778@lisa.zopyra.com>
 <17893.44181.129918.669187@lisa.zopyra.com>
 <20070228163256.GD5479@spearce.org>
 <118833cc0702280842g3e121fg601d7e102956ba93@mail.gmail.com>
 <20070228164922.GB5924@spearce.org>
 <17893.46083.869042.467318@lisa.zopyra.com>
 <20070228170641.GC5924@spearce.org>
 <17893.47007.136145.112498@lisa.zopyra.com> <20070228174339.GE5924@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 18:50:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMSx0-0006JG-OC
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 18:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbXB1Rut (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 12:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbXB1Rut
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 12:50:49 -0500
Received: from relais.videotron.ca ([24.201.245.36]:16000 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbXB1Rus (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 12:50:48 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE6001DPPKNJZH3@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 28 Feb 2007 12:50:47 -0500 (EST)
In-reply-to: <20070228174339.GE5924@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40976>

On Wed, 28 Feb 2007, Shawn O. Pearce wrote:

> Bill Lear <rael@zopyra.com> wrote:
> > Yes: 1.4.x worked fine.  This was actually my attempt to re-do the 1.4
> > clone I had laying around, as I wanted my backup done with 1.5.  I
> > still have the 1.4 cloned repo, just moved it out of the way...
> 
> OK, is ~/devel/project fully packed?  If it isn't can you repack
> it (or a clone of it) so that it is?
> 
> Then take the packfile and try to feed it right into index-pack:
> 
> 	mkdir /austin/users/rael/repos/git/project-test
> 	cd /austin/users/rael/repos/git/project-test
> 	git --bare init
> 	git --bare index-pack --stdin --fix-thin \
> 	  <~/devel/project/.git/objects/pack/pack-*.pack
> 
> Now while that is running it should be creating pack_XXXXXX as a
> temporary file (where XXXXXX is replaced with the temp string).
> Its this file that we are seeing magically truncate to 0 in the
> middle of running.
> 
> But I fail to see anything in index-pack that would cause this,
> and its the only program that knows about this file at this stage
> of the clone.

... and Bill already said that the same clone operation, when not 
performed on top of NFS, works fine.


Nicolas
