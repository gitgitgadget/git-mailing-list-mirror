From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote: allow "-t" with fetch mirrors
Date: Thu, 26 May 2011 13:31:06 -0400
Message-ID: <20110526173106.GA2608@sigill.intra.peff.net>
References: <20110526151100.GA2881@sigill.intra.peff.net>
 <7vk4ddxucf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jimmie WESTER <jimmie.wester@stericsson.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 19:31:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPeOx-0002Lb-Vp
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 19:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757862Ab1EZRbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 13:31:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42455
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757725Ab1EZRbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 13:31:09 -0400
Received: (qmail 14440 invoked by uid 107); 26 May 2011 17:31:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 13:31:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 13:31:06 -0400
Content-Disposition: inline
In-Reply-To: <7vk4ddxucf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174551>

On Thu, May 26, 2011 at 10:08:48AM -0700, Junio C Hamano wrote:

> > So 13fc2c1 was overly constrictive, and disallowed
> > reasonable specific-branch mirroring, like:
> >
> >   git remote add -t heads/foo -t heads/bar --mirror=fetch
> 
> I mildly disagree that it is "reasonable".  I would understand if it were
> something like this:
> 
>   git remote add -t heads/foo:heads/foo -t heads/bar:heads/bar
> 
> I am not saying selective copying is bad or useless.  It would be useful
> in some situations.  I am saying that is not a mirror, and reusing the
> same --mirror option for a different meaning may introduce confusion.

I think of it as "you are mirroring these specific refs to your
repository" instead of "you are fetching these specific refs into remote
tracking branches". But it is somewhat a matter of semantics.

I agree that allowing generalized refspecs via "-t" is a nicer solution
in the long run.  I am mostly trying to fix a regression in 13fc2c1
here; I guess the question is whether it is one worth fixing, or if
people who want to do this in the meantime should just use "git config".

-Peff
