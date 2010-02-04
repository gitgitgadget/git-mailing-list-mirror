From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 3/3] make --max-pack-size argument to 'git pack-object'
 count in bytes
Date: Thu, 04 Feb 2010 13:11:17 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002041309090.1681@xanadu.home>
References: <1265255308-20514-1-git-send-email-nico@fluxnic.net>
 <1265255308-20514-3-git-send-email-nico@fluxnic.net>
 <20100204040046.GR14799@spearce.org> <7v7hqtty38.fsf@alter.siamese.dyndns.org>
 <7vtytxexjl.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002041243570.1681@xanadu.home>
 <20100204180015.GC18548@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 22:15:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd92Z-0007uv-Lu
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 22:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758042Ab0BDVO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 16:14:56 -0500
Received: from relais.videotron.ca ([24.201.245.36]:16565 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab0BDVOz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 16:14:55 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KXB00J0AX6T96X0@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 04 Feb 2010 13:11:17 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100204180015.GC18548@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139005>

On Thu, 4 Feb 2010, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@fluxnic.net> wrote:
> > >  --max-pack-size=<n>::
> > > -	Maximum size of each output packfile, expressed in MiB.
> > > -	The default is 4096 (4 GiB) as that is the maximum allowed
> > > +	Maximum size of each output packfile.
> > > +	The default is 4 GiB as that is the maximum allowed
> > >  	packfile size (due to file format limitations). Some
> > >  	importers may wish to lower this, such as to ensure the
> > >  	resulting packfiles fit on CDs.
> > 
> > What file format limitation is alluded to here?  It has been a while 
> > since the 4GB limit on pack file format has been removed.
> 
> The pack index v1 32 bit offset thing.  Which you fixed.
> 
> > If this is a 
> > limitation of fast-import only then maybe this should be explained more 
> > explicitly.
> 
> Damn.  It is.  fast-import can't write a v2 index.  Ugh.

Isn't it using write_idx_file()?  That function would do it all for you 
already.


Nicolas
