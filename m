From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Sun, 23 Oct 2011 12:09:15 -0400
Message-ID: <20111023160914.GB22444@sigill.intra.peff.net>
References: <1319277881-4128-1-git-send-email-pclouds@gmail.com>
 <20111022190914.GA1785@sigill.intra.peff.net>
 <4EA3F00E.9040006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Robin Rosenberg <robin.rosenberg@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 23 18:09:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RI0c0-00077J-FD
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 18:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994Ab1JWQJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Oct 2011 12:09:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39927
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550Ab1JWQJT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 12:09:19 -0400
Received: (qmail 3534 invoked by uid 107); 23 Oct 2011 16:09:28 -0000
Received: from 75-147-138-244-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (75.147.138.244)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 23 Oct 2011 12:09:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Oct 2011 12:09:15 -0400
Content-Disposition: inline
In-Reply-To: <4EA3F00E.9040006@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184142>

On Sun, Oct 23, 2011 at 12:44:30PM +0200, Robin Rosenberg wrote:

> Jeff King skrev 2011-10-22 21.09:
> >On Sat, Oct 22, 2011 at 09:04:19PM +1100, Nguyen Thai Ngoc Duy wrote:
> >
> >>This series helps pass commit message size up to output functions,
> >>though it does not change any output functions to print ^@.
> >Can we take a step back for a second and discuss what git _should_ do
> >with commits that contain NUL?
> Yes please. I don't think allowing NUL makes sense, but it makes sense
> to state how NUL should be handled when anyone attempt it, so there
> might be things to fix even if NUL is banned.
> 
> Are there any such commits in the wild?

Adding an arbitrary NUL, no, I don't think I've ever seen it outside of
people (myself included) trying to break git in interesting ways.

But utf16 may contains NUL bytes, so I expect configuring your editor to
output utf16 and running "git commit" would give you the most likely
example.

-Peff
