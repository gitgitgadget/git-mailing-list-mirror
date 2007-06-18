From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [ANNOUNCE] GIT 1.5.2.2
Date: Sun, 17 Jun 2007 23:43:23 -0400
Message-ID: <20070618034322.GI18491@spearce.org>
References: <7vodjf1gxl.fsf@assigned-by-dhcp.pobox.com> <200706171230.37659.arekm@maven.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Arkadiusz Miskiewicz <arekm@maven.pl>
X-From: git-owner@vger.kernel.org Mon Jun 18 05:43:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I089M-0001jq-H7
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 05:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbXFRDnc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 23:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621AbXFRDnb
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 23:43:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52058 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbXFRDnb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 23:43:31 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I0895-0001hp-Q4; Sun, 17 Jun 2007 23:43:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8310220FBAE; Sun, 17 Jun 2007 23:43:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200706171230.37659.arekm@maven.pl>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50379>

Arkadiusz Miskiewicz <arekm@maven.pl> wrote:
> On Sunday 17 of June 2007, Junio C Hamano wrote:
> > The latest maintenance release GIT 1.5.2.2 is available at the
> > usual places:
> >
> >   http://www.kernel.org/pub/software/scm/git/
> >
> >   git-1.5.2.2.tar.{gz,bz2}			(tarball)
> >   git-htmldocs-1.5.2.2.tar.{gz,bz2}		(preformatted docs)
> >   git-manpages-1.5.2.2.tar.{gz,bz2}		(preformatted docs)
> >   RPMS/$arch/git-*-1.5.2.2-1.$arch.rpm	(RPM)
> 
> Should git testsuite (make test) go without any problem? (I'm asking because 
> some projects have test suites where some tests are expected to fail).

No, our test suite should always pass.  Junio does not ship a release
of Git where the test suite fails on his standard systems.  We have
a lot of users running the current `master` and `next` branches on
a lot of different platforms, so usually platform specific breakages
are caught relatively early, before a release gets made.

We do have tests we expect to fail, but then the test suite has an
inversion in it.  That is the test only passes if the underlying
operation failed.  ;-)

> I have 4 failures on amd64/linux and this git release:
...
> * FAIL 16: corrupt a pack and see if verify catches
>         cat test-1-${packname_1}.idx >test-3.idx &&
>              cat test-2-${packname_2}.pack >test-3.pack &&

Hmm.  That is t5300-pack-objects.sh.  Something is really fishy
if that test failed.  We destroy a packfile and then look to see
if the SHA-1 hash detects the change.  It always does.  So uh,
what's up with your hardware that it doesn't fail?

I just built 1.5.2.2 on one of my Gentoo Linux amd64 systems and I'm
not seeing any failures from the test suite.  Not that I expected
to find any; Linux amd64 is popular enough that a number of people
run it.

-- 
Shawn.
