From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] Using index-pack in place of verify-pack
Date: Mon, 28 Feb 2011 11:58:27 -0500
Message-ID: <20110228165827.GB24915@sigill.intra.peff.net>
References: <1298886583-30965-1-git-send-email-gitster@pobox.com>
 <AANLkTimrO6NqB0pXcfz=dAzA5fxz9ZizLyW7YV4Jan6S@mail.gmail.com>
 <7vfwr8jfsl.fsf@alter.siamese.dyndns.org>
 <AANLkTikTPVf1fZiTxsmLe-MCWVQY4YBGen5Bj_Yn0SSz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 17:58:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu6Qe-0004rm-99
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 17:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124Ab1B1Q6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 11:58:31 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49757 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753973Ab1B1Q6a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 11:58:30 -0500
Received: (qmail 25587 invoked by uid 111); 28 Feb 2011 16:58:27 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 28 Feb 2011 16:58:27 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Feb 2011 11:58:27 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikTPVf1fZiTxsmLe-MCWVQY4YBGen5Bj_Yn0SSz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168122>

On Mon, Feb 28, 2011 at 05:46:19PM +0100, Sverre Rabbelier wrote:

> On Mon, Feb 28, 2011 at 17:16, Junio C Hamano <gitster@pobox.com> wrote:
> > Not yet; the code has just become in good enough shape to be built and
> > measured by anybody interested --- didn't I say WIP somewhere?
> 
> Yes, but I figured that we'd want to see if it's worth pursuing at
> all, e.g., whether we should try and get this in decent shape or not?

I'm not at all interested in this topic, but in the time it took the two
of you to write your emails, I did this:

  $ cd linux-2.6

  $ time git verify-pack \
      .git/objects/pack/pack-36c50f6082df404c26a699f2702946e0cce6208f.idx
  real    2m37.338s
  user    2m35.874s
  sys     0m1.348s

  $ time git index-pack --verify \
      .git/objects/pack/pack-36c50f6082df404c26a699f2702946e0cce6208f.pack
  real    1m37.208s
  user    1m36.106s
  sys     0m1.048s


OK, with the CPU time it probably took longer than your emails. But I
ate some ice cream while it computed. :)

-Peff
