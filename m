From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce get_octopus_merge_bases() in commit.c
Date: Tue, 10 Jun 2008 00:08:01 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806100006140.1783@racer>
References: <alpine.DEB.1.00.0806091458190.1783@racer> <1213051426-11530-1-git-send-email-vmiklos@frugalware.org> <7vd4mqfcb0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:10:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5qVH-00069T-4O
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 01:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759834AbYFIXJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 19:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759659AbYFIXJV
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 19:09:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:36997 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759318AbYFIXJU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 19:09:20 -0400
Received: (qmail invoked by alias); 09 Jun 2008 23:09:18 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp051) with SMTP; 10 Jun 2008 01:09:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/T601GFV3Tv3ZyDFtYYfi9voti9fN6Sjmwasa0Iv
	A40ZSVkaZzHnnl
X-X-Sender: gene099@racer
In-Reply-To: <7vd4mqfcb0.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84449>

Hi,

On Mon, 9 Jun 2008, Junio C Hamano wrote:

> Miklos Vajna <vmiklos@frugalware.org> writes:
> 
> > Exactly. I modified merge_bases_many() to use a commit list.
> 
> I just looked at your f755fb6; from the point of view of merge_bases() 
> which is far more often used, I think this is not an improvement but 
> actively wrong thing to do.  Most of the time callers compute merge base 
> of two, and the codepath should be optimized for that case.

But how much work is

	struct commit_list list = { two, NULL };

	merge_bases_many(one, &list);

?  merge_bases_many() does not modify the list IIRC, and it looks 
conceptually clean while being pretty much in the same performance 
ballpark.

Ciao,
Dscho
