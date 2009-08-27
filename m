From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes trees
 with various fanout schemes
Date: Thu, 27 Aug 2009 12:47:49 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908271243120.7562@intel-tinevez-2-302>
References: <1251337437-16947-1-git-send-email-johan@herland.net> <1251337437-16947-9-git-send-email-johan@herland.net> <7v7hwp6ebb.fsf@alter.siamese.dyndns.org> <200908271135.31794.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Aug 27 12:48:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgcWZ-0006XD-Mk
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 12:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbZH0Kru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 06:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbZH0Kru
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 06:47:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:45042 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751229AbZH0Krt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 06:47:49 -0400
Received: (qmail invoked by alias); 27 Aug 2009 10:47:50 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp028) with SMTP; 27 Aug 2009 12:47:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GS/lRrUAG0waS3xXur0NCqEZTYxAr50dnFf6KQH
	6vLk9bIXDnHq5W
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200908271135.31794.johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127154>

Hi,

On Thu, 27 Aug 2009, Johan Herland wrote:

> On Thursday 27 August 2009, Junio C Hamano wrote:

> > Somebody up in the project is supposed to decide what fan-out is to be 
> > used for the whole project and everybody should follow that structure?
> 
> Nope, the code should decide which fanout scheme to use.

I half-agree, the code should decide which fanout scheme to use, but 
_only_ when producing new notes.

I imagine that it could merge the existing notes, and try to make sure 
that there are no more blobs in a given subtree than a certain threshold; 
if that threshold is reached, it could fan-out using 2-digit subtrees, 
merging what needs merging (by concatenation) along the way.

The natural precedence of shallower paths/longer basenames should cope 
well with that (i.e. prefer to show abcd/... over ab/cd/...).

Ciao,
Dscho
