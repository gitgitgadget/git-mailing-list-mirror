From: Jeff King <peff@peff.net>
Subject: Re: 'typechange' in the git-status output
Date: Mon, 14 Mar 2011 14:39:48 -0400
Message-ID: <20110314183947.GA21070@sigill.intra.peff.net>
References: <AANLkTimWR0avW6mBWGa0ArVB8oZUM7nuvc5AYf=wgU-W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alexei Sholik <alcosholik@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 19:40:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzCgP-0007Mi-Js
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 19:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961Ab1CNSjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 14:39:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41792
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299Ab1CNSjx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 14:39:53 -0400
Received: (qmail 12081 invoked by uid 107); 14 Mar 2011 18:40:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Mar 2011 14:40:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Mar 2011 14:39:48 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimWR0avW6mBWGa0ArVB8oZUM7nuvc5AYf=wgU-W@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169007>

On Mon, Mar 14, 2011 at 08:29:57PM +0200, Alexei Sholik wrote:

> But then, after copying the whole directory with 'cp -r' and running
> git-status in the newly created directory, I get the following:

"cp -r" isn't an exact copy. You probably want "cp -a" or at least "cp
-rs".

> > # On branch master
> > # Changed but not updated:
> > #   (use "git add <file>..." to update what will be committed)
> > #   (use "git checkout -- <file>..." to discard changes in working directory)
> > #
> > #	typechange: RelNotes

Right. RelNotes is a symlink. But "cp -r" dereferences the symlink and
copies the file contents themselves.

> What happened with the copied repository? I've found a couple of
> instances of the word 'typechange' in the source, but no mention in
> the docs. What does it mean and what could be the cause of this
> change?

It's the same as the "T" flag in "git diff --name-status". Namely, the
type of the file changed (between a symlink and a regular file).

-Peff
