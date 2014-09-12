From: Jeff King <peff@peff.net>
Subject: Re: Is the a way to get a log with files that were changed
Date: Thu, 11 Sep 2014 22:26:01 -0400
Message-ID: <20140912022600.GA15519@peff.net>
References: <FD6D2EE2-AD97-4D40-B461-435FD18D7E1A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Stephen Smith <ischis2@cox.net>
To: Stephen Smith <ishchis2@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 04:26:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSGYv-0007Xt-4C
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 04:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbaILC0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 22:26:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:47280 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752070AbaILC0F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 22:26:05 -0400
Received: (qmail 26444 invoked by uid 102); 12 Sep 2014 02:26:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Sep 2014 21:26:03 -0500
Received: (qmail 31192 invoked by uid 107); 12 Sep 2014 02:26:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Sep 2014 22:26:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Sep 2014 22:26:01 -0400
Content-Disposition: inline
In-Reply-To: <FD6D2EE2-AD97-4D40-B461-435FD18D7E1A@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256892>

On Fri, Sep 12, 2014 at 07:16:26AM +0530, Stephen Smith wrote:

> Is there a way to get a log of first parent  commits and with each
> commit a entry a list of the files that were changed?

How about:

  git log --first-parent -m --name-only

The "--first-parent" restricts the traversal. The "-m" tells git to show
merge diffs against their parents. We show only the diff against the
first parent due to "--first-parent", so we effectively show the diff of
what was brought in by the merge. And then "--name-only" can be replaced
with "--raw", "-p", or whatever diff format you prefer.

-Peff
