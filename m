From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Wed, 3 Oct 2007 05:05:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710030503520.28395@racer.site>
References: <20071002155800.GA6828@coredump.intra.peff.net>
 <200710021916.44388.andyparkins@gmail.com> <20071002191104.GA7901@coredump.intra.peff.net>
 <7vsl4tjo28.fsf@gitster.siamese.dyndns.org> <20071002204848.GA8284@coredump.intra.peff.net>
 <7vr6kdhwsg.fsf@gitster.siamese.dyndns.org> <20071003025853.GA11440@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 06:06:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcvVQ-0004Xi-NH
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 06:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbXJCEGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 00:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbXJCEGd
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 00:06:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:59659 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750695AbXJCEGc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 00:06:32 -0400
Received: (qmail invoked by alias); 03 Oct 2007 04:06:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 03 Oct 2007 06:06:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//3vRuXZr/gvIufpcvv4Gyg+1tc1NOGVQVhqQUpI
	Vkoi8Pp8UgvCyj
X-X-Sender: gene099@racer.site
In-Reply-To: <20071003025853.GA11440@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59777>

Hi,

On Tue, 2 Oct 2007, Jeff King wrote:

> On Tue, Oct 02, 2007 at 05:22:23PM -0700, Junio C Hamano wrote:
> 
> > >   strbuf_init(&url);
> > >   strbuf_addf(&url, "%s/objects/pack/pack-%s.idx", repo->base, hex);
> > 
> > Ugh, this typically calls snprintf() twice doesn't it?
> 
> Yes, it probably does. However, I think it is considerably easier to
> read and more maintainable. Are you "ugh"ing because of the performance
> impact (which should be negligible unless this is in a tight loop) or
> because of the portability problems associated with va_copy?

I wonder, I wonder, if

	strbuf_addstr(&url, repo->base);
	strbuf_addstr(&url, "/objects/pack/pack-");
	strbuf_addstr(&url, hex);
	strbuf_addstr(&url, ".idx");

would make anybody else but me happy...

Ciao,
Dscho
