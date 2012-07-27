From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/4] Prepare Git::SVN for extraction into its own file.
Date: Fri, 27 Jul 2012 11:53:26 +0000
Message-ID: <20120727115326.GA8890@dcvr.yhbt.net>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
 <1343344945-3717-3-git-send-email-schwern@pobox.com>
 <7vvch93hpy.fsf@alter.siamese.dyndns.org>
 <50124E71.2010302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca, jrnieder@gmail.com
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 13:53:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Suj6s-00054S-67
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 13:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344Ab2G0Lx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 07:53:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57215 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872Ab2G0Lx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 07:53:26 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 753341F4CB;
	Fri, 27 Jul 2012 11:53:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <50124E71.2010302@pobox.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202351>

Michael G Schwern <schwern@pobox.com> wrote:
> On 2012.7.26 10:18 PM, Junio C Hamano wrote:
> > Again, I agree with you that passing $prefix as one of the arguments
> > to ->new is the right thing to do in the final state after applying
> > the whole series.  I don't know if later steps in your patch series
> > will do so, but it _might_ make more sense to update ->new and its
> > callers to do so without doing anything else first, so that you do
> > not have to call out to the ::opt_prefix() when you split things
> > out.
> 
> I don't personally plan on doing any more about it, no.  It isn't needed for
> SVN 1.7, there's very little real code change (which you could see by looking
> at my remote instead of waiting to be fed patches...) and its a very, very
> minor problem in the grand scheme.

I agree, its not worth it right now.

> The first step toward that would be to change git-svn so it can be loaded as a
> library using the standard "main() unless caller" trick.  Then Git::SVN unit
> tests can require git-svn as a library without executing it and get some tests
> written with a minimum of Git::SVN code change.

> None of which I plan to get into just now.

That's fine.  The modules were an afterthought and not intended at the
time for standalone use, so it'd take a bit of work.  I doubt the
modules will be useful elsewhere, but will make code easier to
maintain in the future.

I also value functional/integration tests far more than unit tests.
