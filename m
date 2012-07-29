From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] buitin_config: return postitive status in get_value
Date: Sun, 29 Jul 2012 17:41:17 -0400
Message-ID: <20120729214117.GB3071@sigill.intra.peff.net>
References: <1343475730-18743-1-git-send-email-nikolay@vladimiroff.com>
 <CACsJy8BUU13H1tRfTtUme_7u0Jf0upca31U-VNhXva_0R2MLoQ@mail.gmail.com>
 <CAJg5NvdAq_zEx2phVGS4EiUfqMtFJA2Bo=y1d3FJyWXtzMwCTw@mail.gmail.com>
 <20120728132923.GA31388@do>
 <7vipd7vzql.fsf@alter.siamese.dyndns.org>
 <7v4noqwb6e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nikolay Vladimirov <nikolay@vladimiroff.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 23:41:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvbEq-0004ie-Ns
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 23:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646Ab2G2VlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 17:41:20 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40813 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753099Ab2G2VlT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 17:41:19 -0400
Received: (qmail 10487 invoked by uid 107); 29 Jul 2012 21:41:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 29 Jul 2012 17:41:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Jul 2012 17:41:17 -0400
Content-Disposition: inline
In-Reply-To: <7v4noqwb6e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202501>

On Sun, Jul 29, 2012 at 01:43:21PM -0700, Junio C Hamano wrote:

> > But if we really want to follow that "documented" subset of possible
> > conditions, I agree that your version to return "1" in this case,
> > together with a change to initialize "ret" to "7" and document it as
> > "all other errors (ret=7), would make more sense.  Other conditions
> > that have been added since that partial enumeration of the exit code
> > was done are regexp errors, which I think will get -1 from the same
> > function.
> 
> IOW, something like this.
> 
>  Documentation/git-config.txt | 18 ++++++++++--------
>  builtin/config.c             |  8 ++++++--
>  2 files changed, 16 insertions(+), 10 deletions(-)

This looks right to me. Even if we are missing an error case, it is
certainly going in the right direction.

-Peff
