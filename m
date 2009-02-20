From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Add more tests of cvsimport
Date: Fri, 20 Feb 2009 10:00:22 -0500
Message-ID: <20090220150022.GB3515@coredump.intra.peff.net>
References: <1235107093-32605-1-git-send-email-mhagger@alum.mit.edu> <20090220062543.GA27837@coredump.intra.peff.net> <499E8432.9010806@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 20 16:02:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaWt0-0006IM-Rx
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 16:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbZBTPA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 10:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426AbZBTPAZ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 10:00:25 -0500
Received: from peff.net ([208.65.91.99]:44130 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752411AbZBTPAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 10:00:25 -0500
Received: (qmail 2762 invoked by uid 107); 20 Feb 2009 15:00:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Feb 2009 10:00:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Feb 2009 10:00:22 -0500
Content-Disposition: inline
In-Reply-To: <499E8432.9010806@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110852>

On Fri, Feb 20, 2009 at 11:21:38AM +0100, Michael Haggerty wrote:

> > I do wonder, though, whether it would be simpler to make a "cvs import
> > test suite" that could pluggably test cvs2svn, git-cvsimport, or other
> > converters. Then you could test each on the exact same set of test
> > repos. And abstracting "OK, now make a repository from this cvsroot"
> > wouldn't be that hard for each command (I wouldn't think, but obviously
> > I haven't tried it :) ).
> [...]
> But other tests would be harder to write in a neutral fashion.  For
> example, the cvs2svn test suite has tests of log messages, character-set
> conversions of metadata, correct commit ordering, branching topology, etc.

OK. I haven't looked at it and you have, so I will accept your
judgement.

> > The code in t9600 (which gets moved to lib-cvs in your patch 1) sets
> > HOME explicitly. So is this really a problem?
> 
> That's a good question.  I just checked, and empirically cvs uses .cvsrc
> from my true home directory even if HOME is set differently.  So I think
> that the -f option is indeed necessary.

Yuck. But if that's the way it works, then I think your patch is the
only way.

> > Cool. Are you volunteering to fix git-cvsimport, too? :)
> Not unless you call cvs2git the fixed version :-)

Heh.

> design limits).  But I hope to raise awareness that cvsps-based tools
> are not the best choice for "one-shot" conversions, and maybe work
> against people's tendency to use the "default" tool unless it obviously
> blows up.

Agreed. I have seen that advice given on the list several times, and it
seems to be working for people. So it really is about the right tool for
the job, IMHO.

-Peff
