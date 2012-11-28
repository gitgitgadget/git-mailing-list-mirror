From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Wed, 28 Nov 2012 14:42:16 -0500
Message-ID: <20121128194216.GA22202@odin.tremily.us>
References: <7vboehv9d6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 20:42:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdnWk-0003wd-DR
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 20:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab2K1TmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 14:42:19 -0500
Received: from vms173015pub.verizon.net ([206.46.173.15]:59471 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754211Ab2K1TmS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 14:42:18 -0500
Received: from odin.tremily.us ([unknown] [72.68.95.13])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME700L6AQQG8C60@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 28 Nov 2012 13:42:17 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 395E76E1B38; Wed,
 28 Nov 2012 14:42:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354131736; bh=IZUFef/d97hXhwQ84HTtSseuMfh7nTdRzL1ygf2+PfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=pIkZR9LPZS3BoUT+SjLrGChcTYaw8PUSWA8pHrhnonpEY04FtWuq9Vp9HqJP2TUXF
 K0GrrMKQIR5nrKxpNucGymS1QrmcTtwVHwDZ98ViKo7bv5KxicYkHh9ldqq3eB8ICd
 e59MBwjv+xe201wngwZ7mhPlf7CyadYv3+OPtn18=
Content-disposition: inline
In-reply-to: <7vboehv9d6.fsf@alter.siamese.dyndns.org>
 <7vzk2oo2d2.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210767>

On Wed, Nov 28, 2012 at 11:02:45AM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> 
> > From: "W. Trevor King" <wking@tremily.us>
> >
> > Signed-off-by: W. Trevor King <wking@tremily.us>
> > ---
> >  Documentation/git-submodule.txt | 3 ++-
> >  git-submodule.sh                | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> Hmm, I wonder why I have this funny feeling that this was proposed
> and rejected already...
> 
> As the command takes other options whose names begin with 'r', I
> thought the longer term plan was to stop letting "--rebase" squat on
> short and sweet "-r" and leaving it undocumented (even though the
> short one was added by mistake) was meant to be the first step in
> that process.
> 
> But maybe I am confusing an undocumented single-letter option from
> some other subcommand.  Anybody remembers?

Perhaps you are remembering:

On Sun, Nov 11, 2012 at 02:33:45AM -0800, Junio C Hamano wrote:
> Ah, this reminds me of another thing I noticed when I saw that
> patch.  The change seems to think "branch" is the _only_ thing the
> user might want to record per submodule upon "git submodule add".
> As an interface to muck with an uninterpreted random configuration,
> it squats on a good option name for setting one single and arbitrary
> variable---quite a selfish change that is not acceptable.
> 
> Calling the option "--record-branch-for-submodule" or something more
> specific might alleviate the problem, but then it would become even
> less useful as a short-hand for "config submodule.$name.branch", I
> would suspect.

With this recent patch, I'm just documenting someone else's squatting
;).  But yes, the reason I noticed was because I was tempted to make
the same mistake again :p.  In my defense, I think `update --remote`
is a good deal more general than my earlier `add --record`.

Cheers,
Trevor

-- 
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy
