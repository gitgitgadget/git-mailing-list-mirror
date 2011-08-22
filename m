From: Jeff King <peff@peff.net>
Subject: Re: Malformed branch name in fast-export when specifying
 non-HEAD/branch revision
Date: Mon, 22 Aug 2011 12:19:32 -0400
Message-ID: <20110822161932.GA1945@sigill.intra.peff.net>
References: <CAORuUR1viqG27+dYOFS_5SLxFOE2wHJqAQ3i3RByg_fbWACh-Q@mail.gmail.com>
 <CAORuUR154Dhg5vDojga-01bDxxf+=R2X-oJK-0417CgmqxCwvA@mail.gmail.com>
 <CABPp-BFRZMZjhWuUUeD7Oa1HbWQMnZot7dRm3zKOpCoj_QwZeg@mail.gmail.com>
 <7vliurd62x.fsf@alter.siamese.dyndns.org>
 <20110817231922.GA28966@sigill.intra.peff.net>
 <CAGdFq_iiTt8F+kPXwZZT3fAKwZLCpPr7BOYtistxvv6s52Q5nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Owen Stephens <git@owenstephens.co.uk>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 18:19:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvXDx-0008TZ-Vh
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 18:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940Ab1HVQTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 12:19:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56870
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab1HVQTg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 12:19:36 -0400
Received: (qmail 17782 invoked by uid 107); 22 Aug 2011 16:20:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 22 Aug 2011 12:20:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Aug 2011 12:19:32 -0400
Content-Disposition: inline
In-Reply-To: <CAGdFq_iiTt8F+kPXwZZT3fAKwZLCpPr7BOYtistxvv6s52Q5nQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179870>

On Sun, Aug 21, 2011 at 03:29:38PM -0700, Sverre Rabbelier wrote:

> > Yes, this was the conclusion I came to when I looked at this a month or
> > so ago. You really need to give fast-export a mapping of objects to
> > refnames, and it should output ref names _only_ for the mapping. That
> > would handle this "not a ref" case, but would also let you push
> > "refs/heads/foo" when it is equivalent to "refs/heads/master", without
> > fast-export mentioning "refs/heads/master" at all.
> 
> Does this bring any new insights into how the problem I was pointing
> out (trying to push next if master points at the same commit does
> nothing) could/should be solved?

Hmm. Maybe I am misremembering the problem, but I thought that worked
already. If you say:

  git fast-export refs/heads/foo

you should get only reset/commit lines in the output for refs/heads/foo,
no?

Now I can't seem to replicate the case where refs/heads/master is
mentioned, but you didn't want it to be. I may have to go back and
re-read the thread from a month or two ago when we discussed these
issues.

-Peff
