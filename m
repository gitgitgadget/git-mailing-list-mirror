From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Allow building Git with Asciidoctor
Date: Tue, 14 Oct 2014 05:51:19 -0400
Message-ID: <20141014095119.GC16686@peff.net>
References: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Oct 14 15:51:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe2Vb-0000uJ-GF
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 15:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbaJNNvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 09:51:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:58321 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755244AbaJNNvX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 09:51:23 -0400
Received: (qmail 12016 invoked by uid 102); 14 Oct 2014 13:51:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Oct 2014 08:51:22 -0500
Received: (qmail 10963 invoked by uid 107); 14 Oct 2014 09:51:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Oct 2014 05:51:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Oct 2014 05:51:19 -0400
Content-Disposition: inline
In-Reply-To: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 11, 2014 at 11:37:32PM +0000, brian m. carlson wrote:

> This series is designed to implement the changes necessary to build Git
> using Asciidoctor instead of AsciiDoc.

Thanks. I had always taken the attitude that we wrote for the original
Python AsciiDoc, and that using AsciiDoctor was a choice that
git-scm.com made, and something they would have to deal with as far as
compatibility (AFAIK, AsciiDoctor grew out of git-scm.com's home-grown
asciidoc parser).

What's the status on AsciiDoc versus AsciiDoctor? The latter seems more
actively developed these days, but perhaps that is just my perception.
The incompatibilities seem fairly minimal (if those first two patches
are the extent of it, I have no problem at all trying to remain
compatible with both). Would it ever make sense to switch to AsciiDoctor
as our official command-line build program? I know it is supposed to be
much faster (though a lot of the slowness in our build chain is due to
docbook, not asciidoc itself).

Specifically I'm not excited about getting into a state where we have to
maintain both an asciidoc.conf file _and_ ruby extensions for
asciidoctor. I don't mind if somebody wants to step up and keep the
asciidoctor bits in sync with the asciidoc.conf, but I feel like one of
them needs to be considered the "master".

-Peff
