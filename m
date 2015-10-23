From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2 jk/war-on-sprintf] compat/mingw.c: remove printf
 format warning
Date: Fri, 23 Oct 2015 07:20:19 -0400
Message-ID: <20151023112019.GB14996@sigill.intra.peff.net>
References: <2c89c60e470def8f85941933c9fafe4db314628a.1445579874.git.j6t@kdbg.org>
 <28a610a30ab9d4f742be2f3225db341ea40c8a51.1445579874.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, git-for-windows@googlegroups.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Oct 23 13:20:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpaOY-00042S-Oh
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 13:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbbJWLUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 07:20:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:46940 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752077AbbJWLUW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 07:20:22 -0400
Received: (qmail 27740 invoked by uid 102); 23 Oct 2015 11:20:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Oct 2015 06:20:22 -0500
Received: (qmail 26609 invoked by uid 107); 23 Oct 2015 11:20:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Oct 2015 07:20:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Oct 2015 07:20:19 -0400
Content-Disposition: inline
In-Reply-To: <28a610a30ab9d4f742be2f3225db341ea40c8a51.1445579874.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280092>

On Fri, Oct 23, 2015 at 08:02:52AM +0200, Johannes Sixt wrote:

> 5096d490 (convert trivial sprintf / strcpy calls to xsnprintf) converted
> two sprintf calls. Now GCC warns that "format '%u' expects argument of
> type 'unsigned int', but argument 4 has type 'long unsigned int'".
> Instead of changing the format string, use a variable of type unsigned
> in place of the typedef-ed type DWORD, which hides that it is actually an
> unsigned long.
> 
> There is no correctness issue with the old code because unsigned long and
> unsigned are always of the same size on Windows, even in 64-bit builds.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> I do not know why there are no warnings with the old code. Apparently, the
> system provided sprintf declaration does not have format-printf
> annotation.

Makes sense, and the patch looks obviously correct.

-Peff
