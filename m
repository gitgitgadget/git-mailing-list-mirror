From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Uses git-credential for git-imap-send
Date: Mon, 28 Apr 2014 23:05:34 -0400
Message-ID: <20140429030534.GA12118@sigill.intra.peff.net>
References: <20140428192349.GC25993@sigill.intra.peff.net>
 <c3bb0fb7f87e6ada5c73923b14d66c743a76caa6.1398739667.git.danalbert@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dan Albert <danalbert@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 05:05:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeyMX-00085I-8R
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 05:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbaD2DFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 23:05:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:40916 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754446AbaD2DFg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 23:05:36 -0400
Received: (qmail 7706 invoked by uid 102); 29 Apr 2014 03:05:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Apr 2014 22:05:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Apr 2014 23:05:34 -0400
Content-Disposition: inline
In-Reply-To: <c3bb0fb7f87e6ada5c73923b14d66c743a76caa6.1398739667.git.danalbert@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247513>

On Mon, Apr 28, 2014 at 08:00:04PM -0700, Dan Albert wrote:

> > I noticed that we are just filling in the password here, since we'll
> > always fill cred.username from srvc->user. The lines directly above are:
> > 
> >         if (!srvc->user) {
> >                 fprintf(stderr, "Skipping server %s, no user\n", srvc->host);
> >                 goto bail;
> >         }
> > 
> > That comes from the imap.user config variable. I wonder if we should
> > just pass it off to credential_fill() in this case, too, which will fill
> > in the username if necessary.
> [...]
> 
> Yeah, doubtful anyone cares, but it's simple enough to do.

Thanks, I think the result looks good.

Acked-by: Jeff King <peff@peff.net>

-Peff
