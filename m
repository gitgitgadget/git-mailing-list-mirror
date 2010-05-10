From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Add [] as an alias for a reference to the empty
 tree
Date: Mon, 10 May 2010 06:00:50 -0400
Message-ID: <20100510100050.GB2098@coredump.intra.peff.net>
References: <1273250247-20762-1-git-send-email-pkj@axis.com>
 <20100508045319.GD14998@coredump.intra.peff.net>
 <7vhbmjc6dy.fsf@alter.siamese.dyndns.org>
 <A612847CFE53224C91B23E3A5B48BAC74482E511E7@xmail3.se.axis.com>
 <20100510092054.GA2602@coredump.intra.peff.net>
 <AANLkTinsofcjlVmnMtW7mONO8zGQd2eT9rMEynVNchsR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 12:00:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBPnF-0006IB-Qd
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 12:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035Ab0EJKAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 06:00:52 -0400
Received: from peff.net ([208.65.91.99]:57580 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985Ab0EJKAw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 06:00:52 -0400
Received: (qmail 3230 invoked by uid 107); 10 May 2010 10:01:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 10 May 2010 06:01:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 May 2010 06:00:50 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinsofcjlVmnMtW7mONO8zGQd2eT9rMEynVNchsR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146789>

On Mon, May 10, 2010 at 11:51:05AM +0200, Sverre Rabbelier wrote:

> On Mon, May 10, 2010 at 11:20, Jeff King <peff@peff.net> wrote:
> >> However, if INDEX, WORKTREE and EMPTY are preferred as syntactic sugar
> >> tokes, then that is fine by me.
> 
> Must it be ALL CAPS? In Mercurial the fairly elegant 'nil' is used for
> the empty commit, why can't we do the same?

[Please watch your quoting, which is a bit misleading there].

I think the intent was that because they clash in the normal refs
namespace, we would set them apart with caps (and we have already
sort-of claimed the all-caps namespace with things like HEAD,
FETCH_HEAD, etc).

> > So certainly if you want to do EMPTY, I wouldn't let the lack of the
> > other two hold you back. The only reason they are related at all is that
> > they would probably share a syntax, if the other two ever even get
> > implemented.
> 
> I still don't see the point in having INDEX and WORKTREE, especially
> since they're so CAPSY. Almost as if they're supposed to be
> environment variables.

The point was to make a more obvious and verbose alternative for people
who find "git diff" a little confusing. E.g.:

  # diff index to working tree
  # (now)
  git diff
  # (verbose)
  git diff INDEX..WORKTREE

  # diff HEAD to index
  # (now)
  git diff --cached
  # (verbose)
  git diff HEAD..INDEX

  # diff HEAD to working tree
  # (now)
  git diff HEAD
  # (verbose)
  git diff HEAD..WORKTREE

I think the original proposal is from this post-GitTogether 2008 thread:

  http://thread.gmane.org/gmane.comp.version-control.git/99376/focus=100729

-Peff
