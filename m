From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] clean up push config callbacks
Date: Mon, 16 Feb 2015 00:45:50 -0500
Message-ID: <20150216054550.GA24611@peff.net>
References: <1424055690-32631-1-git-send-email-cxreg@pobox.com>
 <20150216052049.GA5031@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 06:46:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNEVJ-0007eR-L9
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 06:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbbBPFpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 00:45:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:49362 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751579AbbBPFpx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 00:45:53 -0500
Received: (qmail 7997 invoked by uid 102); 16 Feb 2015 05:45:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 15 Feb 2015 23:45:53 -0600
Received: (qmail 12210 invoked by uid 107); 16 Feb 2015 05:45:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 00:45:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2015 00:45:50 -0500
Content-Disposition: inline
In-Reply-To: <20150216052049.GA5031@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263870>

On Mon, Feb 16, 2015 at 12:20:49AM -0500, Jeff King wrote:

> But here you are adding to git_default_push_config, which is in another
> file.
> 
> I'm trying to figure out why git_default_push_config exists at all. The
> major difference from git_push_config is that the "default" variant will
> get loaded for _all_ commands, not just "push". So if it affected
> variables that were used by other commands, it would be needed. But all
> it sets is push_default, which seems to be specific to builtin/push.c.
> 
> So I suspect it can be removed entirely, and folded into
> git_config_push. But that's outside the scope of your patch.

Here's that cleanup, plus another one I noticed while doing it.

  [1/2]: git_push_config: drop cargo-culted wt_status pointer
  [2/2]: builtin/push.c: make push_default a static variable

-Peff
