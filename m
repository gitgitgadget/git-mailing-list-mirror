From: Jeff King <peff@peff.net>
Subject: Re: [RFC] How to pass Git config command line instructions to
 Submodule commands?
Date: Mon, 25 Apr 2016 17:27:09 -0400
Message-ID: <20160425212709.GB7636@sigill.intra.peff.net>
References: <60724588-B06E-47E8-9302-8709C4601826@gmail.com>
 <CAGZ79kYmAr-O6_Jw2KO9eZEfZQ+_WBiERF=nhOYLJCZpUjSSyA@mail.gmail.com>
 <CA+P7+xoaqNF+uBHVnD2QR7j-=0Hyvd-scTc_vOdV+etC0VS9jA@mail.gmail.com>
 <20160425212449.GA7636@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:27:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auo2G-0002nM-ES
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 23:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbcDYV1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 17:27:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:56109 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933361AbcDYV1M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 17:27:12 -0400
Received: (qmail 9076 invoked by uid 102); 25 Apr 2016 21:27:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Apr 2016 17:27:12 -0400
Received: (qmail 6440 invoked by uid 107); 25 Apr 2016 21:27:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Apr 2016 17:27:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Apr 2016 17:27:09 -0400
Content-Disposition: inline
In-Reply-To: <20160425212449.GA7636@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292565>

On Mon, Apr 25, 2016 at 05:24:50PM -0400, Jeff King wrote:

> It does mean that somebody would be stuck who really wanted to run the
> smudge filter in their local repo, but for some reason not in the
> subrepos. I am trying to think of a case in which that might be
> security-relevant if you didn't trust the sub-repos[1]. But I really
> don't see it. The filter is arbitrary code, but that's specified by the
> user; we're just feeding it possibly untrusted blobs.

I forgot my [1], which was going to be: I wonder if there are any
interesting things you can do by feeding git-lfs untrusted content
(e.g., convincing it to hit arbitrary URLs). But I don't think so. The
URL is derived from the remote, and the LFS pointer files just contain
hashes.

That's all orthogonal to this thread anyway, though. People using LFS
generally have the config in ~/.gitconfig, so they run it for all repos,
trusted and untrusted.

-Peff
