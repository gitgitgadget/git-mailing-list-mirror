From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git-add -a: add all files
Date: Sun, 20 Jul 2008 19:59:33 -0400
Message-ID: <20080720235933.GA12454@sigill.intra.peff.net>
References: <7vtzeofjpi.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807171940160.8986@racer> <48806897.1080404@fastmail.fm> <76718490807181318o228171f9j836aaca2edb9b377@mail.gmail.com> <7vsku5grpr.fsf@gitster.siamese.dyndns.org> <7vk5fhgrm6.fsf_-_@gitster.siamese.dyndns.org> <905315640807192120k45b8c0e3k5b341e77c466dde@mail.gmail.com> <alpine.DEB.1.00.0807201250530.3305@eeepc-johanness> <76718490807200545l653bbda1l4d13f1e1e698c855@mail.gmail.com> <7v4p6k8l36.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tarmigan <tarmigan+git@gmail.com>, git@vger.kernel.org,
	Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 02:00:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKipg-000547-10
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 02:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756302AbYGTX7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 19:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756289AbYGTX7f
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 19:59:35 -0400
Received: from peff.net ([208.65.91.99]:1612 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756301AbYGTX7f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 19:59:35 -0400
Received: (qmail 6149 invoked by uid 111); 20 Jul 2008 23:59:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 20 Jul 2008 19:59:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Jul 2008 19:59:33 -0400
Content-Disposition: inline
In-Reply-To: <7v4p6k8l36.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89269>

On Sun, Jul 20, 2008 at 11:30:21AM -0700, Junio C Hamano wrote:

> So for such people who would find "add -A" useful, "commit -a" will not be
> "unrelated changes in the same commit".  And for such people, I would even
> say "commit -A" would be even more useful, too.
> 
> I'll never be in that camp of perfect people myself, though..

I don't claim to be perfect, but I do use "commit -a" and I haven't ever
had a problem committing unrelated changes. My secret is to keep a good
.gitignore, and to peek at "git status" and "git diff" before
committing. So it's just a shorthand because after seeing that
everything is ready for commit, I'm too lazy to type each filename. I
also use "git add ." for the same purpose if files are to be added.

But note that avoiding "-a" doesn't save you from unrelated changes
anyway; it only saves you from changes in unrelated files. You still
have to look below the file granularity with "git diff" to avoid (for
example) a debugging printf. I often will use "git add -i" if I have a
lot of complex changes, even if I end up staging _everything_. But it
lets me say "yes, this should go in" for each hunk.

So maybe I will use "git add -A", but I have to admit to not really
having felt its lack to this point.  However, something Lars said makes
me wonder: do people _really_ want this as an option to add? I seem to
recall the primary request for this being the "undisciplined" approach
you gave ("I have a project that periodically gets data dumped by an
external program, and I want to commit it all"). In that case, the next
step is always commit, so what would be most convenient is "commit -A".

But again, I haven ever felt the lack of this feature; such usage for me
always goes in scripts, where I am more than happy to write out "add .
&& add -u && commit".

-Peff
