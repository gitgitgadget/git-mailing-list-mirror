From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] status: list unmerged files last
Date: Tue, 1 Sep 2009 21:15:14 -0400
Message-ID: <20090902011513.GA3874@coredump.intra.peff.net>
References: <20090901145213.GB4194@debian.b2j>
 <200909012213.54611.j6t@kdbg.org>
 <7vy6oy9z9r.fsf@alter.siamese.dyndns.org>
 <200909012325.45739.j6t@kdbg.org>
 <7vtyzmxkpr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, bill lam <cbill.lam@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 03:15:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MieRc-0006q7-Es
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 03:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336AbZIBBPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 21:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755325AbZIBBPR
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 21:15:17 -0400
Received: from peff.net ([208.65.91.99]:60602 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755324AbZIBBPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 21:15:16 -0400
Received: (qmail 3324 invoked by uid 107); 2 Sep 2009 01:15:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 01 Sep 2009 21:15:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Sep 2009 21:15:14 -0400
Content-Disposition: inline
In-Reply-To: <7vtyzmxkpr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127573>

On Tue, Sep 01, 2009 at 05:18:40PM -0700, Junio C Hamano wrote:

> The "keeping related things together" argument does mean your v1 is better
> than this patch, as you had "unmerged" next to "changed but not updated".
> I personally think the "keep related things together" argument makes much
> more sense than the "close to the bottom is easier to cut and paste"
> argument, as I tend to focus at the top of the output when looking at the
> status output and almost never cut & paste using mouse (screen for
> rectangular cutting and pasting works wonderfully), but it probably is
> just me.  And remember that I am only just one of the users, nothing more.
> 
> Sadly, "keep related things together" and "as close to the bottom as
> possible" are not quite compatible, and we can pick one or the other, but
> not both.

Just my two cents (and I think I have as good a track record at UI
design as Junio... ;) ):

I think "related things together" trumps "close to the bottom". Because
the former is something that _always_ applies to your output, while the
latter is catering to a particular use case and a particular screen
setup.

In other words, why is the _bottom_ reserved for more important things
instead of the _top_? If I have a tall terminal that is long enough to
see the output, are you potentially making the important thing less
obvious (because I tend to read the the output from top to bottom)? If I
use a pager (either manually, because I have seen that the output is too
long, or automatically via the pager.status config variable)? What about
reading status output into an interface wrapper like "tig status"?

So while you may be helping some users, I tend to think you may be
hurting others.

-Peff

PS I am also not entirely convinced that unmerged entries are somehow
more important to call attention to in the list than other entries. But
the above argues that even _if_ you think they are more important, it is
still not necessarily a good thing to move them to the bottom.
