From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tag -d: print sha1 of deleted tag
Date: Thu, 10 Dec 2009 08:36:46 -0500
Message-ID: <20091210133645.GA2149@coredump.intra.peff.net>
References: <87ljhb87nj.fsf@jondo.cante.net>
 <3b0a7bfa75126e4c13ec15a4357645b2bfd14b5b.1260447713.git.git@drmicha.warpmail.net>
 <20091210124929.GA444@coredump.intra.peff.net>
 <4B20F733.6010401@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jari Aalto <jari.aalto@cante.net>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Dec 10 14:36:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIjCS-0005TZ-KY
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 14:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758681AbZLJNgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 08:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758652AbZLJNgp
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 08:36:45 -0500
Received: from peff.net ([208.65.91.99]:57415 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692AbZLJNgo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 08:36:44 -0500
Received: (qmail 23307 invoked by uid 107); 10 Dec 2009 13:41:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 10 Dec 2009 08:41:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Dec 2009 08:36:46 -0500
Content-Disposition: inline
In-Reply-To: <4B20F733.6010401@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135027>

On Thu, Dec 10, 2009 at 02:27:15PM +0100, Michael J Gruber wrote:

> >   1. It is not immediately obvious to a user seeing this message
> >      for this first time exactly what the trailing sha1 means. We
> >      already had this discussion with "git branch -d" and decided
> >      that "(was DEADBEEF)" was more readable.
> 
> So, should we simply go with that then?

I think so. Jari obviously disagrees, but I don't have much more to say
in favor of it except that I find the other ugly and unintuitive. So it
is up to you what you want to submit and Junio what he wants to apply.
:)

> Meanwhile, RFCs/PATCHes crossed paths. I take it that Zoltan suggests
> giving the same output for force-overwritten existing tags. I beat him
> by 11 minutes, though ;)

Yes, I think if you are going to protect "tag -d", you might as well
protect overwriting, as well.  Which made me think at first that we need
something similar for "branch -f", but I don't think we do; the last
branch value will be left in the reflog (but with tags, there is no
reflog).

-Peff
