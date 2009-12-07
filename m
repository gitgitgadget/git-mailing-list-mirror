From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow --quiet option to git remote, particularly for
 `git remote update`
Date: Mon, 7 Dec 2009 01:40:07 -0500
Message-ID: <20091207064007.GA3664@coredump.intra.peff.net>
References: <1260057623-28960-1-git-send-email-alex@chmrr.net>
 <20091206145000.GC26440@coredump.intra.peff.net>
 <1260156352-sup-6170@utwig>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 07:40:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHXGZ-0006qG-Kr
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 07:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbZLGGkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 01:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754193AbZLGGkD
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 01:40:03 -0500
Received: from peff.net ([208.65.91.99]:52353 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754171AbZLGGkC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 01:40:02 -0500
Received: (qmail 1076 invoked by uid 107); 7 Dec 2009 06:44:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 07 Dec 2009 01:44:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Dec 2009 01:40:07 -0500
Content-Disposition: inline
In-Reply-To: <1260156352-sup-6170@utwig>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134715>

On Mon, Dec 07, 2009 at 01:15:05AM -0500, Alex Vandiver wrote:

> At Sun Dec 06 09:50:00 -0500 2009, Jeff King wrote:
> > Should --quiet also affect this "Updating %s" line?
> 
> Looking at it more closely, I think this patch should -- but for
> reasons unrelated o your argument below.  The "Updating %s" line there
> is in fetch_remote, which is _only_ called during `git remote add -f`.
> It stands in for the "Fetching %s" line which `git fetch` (and `git
> remote update`) outputs, which (after this patch), _is_ controlled by
> --quiet.

Ah, sorry, this has actually changed since the last time I looked at it
closely, as a result of 9c4a036 (Teach the --all option to 'git fetch',
2009-11-09). So nevermind my complaint...it has actually been addressed
separately (I didn't notice because I have been suppressing the output
by redirecting stdout for some time).

> Thus I feel like "Updating %s" should change to "Fetching %s" for both
> consistency and explicitness, and should also be controlled by
> --quiet.  The --quiet-remote option is an entirely different bikeshed,
> which I don't have a strong opinion on, offhand.

Yes, I agree (that it should be quieted, and that it should say
"Fetching").  My --quiet-remote argument is now pointless as of
9c4a036b.

-Peff
