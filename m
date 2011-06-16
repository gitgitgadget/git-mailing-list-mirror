From: Jeff King <peff@github.com>
Subject: Re: [PATCH 7/7] archive: provide builtin .tar.gz filter
Date: Thu, 16 Jun 2011 02:51:46 -0400
Message-ID: <20110616065146.GA30672@sigill.intra.peff.net>
References: <20110616003800.GC20355@sigill.intra.peff.net>
 <7v39jai94h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 08:51:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QX6Qk-0006Or-A2
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 08:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180Ab1FPGvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 02:51:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49459
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049Ab1FPGvs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 02:51:48 -0400
Received: (qmail 11864 invoked by uid 107); 16 Jun 2011 06:51:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jun 2011 02:51:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2011 02:51:46 -0400
Content-Disposition: inline
In-Reply-To: <7v39jai94h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175882>

On Wed, Jun 15, 2011 at 11:27:26PM -0700, Junio C Hamano wrote:

> Jeff King <peff@github.com> writes:
> 
> > This feels a little wrong, as we are changing what the tool outputs all
> > the time just to appease a poorly-written test.
> 
> Now you confused me.  Isn't '-n' to tell the tool *not* to write timestamp
> out, so that we can avoid changing what the tool outputs all the time?

No, I mean that people may _want_ the timestamp in day to day use. Using
"-n" all the time suppresses it. And there is no reason to suppress it,
except that our test does not account for it properly. So your patch is
hurting people who don't want "-n" (i.e., want the timestamp) just to
make our test happy.

-Peff
