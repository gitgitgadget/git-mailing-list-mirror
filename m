From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to
 significantly speed up packing/walking
Date: Fri, 07 Aug 2009 00:42:14 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908070036450.16073@xanadu.home>
References: <op.ux8i6hrbtdk399@sirnot.private>
 <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de>
 <4A7AEFA8.5010001@drmicha.warpmail.net>
 <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
 <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
 <c77435a80908061301n5e855aeci16af392ed3128651@mail.gmail.com>
 <c77435a80908061330h2461012at8b877970cab4906b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Sam Vilain <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 06:42:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZHHi-0006q4-WD
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 06:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735AbZHGEmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 00:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754513AbZHGEmV
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 00:42:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64509 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532AbZHGEmT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 00:42:19 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KNZ009PZP2EXZV0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 Aug 2009 00:42:15 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <c77435a80908061330h2461012at8b877970cab4906b@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125176>

On Thu, 6 Aug 2009, Nick Edelen wrote:

> Hrmm, I just realized that it dosn't actually cache paths/names...
> This obviously has no bearing on its use in packing, but I should
> either add that in or restrict usage in non-packing-related walks.
> Weird how things like that escape you.

Actually it is really the packing related walk that would benefit the 
most from this work.  The "counting objects" phase of a clone may take 
quite a while with some repositories.  Most other operations don't care 
as much because the rev walk is done incrementally whereas the packing 
operation needs to perform it all up front.


Nicolas
