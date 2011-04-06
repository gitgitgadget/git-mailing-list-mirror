From: Jeff King <peff@github.com>
Subject: Re: Re* git commit fails under some circumstances
Date: Wed, 6 Apr 2011 13:57:01 -0400
Message-ID: <20110406175700.GB8205@sigill.intra.peff.net>
References: <AANLkTikHRM10p9e8XCzuiih7cYtQRG7Az2Qn5qtPzhZJ@mail.gmail.com>
 <7vhbagh3aw.fsf@alter.siamese.dyndns.org>
 <20110405173603.GD9965@sigill.intra.peff.net>
 <7v1v1fjnsu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Laszlo Papp <djszapi@archlinux.us>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 19:57:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Wye-0004Hz-O0
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 19:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756059Ab1DFR5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 13:57:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47017
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754903Ab1DFR5F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 13:57:05 -0400
Received: (qmail 7186 invoked by uid 107); 6 Apr 2011 17:57:51 -0000
Received: from 205.158.58.41.ptr.us.xo.net (HELO sigill.intra.peff.net) (205.158.58.41)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Apr 2011 13:57:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Apr 2011 13:57:01 -0400
Content-Disposition: inline
In-Reply-To: <7v1v1fjnsu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170996>

On Wed, Apr 06, 2011 at 10:24:17AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I am much more concerned with whether and how this information would be
> > represented in the "git status --porcelain" format.
> 
> I earlier suggested using 'I'; a safer alternative would be to change
> nothing and let the callers figure it out.

Ah, sorry, I missed that.

> I slightly favor the former; while there is a definite risk of
> breaking scripts' expectations, they can be tentatively marked "this
> script does not work until you 'git add' paths you used 'add -N'" and
> I don't think it would be such a big deal.

I think that is reasonable. Maintaining backwards compatibility doesn't
mean we can _never_ expand to cover new situations or give more
information. In this case we would be maintaining syntactic
compatibility, and have identical output when the "add -N" feature is
not used.

-Peff
