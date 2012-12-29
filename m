From: Jeff King <peff@peff.net>
Subject: Re: [RFC] pack-objects: compression level for non-blobs
Date: Sat, 29 Dec 2012 00:27:47 -0500
Message-ID: <20121229052747.GA14928@sigill.intra.peff.net>
References: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
 <20121229004104.GA24828@sigill.intra.peff.net>
 <CACsJy8D_E0shqJAvZH7xqij6F4a6qUxkUPNcZL=0yX5w9bLd_g@mail.gmail.com>
 <20121229050707.GA14475@sigill.intra.peff.net>
 <CACsJy8AN3y_4wcZ_w0zz+ZAaDasRT-+h8vA_fp2j4+FL00dbLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Michael Barr <b@rr-dav.id.au>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 06:28:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tooxt-0001Wi-R4
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 06:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449Ab2L2F1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 00:27:52 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38490 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047Ab2L2F1v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 00:27:51 -0500
Received: (qmail 27127 invoked by uid 107); 29 Dec 2012 05:29:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 29 Dec 2012 00:29:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Dec 2012 00:27:47 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8AN3y_4wcZ_w0zz+ZAaDasRT-+h8vA_fp2j4+FL00dbLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212291>

On Sat, Dec 29, 2012 at 12:25:04PM +0700, Nguyen Thai Ngoc Duy wrote:

> > But just dropping the compression (or doing partial
> > decompression when we only care about the beginning part) is way less
> > code and complexity.
> 
> I think I tried the partial decompression for commit header and it did
> not help much (or I misremember it, not so sure).

I'll see if I can dig up the reference, as it was something I was going
to look at next.

> > There's no cache to manage.
> 
> If reachability bitmap is implemented, we'll have per-pack cache
> infrastructure ready, so less work there for commit cache.

True. I don't want to dissuade you from doing any commit cache work. I
only wanted to point out that this alternative may have merit because of
its simplicity (so we can use it until a caching solution exists, or
even after, if managing the cache has downsides).

-Peff
