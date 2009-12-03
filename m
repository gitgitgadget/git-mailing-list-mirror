From: Jeff King <peff@peff.net>
Subject: Re: Git documentation consistency
Date: Thu, 3 Dec 2009 02:45:00 -0500
Message-ID: <20091203074500.GA31566@coredump.intra.peff.net>
References: <m1NEaLp-000kn1C@most.weird.com>
 <20091129051427.GA6104@coredump.intra.peff.net>
 <m1NFAji-000kn2C@most.weird.com>
 <20091202200904.GA7631@coredump.intra.peff.net>
 <m1NG0O6-000kmgC@most.weird.com>
 <7vaay096ye.fsf@alter.siamese.dyndns.org>
 <m1NG61U-000kn4C@most.weird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 03 08:45:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG6NB-0000U4-8q
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 08:45:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712AbZLCHo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 02:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754222AbZLCHoz
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 02:44:55 -0500
Received: from peff.net ([208.65.91.99]:46188 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754327AbZLCHox (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:53 -0500
Received: (qmail 12507 invoked by uid 107); 3 Dec 2009 07:49:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 03 Dec 2009 02:49:28 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Dec 2009 02:45:00 -0500
Content-Disposition: inline
In-Reply-To: <m1NG61U-000kn4C@most.weird.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134439>

On Thu, Dec 03, 2009 at 02:22:41AM -0500, Greg A. Woods wrote:

> > I think you are showing ignorance here, as -? is *not* even close to
> > standard, nor even widely used practice at all.
> 
> I think I should know something about Unix command line and option
> parsers, having used them for some 25 years or so now.  In fact I've
> used most every kind of unix that ever was, and I've worked on the
> source to more than a few.

I don't want to nitpick, because the main thrust of your point (that
"git foo --bogus" should show a more useful message) is not affected by
this subpoint at all.  But if we are considering special-casing "-?", I
would like to see some evidence that it is actually in use.

I can't seem to find it respected anywhere, as shown below (and note
that yes, some of this output does show a useful help message, but that
is because --bogus would show the same message, and I am not disputing
that we should handle that case):

# My linux box
$ uname -sr
Linux 2.6.31-1-686
$ ls -?
ls: invalid option -- '?'
Try `ls --help' for more information.

# Solaris
$ uname -sr
SunOS 5.8
$ /bin/ls -?
/bin/ls: illegal option -- ?
usage: ls -1RaAdCxmnlogrtucpFbqisfL [files]
$ /usr/ucb/ls -? ;# appears to ignore bogus options entirely?
foo
$ /usr/ucb/fold -?
/usr/ucb/fold: illegal option -- ?
Usage: fold [-bs] [-w width | -width ] [file...]
$ /usr/xpg4/bin/ls -?
/usr/xpg4/bin/ls: illegal option -- ?
usage: ls -1RaAdCxmnlogrtucpFbqisfL [files]
$ /usr/xpg6/bin/ls -?
bash: /usr/xpg6/bin/ls: No such file or directory

# AIX
$ uname -svr
AIX 1 6
$ /bin/ls -?
/bin/ls: illegal option -- ?
usage: ls [-1ACFHLNRabcdefgilmnopqrstuxEUX] [File...]

So what systems _do_ treat "-?" specially?

-Peff
