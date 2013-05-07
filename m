From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] deprecate core.statinfo at Git 2.0 boundary
Date: Tue, 7 May 2013 10:09:05 -0400
Message-ID: <20130507140904.GA3282@sigill.intra.peff.net>
References: <7v4niblhr6.fsf@alter.siamese.dyndns.org>
 <1358840962-12316-1-git-send-email-robin.rosenberg@dewire.com>
 <20130506232242.GA27393@sigill.intra.peff.net>
 <7va9o7o0dl.fsf@alter.siamese.dyndns.org>
 <7v1u9jnyox.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	j sixt <j.sixt@viscovery.net>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 07 16:09:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZiaB-0001Y8-DT
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 16:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933019Ab3EGOJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 10:09:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:48181 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933754Ab3EGOJH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 10:09:07 -0400
Received: (qmail 13594 invoked by uid 102); 7 May 2013 14:09:28 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 May 2013 09:09:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 May 2013 10:09:05 -0400
Content-Disposition: inline
In-Reply-To: <7v1u9jnyox.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223569>

On Mon, May 06, 2013 at 10:31:10PM -0700, Junio C Hamano wrote:

> c08e4d5b5cfa (Enable minimal stat checking, 2013-01-22) advertised
> the configuration variable core.checkstat in the documentation and
> its log message, but the code expected core.statinfo instead.
> 
> For now, add core.checkstat, and warn people who have core.statinfo
> in their configuration file that we will remove it in Git 2.0.

Yeah, that looks like a fine solution to me.

To be honest, I doubt that it is even necessary to handle the backwards
compatibility. The checkstat option never actually worked, statinfo was
never advertised, and the broken state was available in only one
release. So I'd be very surprised if anyone more than the author was
actually using it.

Still, it is not that hard to handle both, so I suppose it is better to
be conservative.

-Peff
