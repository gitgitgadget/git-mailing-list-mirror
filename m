From: Jeff King <peff@peff.net>
Subject: Re: Re* [BUG?] "error: cache entry has null sha1"
Date: Sun, 3 Nov 2013 03:03:00 -0500
Message-ID: <20131103080300.GA2868@sigill.intra.peff.net>
References: <20131031172116.GA19428@sigill.intra.peff.net>
 <1383345895-23341-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 03 09:03:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vcseb-0003RY-MO
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 09:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076Ab3KCIDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 03:03:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:60773 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752014Ab3KCIDE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 03:03:04 -0500
Received: (qmail 28280 invoked by uid 102); 3 Nov 2013 08:03:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 03 Nov 2013 02:03:03 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Nov 2013 03:03:00 -0500
Content-Disposition: inline
In-Reply-To: <1383345895-23341-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237255>

On Fri, Nov 01, 2013 at 03:44:52PM -0700, Junio C Hamano wrote:

> Here is a proposed endgame for the topic in a patch form, then.
> 
> I've added a test for low-level "read-tree --reset -u A B", and
> tried the "am --abort" I saw the problem with manually, but other
> than that, I haven't (re)thought about the issue hard enough to be
> comfortable with this change yet.

Thanks for moving this forward.

I read over the old discussion and the patches, and I think the patch is
a good thing. There was some question from me earlier on whether there
were other cases we weren't considering.  The discussion convinced me
that there almost certainly aren't. And even if there are, this is still
the right direction. Writing out a bogus CE_CONFLICTED entry is
_certainly_ wrong, so even if we do not get the details right (e.g.,
rejecting a merge we should be accepting), this patch still forms a base
for further fixups.

> Jeff King (1):
>   unpack-trees: fix "read-tree -u --reset A B" with conflicted index

My missing signoff:

  Signed-off-by: Jeff King <peff@peff.net>

-Peff
