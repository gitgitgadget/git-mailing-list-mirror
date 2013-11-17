From: Jeff King <peff@peff.net>
Subject: Re: Possibly a bug
Date: Sun, 17 Nov 2013 04:49:47 -0500
Message-ID: <20131117094946.GA22166@sigill.intra.peff.net>
References: <CAJbVpmyoZCCQU3w8oMTJfxFr4f1cSNTgF+qQW6QD5e44LYg_Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jiergir Ogoerg <f35f22fan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 17 10:50:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vhyzc-0007tA-HE
	for gcvg-git-2@plane.gmane.org; Sun, 17 Nov 2013 10:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447Ab3KQJtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 04:49:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:40768 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751973Ab3KQJts (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 04:49:48 -0500
Received: (qmail 15305 invoked by uid 102); 17 Nov 2013 09:49:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Nov 2013 03:49:49 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Nov 2013 04:49:47 -0500
Content-Disposition: inline
In-Reply-To: <CAJbVpmyoZCCQU3w8oMTJfxFr4f1cSNTgF+qQW6QD5e44LYg_Ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237958>

On Sun, Nov 17, 2013 at 04:59:20AM +0200, Jiergir Ogoerg wrote:

> As suggested by the git book/tutorial I cloned "simplegit-progit" to
> learn using git.
> The issue:
> git log --since=5.years
> yields 2 commits, while
> git log --since=6.years
> yields 3 commits, despite the "Date" in both cases being March 2008.
> Is it a bug?

No, but it is confusing.

The `--since` and `--until` flags use the committer date, not the author
date. Try `git log --pretty=fuller`, and you will see that the author
and committer dates do not match for the top two commits (their
committer date is within 5 years).

Usually the two dates are the same, but they can be different if a
commit is rebased, or applied via patch.

-Peff
