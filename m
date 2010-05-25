From: Jeff King <peff@peff.net>
Subject: Re: Git log follow question
Date: Tue, 25 May 2010 05:31:40 -0400
Message-ID: <20100525093140.GA32460@coredump.intra.peff.net>
References: <006d01caf300$703e96a0$50bbc3e0$@burgmann.anu.edu.au>
 <20100514043704.GC6075@coredump.intra.peff.net>
 <alpine.LFD.2.00.1005140730030.3711@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Albert Krawczyk <albert@burgmann.anu.edu.au>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 25 11:31:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGqUF-0002la-S0
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 11:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414Ab0EYJbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 05:31:45 -0400
Received: from peff.net ([208.65.91.99]:34332 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932365Ab0EYJbo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 05:31:44 -0400
Received: (qmail 18656 invoked by uid 107); 25 May 2010 09:31:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 May 2010 05:31:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 May 2010 05:31:40 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005140730030.3711@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147701>

On Fri, May 14, 2010 at 07:50:26AM -0700, Linus Torvalds wrote:

> I'm pretty sure I mentioned about this exact issue when I posted the 
> original follow patches, and it basically boils down to: "--follow" is a 
> total hack, and does _not_ use the regular commit filtering function, and 
> as a result, fancy things like "--parent" don't really work well with it.
>
> [...]
>
> And no, I'm unlikely to look at it. Sorry. I have used --follow 
> occasionally, but it's a hack to see "ok, there it got renamed". It would 
> be nice if "gitk --follow <pathname>" worked properly, but it's just not 
> something I care very much about.

Thanks for the input. I took a look at it myself and it is a bit more
complex than just turning on pruning. I have a prototype --follow that
handles arbitrary pathspecs instead of single files; instead of
replacing the single-file pathspec, it just widens the pathspec as it
traverses history. That eliminates some of the issues, but I am still
getting some odd results from --parents.

So I am giving up for now, as it is not something I care that much
about, either (though multiple-file --follow is). However, Bo Yang, one
of the GSoC students, is planning on working on it as part of his
line-level history browsing project. So we'll see what comes of that.

-Peff
