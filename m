From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Revert diffstat back to English
Date: Thu, 13 Sep 2012 17:31:21 -0400
Message-ID: <20120913213121.GA31426@sigill.intra.peff.net>
References: <20120913132847.GD4287@sigill.intra.peff.net>
 <1347545786-936-1-git-send-email-pclouds@gmail.com>
 <7vzk4t960y.fsf@alter.siamese.dyndns.org>
 <7va9wt9377.fsf@alter.siamese.dyndns.org>
 <20120913210111.GA16956@sigill.intra.peff.net>
 <7v627h7hny.fsf@alter.siamese.dyndns.org>
 <20120913212043.GB16968@sigill.intra.peff.net>
 <7vr4q562cg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 23:31:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCH0f-00007M-JX
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 23:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772Ab2IMVbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 17:31:25 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43808 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753686Ab2IMVbY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 17:31:24 -0400
Received: (qmail 8585 invoked by uid 107); 13 Sep 2012 21:31:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Sep 2012 17:31:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Sep 2012 17:31:21 -0400
Content-Disposition: inline
In-Reply-To: <7vr4q562cg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205433>

On Thu, Sep 13, 2012 at 02:26:55PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I do not think they are incompatible if you separate it into three
> > categories: machine readable (must never be translated), for the current
> > user right now (current i18n), and for sharing with other humans
> > (i18n.projectlang).
> 
> Anything you see as a user is potentially useful to other project
> participants, so I do not think there is a bright line that
> delineates the latter two classes.  The output of format-patch is
> obviously meant as the latter, but how about the output from show or
> log?  Is it worth trying to define the bright line somewhere, only
> to annoy users who may want to draw the line differently?

I agree that the line is not bright. I do not know if it is worthwhile
or not. I think it will solve some practical problems, but it may also
introduce others.  But basically having a per-repo LANG setting (which
is what the projectlang you are talking about would do) also does not
seem like a solution that people will use, because they will not get any
localization benefit at all.

So again, I'd rather err on the side of pushing those things that are
near the line into the "do not translate" side, letting people use LANG
to localize the rest, and accepting that occasionally people are going
to accidentally show you output in a language you don't understand. But
hopefully that keeps it to "occasionally" and not "every time you send
out a patch".

-Peff
