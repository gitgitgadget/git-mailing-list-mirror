From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] diff: make "too many files" rename warning optional
Date: Mon, 5 May 2008 09:59:55 -0400
Message-ID: <20080505135954.GA17334@sigill.intra.peff.net>
References: <20080430172136.GA22601@sigill.intra.peff.net> <20080430172553.GC23747@sigill.intra.peff.net> <481CA227.1000801@ramsay1.demon.co.uk> <20080504192332.GB13029@sigill.intra.peff.net> <18462.18066.769759.585596@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon May 05 16:00:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt1FD-0000ze-UC
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 16:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755712AbYEEN74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 09:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754973AbYEEN74
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 09:59:56 -0400
Received: from peff.net ([208.65.91.99]:2634 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752338AbYEEN7z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 09:59:55 -0400
Received: (qmail 32229 invoked by uid 111); 5 May 2008 13:59:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 05 May 2008 09:59:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 May 2008 09:59:55 -0400
Content-Disposition: inline
In-Reply-To: <18462.18066.769759.585596@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81283>

On Mon, May 05, 2008 at 09:28:18AM +1000, Paul Mackerras wrote:

> At the moment I don't think there is a good way in Tcl to get hold of
> the stderr output if a subcommand returns a non-zero exit status, but
> ignore it if the exit status is 0, other than by redirecting stderr to
> a temporary file, which has its own problems.  Tcl can bundle stderr
> in with stdout, or ignore it, or take it as an error indication, or
> send it to a file.
> 
> So if git commands can avoid writing non-error messages to stderr,
> that will make my life easier...

In that case, Junio, perhaps we should restrict this particular warning
just to merge.

However, there a number of other warnings that can get printed on
stderr, many of them related to reflogs. So I suspect with some reflog
conditions (like a reflog that only goes back 1 day) you could end up
with a tcl error for "gitk HEAD@{2.days.ago}".

-Peff
