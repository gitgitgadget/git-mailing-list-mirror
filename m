From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: default behaviour for `gitmerge` (no arguments)
Date: Wed, 13 Jan 2010 12:04:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001131202510.3043@intel-tinevez-2-302>
References: <loom.20100111T185144-655@post.gmane.org> <7v7hrojukz.fsf@alter.siamese.dyndns.org> <20100112162355.GB25092@coredump.intra.peff.net> <7vhbqr2nxt.fsf@alter.siamese.dyndns.org> <20100112182550.GA15696@coredump.intra.peff.net>
 <7vwrzmqypn.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1001131024420.3043@intel-tinevez-2-302> <7v6376pc9w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Gareth Adams <gareth.adams@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 12:04:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV11Y-0001nI-3l
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 12:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465Ab0AMLEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 06:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755487Ab0AMLEX
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 06:04:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:60668 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754959Ab0AMLEX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 06:04:23 -0500
Received: (qmail invoked by alias); 13 Jan 2010 11:04:20 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp061) with SMTP; 13 Jan 2010 12:04:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0aPAKI5+0TKyXtsxU8WduUNOKfAuJmpS1t13bPs
	FkC/+8VVwBnMwE
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7v6376pc9w.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136809>

Hi,

On Wed, 13 Jan 2010, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I wondered why it doesn't hook into interpret_branch_name(), and 
> >> instead adds itself to the static substitute_branch_name(); it 
> >> forbids the use of the syntax from by callers of strbuf_branchname().
> >
> > I _think_ it was to allow something like
> >
> > 	git log -g @{u}
> >
> > but frankly, this is so long ago, I do not remember, I reconstructed this 
> > reasoning as being the most likely.
> 
> That is not the question I was asking.
> 
> If you compare substitute_branch_name() and interpret_branch_name() before
> your patch, you will notice that they are _meant_ to do the same thing,
> with different external API, only because many callers in sha1_name.c do
> not use strbuf to hold their names.  The primary API is the latter (which
> is extern), and the former (which is static) is merely a helping wrapper
> that is internal to sha1_name.c

So you meant to say that substitute_branch_name() calls 
interpret_branch_name(), so the change should be in the latter.  (This is 
supposed to be the summary of your 4 paragraphs.)

I have no problems with that, except that I do not have the time to do it 
myself.

Ciao,
Dscho
