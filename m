From: Jeff King <peff@peff.net>
Subject: Re: How to efficiently find where a patch applies?
Date: Thu, 5 May 2011 16:17:18 -0400
Message-ID: <20110505201718.GA2533@sigill.intra.peff.net>
References: <20110505181741.GA27251@nwp-laptop>
 <20110505195556.GA1770@sigill.intra.peff.net>
 <20110505201204.GA31572@nwp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 22:17:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI4zg-0006Z7-7m
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 22:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894Ab1EEURZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 16:17:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44106
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327Ab1EEURW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 16:17:22 -0400
Received: (qmail 2956 invoked by uid 107); 5 May 2011 20:19:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 May 2011 16:19:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 May 2011 16:17:18 -0400
Content-Disposition: inline
In-Reply-To: <20110505201204.GA31572@nwp-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172904>

On Thu, May 05, 2011 at 03:12:05PM -0500, Nathan W. Panike wrote:

> The patches were emailed as raw diffs, not as format-patch messages, so I
> thought git-am was not applicable. Also, I was applying the patches to the git
> repository on behalf of local colleagues when they ran into problems using
> 'git-apply'.

Git-am is basically just a wrapper around git-apply that will split an
email message into a raw diff and a commit message. If you have raw
diffs in an email, it may handle them OK, or it may be simple enough to
massage them into the right form.

As far as I know, there isn't a convenient way to get "git apply" to do
the same merge magic for a raw diff that "git am -3" does. It should be
possible, as the only relevant input is the raw diff; I just don't think
anybody has bothered to do it.

> I did not want to deal with merge conflicts---my colleagues can
> handle the conflicts themselves. So a clean merge was optimal from my
> perspective.

Ah, that makes more sense. I have been in a similar "helping people with
git" situation myself.

> > Wow, dynamically generating awk using perl. That's a new one for me. :)
> You might say it is awk-ward.

Ouch. :)

-Peff
