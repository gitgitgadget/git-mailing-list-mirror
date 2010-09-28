From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH v3 1/3] tests: Prepare --textconv tests for correctly-failing conversion program
Date: Tue, 28 Sep 2010 18:35:40 +0400
Message-ID: <20100928143540.GA30357@landau.phys.spbu.ru>
References: <cover.1285351816.git.kirr@landau.phys.spbu.ru> <66d4603c7e21561557f612690d6196e7ae0b38f9.1285351816.git.kirr@landau.phys.spbu.ru> <7vsk0vyriw.fsf@alter.siamese.dyndns.org> <20100928120722.GA29525@landau.phys.spbu.ru> <20100928132356.GA5829@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl??ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 28 16:37:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0bIg-0000xT-Pd
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 16:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127Ab0I1Ofn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 10:35:43 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:35438 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab0I1Ofl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 10:35:41 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 6DED5FF718; Tue, 28 Sep 2010 18:35:40 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <20100928132356.GA5829@sigill.intra.peff.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157426>

On Tue, Sep 28, 2010 at 09:23:57AM -0400, Jeff King wrote:
> On Tue, Sep 28, 2010 at 04:07:22PM +0400, Kirill Smelkov wrote:
> 
> > > Granted, echo is forgiving and will concatenate the arguments it gets with
> > > a space in between, but you would either want to either:
> > > 
> > >  (1) make it more explicit that helper gets only one argument, by saying
> > >      "$1" instead of "$@", in all places in the helper script; or
> > > 
> > >  (2) if you are planning to make 'helper' capable of handling multiple
> > >      input files, show the error message for the ones that are not binary
> > >      (you would probably need a loop for that).
> > > 
> > > I think (1) would be sufficient in this case.
> > 
> > I too think (1) is right. It was just that originally there was $@
> > (which I now understand was wrong). So ok to apply the following patch
> > on top of this series? (I assume it's ok, and will repost the whole
> > thing)
> 
> No, "helper" is supposed to be able to take multiple arguments, at least
> in t4042. See the "changing textconv invalidates cache" test. The extra
> argument comes from the user, not from git.

Yes, I've reworked that in my v4/patch4 post.

> >  t/t4042-diff-textconv-caching.sh |    4 ++--
> 
> Why are we touching t4042 at all in this series? We are not actually
> adding any tests to it, AFAICT.

Because we want to catch potential wrong textconv invocation on non
"bin: " files there too?


Thanks,
Kirill
