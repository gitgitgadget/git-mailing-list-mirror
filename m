From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH v3 1/3] tests: Prepare --textconv tests for correctly-failing conversion program
Date: Tue, 28 Sep 2010 19:09:10 +0400
Message-ID: <20100928150910.GA30544@landau.phys.spbu.ru>
References: <cover.1285351816.git.kirr@landau.phys.spbu.ru> <66d4603c7e21561557f612690d6196e7ae0b38f9.1285351816.git.kirr@landau.phys.spbu.ru> <7vsk0vyriw.fsf@alter.siamese.dyndns.org> <20100928120722.GA29525@landau.phys.spbu.ru> <20100928132356.GA5829@sigill.intra.peff.net> <20100928143540.GA30357@landau.phys.spbu.ru> <20100928143928.GA8918@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl??ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 28 17:09:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0bnz-0004T7-Ib
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 17:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270Ab0I1PJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 11:09:12 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:45095 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643Ab0I1PJL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 11:09:11 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 316DCFF718; Tue, 28 Sep 2010 19:09:10 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <20100928143928.GA8918@sigill.intra.peff.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157433>

On Tue, Sep 28, 2010 at 10:39:28AM -0400, Jeff King wrote:
> On Tue, Sep 28, 2010 at 06:35:40PM +0400, Kirill Smelkov wrote:
> 
> > > >  t/t4042-diff-textconv-caching.sh |    4 ++--
> > > 
> > > Why are we touching t4042 at all in this series? We are not actually
> > > adding any tests to it, AFAICT.
> > 
> > Because we want to catch potential wrong textconv invocation on non
> > "bin: " files there too?
> 
> But we don't actually add any tests that display the problem there, do
> we? And even if we wanted to test the diff implementation, wouldn't
> t4030 be the write place to do that? t4042 is specifically about
> textconv caching.

Yes, I hadn't added new tests there, but at least I've changed
already-in-there helper to bail out if it is called on non "binary"
files, so a small step, but still step forward, no?

And I've changed that helper after doing `git grep` for textconv, and
ideally we shouldn't keep those copy-pasted helpers in several tests (we
have 3 at present - in t4042, t8006 and t8007), but move them into one
common place some day.

So in order to at least keep copies consistent between each other, I've
changed them all in uniform manner.

That was my rationale.


Thanks,
Kirill
