From: Jeff King <peff@peff.net>
Subject: Re: Show all branches and ahead/behind states
Date: Thu, 14 May 2015 18:38:27 -0400
Message-ID: <20150514223827.GB21149@peff.net>
References: <CAHd499AyEDNM7mDstFugD0Ah46=gAS=BRocDmpmOK-1k+qMCmw@mail.gmail.com>
 <1431618938.31573.3.camel@kaarsemaker.net>
 <CAHd499CQTW0J6ms+XYUBbyfT6gGKuiFFCiP57i8-eTwng+UzNQ@mail.gmail.com>
 <1431624587.31573.5.camel@kaarsemaker.net>
 <CAHd499BoApGJSM_qEKG8cHNOV_pOCyPRqEAXHo8iqYVg1LpGdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 00:38:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt1mG-0004Vu-N2
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 00:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965385AbbENWic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 18:38:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:58955 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965116AbbENWia (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 18:38:30 -0400
Received: (qmail 31300 invoked by uid 102); 14 May 2015 22:38:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 17:38:30 -0500
Received: (qmail 29286 invoked by uid 107); 14 May 2015 22:38:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 18:38:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2015 18:38:27 -0400
Content-Disposition: inline
In-Reply-To: <CAHd499BoApGJSM_qEKG8cHNOV_pOCyPRqEAXHo8iqYVg1LpGdw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269119>

On Thu, May 14, 2015 at 01:13:15PM -0500, Robert Dailey wrote:

> > git for-each-ref --format '%(HEAD) %(refname:short) %(upstream:short) %(upstream:track) %(subject)' refs/heads
> 
> Great idea. For some reason I can't apply coloring though:
> 
> for-each-ref --format '%(HEAD) %(refname:short) %C(bold
> blue)%(upstream:track)%C(reset)' refs/heads
> 
> Output:
> 
> hotfix/4.2.3.1 %C(bold blue)[ahead 1, behind 1]%C(reset)

It's spelled "%C(bold blue)" in the --pretty formats, but in
for-each-ref, it's "%(color:bold blue)". Unifying these is one of those
things that has been on the radar for a long time, but nobody has quite
gotten around to it.

-Peff
