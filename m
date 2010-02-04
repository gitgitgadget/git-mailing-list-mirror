From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] make --max-pack-size argument to 'git pack-object'
	count in bytes
Date: Thu, 4 Feb 2010 13:20:33 -0800
Message-ID: <20100204212033.GB18668@spearce.org>
References: <1265255308-20514-1-git-send-email-nico@fluxnic.net> <1265255308-20514-3-git-send-email-nico@fluxnic.net> <20100204040046.GR14799@spearce.org> <7v7hqtty38.fsf@alter.siamese.dyndns.org> <7vtytxexjl.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1002041243570.1681@xanadu.home> <20100204180015.GC18548@spearce.org> <alpine.LFD.2.00.1002041309090.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 22:21:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd98B-0003h0-Qu
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 22:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758297Ab0BDVUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 16:20:43 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50961 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758243Ab0BDVUm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 16:20:42 -0500
Received: by vws20 with SMTP id 20so1026476vws.19
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 13:20:41 -0800 (PST)
Received: by 10.220.124.25 with SMTP id s25mr2582956vcr.68.1265318440010;
        Thu, 04 Feb 2010 13:20:40 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 33sm4447573vws.11.2010.02.04.13.20.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Feb 2010 13:20:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1002041309090.1681@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139008>

Nicolas Pitre <nico@fluxnic.net> wrote:
> On Thu, 4 Feb 2010, Shawn O. Pearce wrote:
> > Nicolas Pitre <nico@fluxnic.net> wrote:
> > > >  --max-pack-size=<n>::
> > > > -	Maximum size of each output packfile, expressed in MiB.
> > > > -	The default is 4096 (4 GiB) as that is the maximum allowed
> > > > +	Maximum size of each output packfile.
> > > > +	The default is 4 GiB as that is the maximum allowed
> > > >  	packfile size (due to file format limitations). Some
> > > >  	importers may wish to lower this, such as to ensure the
> > > >  	resulting packfiles fit on CDs.
> > > 
> > > What file format limitation is alluded to here?  It has been a while 
> > > since the 4GB limit on pack file format has been removed.
> > 
> > The pack index v1 32 bit offset thing.  Which you fixed.
> > 
> > > If this is a 
> > > limitation of fast-import only then maybe this should be explained more 
> > > explicitly.
> > 
> > Damn.  It is.  fast-import can't write a v2 index.  Ugh.
> 
> Isn't it using write_idx_file()?  That function would do it all for you 
> already.

Nope.  Its still using its own code.  I never ported it to
write_idx_file().  And I don't have the CRC32 data available for
each object (it failed to compute/save it as it wrote).

I mean to port to write_idx_file() but didn't... :-(


-- 
Shawn.
