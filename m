From: Jeff King <peff@peff.net>
Subject: Re: git apply: git diff header lacks filename information for git
	diff --no-index patch
Date: Sun, 5 Oct 2008 15:19:03 -0400
Message-ID: <20081005191903.GA13980@coredump.intra.peff.net>
References: <500f3d130810021127j570bb540p901f6a73f58a6cb1@mail.gmail.com> <20081004041714.GA12413@coredump.intra.peff.net> <gc79f4$22m$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Imre Deak <imre.deak@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 21:20:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmZ9N-0005En-PI
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 21:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118AbYJETTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 15:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756100AbYJETTG
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 15:19:06 -0400
Received: from peff.net ([208.65.91.99]:4152 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755986AbYJETTF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 15:19:05 -0400
Received: (qmail 17064 invoked by uid 111); 5 Oct 2008 19:19:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 05 Oct 2008 15:19:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Oct 2008 15:19:03 -0400
Content-Disposition: inline
In-Reply-To: <gc79f4$22m$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97524>

[argh, resending with the list cc'd]

On Sat, Oct 04, 2008 at 10:28:19AM +0200, Jakub Narebski wrote:

> > Hmm. The problem is that "git apply" doesn't accept that "a/dev/null"
> > and "b/a" are the same, so it rejects them as a name. I
> 
> Shouldn't it be "/dev/null", not "a/dev/null"?  

Yes, see my recent reply to Linus elsewhere in the thread for why I
didn't think it was an issue at the time (but it clearly is).

> Besides git-diff(1) states:
> 
>   1. It is preceded with a "git diff" header, that looks like
>      this:
> 
>        diff --git a/file1 b/file2
> 
>      The `a/` and `b/` filenames are the same unless rename/copy is
>      involved.  Especially, even for a creation or a deletion,
>      `/dev/null` is _not_ used in place of `a/` or `b/` filenames.

And I hadn't seen this, which makes it utterly clear that the diff is
broken. Thanks for pointing it out.

-Peff
