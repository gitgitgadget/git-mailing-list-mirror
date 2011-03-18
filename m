From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFD 0/2] revision.c: --merges, --no-merges and
 --merges-only
Date: Fri, 18 Mar 2011 04:56:16 -0400
Message-ID: <20110318085616.GA16703@sigill.intra.peff.net>
References: <cover.1300359256.git.git@drmicha.warpmail.net>
 <20110317195905.GG20508@sigill.intra.peff.net>
 <4D831043.1060709@drmicha.warpmail.net>
 <7vbp18yh1f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 09:56:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0VTy-0001X2-5k
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 09:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095Ab1CRI4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 04:56:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53284
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756408Ab1CRI4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 04:56:24 -0400
Received: (qmail 480 invoked by uid 107); 18 Mar 2011 08:56:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 Mar 2011 04:56:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Mar 2011 04:56:16 -0400
Content-Disposition: inline
In-Reply-To: <7vbp18yh1f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169303>

On Fri, Mar 18, 2011 at 01:22:20AM -0700, Junio C Hamano wrote:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > From the ui perspective I'm somehow not a big fan of tri-state options
> > but can't give hard reasons why; maybe because they force you to use
> > option arguments.
> 
> But in this particular case, you cannot really hack it with two options
> that appear independent on surface but in reality are not. Logically, it
> is an enum <everything, non-merges, merges-only> and you can choose only
> one of them, and it is even worse from the UI perspective to use
> combination of two not-quite-independent options.
> 
> Also I have a hidden agenda to add "because we could" --show=octopus to
> the enum later perhaps only to my private edition ;-)

Yes, I read your other response to Michael and I think that makes the
most sense. In the most general form it is "--show=<num_parents>",
though I don't think there is really much point in values besides 0, 1,
2, or >2 (or combinations thereof, though again, probably only "this
particular value" or "any" is of interest).

So what you have said so far covers that, except for "--show=roots",
which I think would be a useful addition.

The over-engineer in me wants to have the general form
"--grep-by-parent-count=0,1" and "--show=no-merges" as a human-friendly
alias to that. But I can't think of a good reason to have the general
form, except for the sake of generalizing.

-Peff
