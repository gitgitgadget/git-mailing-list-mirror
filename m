From: Jeff King <peff@peff.net>
Subject: Re: git not resuming push
Date: Wed, 23 Nov 2011 13:46:15 -0500
Message-ID: <20111123184614.GA21146@sigill.intra.peff.net>
References: <4ECC6F80.6010907@piem.org>
 <20111123050220.GA9127@sigill.intra.peff.net>
 <7vmxbncq5v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Brossier <piem@piem.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 19:46:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTHpv-0007g9-Q7
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 19:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800Ab1KWSqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 13:46:19 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49385
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892Ab1KWSqS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 13:46:18 -0500
Received: (qmail 5161 invoked by uid 107); 23 Nov 2011 18:46:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Nov 2011 13:46:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Nov 2011 13:46:15 -0500
Content-Disposition: inline
In-Reply-To: <7vmxbncq5v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185862>

On Tue, Nov 22, 2011 at 10:24:12PM -0800, Junio C Hamano wrote:

> Another possibility, if it is the connection between you and the other
> side that is the problem, is to chunk your push in smaller pieces. That
> is, if you are trying to push out v3.0, you first push only to v1.0, then
> to v2.0, and then finally to v3.0.
> 
> Peff, by the way, wouldn't this request reminds of us of a scenario we
> discussed recently, which I said I would imagine would be common while you
> dismissed as not likely to be common?

I didn't say it wasn't common; I said I didn't think it was the majority
case, and that I didn't want a solution that only helped this case
without covering the other cases.

Also, it isn't clear to me that an immediate-reconnect scheme would
work. When the connection gets dropped, is it simply that TCP connection
that goes out, and another one could immediately be made to resume? Or
is the network actually out (even if only for a few seconds)?

-Peff
