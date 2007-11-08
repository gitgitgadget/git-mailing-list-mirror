From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-pack: segfault fix on forced push
Date: Thu, 8 Nov 2007 04:43:39 -0500
Message-ID: <20071108094339.GA20766@sigill.intra.peff.net>
References: <7vsl3h2i2j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:44:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq3vc-0006NQ-7G
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758445AbXKHJnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 04:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758565AbXKHJnm
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:43:42 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3462 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758370AbXKHJnl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 04:43:41 -0500
Received: (qmail 13271 invoked by uid 111); 8 Nov 2007 09:43:40 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 Nov 2007 04:43:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2007 04:43:39 -0500
Content-Disposition: inline
In-Reply-To: <7vsl3h2i2j.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63981>

On Thu, Nov 08, 2007 at 01:38:12AM -0800, Junio C Hamano wrote:

> When pushing to overwrite a ref that points at a commit we do
> not even have, the recent "terse push" patch tried to get a
> unique abbreviation for the non-existent (from our point of
> view) object, which resulted in strcpy(buf, NULL) and
> segfaulted.

Good catch. The fix looks obviously correct.

-Peff
