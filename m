From: Jeff King <peff@peff.net>
Subject: Re: Supporting "-v" option for git-log
Date: Wed, 25 May 2011 16:01:36 -0400
Message-ID: <20110525200136.GD27260@sigill.intra.peff.net>
References: <BANLkTik70gu0NUzUEnGNWHQr8CfbdPVe5g@mail.gmail.com>
 <SNT124-W39164C74A457129811245DC4740@phx.gbl>
 <BANLkTi=v8j=VdBNgThRTFXk+YbPFOFvzwQ@mail.gmail.com>
 <SNT124-W5207D5461CD80509763B79C4740@phx.gbl>
 <BANLkTikT4s+Twfip2g7Zo-XcML1Wbd3qBg@mail.gmail.com>
 <20110525132816.GA6709@sigill.intra.peff.net>
 <7vlixu4reu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elazar Leibovich <elazarl@gmail.com>,
	Tim Mazid <timmazid@hotmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 22:01:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPKH3-0005JP-KU
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 22:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608Ab1EYUBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 16:01:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45638
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938Ab1EYUBj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 16:01:39 -0400
Received: (qmail 4927 invoked by uid 107); 25 May 2011 20:01:38 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 May 2011 16:01:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2011 16:01:36 -0400
Content-Disposition: inline
In-Reply-To: <7vlixu4reu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174456>

On Wed, May 25, 2011 at 10:32:41AM -0700, Junio C Hamano wrote:

> > (which now means "grep for b, but do not include commits in c"). And
> > even if we wanted to do that, there is a parsing ambiguity. Does the
> > "--not" apply _just_ to the grep, or does it also include "not c"?
> >
> > Which is a shame, because we already have all of the code for "--and",
> > "--or", and "--not" in git-grep.
> 
> True, that has always been an accepted limitation.
> 
> You could add --grep="-e A --and --not -e B --all-match", split_cmdline()
> and then give the result to append_grep_pattern(), or something like that,
> but I do not think it is worth doing.

Besides being ambiguous with current usage (e.g., grepping for something
starting with "-e"), I do not long for the quoting nightmare of:

  git log --grep="-e 'something with spaces'
      --and --not -e 'something with \"double quotes\"'
      --and --not -e 'something with '\\''single quotes'\\''"

-Peff
