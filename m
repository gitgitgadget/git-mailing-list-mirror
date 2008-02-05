From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/9] Add "skip_unmerged" option to unpack_trees.
Date: Tue, 5 Feb 2008 01:32:08 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802050129570.8543@racer.site>
References: <alpine.LNX.1.00.0802041335530.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 02:33:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMCgf-0004UC-PO
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 02:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466AbYBEBcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 20:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755359AbYBEBcx
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 20:32:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:53419 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754667AbYBEBcx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 20:32:53 -0500
Received: (qmail invoked by alias); 05 Feb 2008 01:32:50 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp021) with SMTP; 05 Feb 2008 02:32:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/15adfCRX1qTXPabTdqb8Xl6kWRWTRMrt+9E7x0K
	se5JWdeHLv8Cag
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802041335530.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72609>

Hi,

On Mon, 4 Feb 2008, Daniel Barkalow wrote:


>  		if (any_files) {
> -			if (o->merge) {
> +			if (skip_entry) {
> +				do
> +					o->pos++;
> +				while (o->pos < active_nr &&
> +				       !strcmp(active_cache[o->pos]->name,
> +					       src[0]->name));
> +			} else if (o->merge) {

Maybe it is just me, but I would have thought

				while (++o->pos < active_nr)
					if (strcmp(active_cache[o->pos]->name,
							src[0]->name))
						break;

more readable.  But that's maybe because I have trouble with do ... while 
constructs logically (I like to see the loop condition first, then the 
loop body).

Ciao,
Dscho
