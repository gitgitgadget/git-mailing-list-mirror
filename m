From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase -i: proper prepare-commit-msg hook argument
	when squashing
Date: Fri, 3 Oct 2008 02:01:10 -0400
Message-ID: <20081003060110.GA4473@coredump.intra.peff.net>
References: <1222992501-943-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Oct 03 08:02:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kldk7-0006b3-3X
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 08:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbYJCGBN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Oct 2008 02:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbYJCGBN
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 02:01:13 -0400
Received: from peff.net ([208.65.91.99]:3340 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbYJCGBM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 02:01:12 -0400
Received: (qmail 4165 invoked by uid 111); 3 Oct 2008 06:01:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 03 Oct 2008 02:01:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2008 02:01:10 -0400
Content-Disposition: inline
In-Reply-To: <1222992501-943-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97397>

On Fri, Oct 03, 2008 at 02:08:21AM +0200, SZEDER G=C3=A1bor wrote:

> +			cp -v "$MSG" "$GIT_DIR"/SQUASH_MSG

Sorry, but "cp -v" is not portable. It's not in POSIX, and this breaks
the script for (at least) Solaris.

However, it's not even clear to me why "-v" is used at all, considering
that the "squash" case above does not use it. Is it a debugging
leftover? Am I missing something?

[Aside: My Solaris 8 autobuilder is now running, which was a huge pain.
However, it is very satisfying to catch things like this in "next"
before they hit a wider audience.]

-Peff
