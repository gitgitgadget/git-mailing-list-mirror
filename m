From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Thu, 24 Feb 2011 14:46:19 -0500
Message-ID: <1298576779.19041.48.camel@drew-northup.unet.maine.edu>
References: <20110219111103.GA1841@elie>
	 <20110222155637.GC27178@sigill.intra.peff.net>
	 <7v4o7vdfz2.fsf@alter.siamese.dyndns.org>
	 <20110223045143.GA11846@sigill.intra.peff.net>
	 <7vlj16aeih.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1102231213280.26358@xanadu.home>
	 <1298502543.28664.19.camel@drew-northup.unet.maine.edu>
	 <alpine.LFD.2.00.1102231908340.26358@xanadu.home>
	 <1298567455.19041.39.camel@drew-northup.unet.maine.edu>
	 <alpine.LFD.2.00.1102241252000.26358@xanadu.home>
	 <20110224190808.GB4318@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 20:48:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PshB0-0001OE-3y
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 20:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440Ab1BXTsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 14:48:32 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:36806 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289Ab1BXTsa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 14:48:30 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p1OJkOQ3004024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 24 Feb 2011 14:46:29 -0500
In-Reply-To: <20110224190808.GB4318@sigill.intra.peff.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=7
	Fuz1=7 Fuz2=7
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p1OJkOQ3004024
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1299181624.28392@mK3VD5RihHIQ2x7ksos5Ug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167856>


On Thu, 2011-02-24 at 14:08 -0500, Jeff King wrote:
> On Thu, Feb 24, 2011 at 01:04:21PM -0500, Nicolas Pitre wrote:
> 
> > > It can be done as a separate patch, but it should all be done in the
> > > public branch (pu?) as atomically as possible (one merge from Junio's
> > > workspace). In other words, the public branch should never fail to build
> > > because of this work.
> > 
> > Who said this would fail to compile?
> > 
> > If you move bar.c into the foo directory, then in the existing Makefile 
> > you simply have to make a mechanical rename of bar.c to foo/bar.c.  
> > Restructuring the Makefile can be done separately from the file move 
> > without ever breaking the build (except for unintentional mistakes of 
> > course).
> 
> Exactly. Maybe it wasn't clear in the previous bits of the thread, but
> Makefile reorganization is a totally optional thing that can come on top
> of file movement if we choose. I just brought it up with file movement
> because having a bunch of subdirs is going to probably make us _want_ to
> do something with Makefiles.
> 
> In the interim it may not work to run make from the "cmds" subdirectory,
> but that is not a "fail to build" breakage. As long as we build via
> "make" from the root, then there is no regression. Adding extra make
> fluff on top of that is feature work, not a bug fix.
> 
> -Peff

I am glad to hear that is the case here. Pretty much everything else
I've ever worked on absolutely breaks if files are moved around and
Makefiles are not updated to suit.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
