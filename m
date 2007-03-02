From: Jeff King <peff@peff.net>
Subject: Re: [PATCH, 4th version] git-branch: register where to merge from, when branching off a remote branch
Date: Fri, 2 Mar 2007 06:21:52 -0500
Message-ID: <20070302112152.GA14377@coredump.intra.peff.net>
References: <45E69EEE.8070905@lu.unisi.ch> <81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com> <7vvehls1h9.fsf@assigned-by-dhcp.cox.net> <45E70041.1030705@lu.unisi.ch> <Pine.LNX.4.63.0703012240210.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45E7DC04.5010701@lu.unisi.ch> <45E7E53E.5020704@gnu.org> <7vtzx4ezvm.fsf@assigned-by-dhcp.cox.net> <20070302103240.GA13217@coredump.intra.peff.net> <45E8076F.1050606@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Paolo Bonzini <paolo.bonzini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 12:22:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN5pn-0006lo-2y
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 12:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423032AbXCBLV4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 06:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423037AbXCBLV4
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 06:21:56 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4870 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423032AbXCBLVz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 06:21:55 -0500
Received: (qmail 26745 invoked from network); 2 Mar 2007 06:22:10 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 2 Mar 2007 06:22:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Mar 2007 06:21:52 -0500
Content-Disposition: inline
In-Reply-To: <45E8076F.1050606@lu.unisi.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41193>

On Fri, Mar 02, 2007 at 12:15:59PM +0100, Paolo Bonzini wrote:

> > the time of branching, which seems to be the source of a lot of objects.

Err, this should be "the source of a lot of objections" of course.

> The problem is that this will pollute the configuration file a lot.
> I'm starting to wonder if all this branch information really belongs
> in .git/config at all.

I'm not sure how this pollutes any more than the existing proposal. But
I have always been a bit uncomfortable with automatic editing of the
user config (having used such programs in the past, it always seems to
cause subtle annoyances -- however, I find I don't even use the per-repo
config in most cases, but just the ~/.gitconfig).

Perhaps if we had an inclusion mechanism, all automatically written
configuration could go into $GIT_DIR/auto_config with a big warning at
the top, and the .git/config could include it.

Or are you concerned with just polluting the config namespace? Obviously
we could store per-branch metadata somewhere else, but I think there has
been a push to put it _into_ the config over the past several months,
instead of in a separate file.

-Peff
