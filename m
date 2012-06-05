From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] api-credentials.txt: add "see also" section
Date: Tue, 5 Jun 2012 07:22:09 -0400
Message-ID: <20120605112209.GA1976@sigill.intra.peff.net>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
 <1338739804-32167-4-git-send-email-Matthieu.Moy@imag.fr>
 <7vsjecvxmc.fsf@alter.siamese.dyndns.org>
 <vpq1ulvuxd9.fsf@bauges.imag.fr>
 <20120604115630.GC27676@sigill.intra.peff.net>
 <vpqpq9en8ol.fsf@bauges.imag.fr>
 <20120605065955.GB25809@sigill.intra.peff.net>
 <20120605073403.GC25809@sigill.intra.peff.net>
 <vpqaa0ij98q.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 13:22:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbrq4-00045G-3d
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 13:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933156Ab2FELWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 07:22:12 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43615
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933168Ab2FELWM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 07:22:12 -0400
Received: (qmail 17298 invoked by uid 107); 5 Jun 2012 11:22:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 07:22:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 07:22:09 -0400
Content-Disposition: inline
In-Reply-To: <vpqaa0ij98q.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199230>

On Tue, Jun 05, 2012 at 01:20:21PM +0200, Matthieu Moy wrote:

> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 14286cb..b3693c8 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -280,6 +280,7 @@ technical/api-index.txt: technical/api-index-skel.txt \
> >  	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
> >  	$(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
> >  
> > +technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
> >  $(patsubst %,%.html,$(API_DOCS) technical/api-index): %.html : %.txt
> >  	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
> >  		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) $*.txt
> > @@ -333,6 +334,7 @@ $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
> >  
> >  WEBDOC_DEST = /pub/software/scm/git/docs
> >  
> > +howto/%.html: ASCIIDOC_EXTRA += git-relative-html-prefix=../
> 
> Don't you miss a "-a" between += and git-relative-html-prefix?

Ugh, thank you. I added the line for howto/* while doing a final review
on the patch, but running "make" again did not actually trigger a
rebuild).

-Peff
