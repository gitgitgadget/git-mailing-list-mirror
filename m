From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-prompt.sh: make '+' work for unborn branches
Date: Thu, 27 Mar 2014 19:08:11 -0400
Message-ID: <20140327230811.GD32434@sigill.intra.peff.net>
References: <20140305233219.A6FF54284F@server>
 <20140306204026.GC29659@sigill.intra.peff.net>
 <CABbCQwskqZzzRXm5K3dnOfRoAcx8jpsdskngmN7f1EvY6BONgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Maurice Bos <m-ou.se@m-ou.se>
X-From: git-owner@vger.kernel.org Fri Mar 28 00:08:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTJPG-0002v1-DE
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 00:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757221AbaC0XIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 19:08:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:48865 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757179AbaC0XIO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 19:08:14 -0400
Received: (qmail 5429 invoked by uid 102); 27 Mar 2014 23:08:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Mar 2014 18:08:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Mar 2014 19:08:11 -0400
Content-Disposition: inline
In-Reply-To: <CABbCQwskqZzzRXm5K3dnOfRoAcx8jpsdskngmN7f1EvY6BONgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245336>

On Thu, Mar 06, 2014 at 10:16:47PM +0100, Maurice Bos wrote:

> I have no clue why git diff --cached isn't used instead of git diff-index.
> I was wondering about it, but I decided I don't know enough about git and
> there are probably valid reasons for doing it this way. Though, replacing
> it with with git diff --cached seems to have the exact same behaviour, as
> far as I tested. That would make the patch a little prettier, as it doesn't
> contain the empty tree id any more:

I think it probably goes in the wrong direction, though. The prompt code
should probably be building on plumbing, not porcelain. So your original
patch as-is is probably the most sensible thing (we may want to convert
the first git-diff call to use plumbing, too, but that would be a
separate patch).

It looks like Junio did not pick up your patch. You may want to repost
it.

-Peff
