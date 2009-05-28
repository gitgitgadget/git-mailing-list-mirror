From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] diff: generate prettier filenames when using
	GIT_EXTERNAL_DIFF
Date: Thu, 28 May 2009 18:06:06 -0400
Message-ID: <20090528220606.GA24148@coredump.intra.peff.net>
References: <1243491077-27738-1-git-send-email-davvid@gmail.com> <1243491077-27738-2-git-send-email-davvid@gmail.com> <20090528174436.GA12723@coredump.intra.peff.net> <20090528213049.GA55167@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, markus.heidelberg@web.de,
	jnareb@gmail.com, j.sixt@viscovery.net
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 00:06:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9nkH-0003Av-Ik
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 00:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbZE1WGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 18:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbZE1WGO
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 18:06:14 -0400
Received: from peff.net ([208.65.91.99]:44415 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbZE1WGO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 18:06:14 -0400
Received: (qmail 23621 invoked by uid 107); 28 May 2009 22:06:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 May 2009 18:06:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2009 18:06:06 -0400
Content-Disposition: inline
In-Reply-To: <20090528213049.GA55167@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120240>

On Thu, May 28, 2009 at 02:30:49PM -0700, David Aguilar wrote:

> > FWIW, I find this name not very descriptive. From the name, I would
> > expect it to do the exact same thing as mkstemps, but be our own
> > personal implementation. But it is actually a wrapper that behaves
> > somewhat differently. So I wonder if "mkstemps_tmpdir" or something
> > would be a better name.
> 
> It does exactly what git_mkstemp() does, plus the extra
> suffix_len parameter.  If we rename this function we have to
> rename both.

Ah. Well, I think that is a crappy name, too, then, but it is not your
fault. ;) So if there is precedent, I guess somebody else thought it was
a good idea, and you should leave your patch as-is.

> I was not aware of the other code paths and only wanted to
> affect the one that I knew about.  I agree that making that the
> default behavior would be great, meaning we could drop the
> pretty_filename flag altogether.
> 
> If you and others agree that the user-friendly names are a good
> thing to have by default then I can rework patch 2/2.

Switching to user-friendly temp filenames for textconv was on my todo
list, so I definitely think it is a good idea.

-Peff
