From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] var: provide explicit/implicit ident information
Date: Wed, 14 Nov 2012 11:53:57 -0800
Message-ID: <20121114195357.GD3860@sigill.intra.peff.net>
References: <20121113164845.GD20361@sigill.intra.peff.net>
 <20121113165308.GD12626@sigill.intra.peff.net>
 <20121114170657.GC6858@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 20:54:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYj2N-0007P5-Rx
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 20:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab2KNTyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 14:54:01 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48600 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753363Ab2KNTyA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 14:54:00 -0500
Received: (qmail 6167 invoked by uid 107); 14 Nov 2012 19:54:49 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Nov 2012 14:54:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2012 11:53:57 -0800
Content-Disposition: inline
In-Reply-To: <20121114170657.GC6858@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209745>

On Wed, Nov 14, 2012 at 09:06:57AM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Internally, we keep track of whether the author or committer
> > ident information was provided by the user, or whether it
> > was implicitly determined by the system. However, there is
> > currently no way for external programs or scripts to get
> > this information
> 
> What are the intended semantics?  If my machine has /etc/mailname
> filled out, is that an implicit identity?  How about if I set the
> EMAIL envvar but not GIT_COMMITTER_EMAIL?
> 
> If external scripts are going to start using this mechanism, they will
> need answers to these questions to support users that run into
> configuration problems.  A few words on this in the documentation
> could probably help.

The intent is to make git's internal rules (whatever they may be)
available to calling scripts. But I agree those rules should be spelled
out now that they are becoming a more visible interface. I'll update the
documentation.

> On most machines I have the EMAIL envvar set explicitly, but in the
> recent past I relied on /etc/mailname on some others, so I'm also
> genuinely curious about the use case here (and too lazy to dig it up).

Right now EMAIL is explicit, but `id`@`cat /etc/mailname` is not. I
think changing that would be a separate issue, though (and I'm not sure
whether it is a good idea; my /etc/mailname is not an email address I
would want to use).

-Peff
