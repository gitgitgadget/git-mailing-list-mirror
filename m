From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Tue, 14 Feb 2012 03:20:51 -0500
Message-ID: <20120214082051.GA9911@sigill.intra.peff.net>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
 <1328865494-24415-7-git-send-email-michal.kiedrowicz@gmail.com>
 <m339aivn4z.fsf@localhost.localdomain>
 <20120214075439.14f1d2b7@mkiedrowicz.ivo.pl>
 <7vpqdh999t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 09:21:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxDdE-0003rB-IX
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 09:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756422Ab2BNIU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 03:20:56 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35416
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754675Ab2BNIUz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 03:20:55 -0500
Received: (qmail 5924 invoked by uid 107); 14 Feb 2012 08:28:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 03:28:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 03:20:51 -0500
Content-Disposition: inline
In-Reply-To: <7vpqdh999t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190708>

On Mon, Feb 13, 2012 at 11:14:22PM -0800, Junio C Hamano wrote:

> > We could tech diff-highlight to produce diffs
> > marked with -{} and +{} (this is the notation used by Jeff in one of his
> > recent patches) or something like this and then just convert that into
> > HTML markup.
> 
> this implementation strategy would not work well, given that the payload
> can contain arbitrary letter sequence (e.g. a Perl script that wants be
> explicit when writing a hashref literal write +{...}  to disambiguate it
> from a block).  If you are going to modularize diff-highlight and reuse
> it, it needs to learn how to talk HTML to properly escape the payload.

They're both written in perl; perhaps a more sensible solution would be
to lib-ify diff-highlight and use it directly inside gitweb.

-Peff
