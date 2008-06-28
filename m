From: Jeff King <peff@peff.net>
Subject: Re: Make test on AIX
Date: Sat, 28 Jun 2008 01:15:00 -0400
Message-ID: <20080628051500.GF9451@sigill.intra.peff.net>
References: <63BEA5E623E09F4D92233FB12A9F794302389D09@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Craig L. Ching" <cching@mqsoftware.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 07:16:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCSn5-00011L-Lc
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 07:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbYF1FPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 01:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754607AbYF1FPF
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 01:15:05 -0400
Received: from peff.net ([208.65.91.99]:1848 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754596AbYF1FPD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 01:15:03 -0400
Received: (qmail 8770 invoked by uid 111); 28 Jun 2008 05:15:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 28 Jun 2008 01:15:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jun 2008 01:15:00 -0400
Content-Disposition: inline
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794302389D09@emailmn.mqsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86706>

On Fri, Jun 27, 2008 at 04:13:41PM -0500, Craig L. Ching wrote:

> The first thing I encountered was that because the tests all use
> #!/bin/sh the exit code was not what the tests expected.  So I ended up
> running 'make SHELL=`which bash` all' directly in the git/t/ directory.
> That seemed to shake out and work for most of the tests except for
> t/t7502-commit.sh.  Try as I might, I could not get SHELL_PATH set to
> anything but /bin/sh except to hard-code the SHELL_PATH in this script.

The SHELL_PATH actually comes from the build options for all of git. So
you should be able to go to the toplevel of your git repo and do a "make
SHELL_PATH=`which bash`". This means that we will also use bash for all
of the script components of git.

I don't know how necessary that is on AIX, but it certainly is on
Solaris, where /bin/sh is unusable.

-Peff
