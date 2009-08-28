From: Jeff King <peff@peff.net>
Subject: Re: Generating patches/Cherry Picking for a large number of commits
Date: Fri, 28 Aug 2009 15:45:56 -0400
Message-ID: <20090828194556.GA13302@coredump.intra.peff.net>
References: <ae09c2a40908281226r744141bm3a5bf4161ddab3e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Alydis <alydis@august8.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 21:46:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh7Ol-0004gW-Uc
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 21:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbZH1Tp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 15:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752932AbZH1Tp5
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 15:45:57 -0400
Received: from peff.net ([208.65.91.99]:43362 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928AbZH1Tp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 15:45:56 -0400
Received: (qmail 7663 invoked by uid 107); 28 Aug 2009 19:46:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 28 Aug 2009 15:46:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Aug 2009 15:45:56 -0400
Content-Disposition: inline
In-Reply-To: <ae09c2a40908281226r744141bm3a5bf4161ddab3e7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127343>

On Fri, Aug 28, 2009 at 02:26:43PM -0500, Alydis wrote:

> I've tried something along these lines:
> 
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
> cd linux-2.6
> git checkout -b mybranch v2.6.21
> git format-patch -o patches v2.6.21..v2.6.30 arch/powerpc/boot
> git am -3 patches/*
> 
> But, to my dismay, format-patch here tears apart the commits and
> applies ONLY the hunks that apply to the arch/powerpc/boot directory.
> What I'd much rather do is obtain a list of commits that apply to
> arch/powerpc/boot; but, then apply the entire patch.

By default, format-patch (and log, gitk, etc) when given a path limiter
will also limit the diff shown. You can override it with --full-diff.

-Peff
