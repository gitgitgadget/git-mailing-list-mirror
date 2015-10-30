From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] checkout: added two options to control progress
 output
Date: Thu, 29 Oct 2015 20:14:04 -0400
Message-ID: <20151030001404.GB2123@sigill.intra.peff.net>
References: <1445698768-22614-1-git-send-email-eantoranz@gmail.com>
 <20151029220519.GA466@sigill.intra.peff.net>
 <CAOc6etakOy_zZ3fH_vS5UGGqouXTd7SJFtD6UC9bZRJaYWsRQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 01:14:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrxKq-0006Xk-79
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 01:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758445AbbJ3AOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 20:14:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:50118 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758410AbbJ3AOH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 20:14:07 -0400
Received: (qmail 29197 invoked by uid 102); 30 Oct 2015 00:14:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Oct 2015 19:14:07 -0500
Received: (qmail 17281 invoked by uid 107); 30 Oct 2015 00:14:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Oct 2015 20:14:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Oct 2015 20:14:04 -0400
Content-Disposition: inline
In-Reply-To: <CAOc6etakOy_zZ3fH_vS5UGGqouXTd7SJFtD6UC9bZRJaYWsRQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280465>

On Thu, Oct 29, 2015 at 06:09:06PM -0600, Edmundo Carmona Antoranz wrote:

> A comment there: I think more builtins support --progress than the ones that
> support --no-progress, right?

Hopefully they are supported equally everywhere. Anybody using parseopt
should have something like (this is from builtin/clone.c):

  OPT_BOOL(0, "progress", &option_progress,
	   N_("force progress reporting")),

That automatically gives us both --progress and --no-progress. And note
how option_progress is initialized to "-1" above that, so we know the
resulting value it stores will either be 1 (--progress),
0 (--no-progress), or -1 (no option specified).

-Peff
