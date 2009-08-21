From: Jeff King <peff@peff.net>
Subject: Re: how to do "git merge --abort"
Date: Fri, 21 Aug 2009 11:37:30 -0400
Message-ID: <20090821153730.GA14456@coredump.intra.peff.net>
References: <20090821145157.GA6471@debian.b2j>
 <20090821151926.GE6850@coredump.intra.peff.net>
 <200908211726.21593.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 21 17:37:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeWBP-0006zh-D5
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 17:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbZHUPha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 11:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbZHUPha
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 11:37:30 -0400
Received: from peff.net ([208.65.91.99]:36787 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932364AbZHUPh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 11:37:29 -0400
Received: (qmail 2077 invoked by uid 107); 21 Aug 2009 15:37:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 21 Aug 2009 11:37:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Aug 2009 11:37:30 -0400
Content-Disposition: inline
In-Reply-To: <200908211726.21593.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126733>

On Fri, Aug 21, 2009 at 05:26:19PM +0200, Thomas Rast wrote:

> > It is spelled "git reset --merge" (though --merge was introduced in
> > v1.6.1; prior to that, you had to use "git reset --hard").
> 
> Umm, no, you still have to use "git reset --hard".

Ah, sorry, you are right. I have never actually used "--merge", but I
knew based on this thread:

  http://article.gmane.org/gmane.comp.version-control.git/102067

that the point was to carry dirty state across a reset. So I assumed you
could use it to reset a failed merge while leaving dirty state in files
unrelated to the merge. But it doesn't actually handle unmerged entries
at all.

Thanks for correcting me.

The downside, of course, of "git reset --hard" is that it kills off any
dirty state you may have wanted to keep.

-Peff
