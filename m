From: Jeff King <peff@peff.net>
Subject: [PATCH 0/6] shortlog fixes and optimizations
Date: Fri, 15 Jan 2016 12:06:28 -0500
Message-ID: <20160115170627.GA20983@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 18:06:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK7pa-0005YF-WE
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 18:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbcAORGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 12:06:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:54461 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751831AbcAORGa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 12:06:30 -0500
Received: (qmail 2018 invoked by uid 102); 15 Jan 2016 17:06:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 12:06:30 -0500
Received: (qmail 21302 invoked by uid 107); 15 Jan 2016 17:06:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 12:06:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 12:06:28 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284180>

These are split out from my the shortlog-trailer series I sent a few
weeks ago. The "trailer" parts still need some re-working, but there is
no need to hold these fixes hostage.

I also dropped the early part of the series, adding skip_prefix_icase().
After digging into the history, I ended up reworking the first patch
here to do a more thorough parse, so we don't need it anymore.

Thanks to Eric Sunshine for review on the first iteration; this
incorporates his comments.

  [1/6]: shortlog: match both "Author:" and "author" on stdin
  [2/6]: shortlog: use strbufs to read from stdin
  [3/6]: shortlog: replace hand-parsing of author with pretty-printer
  [4/6]: shortlog: optimize "--summary" mode
  [5/6]: shortlog: optimize out useless "<none>" normalization
  [6/6]: shortlog: optimize out useless string list

[1] http://thread.gmane.org/gmane.comp.version-control.git/283091
