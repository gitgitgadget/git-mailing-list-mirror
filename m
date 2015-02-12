From: Jeff King <peff@peff.net>
Subject: Re: Keep original author with git merge --squash?
Date: Thu, 12 Feb 2015 04:28:24 -0500
Message-ID: <20150212092824.GA19626@peff.net>
References: <CAN7QDoKQAZKUt_MHWjgt1k3PvXQv6XTcjdijh8KRodO3=VD47A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Glasser <glasser@davidglasser.net>
X-From: git-owner@vger.kernel.org Thu Feb 12 10:28:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLq4Y-0005OP-Pm
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 10:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755166AbbBLJ23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 04:28:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:48080 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753387AbbBLJ21 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 04:28:27 -0500
Received: (qmail 4503 invoked by uid 102); 12 Feb 2015 09:28:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Feb 2015 03:28:28 -0600
Received: (qmail 23120 invoked by uid 107); 12 Feb 2015 09:28:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Feb 2015 04:28:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Feb 2015 04:28:24 -0500
Content-Disposition: inline
In-Reply-To: <CAN7QDoKQAZKUt_MHWjgt1k3PvXQv6XTcjdijh8KRodO3=VD47A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263709>

On Wed, Feb 11, 2015 at 09:21:04AM -0800, David Glasser wrote:

> (I'm not sure if this should be a flag to --squash or to commit.
> Maybe `git merge --squash`; `git commit --use-squashed-author`?  Seems
> like it should be not too hard to implement; SQUASH_MSG is pretty
> parseable.  Or just a config value.)

It sounds like "git commit -c" is close to what you want, which will
pull the author and commit message from a particular commit. But I don't
think there is a convenient way to name the commit in your case (it is
likely to be the first commit on the branch you are squash-merging, but
there isn't a shorthand for that).

I assume you are already munging in your editor the template provided by
"git commit" after the squash? What would be really nice, IMHO, is if
there was a way to set the author during that edit (e.g., by moving one
of the "Author:" lines to the top of the file). That would cover your
use case, I think, and would also be useful in general.

-Peff
