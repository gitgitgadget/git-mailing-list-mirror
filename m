From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Tue, 24 Jun 2008 01:35:04 -0400
Message-ID: <20080624053504.GB19224@sigill.intra.peff.net>
References: <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org> <20080623195314.GA29569@sigill.intra.peff.net> <alpine.LFD.1.10.0806231307070.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 07:36:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB1CH-0002Po-TM
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 07:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbYFXFfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 01:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbYFXFfJ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 01:35:09 -0400
Received: from peff.net ([208.65.91.99]:1976 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208AbYFXFfI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 01:35:08 -0400
Received: (qmail 32644 invoked by uid 111); 24 Jun 2008 05:35:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 24 Jun 2008 01:35:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jun 2008 01:35:04 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806231307070.2926@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85994>

On Mon, Jun 23, 2008 at 01:12:28PM -0700, Linus Torvalds wrote:

> > in your options table. And if setup_revisions takes options that affect
> > things that _aren't_ in that struct, then they probably ought to be.
> 
> The world isn't like "it ought to be". It is like it is.
> 
> If you keep on dreaming about how things "ought to be", you'll never 
> confront the things as they are. The fact is, turning the existing very 
> simple argument parsers into using "parse_options()" is just _hard_.
> 
> Then you say that it all "ought to be" in those options already.

Did you even read my mail? All I said "ought to be" is that revision
options "ought to be" affecting things in the struct. As in, when I
convert this to parse_options, if there are any cases which don't fall
into that pattern then I "ought to be" able to convert them as part of
the code cleanup. And looking over the revision parsing code, it looks
like everything falls into that case already.

So if you have something FACTUAL to say that contradicts that point, by
all means do it. You might save me some work if you find a showstopper
in my approach.

> Sure. Do we have some invisible sky wizard to make it so?

Well, given that I already said I would work on it, I guess that makes
me the sky wizard. Bow down before my wizardly might!

That being said, it looks like Pierre is working on a slightly different
approach, and I am happy to sit back and see how that pans out for now.
So perhaps he is the sky wizard.

> I tried to do just _one_ program. Trust me, I'm not going to even bother 
> trying to do another unless parse_options() is made more palatable to do 
> in small pieces. 

Maybe we are fundamentally talking across each other. I'm not talking
about some specifics for converting a bunch of programs, or some
problems with parse_options. I'm suggesting that the main "two stage"
option parsing generally has the revision parsing as the "second stage".
Converting that one thing to parse_options will help with converting
many programs (e.g., a failed conversion of shortlog that others and I
worked on).

You seem to have a bunch of _other_ problems with parse_options. And
that is fine, but they have nothing whatsoever to do with anything I've
said. So don't "sky wizard" _me_ about those problems. ;P

-Peff
