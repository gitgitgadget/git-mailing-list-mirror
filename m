From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] git-remote-mediawiki: new tool to preview local
 changes without pushing
Date: Wed, 12 Jun 2013 04:55:02 -0400
Message-ID: <20130612085502.GA1935@sigill.intra.peff.net>
References: <1370641831-9115-1-git-send-email-benoit.person@ensimag.fr>
 <20130609060807.GA8906@sigill.intra.peff.net>
 <CAETqRCiJmnz_1yjwvyWx+=kPkt3M+vKk--CnS=rnQcDA4wMSmg@mail.gmail.com>
 <20130611213722.GA21203@sigill.intra.peff.net>
 <vpqli6f24z3.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?Beno=C3=AEt?= Person <benoit.person@ensimag.fr>,
	git@vger.kernel.org,
	=?utf-8?B?Q8OpbGVzdGlu?= Matte <celestin.matte@ensimag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 12 10:55:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umgpm-0001PC-7L
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 10:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130Ab3FLIzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 04:55:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:35039 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753506Ab3FLIzG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 04:55:06 -0400
Received: (qmail 10625 invoked by uid 102); 12 Jun 2013 08:55:57 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Jun 2013 03:55:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jun 2013 04:55:02 -0400
Content-Disposition: inline
In-Reply-To: <vpqli6f24z3.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227594>

On Wed, Jun 12, 2013 at 08:55:12AM +0200, Matthieu Moy wrote:

> > But I think we have already crossed that bridge somewhat with Git.pm.
> > And if you add your module as perl/Git/MediaWiki.pm and use the existing
> > perl build system, then it is not any extra effort from the build
> > system.
> 
> I'm not sure having perl/Git/MediaWiki.pm would be a good idea: this
> MediaWiki.pm would be really a mediawiki thing more than a Git thing, so
> the Git main tree probably want to stay away from it and keep it in
> contrib.

Yes, it's ugly. It means that the mediawiki stuff creeps out of contrib
and into the main tree; and worse, as part of a public API that gets
installed. We'd have to be a lot more picky about the interface and the
code quality.

> But you should be able to use contrib/mw-to-git/perl/GitMediawiki.pm or
> something like that and chain to ../../perl/Makefile in
> contrib/mw-to-git/Makefile.

That might work. Most of the magic in perl/Makefile happens in the
perl-generated MakeMaker bits, though, so it may not be that easy. I
haven't looked.

> Also, for now, git-remote-mediawiki works only after you run "make
> install" in Git's toplevel. I think that's ok, but it would be weird to
> be able to use/test git-remote-mediawiki only after doing a "make
> install" to deploy the new mediawiki Perl module.

Good point.

-Peff
