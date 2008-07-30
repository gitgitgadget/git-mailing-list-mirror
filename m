From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Advertise the ability to abort a commit
Date: Wed, 30 Jul 2008 01:11:00 -0400
Message-ID: <20080730051059.GA4497@sigill.intra.peff.net>
References: <1217359925-30130-1-git-send-email-mail@cup.kalibalik.dk> <1217362342-30370-1-git-send-email-mail@cup.kalibalik.dk> <20080730050715.GA4034@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Wed Jul 30 07:12:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO3yn-0007a3-NY
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 07:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbYG3FLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 01:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbYG3FLE
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 01:11:04 -0400
Received: from peff.net ([208.65.91.99]:4301 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbYG3FLD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 01:11:03 -0400
Received: (qmail 5168 invoked by uid 111); 30 Jul 2008 05:11:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 30 Jul 2008 01:11:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jul 2008 01:11:00 -0400
Content-Disposition: inline
In-Reply-To: <20080730050715.GA4034@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90741>

On Wed, Jul 30, 2008 at 01:07:15AM -0400, Jeff King wrote:

> > -		die("no commit message?  aborting commit.");
> > +		die("no commit message.  aborting commit.");
> 
> I don't think the change of punctuation makes a big difference here,
> but this could probably stand to be reworded. Maybe:
> 
>   Aborting commit due to empty commit message.

Using "die" also prepends "fatal: " which is perhaps a bit much for an
expected feature. So maybe:

  fprintf(stderr, "Aborting commit due to empty commit message.\n");
  exit(1); /* or even some specific "intentional abort" exit code */

-Peff
