From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Document git-svn fetch --log-window-size parameter
Date: Fri, 26 Oct 2012 09:32:50 -0400
Message-ID: <20121026133250.GI1455@sigill.intra.peff.net>
References: <1350988406-97624-1-git-send-email-gunnlaugur@gmail.com>
 <20121025095202.GK8390@sigill.intra.peff.net>
 <20121026094602.GA7887@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Gunnlaugur =?utf-8?B?w57Ds3I=?= Briem <gunnlaugur@gmail.com>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Oct 26 15:33:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRk26-0006bb-9x
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 15:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932838Ab2JZNcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 09:32:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37865 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932123Ab2JZNcx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 09:32:53 -0400
Received: (qmail 22579 invoked by uid 107); 26 Oct 2012 13:33:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Oct 2012 09:33:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Oct 2012 09:32:50 -0400
Content-Disposition: inline
In-Reply-To: <20121026094602.GA7887@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208441>

On Fri, Oct 26, 2012 at 09:46:02AM +0000, Eric Wong wrote:

> > Thanks. Your description makes sense to me, but I do not have enough
> > git-svn knowledge to know if it covers all intended uses of the flag.
> > Eric?
> > 
> > > +--log-window-size=<n>;;
> > > +    Fetch <n> log entries per request when scanning Subversion history.
> > > +    The default is 100. For very large Subversion repositories, larger
> > > +    values may be needed for 'clone'/'fetch' to complete in reasonable
> > > +    time. But overly large values may lead to request timeouts.
> 
> Overly large values also lead to excessive memory usage.  I may have
> only had 256M in my dev machine at the time I added this parameter:

That's probably worth mentioning. Gunnlaugur, any objection to me
amending your commit with:

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 64756c9..8b0d3ad 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -150,7 +150,8 @@ Skip "branches" and "tags" of first level directories;;
     Fetch <n> log entries per request when scanning Subversion history.
     The default is 100. For very large Subversion repositories, larger
     values may be needed for 'clone'/'fetch' to complete in reasonable
-    time. But overly large values may lead to request timeouts.
+    time. But overly large values may lead to higher memory usage and
+    request timeouts.
 
 'clone'::
 	Runs 'init' and 'fetch'.  It will automatically create a

?

-Peff
