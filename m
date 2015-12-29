From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] create_symref: modernize variable names
Date: Tue, 29 Dec 2015 00:02:56 -0500
Message-ID: <20151229050255.GB13253@sigill.intra.peff.net>
References: <20151220072637.GA22102@sigill.intra.peff.net>
 <20151220072949.GC30662@sigill.intra.peff.net>
 <5680F0DA.1020301@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 29 06:03:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDmR7-0004bI-Ka
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 06:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbbL2FDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 00:03:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:46480 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750916AbbL2FC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 00:02:58 -0500
Received: (qmail 11603 invoked by uid 102); 29 Dec 2015 05:02:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 28 Dec 2015 23:02:58 -0600
Received: (qmail 17974 invoked by uid 107); 29 Dec 2015 05:03:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 00:03:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 00:02:56 -0500
Content-Disposition: inline
In-Reply-To: <5680F0DA.1020301@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283065>

On Mon, Dec 28, 2015 at 09:20:42AM +0100, Michael Haggerty wrote:

> On 12/20/2015 08:29 AM, Jeff King wrote:
> > Once upon a time, create_symref() was used only to point
> > HEAD at a branch name, and the variable names reflect that
> > (e.g., calling the path git_HEAD). However, it is much more
> > generic these days (and has been for some time). Let's
> > update the variable names to make it easier to follow:
> > 
> >   - `ref_target` is now just `ref`, matching the declaration
> >     in `cache.h` (and hopefully making it clear that it is
> >     the symref itself, and not the target).
> 
> I've been trying to name variables that hold reference names "refname"
> to distinguish them clearly from other representations of references,
> like "struct ref_entry *".

That makes sense. I've tweaked this patch to use "refname", and carried
through the change to the following patch.

-Peff
