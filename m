From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] fsck: do not canonicalize modes in trees we are
 checking
Date: Mon, 20 Oct 2014 02:21:57 -0700
Message-ID: <20141020092157.GC12913@peff.net>
References: <20140923154751.GA19319@peff.net>
 <20140923162343.GA20379@debian>
 <20140923163008.GA21591@peff.net>
 <543B02A7.9040807@optusnet.com.au>
 <20141014082120.GA16686@peff.net>
 <543F074B.2050907@optusnet.com.au>
 <20141016002021.GA27509@peff.net>
 <5443B136.4060009@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
To: Ben Aveling <bena.001@optusnet.com.au>
X-From: git-owner@vger.kernel.org Mon Oct 20 11:22:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xg9AF-00072Z-DT
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 11:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbaJTJWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 05:22:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:60167 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752901AbaJTJWB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 05:22:01 -0400
Received: (qmail 5245 invoked by uid 102); 20 Oct 2014 09:22:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Oct 2014 04:22:01 -0500
Received: (qmail 10486 invoked by uid 107); 20 Oct 2014 09:22:01 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Oct 2014 05:22:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Oct 2014 02:21:57 -0700
Content-Disposition: inline
In-Reply-To: <5443B136.4060009@optusnet.com.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 19, 2014 at 11:40:22PM +1100, Ben Aveling wrote:

> This seems to have worked. I also had to move away the existing .idx and
> copy in a new one before it was happy.

Sorry if I wasn't clear; you do need to copy the .idx files along with
the packfiles (you can regenerate the .idx files from the packfiles on
the destination, but they're not that big; it's probably easier just to
copy them).

> I'm not sure that what I've done is so different from simply copying the
> other version of the repository - there shouldn't have been anything in the
> corrupt version that wasn't also in the good one. But any rate, it worked.

Right, a valid technique for repairing corruption is to just blow away
the original repo entirely and replace it with a good copy. But this is a
way of ensuring that no commits are missed, and keeping the original set
of refs, config options, and reflogs.

-Peff
