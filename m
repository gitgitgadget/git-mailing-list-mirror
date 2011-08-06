From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fast-export: quote paths in output
Date: Fri, 5 Aug 2011 20:36:04 -0600
Message-ID: <20110806023604.GA7013@sigill.intra.peff.net>
References: <20110805105526.GA22480@sigill.intra.peff.net>
 <4E3BD006.6010005@viscovery.net>
 <20110805223622.GA5808@sigill.intra.peff.net>
 <7v4o1v31uw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	James Gregory <j.gregory@epigenesys.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 06 04:38:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpWmZ-0004tj-QA
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 04:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592Ab1HFCgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 22:36:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56236
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752283Ab1HFCgI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 22:36:08 -0400
Received: (qmail 540 invoked by uid 107); 6 Aug 2011 02:36:42 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Aug 2011 22:36:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Aug 2011 20:36:04 -0600
Content-Disposition: inline
In-Reply-To: <7v4o1v31uw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178820>

On Fri, Aug 05, 2011 at 03:55:19PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +	 git read-tree --empty &&
> 
> Hmmmm, this adds more work to the backporting of this fix.

We can easily replace it with "rm -f .git/index". Or we can be fancy and
actually tell update-index to drop the entries individually, but they
are somewhat of a pain to manipulate, given that they have magic
characters.

-Peff
