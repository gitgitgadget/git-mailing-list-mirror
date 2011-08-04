From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/5] macro-based key/value maps
Date: Thu, 4 Aug 2011 16:43:54 -0600
Message-ID: <20110804224354.GA27476@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713065700.GA18566@sigill.intra.peff.net>
 <20110713175250.GA1448@elie>
 <20110713200814.GD31965@sigill.intra.peff.net>
 <20110714173454.GA21657@sigill.intra.peff.net>
 <7vipr4373f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 00:44:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp6e4-00060O-UZ
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 00:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945Ab1HDWn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 18:43:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32909
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816Ab1HDWn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 18:43:57 -0400
Received: (qmail 23266 invoked by uid 107); 4 Aug 2011 22:44:31 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Aug 2011 18:44:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2011 16:43:54 -0600
Content-Disposition: inline
In-Reply-To: <7vipr4373f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178767>

On Thu, Jul 14, 2011 at 02:06:28PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Doing macro meta-programming like this makes me feel a little dirty, but
> > I actually think the result is more readable.
> >
> >   [1/3]: implement generic key/value map
> >   [2/3]: fast-export: use object to uint32 map instead of "decorate"
> >   [3/3]: decorate: use "map" for the underlying implementation
> >
> > What do you think?
> 
> Yeah, dirty but nice ;-)

Well, if you like that, then here is the end-result of what the
persistent version would look like. It's quite convenient to use, but an
awful pain to debug.  It's done entirely in the preprocessor; I suspect
if I wrote the code generation externally, that would be easier and more
readable (and there are one or two places where we could be slightly
more efficient, that are just difficult to implement via the
preprocessor).

  [1/5]: implement generic key/value map
  [2/5]: fast-export: use object to uint32 map instead of "decorate"
  [3/5]: decorate: use "map" for the underlying implementation
  [4/5]: map: implement persistent maps
  [5/5]: implement metadata cache subsystem

-Peff
