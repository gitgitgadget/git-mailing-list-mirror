From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/7] Make alternates affect fetch behavior
Date: Tue, 14 Feb 2012 17:51:13 -0500
Message-ID: <20120214225113.GA25558@sigill.intra.peff.net>
References: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Feb 14 23:51:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxRDW-00009n-Mz
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757335Ab2BNWvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 17:51:18 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36040
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755181Ab2BNWvR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:51:17 -0500
Received: (qmail 13848 invoked by uid 107); 14 Feb 2012 22:58:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 17:58:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 17:51:13 -0500
Content-Disposition: inline
In-Reply-To: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190790>

On Sat, Feb 11, 2012 at 07:20:54AM +0100, mhagger@alum.mit.edu wrote:

> It used to be that alternate references were not considered "complete"
> when fetching via fetch-pack.  This failure was not so obvious because
> the big benefit of alternates is seen when cloning, and clone used a
> different data path: it put the alternate references into extra refs
> (which makes them look like references within the local repository).
> 
> This patch series teaches fetch-pack to treat objects that are
> available via alternates as "complete".
> 
> Once that is fixed, clone doesn't need to use the special extra_refs
> kludge, so change that.
> 
> And once that is changed, the extra_refs API is no longer needed at
> all, so remove it.
> 
> Michael Haggerty (7):
>   t5700: document a failure of alternates to affect fetch
>   clone.c: move more code into the "if (refs)" conditional
>   fetch-pack.c: rename some parameters from "path" to "refname"
>   fetch-pack.c: inline insert_alternate_refs()
>   everything_local(): mark alternate refs as complete
>   clone: do not add alternate references to extra_refs
>   refs: remove the extra_refs API

>From my reading, all of these patches look good. Thanks for a
well-organized series.

-Peff
