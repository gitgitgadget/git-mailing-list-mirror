From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 01/33] setup: call setup_git_directory_gently before
 accessing refs
Date: Tue, 1 Mar 2016 04:55:43 -0500
Message-ID: <20160301095542.GA4718@sigill.intra.peff.net>
References: <CACsJy8AiT0=juU0pqBfraCZyk-g9MgEuybOw-0JQyqm9VveUWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 10:55:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aah21-0001Yk-Ie
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 10:55:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbcCAJzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 04:55:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:52283 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750933AbcCAJzq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 04:55:46 -0500
Received: (qmail 14424 invoked by uid 102); 1 Mar 2016 09:55:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 04:55:46 -0500
Received: (qmail 6415 invoked by uid 107); 1 Mar 2016 09:55:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 04:55:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2016 04:55:43 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8AiT0=juU0pqBfraCZyk-g9MgEuybOw-0JQyqm9VveUWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288004>

On Tue, Mar 01, 2016 at 04:53:30PM +0700, Duy Nguyen wrote:

> > The basic strategy was to adapt the
> > existing "struct startup_info" to be available everywhere, and have
> > relevant bits of code assert() on it, or even behave differently (e.g.,
> > if some library code should do different things in a repo versus not).
> 
> startup_info is NULL for external programs if I remember correctly, or
> do you make it available to all of them too?

Yes, that was what I meant by "available everywhere". Library code
cannot rely on it right now, as only builtins set it up (even though
external programs may call setup_git_directory()).

-Peff
