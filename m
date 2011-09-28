From: Jeff King <peff@peff.net>
Subject: Re: SVN -> Git *but* with special changes
Date: Wed, 28 Sep 2011 15:04:45 -0400
Message-ID: <20110928190445.GC1482@sigill.intra.peff.net>
References: <1317227849979-6840904.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Abscissa <bus_nabble_git@semitwist.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 21:04:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8zR6-0002GT-OL
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 21:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136Ab1I1TEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 15:04:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47528
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962Ab1I1TEs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 15:04:48 -0400
Received: (qmail 7895 invoked by uid 107); 28 Sep 2011 19:09:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Sep 2011 15:09:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Sep 2011 15:04:45 -0400
Content-Disposition: inline
In-Reply-To: <1317227849979-6840904.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182358>

On Wed, Sep 28, 2011 at 09:37:29AM -0700, Abscissa wrote:

> I have a couple big projects in SVN that I'd like to convert to Git. Being in
> SVN, they've operated under a couple assumptions that are not true under
> Git. These assumptions are:
> 
> 1. Directories can exist even if there's nothing in them (just like any
> filesystem).

The usual technique is to put an empty .gitignore file into the empty
directory, which will make sure it always exists.  If you import with
git-svn, it supports "--preserve-empty-dirs", which will do this for you
automatically.

> 2. Keeping binary files in version control isn't a big deal because the
> whole repo doesn't get copied to everyone's system or use up people's GitHub
> storage space.

git-svn --ignore-paths will handle this for you.

Side note on the GitHub thing: all of the forks will share objects, so
it's not much as space as you might think. And all of the paid plans
count repos, not bytes. Of course, the painful part is probably cloning
the big objects to everybody's workstation. :)

> (Also, there are tags and branches to be converted too, in the
> SVN-standard "tags" and "branches" directories.)

git svn --stdlayout ?

-Peff
