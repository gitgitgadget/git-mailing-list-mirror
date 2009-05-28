From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] Makefile: add NEEDS_RESOLV to optionally add
	-lresolv to compile arguments
Date: Thu, 28 May 2009 15:35:37 -0400
Message-ID: <20090528193537.GA14324@coredump.intra.peff.net>
References: <8D9Pn2N3FZLQcyxrPABrG-rVdsP-X00e6c8oj-YzYQzWI-MvSy5AAzVjbQS0XsK76Ax9XKaLBbU@cipher.nrlssc.navy.mil> <8D9Pn2N3FZLQcyxrPABrG3rdrFXFL1OddmlhE77V4q-K8NSzkS8xbqdJw0C0CnqkCcLEUU_UEIs@cipher.nrlssc.navy.mil> <20090528191051.GE13499@coredump.intra.peff.net> <vVyKoW1VAw2ieNPkJ-SGMNqgFzp_toRpDdk-ZeAp3qzdczSzN4yckg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 28 21:36:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9lOh-0006Al-NZ
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 21:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763690AbZE1Tfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 15:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763100AbZE1Tfn
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 15:35:43 -0400
Received: from peff.net ([208.65.91.99]:57389 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757419AbZE1Tfn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 15:35:43 -0400
Received: (qmail 22584 invoked by uid 107); 28 May 2009 19:35:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 May 2009 15:35:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2009 15:35:37 -0400
Content-Disposition: inline
In-Reply-To: <vVyKoW1VAw2ieNPkJ-SGMNqgFzp_toRpDdk-ZeAp3qzdczSzN4yckg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120215>

On Thu, May 28, 2009 at 02:32:20PM -0500, Brandon Casey wrote:

> >> This library is required on Solaris since hstrerror resides in libresolv.
> >> Additionally, on Solaris 7, inet_ntop and inet_pton reside there too.
> > 
> > Patch works for me on Solaris 8, though it is largely a non-issue:
> > hstrerror is only used at all if NO_IPV6 is set, and I don't set that
> > for my build.
> 
> Ah, in that case I guess NEED_RESOLV should only go in the 5.7 specific
> configuration section.

Well, not exactly. Getting rid of NO_HSTRERROR and then compiling with
NO_IPV6 still requires NEED_RESOLV. It's just that NO_HSTRERROR isn't
even useful unless NO_IPV6 is defined.

-Peff
