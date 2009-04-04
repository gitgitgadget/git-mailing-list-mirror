From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] tests: skip perl tests if NO_PERL is defined
Date: Sat, 4 Apr 2009 19:42:41 -0400
Message-ID: <20090404234241.GC26906@coredump.intra.peff.net>
References: <20090403192700.GA14965@coredump.intra.peff.net> <20090403193359.GD5547@coredump.intra.peff.net> <20090404T225904Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 01:44:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqFXJ-0002op-Tv
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 01:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737AbZDDXm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 19:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755684AbZDDXm6
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 19:42:58 -0400
Received: from peff.net ([208.65.91.99]:38522 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755679AbZDDXm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 19:42:58 -0400
Received: (qmail 13045 invoked by uid 107); 4 Apr 2009 23:43:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 04 Apr 2009 19:43:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Apr 2009 19:42:41 -0400
Content-Disposition: inline
In-Reply-To: <20090404T225904Z@curie.orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115605>

On Sat, Apr 04, 2009 at 04:30:10PM -0700, Robin H. Johnson wrote:

> Testing on a box without Perl, I get the following failures.
> You can reproduce by doing mv /usr/bin/perl{,.tmp}, 
> gmake NO_PERL=1 clean all test
> 
> This is the only one that doesn't appear to use perl.
> *** t6030-bisect-porcelain.sh ***

Probably this:

  $ grep -B1 -A7 PERL git-bisect.sh
  sq() {
          @@PERL@@ -e '
                  for (@ARGV) {
                          s/'\''/'\'\\\\\'\''/g;
                          print " '\''$_'\''";
                  }
                  print "\n";
          ' "$@"
  }

-Peff
