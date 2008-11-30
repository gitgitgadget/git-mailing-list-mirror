From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] git add --intent-to-add: fix removal of cached
	emptiness
Date: Sun, 30 Nov 2008 14:21:01 -0500
Message-ID: <20081130192101.GD10981@coredump.intra.peff.net>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de> <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de> <20081128192033.GF23984@spearce.org> <7voczz4cfb.fsf@gitster.siamese.dyndns.org> <7vk5an4cba.fsf_-_@gitster.siamese.dyndns.org> <7vvdu72nq9.fsf@gitster.siamese.dyndns.org> <7vprkf2nki.fsf_-_@gitster.siamese.dyndns.org> <bd6139dc0811290738qbd93ff6oa7aa854708009075@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Sun Nov 30 20:22:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6rsE-0006pR-6m
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 20:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbYK3TVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 14:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752492AbYK3TVE
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 14:21:04 -0500
Received: from peff.net ([208.65.91.99]:2441 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545AbYK3TVE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 14:21:04 -0500
Received: (qmail 9571 invoked by uid 111); 30 Nov 2008 19:21:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 30 Nov 2008 14:21:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Nov 2008 14:21:01 -0500
Content-Disposition: inline
In-Reply-To: <bd6139dc0811290738qbd93ff6oa7aa854708009075@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101983>

On Sat, Nov 29, 2008 at 04:38:12PM +0100, Sverre Rabbelier wrote:

> On Sat, Nov 29, 2008 at 04:55, Junio C Hamano <gitster@pobox.com> wrote:
> > This uses the extended index flag mechanism introduced earlier to mark
> > the entries added to the index via "git add -N" with CE_INTENT_TO_ADD.
> 
> Is 'intent' [0] used properly here? Should it not be 'intend' [1]?
> 
> [0] http://en.wiktionary.org/wiki/intent
> [1] http://en.wiktionary.org/wiki/intend

I think it's fine. The flags describe the entry, not the user (e.g.,
CE_VALID). So the entry does not _intend_ to add anything, but rather
there exists _intent_ to add this entry (you might also say the entry is
"_intended_ to be added", but that is getting a bit clunky).

-Peff
