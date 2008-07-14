From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/4] Honor core.deltaBaseCacheLimit during index-pack
Date: Mon, 14 Jul 2008 13:10:47 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807141309340.8950@racer>
References: <20080713011512.GB31050@spearce.org> <1216001267-33235-1-git-send-email-spearce@spearce.org> <alpine.LFD.1.10.0807132220570.12484@xanadu.home> <20080714031242.GA14542@spearce.org> <alpine.LSU.1.00.0807141216390.32392@wbgn129.biozentrum.uni-wuerzburg.de>
 <m31w1wu1hc.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>,
	Andreas Ericsson <ae@op5.se>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 14:12:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIMuH-0007uY-Iz
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 14:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbYGNMKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 08:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbYGNMKy
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 08:10:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:42039 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751419AbYGNMKy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 08:10:54 -0400
Received: (qmail invoked by alias); 14 Jul 2008 12:10:52 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp066) with SMTP; 14 Jul 2008 14:10:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/1jWFXm9f1yQYvSaxAhfrDCNVuf3H+WdnRRsUImW
	VZgQquYxO4PKeT
X-X-Sender: gene099@racer
In-Reply-To: <m31w1wu1hc.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88417>

Hi,

On Mon, 14 Jul 2008, Jakub Narebski wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > On Mon, 14 Jul 2008, Shawn O. Pearce wrote:
> 
> > > The only other alternative I can come up with is to change pack-objects 
> > > (or at least its defaults) so we don't generate these massive delta 
> > > chains.  But there are already packs in the wild that use these chains, 
> > > resulting in performance problems for clients.
> > 
> > But the long chains make the pack actually as efficient as it is...
> 
> Perhaps Shawn thought here about limiting delta chain not by its
> *length*, but by its *size* (as required when unpacking last object
> in a delta chanin).

So you mean once the sizes of the reconstructed objects are too big, i.e. 
when the delta chain is actually _most useful_, we should not do it?  
Don't think so.

Ciao,
Dscho
