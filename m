From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2] make pack-objects a bit more resilient to repo
 corruption
Date: Fri, 22 Oct 2010 17:19:29 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010221714450.2764@xanadu.home>
References: <alpine.LFD.2.00.1010220037250.2764@xanadu.home>
 <20101022144600.GA5554@sigill.intra.peff.net>
 <alpine.LFD.2.00.1010221427390.2764@xanadu.home>
 <alpine.LFD.2.00.1010221606550.2764@xanadu.home>
 <AANLkTimy-ihrF1syWYe3T4W6-UHzCaj5Jud5rdFmv3D5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_eyzmE/gVUuV8jAxJ73175w)"
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 23:19:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9P1U-0006ym-Q4
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 23:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032Ab0JVVTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 17:19:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12170 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454Ab0JVVTa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 17:19:30 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LAP006FCN8IS110@VL-MR-MRZ22.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Oct 2010 17:19:30 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTimy-ihrF1syWYe3T4W6-UHzCaj5Jud5rdFmv3D5@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159752>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_eyzmE/gVUuV8jAxJ73175w)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Fri, 22 Oct 2010, Sverre Rabbelier wrote:

> Heya,
> 
> On Fri, Oct 22, 2010 at 13:26, Nicolas Pitre <nico@fluxnic.net> wrote:
> > +                               static int warned = 0;
> > +                               if (!warned++)
> > +                                       warning("object %s cannot be read",
> > +                                               sha1_to_hex(src_entry->idx.sha1));
> 
> How does this handle multiple missing objects? Will it only warn for
> the first one?

Yes, only the first one, so you have a bone to chase if that ever 
happens to you.  And that's good enough IMHO.  Trying to warn for every 
missing object would require extra storage per object to remember if any 
particular object was warned for already, which is I think overkill for 
an extremely unlikely event.  Comprehensive reporting is the job of 
fsck.


Nicolas

--Boundary_(ID_eyzmE/gVUuV8jAxJ73175w)--
