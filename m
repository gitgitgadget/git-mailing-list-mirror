From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2 v3] git-fast-import.txt: improve documentation for
 quoted paths
Date: Thu, 29 Nov 2012 14:46:38 -0500
Message-ID: <20121129194637.GA22084@sigill.intra.peff.net>
References: <20121129185404.GC17309@sigill.intra.peff.net>
 <1354216293-21921-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vr4ncp5kw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 20:47:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeA4b-0003ad-7N
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 20:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545Ab2K2Tqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 14:46:40 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41395 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465Ab2K2Tqk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 14:46:40 -0500
Received: (qmail 25898 invoked by uid 107); 29 Nov 2012 19:47:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Nov 2012 14:47:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2012 14:46:38 -0500
Content-Disposition: inline
In-Reply-To: <7vr4ncp5kw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210873>

On Thu, Nov 29, 2012 at 11:33:19AM -0800, Junio C Hamano wrote:

> > diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> > index 959e4d3..d1844ea 100644
> > --- a/Documentation/git-fast-import.txt
> > +++ b/Documentation/git-fast-import.txt
> > @@ -562,8 +562,12 @@ A `<path>` string must use UNIX-style directory separators (forward
> >  slash `/`), may contain any byte other than `LF`, and must not
> >  start with double quote (`"`).
> >  
> > -If an `LF` or double quote must be encoded into `<path>` shell-style
> > -quoting should be used, e.g. `"path/with\n and \" in it"`.
> > +A path can use C-style string quoting; this is accepted in all cases
> > +and mandatory if the filename starts with double quote or contains
> > +`LF`.
> 
> ... or backslash?

No, that was what we discussed elsewhere in the thread. It is OK to say:

  M 100644 :1 file \with \backslashes

as de-quoting is triggered by the first character being double-quote.

-Peff
