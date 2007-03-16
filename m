From: Nicolas Pitre <nico@cam.org>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 14:53:06 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703161433300.18328@xanadu.home>
References: <20070316042406.7e750ed0@home.brethil>
 <20070316045928.GB31606@spearce.org> <7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
 <20070316060033.GD31606@spearce.org> <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LFD.0.83.0703161145520.5518@xanadu.home>
 <Pine.LNX.4.63.0703161710400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LFD.0.83.0703161218140.5518@xanadu.home>
 <1174069353.2599.13.camel@mejai>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_zoe681yl8ZyqC08S/gq5Qw)"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Rocco Rutte <pdmef@gmx.net>, git@vger.kernel.org
To: =?iso-8859-15?Q?Steve_Fr=E9cinaux?= <nudrema@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 19:53:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSHYC-0007Ga-2z
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 19:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965831AbXCPSxN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 14:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965849AbXCPSxN
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 14:53:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14922 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965831AbXCPSxL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 14:53:11 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF0001J1F4IPXR0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 16 Mar 2007 14:53:06 -0400 (EDT)
In-reply-to: <1174069353.2599.13.camel@mejai>
X-X-Sender: nico@xanadu.home
Content-id: <alpine.LFD.0.83.0703161448020.18328@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42393>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_zoe681yl8ZyqC08S/gq5Qw)
Content-id: <alpine.LFD.0.83.0703161448021.18328@xanadu.home>
Content-type: TEXT/PLAIN; CHARSET=iso-8859-15
Content-transfer-encoding: 8BIT

On Fri, 16 Mar 2007, Steve Frécinaux wrote:

> Also, I guess what people would expect from a C library is roughly the
> same as for the current plumbing... just easier to use from another
> program. It doesn't need a low-level access to data structure (most
> applications would be to interact with an existing repo or to store data
> for a third-party software, something that is high-level) and I don't
> think such an opaque API would be a huge constraint as soon as you keep
> the Object/Index/Tree/Commit/etc basic opaque structs.

Right.  I like that idea.

A good way to define the lib API needs then might be expressed as 
follows:

  Each existing plumbing commands must be turned into the minimal 
  implementation required to interact with the libgit public API and
  display results.

  In other words, the public libgit API should provide the same 
  functionality as existing plumbing commands such that those existing
  commands will only need the necessary code to bridge the C interface
  with the existing command line interface.

Then, of course, there is the matter of reentrancy.  But that's still a 
minor API detail even if it is not a trivial issue implementation wise.  
But the API must be right as this is what we'll be stuck with even if 
the implementation may change.  And as far as an API definition is 
needed I think that it should reflect the current plumbing which is 
actually the real API that grew naturally and has been proven useful.


Nicolas

--Boundary_(ID_zoe681yl8ZyqC08S/gq5Qw)--
