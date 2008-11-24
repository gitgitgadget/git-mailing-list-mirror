From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] bisect: teach "skip" to accept special arguments  
 like "A..B"
Date: Mon, 24 Nov 2008 11:35:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811241134540.30769@pacific.mpi-cbg.de>
References: <20081123220249.2e7f30a5.chriscool@tuxfamily.org> <alpine.DEB.1.00.0811240126430.30769@pacific.mpi-cbg.de> <492A5346.1040405@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 24 11:28:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4Yg7-0005he-Mg
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 11:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbYKXK1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 05:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbYKXK1J
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 05:27:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:43721 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750703AbYKXK1I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 05:27:08 -0500
Received: (qmail invoked by alias); 24 Nov 2008 10:27:05 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp032) with SMTP; 24 Nov 2008 11:27:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187/SJybI47UZbqpstDX552EgA51S7kjPAFfHqa5s
	ry4mwTNoj73SZm
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <492A5346.1040405@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101595>

Hi,

On Mon, 24 Nov 2008, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > On Sun, 23 Nov 2008, Christian Couder wrote:
> >> 	Dscho wrote:
> >> 	> Would it not be more intuitive to have support for
> >> 	>
> >>         > git bisect skip A..B
> >> 	>
> >> 	> ?
> >>
> >> 	Here is a patch to do that. I am not sure it's worth it
> >> 	because this is a special case in many ways.
> > 
> > Why not have something like
> > 
> > 	skip)
> > 		for arg in $(git rev-list "$@")
> > 		do
> > 			bisect_state skip $arg
> > 		done
> 
> Because if you say
> 
> 	$ git bisect skip
> 
> this would be incorrectly calling rev-list; but more importantly, if you say
> 
> 	$ git bisect skip A
> 
> then this would skip A *and all its ancestors*. Not quite what you intended.

Good point indeed.

Thanks,
Dscho
