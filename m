From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: allow detached checkout when --branch takes a tag
Date: Fri, 6 Jan 2012 09:42:27 -0500
Message-ID: <20120106144226.GA4525@sigill.intra.peff.net>
References: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
 <20120105141844.GA26771@sigill.intra.peff.net>
 <CACsJy8BSzQiTScOhvQjLz8mQZC0g3fEOayBxn7n65t1tKwWnsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 15:42:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjB05-00019Y-OM
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 15:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758749Ab2AFOmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 09:42:32 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58711
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758741Ab2AFOmb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 09:42:31 -0500
Received: (qmail 5755 invoked by uid 107); 6 Jan 2012 14:49:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Jan 2012 09:49:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2012 09:42:27 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8BSzQiTScOhvQjLz8mQZC0g3fEOayBxn7n65t1tKwWnsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188030>

On Fri, Jan 06, 2012 at 06:09:16PM +0700, Nguyen Thai Ngoc Duy wrote:

> > I wonder, though, if the original code makes any sense. By using
> > "refs/", I would have to say "--branch=heads/foo", which is kind of
> > weird and undocumented. I think it should probably always be
> > "refs/heads/", no matter if we are mirroring or not.
> 
> --branch should not be used with --mirror in my opinion. --branch
> changes HEAD so it's no longer an exact mirror.

You could be making a repo that mirrors all of the refs, but has a
different HEAD (e.g., the upstream has "development" as the main branch,
but you want a local mirror with "production" as the HEAD).

I agree it's an unlikely combination (which is probably why nobody has
complained about the weird behavior), but I don't see a particular
reason to forbid it.

-Peff
