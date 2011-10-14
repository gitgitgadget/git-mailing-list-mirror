From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not
 allowed
Date: Fri, 14 Oct 2011 16:34:38 -0400
Message-ID: <20111014203438.GA15643@sigill.intra.peff.net>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
 <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net>
 <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
 <20111013182816.GA17573@sigill.intra.peff.net>
 <7vvcrs181e.fsf@alter.siamese.dyndns.org>
 <20111014131041.GC7808@sigill.intra.peff.net>
 <20111014192326.GA7713@sigill.intra.peff.net>
 <20111014192741.GA13029@sigill.intra.peff.net>
 <7v7h47z5i0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 22:34:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REoSt-0002qR-TU
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 22:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334Ab1JNUen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 16:34:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60831
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906Ab1JNUem (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 16:34:42 -0400
Received: (qmail 14633 invoked by uid 107); 14 Oct 2011 20:34:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Oct 2011 16:34:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Oct 2011 16:34:38 -0400
Content-Disposition: inline
In-Reply-To: <7v7h47z5i0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183606>

On Fri, Oct 14, 2011 at 01:24:07PM -0700, Junio C Hamano wrote:

> > Git is foremost an open system, and our defaults should
> > reflect that.
> [...]
> 
> I think the logic in the last paragraph is flawed.
> 
> There is a difference between Git being an open system, and installations
> and users of Git being primarily people who work on open projects.
> 
> Even though personally I wish there weren't.

I think it is not the logic that is flawed, but the communication. What
I meant was that git was originally designed to support open projects
(like the kernel), and they are our primary target.

Ingo said something similar here:

  http://article.gmane.org/gmane.linux.kernel/1202320

Still, primary target and primary user are not necessarily the same
thing. And a minor convenience for one audience that introduces a
security problem for another audience may not be a good tradeoff, no
matter who the audiences are.

I didn't really expect you to take my second patch. We tend to be a bit
more conservative than that around here.

> > But since it is a potential security issue, it does seem kind of mean to
> > closed sites to just flip the switch on them.
> 
> It would have been a better split to have the 1/2 patch to support both
> informative and uninformative errors, with the default to say "access
> denied", and 2/2 to flip the default to be more open.

Isn't that what I did? It was what I meant to do, anyway...

Or did you mean the options would have been better worded as:

  --errors={terse,informative}

or something similar?

-Peff
