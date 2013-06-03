From: Jeff King <peff@peff.net>
Subject: Re: crash on git diff-tree -Ganything <tree> for new files with
 textconv filter
Date: Mon, 3 Jun 2013 18:17:16 -0400
Message-ID: <20130603221716.GC23224@sigill.intra.peff.net>
References: <508C29E4.5000801@arcor.de>
 <20121028120104.GE11434@sigill.intra.peff.net>
 <508D8DF7.7040007@arcor.de>
 <20121029060524.GB4457@sigill.intra.peff.net>
 <508EE4E4.1080407@arcor.de>
 <20121029223521.GJ20513@sigill.intra.peff.net>
 <509ACE63.9070007@arcor.de>
 <20121107211339.GA29184@sigill.intra.peff.net>
 <51ACD172.4070608@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Tue Jun 04 00:17:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujd4I-00039K-C8
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 00:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759119Ab3FCWR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 18:17:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:35082 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758968Ab3FCWRU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 18:17:20 -0400
Received: (qmail 7910 invoked by uid 102); 3 Jun 2013 22:18:03 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Jun 2013 17:18:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Jun 2013 18:17:16 -0400
Content-Disposition: inline
In-Reply-To: <51ACD172.4070608@arcor.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226299>

On Mon, Jun 03, 2013 at 07:25:06PM +0200, Peter Oberndorfer wrote:

> > Thanks for the report. I'd still like to pursue using a regex library
> > that does not require NUL-termination, but I've been distracted by other
> > things. I'm going to hold back my copy-to-a-NUL-buffer patch for now and
> > see if I can get to the regex thing this week.
> >
> are there any news regarding this problem?
> The crash seems to still exist in the current version 1.8.3 and master.

Sorry, no, this got dropped due to lack of time. I _think_ it is as
simple as just tweaking the Makefile to unconditionally build against
the compat/ regex library, and then tweaking callsites as appropriate to
use the GNU-specific interface that takes buf/len instead of a
NUL-terminated string.

But there may be some hidden complexities to it.

-Peff
