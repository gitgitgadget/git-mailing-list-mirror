From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] init-db: support --import to add all files and commit
	right after init
Date: Wed, 25 Mar 2009 00:49:09 -0400
Message-ID: <20090325044909.GA21311@coredump.intra.peff.net>
References: <1237946996-5287-1-git-send-email-pclouds@gmail.com> <20090325041934.GA15524@coredump.intra.peff.net> <fcaeb9bf0903242132k71e78219xfda5553854df4a2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 05:55:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmL97-0003mZ-Md
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 05:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbZCYEtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 00:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbZCYEtU
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 00:49:20 -0400
Received: from peff.net ([208.65.91.99]:37917 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbZCYEtT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 00:49:19 -0400
Received: (qmail 4418 invoked by uid 107); 25 Mar 2009 04:49:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Mar 2009 00:49:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2009 00:49:09 -0400
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0903242132k71e78219xfda5553854df4a2c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114563>

On Wed, Mar 25, 2009 at 03:32:17PM +1100, Nguyen Thai Ngoc Duy wrote:

> I tend to do "commit -q -m i", not a big deal for two more keystrokes.
> My initial version allowed "git init /path/to/workdir" too so it might
> be ambiguous for optional message. So all vote for "Initial commit"?
> Dynamic message seems overkill because most of the cases, this is a
> throw away repository.

Initial commit is fine with me. I plan to use this mostly for throw-away
repositories. I was thinking it might be useful for this:

  tar xzf package-0.1.tar.gz
  cd package-0.1
  git init --import

so that later you remember it came from package-0.1 (when you are
looking at package 0.2). OTOH, if we take the information from the
directory, then the fact that it came from 0.1 is by definition already
in the directory name.  So it is pretty pointless unless you later
rename the directory to just "package".

> > I seem to recall that we were phasing out "--long-option <arg>" at some
> > point, and that all long-options should use "--long-option=". But maybe
> > I am mis-remembering.
> 
> I did not know too. Any reference?

I was, in fact, mis-remembering. The problem is not about long versus
short options, but rather about options which have an optional value.
See "Separating argument from the option" in "git help cli".

However, what we are discussing above _is_ making it an optional value,
in which case "--import <arg>" would have no value for "--import".

-Peff
