From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] buitin_config: return postitive status in get_value
Date: Sun, 29 Jul 2012 17:39:28 -0400
Message-ID: <20120729213928.GA3071@sigill.intra.peff.net>
References: <1343475730-18743-1-git-send-email-nikolay@vladimiroff.com>
 <CACsJy8BUU13H1tRfTtUme_7u0Jf0upca31U-VNhXva_0R2MLoQ@mail.gmail.com>
 <CAJg5NvdAq_zEx2phVGS4EiUfqMtFJA2Bo=y1d3FJyWXtzMwCTw@mail.gmail.com>
 <20120728132923.GA31388@do>
 <7vipd7vzql.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nikolay Vladimirov <nikolay@vladimiroff.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 23:39:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvbD5-0003Yr-Jy
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 23:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642Ab2G2Vjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 17:39:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40802 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753594Ab2G2Vja (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 17:39:30 -0400
Received: (qmail 10443 invoked by uid 107); 29 Jul 2012 21:39:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 29 Jul 2012 17:39:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Jul 2012 17:39:28 -0400
Content-Disposition: inline
In-Reply-To: <7vipd7vzql.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202500>

On Sat, Jul 28, 2012 at 11:38:10PM -0700, Junio C Hamano wrote:

> > Then the following patch may be better because it leaves other cases
> > untouched (I'm not saying that we should or should not do it though)
> 
> I personally think that the documentation unnecessarily exposes the
> useless value assignment of the exit codes (the use of different
> exit codes was done merely to aid debugging the git-config command
> itself) by describing the then-current set of conditions, and should
> be reduced to say "0 for success, non-zero for any error".

We use ret=5 in the test suite to say "unset this variable, but it's OK if
it wasn't set in the first place" but still fail on error. The only
other one I can imagine that would be useful is "you tried to get a
variable but it did not exist, and there was no other error". Which is
probably what ret=1 is attempting to do, though it also encompasses
syntactically bogus keys.

-Peff
