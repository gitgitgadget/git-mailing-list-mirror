From: Jeff King <peff@peff.net>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Thu, 5 Mar 2015 00:22:06 -0500
Message-ID: <20150305052206.GC3344@peff.net>
References: <20150225185128.GA16569@peff.net>
 <xmqqbnkholx9.fsf@gitster.dls.corp.google.com>
 <20150225191108.GA17467@peff.net>
 <20150227100441.GA11861@tsaunders-iceball.corp.tor1.mozilla.com>
 <xmqqvbilh0wn.fsf@gitster.dls.corp.google.com>
 <20150301130142.GA24782@tsaunders-iceball.corp.tor1.mozilla.com>
 <xmqqr3t8fgm4.fsf@gitster.dls.corp.google.com>
 <20150302125017.GA4464@tsaunders-iceball.corp.tor1.mozilla.com>
 <54F6EB96.6080500@peralex.com>
 <xmqq385k8ot1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Noel Grandin <noel@peralex.com>,
	Trevor Saunders <tbsaunde@tbsaunde.org>,
	Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 06:22:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTOEh-0007J2-1B
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 06:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbbCEFWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 00:22:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:56663 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751763AbbCEFWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 00:22:09 -0500
Received: (qmail 25013 invoked by uid 102); 5 Mar 2015 05:22:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 23:22:09 -0600
Received: (qmail 8296 invoked by uid 107); 5 Mar 2015 05:22:14 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Mar 2015 00:22:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Mar 2015 00:22:06 -0500
Content-Disposition: inline
In-Reply-To: <xmqq385k8ot1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264814>

On Wed, Mar 04, 2015 at 12:56:10PM -0800, Junio C Hamano wrote:

> > As in, while working on a specific project, I sometimes just want to
> > exclude, for the time being, a bunch of stuff from 'git grep'.
> 
> The key word here is "for the time being", though.  What would you
> do once you are done with the "for the time being" activity?  "git
> config --unset"?

IMHO this is being too paternalistic. You can already shoot yourself
in the foot by configuring an alias to grep, running your alias, and
wondering why it does not produce the results you wanted.

But I'd also oppose a `grep.pathspecs` config option for a similar
reason: you can already accomplish the same thing (and more) with an
alias.

-Peff

PS One annoying thing about aliases is that you cannot re-alias an
   existing command, and git has already taken all of the good, easy
   names that we have trained our fingers for. :)

   Of course re-aliasing git-grep is another recipe for head-scratching
   (and broken scripts), but I am not sure there aren't a host of other
   ways to do a similar thing (basically any configuration option has
   the capacity to produce unexpected results if you forget that it is
   set).

   I dunno. Probably I am a bad person for dredging up that ancient
   argument again.
