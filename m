From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] send-pack: cluster ref status reporting
Date: Wed, 21 Nov 2007 02:33:32 -0500
Message-ID: <20071121073332.GA10244@sigill.intra.peff.net>
References: <20071120111317.GA4120@sigill.intra.peff.net> <20071120111801.GA7814@sigill.intra.peff.net> <7v1wakhxh4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 08:33:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuk5o-0006SP-M3
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 08:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbXKUHdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 02:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbXKUHdf
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 02:33:35 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4017 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755312AbXKUHdf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 02:33:35 -0500
Received: (qmail 4828 invoked by uid 111); 21 Nov 2007 07:33:34 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 21 Nov 2007 02:33:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2007 02:33:32 -0500
Content-Disposition: inline
In-Reply-To: <7v1wakhxh4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65609>

On Tue, Nov 20, 2007 at 11:24:55PM -0800, Junio C Hamano wrote:

> > +	case REF_STATUS_REMOTE_REJECT:
> > +		print_ref_status('!', "[remote rejected]", ref,
> > +				ref->deletion ? ref->peer_ref : NULL,
> > +				ref->remote_status);
> > +		break;
> > +	case REF_STATUS_EXPECTING_REPORT:
> > +		print_ref_status('!', "[remote failure]", ref,
> > +				ref->deletion ? ref->peer_ref : NULL,
> > +				"remote failed to report status");
> > +		break;
> 
> Eh,... in ref->deletion mode, the peer_ref is...

Gah, sorry. This crept in because I based it on the previous, broken
version of the other patch series which had the same problem (and
obviously this chunk is just a pure code move + reindent).

But pretend like it was competently prepared and give your comments on
the idea. ;)

-Peff
