From: Jeff King <peff@peff.net>
Subject: Re: Separate default remotes for pulling and pushing
Date: Mon, 9 May 2011 18:04:59 -0400
Message-ID: <20110509220459.GA3719@sigill.intra.peff.net>
References: <1FDDE878-C81A-4318-836B-7F8BED51A981@gmail.com>
 <BANLkTinJDUa7sXjKHo81bG7KbnspxZ88oA@mail.gmail.com>
 <20110509081708.GA5871@sigill.intra.peff.net>
 <7viptjq0ua.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	David Lee <davidomundo@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 00:05:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYaF-0005q9-RJ
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115Ab1EIWFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 18:05:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46146
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755130Ab1EIWFD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 18:05:03 -0400
Received: (qmail 12539 invoked by uid 107); 9 May 2011 22:06:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 18:06:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 18:04:59 -0400
Content-Disposition: inline
In-Reply-To: <7viptjq0ua.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173269>

On Mon, May 09, 2011 at 09:45:49AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   4. Decentralized, you're a developer that publishes work via git. You
> >      call the upstream maintainer "origin", so fetches are convenient
> >      (and git does this for you at clone, after all). But pushing, even
> >      though you probably always push to the same central, does not have
> >      a convenient shorthand.
> >
> >      This is David's case (and mine, and I suspect some other git
> >      developers who do enough work that they want to make it publicly
> >      available via git, or even just have backups). It's also encouraged
> >      by sites like github, where you might clone the upstream's
> >      repository, but then pushes your changes up to a personal "fork"
> >      to let others see and merge them.
> 
> In a sense, this is what I do as well.  As you mentioned, I push to "ko"
> to publish, but when I "fetch" (or "pull") from "origin", I get the public
> copy I have at kernel.org like everybody else, and I do fetch every time
> after I push to "ko" to get the updated preformatted HTML and man page
> branches.

Interesting. Is your fetch from "ko" a no-op, or are you using it to
syncrhonize development between different machines?

> While I see why some people might want to say "origin" for both in such a
> set-up (when they do not push to multiple places like I do), I have a
> feeling that it is a misguided wish that would make themselves unnecessary
> confused than they already are, especially if the repositories used for
> pushing and fetching are in reality different repositories (one good
> example why it would be confusing is how remote tracking branches are
> updated).

I think it is important to note that calling them both "origin" is
definitely the wrong thing. The proposal is instead that "git push"
without a remote would default to something besides "origin". For people
who publish multiple places, it might even make sense for it to be an
iterative push to each place.

But this is all definitely a minor convenience. It is not that
world-shattering to type "git push my-fork", nor "git push my-fork &&
git push my-backup". Probably twice a week I accidentally try to push to
"git://git.kernel.org/pub/scm/git/git.git", but git make it clear that
is not allowed. :)

-Peff
