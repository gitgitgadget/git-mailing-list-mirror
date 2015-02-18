From: Jeff King <peff@peff.net>
Subject: Re: Interested in helping open source friends on HP-UX?
Date: Wed, 18 Feb 2015 13:57:34 -0500
Message-ID: <20150218185734.GB7257@peff.net>
References: <xmqq4mt2fx2m.fsf@gitster.dls.corp.google.com>
 <20150218170007.784be6aa@pc09.procura.nl>
 <54E4CFDC.40401@drmicha.warpmail.net>
 <20150218182547.GA6346@peff.net>
 <xmqqpp972h1n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 19:57:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO9oc-00016c-Ju
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 19:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbbBRS5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 13:57:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:50607 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752341AbbBRS5h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 13:57:37 -0500
Received: (qmail 3807 invoked by uid 102); 18 Feb 2015 18:57:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 12:57:36 -0600
Received: (qmail 19749 invoked by uid 107); 18 Feb 2015 18:57:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 13:57:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2015 13:57:34 -0500
Content-Disposition: inline
In-Reply-To: <xmqqpp972h1n.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264042>

On Wed, Feb 18, 2015 at 10:47:16AM -0800, Junio C Hamano wrote:

> > It seems like we could use
> >
> >   (cd src && tar cf - .) | (cd dst && tar xf -)
> >
> > here as a more portable alternative. I don't think we can rely on rsync
> > being everywhere.
> 
> Thanks; I wasn't even aware that we used rsync in our tests.  We
> certainly do not want to rely on it.

I don't think we do.

Grepping for rsync in t/, it is mentioned in three places:

  1. In t1509, we use it, but that test script does not run unless you
     set a bunch of environment variables to enable it.

  2. In a sample patch for t4100. Obviously this one doesn't execute. :)

  3. In t5500, to test "rsync:" protocol supported. This is behind a
     check that we can run rsync at all (though it does not properly use
     prereqs or use the normal "skip" procedure).

> Why not "cp -r src dst", though?

I was assuming that the "-P" in the original had some purpose. My "cp
-r" does not seem to dereference symlinks, but maybe there is something
I am missing.

-Peff
