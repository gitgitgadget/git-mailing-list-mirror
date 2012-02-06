From: Ted Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] Fix build problems related to profile-directed
 optimization
Date: Mon, 6 Feb 2012 00:57:50 -0500
Message-ID: <20120206055750.GA6615@thunk.org>
References: <7vaa4zpu2r.fsf@alter.siamese.dyndns.org>
 <1328489090-14178-1-git-send-email-tytso@mit.edu>
 <20120206041839.GB29365@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 06:58:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuHaS-00077b-Et
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 06:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837Ab2BFF54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 00:57:56 -0500
Received: from li9-11.members.linode.com ([67.18.176.11]:36489 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769Ab2BFF5z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 00:57:55 -0500
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1RuHaL-0006Sd-Dk; Mon, 06 Feb 2012 05:57:53 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1RuHaI-0001qp-8q; Mon, 06 Feb 2012 00:57:50 -0500
Content-Disposition: inline
In-Reply-To: <20120206041839.GB29365@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190024>

On Sun, Feb 05, 2012 at 11:18:39PM -0500, Jeff King wrote:
> > -	$ make profile-all
> > -	# make prefix=... install
> > +	$ make --prefix=/usr PROFILE=BUILD all
> > +	# make --prefix=/usr PROFILE=BUILD install
> 
> Eh? --prefix?

Oops, configure meme strikes; will fix.

> > +As a caveat: a profile-optimized build takes a *lot* longer since it
> > +is the sources have to be built twice, and in order for the profiling
> 
> s/it is//

Thanks, will fix.

> > +ifeq "$(PROFILE)" "GEN"
> > +	CFLAGS += -fprofile-generate=$(PROFILE_DIR) -DNO_NORETURN=1
> > +	EXTLIBS += -lgcov
> > +	export CCACHE_DISABLE=t
> > +	V=1
> > +else ifneq "$PROFILE" ""
> 
> Did you mean "$(PROFILE)" in the second conditional?

Yes, thanks.   Will fix.

						- Ted
