From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: use free()+xcalloc() instead of
 xrealloc()+memset()
Date: Mon, 2 Jun 2014 17:59:11 -0400
Message-ID: <20140602215911.GA4612@sigill.intra.peff.net>
References: <538B0969.9080409@web.de>
 <20140602194246.GD2510@sigill.intra.peff.net>
 <878upf9h9v.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Vicent Marti <tanoku@gmail.com>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 23:59:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WraGP-0006Y3-Rl
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 23:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbaFBV7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 17:59:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:36185 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752055AbaFBV7N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 17:59:13 -0400
Received: (qmail 12277 invoked by uid 102); 2 Jun 2014 21:59:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Jun 2014 16:59:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jun 2014 17:59:11 -0400
Content-Disposition: inline
In-Reply-To: <878upf9h9v.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250603>

On Mon, Jun 02, 2014 at 10:40:44PM +0200, David Kastrup wrote:

> > BTW, the code does git-blame to Vicent's 2834bc2 (which I also worked
> > on), but actually originated in 7a979d9 (Thin pack - create packfile
> > with missing delta base., 2006-02-19). Not that it matters, but I was
> > just surprised since the code you are changing did not seem familiar to
> > me. I guess there was just too much refactoring during the code movement
> > for git-blame to pass along the blame in this case.
> 
> Without -M, "too much refactoring" for git-blame may just be moving a
> function to a different place in the same file.

I tried "git blame -M -C -C -C pack-objects.c" but couldn't get anything
but the whole thing blamed to 2834bc2.

-Peff
