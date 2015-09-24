From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] gc: remove broken refs
Date: Thu, 24 Sep 2015 13:57:59 -0400
Message-ID: <20150924175758.GB15117@sigill.intra.peff.net>
References: <cover.1443085919.git.johannes.schindelin@gmx.de>
 <8855bae256311446dffd221ab33c1163eb104c4a.1443085919.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 24 19:58:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfAmW-00073P-2E
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 19:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756832AbbIXR6C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 13:58:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:35800 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754904AbbIXR6B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 13:58:01 -0400
Received: (qmail 32377 invoked by uid 102); 24 Sep 2015 17:58:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 12:58:01 -0500
Received: (qmail 27645 invoked by uid 107); 24 Sep 2015 17:58:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 13:58:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 13:57:59 -0400
Content-Disposition: inline
In-Reply-To: <8855bae256311446dffd221ab33c1163eb104c4a.1443085919.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278550>

On Thu, Sep 24, 2015 at 11:14:02AM +0200, Johannes Schindelin wrote:

> When encountering broken refs, such as a stale remote HEAD (which can
> happen if the active branch was renamed in the remote), it is more
> helpful to remove those refs than to exit with an error.

For the same reasons as in my earlier responses, I think it's dangerous
to remove broken refs (it makes a small corruption much worse). It seems
reasonably sane to remove a dangling symref, though if we teach
for_each_ref to gracefully skip them, then leaving them in place isn't a
problem.

-Peff
