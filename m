From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 41/68] init: use strbufs to store paths
Date: Wed, 30 Sep 2015 22:51:19 -0400
Message-ID: <20151001025119.GA31565@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
 <20150924210736.GL30946@sigill.intra.peff.net>
 <CAO2U3QjunOPoAbGSRjAmCwfk-TnoMveXOJhpb351eh1a_3Xp3A@mail.gmail.com>
 <20150930002347.GA23406@sigill.intra.peff.net>
 <xmqqh9mb7k3r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 04:51:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhTxv-0004vW-Vm
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 04:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbbJACvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 22:51:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:38407 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750999AbbJACvW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 22:51:22 -0400
Received: (qmail 5913 invoked by uid 102); 1 Oct 2015 02:51:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Sep 2015 21:51:22 -0500
Received: (qmail 15121 invoked by uid 107); 1 Oct 2015 02:51:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Sep 2015 22:51:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Sep 2015 22:51:19 -0400
Content-Disposition: inline
In-Reply-To: <xmqqh9mb7k3r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278880>

On Wed, Sep 30, 2015 at 01:00:56PM -0700, Junio C Hamano wrote:

> > Wow, my patch isn't even close to reasonable. I didn't realize because
> > we do not compile this code at all for non-Mac platforms. Sorry.
> 
> Perhaps the way we completely stub out the platform specific helpers
> contributes to this kind of gotchas?  I am wondering how much additional
> safety we would gain if we start doing something like this.

I think it is an improvement, but it does not solve all of the problems.
I also botched the implementation of probe_utf8_pathname_composition,
and that does not get compiled on most platforms (though we _could_
compile it and just never call it).

-Peff
