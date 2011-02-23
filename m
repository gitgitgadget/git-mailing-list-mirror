From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git-svn fails to rename files with %20 in filename
Date: Wed, 23 Feb 2011 05:04:32 -0500
Message-ID: <20110223100431.GD9222@sigill.intra.peff.net>
References: <1298283144.2772.7.camel@wpalmer.simply-domain>
 <20110221123115.GB23033@sigill.intra.peff.net>
 <1298393415.2286.18.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Wong <normalperson@yhbt.net>, git <git@vger.kernel.org>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 11:04:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsBaI-0003lE-Mc
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 11:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab1BWKEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 05:04:34 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52145 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355Ab1BWKEd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 05:04:33 -0500
Received: (qmail 10845 invoked by uid 111); 23 Feb 2011 10:04:32 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 23 Feb 2011 10:04:32 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Feb 2011 05:04:32 -0500
Content-Disposition: inline
In-Reply-To: <1298393415.2286.18.camel@wpalmer.simply-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167685>

On Tue, Feb 22, 2011 at 04:50:15PM +0000, Will Palmer wrote:

> > IOW, it looks like the path we hand to svn needs url-encoding even for
> > the local case (which make sense, as it is a file:// url). But I know
> > nothing about svn, so probably I am breaking some other weird non-url
> > local case. :)
> > 
> 
> Unless I've got my line-numbers mixed up, the commit which introduced
> the https-specific encoding behaviour,
> 29633bb91c git-svn: fix commiting renames over DAV with funky file names
> 
> seems to be of the opinion that the bug did not effect file:// and
> svn:// URLs. Has something changed?

Yeah, what we are seeing definitely contradicts that commit. It's been
3.5 years; maybe something was tweaked in the subversion library? I
tried reading the code, but I got lost amidst all of the nasty perl
bindings. I couldn't find anything relevant in svn's changelog or in
google, either.

-Peff
