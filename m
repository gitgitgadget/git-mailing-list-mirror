From: Jeff King <peff@peff.net>
Subject: Re: Git push failure in the case of SSH to localhost
Date: Wed, 11 Feb 2009 14:42:18 -0500
Message-ID: <20090211194218.GA28927@coredump.intra.peff.net>
References: <8e04b5820902110824u1ab99cc1r4df6349b20d62f84@mail.gmail.com> <20090211180559.GC19749@coredump.intra.peff.net> <8e04b5820902111042q138a2e79vc97c533007482e5c@mail.gmail.com> <20090211184429.GA27896@coredump.intra.peff.net> <8e04b5820902111103n69cde3e1le5781fb1818b622c@mail.gmail.com> <20090211191445.GU30949@spearce.org> <8e04b5820902111120w4cb87b41sfca647a838bab43c@mail.gmail.com> <20090211192245.GA28832@coredump.intra.peff.net> <8e04b5820902111132v5b7c8e14s15c6fad13b5b76a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 20:43:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXKzs-0005HM-CI
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 20:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755969AbZBKTmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 14:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754846AbZBKTmV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 14:42:21 -0500
Received: from peff.net ([208.65.91.99]:48932 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753980AbZBKTmV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 14:42:21 -0500
Received: (qmail 1097 invoked by uid 107); 11 Feb 2009 19:42:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 11 Feb 2009 14:42:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Feb 2009 14:42:18 -0500
Content-Disposition: inline
In-Reply-To: <8e04b5820902111132v5b7c8e14s15c6fad13b5b76a9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109517>

On Wed, Feb 11, 2009 at 09:32:29PM +0200, Ciprian Dorin, Craciun wrote:

>     Anyway, I don't see why it's wrong to have such a bin folder per
> repository... Let's for a moment assume that there is a use case for
> such a thing, I'm wondering what is wrong with this solution from a
> Git perspective???

It's not _wrong_, we're just suggesting ways that the same thing might
be accomplished more easily.

>     P.S.: It seems that indeed setup_git_directory_gently (or
> something in the setup system) is kind of broken if I call it twice...

Yes, I think your patch is running into a long-standing problem in the
git initialization code. There are problems if you need to look into the
repo dir to find out which command to execute, because finding the repo
dir changes the environment. There is a similar problem with aliases.

So I think getting your patch to run correctly may be hard. But I admit
I didn't look at it that closely.

-Peff
