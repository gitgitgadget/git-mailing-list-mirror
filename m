From: Jeff King <peff@peff.net>
Subject: Re: What is 'git BRANCH'?
Date: Wed, 30 Jul 2008 01:14:53 -0400
Message-ID: <20080730051453.GB4034@sigill.intra.peff.net>
References: <g6o4vi$rap$1@ger.gmane.org> <7vej5cba6z.fsf@gitster.siamese.dyndns.org> <7v63qob9hz.fsf@gitster.siamese.dyndns.org> <bd6139dc0807291549y66c56fbah928a854f37573680@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jurko =?utf-8?Q?Gospodneti=C4=87?= <jurko.gospodnetic@docte.hr>,
	git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Wed Jul 30 07:15:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO42V-0008GA-LL
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 07:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbYG3FO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 01:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbYG3FOz
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 01:14:55 -0400
Received: from peff.net ([208.65.91.99]:2622 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225AbYG3FOz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 01:14:55 -0400
Received: (qmail 5198 invoked by uid 111); 30 Jul 2008 05:14:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 30 Jul 2008 01:14:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jul 2008 01:14:53 -0400
Content-Disposition: inline
In-Reply-To: <bd6139dc0807291549y66c56fbah928a854f37573680@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90742>

On Wed, Jul 30, 2008 at 12:49:00AM +0200, Sverre Rabbelier wrote:

> Why does handle_internal_command not complain after the "	for (i = 0;
> i < ARRAY_SIZE(commands); i++) {" that no matching commands were
> found? Is that not an implicit assertion that would do well with being
> asserted here?

Because it is called from two places. In one, we _know_ that this must
be internal, so we die right after. In the other, we try internal, then
external, then alias. So we don't want to die. Grep for
handle_internal_cmmand in git.c.

-Peff
