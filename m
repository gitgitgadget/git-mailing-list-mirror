From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] builtin-fast-export: Add importing and exporting of
 revision marks
Date: Wed, 11 Jun 2008 19:45:27 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806111941160.1783@racer>
References: <7vve0hdbvv.fsf@gitster.siamese.dyndns.org> <1213183024-60013-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Wed Jun 11 20:47:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6VM9-0004h5-Cf
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 20:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbYFKSqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 14:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752258AbYFKSqn
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 14:46:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:54022 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751488AbYFKSqm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 14:46:42 -0400
Received: (qmail invoked by alias); 11 Jun 2008 18:46:40 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 11 Jun 2008 20:46:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ugO4Hr86uDExNwD4Dy1d7675Bd1RREDNehxx6aS
	SwRcLE2L+BmzMZ
X-X-Sender: gene099@racer
In-Reply-To: <1213183024-60013-1-git-send-email-pdebie@ai.rug.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84636>

Hi,

On Wed, 11 Jun 2008, Pieter de Bie wrote:

>   I actually had this new patch ready, but I was hoping Dscho would answer
>   this first:
>   
> On 7 jun 2008, at 18:37, Junio C Hamano wrote:
> >Oh, I was not complaining about the one-fourthness.  I was wondering why
> >"(uint32_t *)", which makes it look like the type itself has very deep
> >meaning for this computation, was used, instead of "(char *)" or something
> >that makes it much clearer that what could be pointed at by the pointer
> >does not matter and you are only using them as fake integers.  If there is
> >such a deep meaning, it needs documented, and if there isn't then probably
> >the use of (uint32_t *) should also be fixed.
>   
>   since I don't know the answer to that :)

I think that your patch does not need to address that, as the logic is (or 
should be) confined to the functions markt_object() and get_object_mark() 
(except that you have to split off mark_to_ptr() from 
mark_object(), as you did).

Unfortunately, I did not yet have time to look up the discussion on the 
mailing list that led me to implement this funny pointer arithmetic.

Ciao,
Dscho
