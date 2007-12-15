From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: testsuite failures in mainline...
Date: Sat, 15 Dec 2007 01:18:59 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712150117330.27959@racer.site>
References: <20071214214533.GA4943@steel.home> <20071214.142448.52660507.davem@davemloft.net>
 <7v7ijgq311.fsf@gitster.siamese.dyndns.org> <20071214.160845.185161708.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, raa.lkml@gmail.com, git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Sat Dec 15 02:19:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3Lgn-0001z9-VP
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 02:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754408AbXLOBTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 20:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754348AbXLOBTL
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 20:19:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:50898 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752377AbXLOBTK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 20:19:10 -0500
Received: (qmail invoked by alias); 15 Dec 2007 01:19:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 15 Dec 2007 02:19:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7wg5QJgX7tol1w8hka0RzYmVx/w1EN/ajuoF9gM
	kLm/+XS2fy8XPf
X-X-Sender: gene099@racer.site
In-Reply-To: <20071214.160845.185161708.davem@davemloft.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68368>

Hi,

On Fri, 14 Dec 2007, David Miller wrote:

> -	char space[FLEX_ARRAY]; /* more */
> +	uintmax_t space[FLEX_ARRAY]; /* more */

Usually, a much better idea is to use

	union {
		char cp[FLEX_ARRAY];
		uintmax_t up[FLEX_ARRAY];
	}

because that is exactly the reason union was invented for.

Ciao,
Dscho
