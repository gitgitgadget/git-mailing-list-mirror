From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] cvsimport: rewrite to use cvsps 3.x to fix major bugs
Date: Sat, 12 Jan 2013 00:04:31 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130112050431.GA31727@thyrsus.com>
References: <1357875152-19899-1-git-send-email-gitster@pobox.com>
 <7va9sfd6lk.fsf@alter.siamese.dyndns.org>
 <20130111185818.GA30398@thyrsus.com>
 <7vmwwfbjv3.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 06:05:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TttHF-0001Ne-AK
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 06:05:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401Ab3ALFEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 00:04:45 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:43847
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab3ALFEo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 00:04:44 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id F04F44065F; Sat, 12 Jan 2013 00:04:31 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vmwwfbjv3.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213260>

Junio C Hamano <gitster@pobox.com>:
> Yeah, it is OK to _discourage_ its use, but to me it looks like that
> the above is a fairly subjective policy decision, not something I
> should let you impose on the users of the old cvsimport, which you
> do not seem to even treat as your users.

Er.  You still don't seem to grasp the fundamentals of this
situation. I'm not imposing any damn thing on the users.  What's
imposing is the fact that cvsps-2.x and the Perl cvsimport are both
individually and collectively *broken right now*, and within a few
months the Perl git-cvsimport is going to cease even pretending to
work.  I'm trying to *fix that problem* as best I can, fixing it
required two radical rewrites, and criticizing me for not emulating
every last detail and misfeature immediately is every bit as pointless
and annoying as arguing about the fabric on the deck chairs while the
ship is sinking.

To put it bluntly, you should be grateful to be getting back any
functionality at all - because the alternative is that the Perl
git-cvsimport will hang out in your tree as a dead piece of cruft.
Your choice is between making it easy for me replace it with minimum
disruption now and hoping for someone else to replace it months from
now after you've had a bunch of unhappy users bitching at you.

So let me be more direct.  I think the -M and -m options are
sufficiently bad ideas that I am *not willing* to put in the quite
large amount of effort that would be required to implement them in cvsps
or parsecvs.  That would be a bad use of my time.

This is not the case with -o; that might be a good idea if I
understood it. This is also not like the 2.x fallback; I thought that
was a bad idea (because it would be better for users that the
combination break in an obvious way than continue breaking in a silent
one), but it was a small enough effort that I was willing to do it
anyway to keep the git maintainer happy. The effort to fix the quoting
bugs is even easier for me to justify; they are actual bugs.

Those are my engineering judgments; go ahead and call them
"subjective" if you like, but neither the facts nor my judgment will
change on that account.

> The "major" in my sentence was from your description (the bugs you
> fixed), and not about the new ones you still have in this draft.  I
> did not mean to say that you are trading fixes to "major" bugs with
> different "major" bugs.

OK, thank you.  In the future I will try to bear in mind that English
is not your primary language when I evaluate statements that seems a bit
offensive.

So what's your next bid? Note that you can't increase my friction and
hassle costs much more before I give up and let you deal with the
consequences without me. I want to do the right thing, but I have
more other projects clamoring for my attention than you could easily
guess.  I need to get git-cvsimport *finished* and off my hands -
I may already have given it more time than I really should have.

So give me your minimum list of deliverables before you'll merge,
please, and then stick to it.  I assume fixes for the quoting bugs
will be on that list.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
