From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] transport-helper: report errors properly
Date: Wed, 10 Apr 2013 23:39:32 -0400
Message-ID: <20130411033932.GC14551@sigill.intra.peff.net>
References: <1365432004-20132-1-git-send-email-felipe.contreras@gmail.com>
 <20130410161320.679b68ca07cd1fe32bb25c70@lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 05:39:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ8MT-0001g1-A2
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 05:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936532Ab3DKDjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 23:39:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39642 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934717Ab3DKDjj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 23:39:39 -0400
Received: (qmail 11266 invoked by uid 107); 11 Apr 2013 03:41:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 23:41:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 23:39:32 -0400
Content-Disposition: inline
In-Reply-To: <20130410161320.679b68ca07cd1fe32bb25c70@lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220812>

On Wed, Apr 10, 2013 at 04:13:20PM -0700, rh wrote:

> > +++ b/transport-helper.c
> > @@ -54,7 +54,7 @@ static int recvline_fh(FILE *helper, struct strbuf
> > *buffer) if (strbuf_getline(buffer, helper, '\n') == EOF) {
> >  		if (debug)
> >  			fprintf(stderr, "Debug: Remote helper quit.
> > \n");
> > -		exit(128);
> > +		die("Reading from remote helper failed");
> 
> Do I read this correctly?  If I'm in debug mode the remote helper quit
> but if not in debug mode it failed?  Debuggers never fail they only quit!

In debug mode, it prints both messages. The debug version is superfluous
at this point, though, and we can probably just drop it.

-Peff
