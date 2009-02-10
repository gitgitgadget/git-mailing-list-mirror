From: Jeff King <peff@peff.net>
Subject: Re: A little mystery - crash caused by empty commit message.
Date: Tue, 10 Feb 2009 10:30:48 -0500
Message-ID: <20090210153048.GA17660@coredump.intra.peff.net>
References: <1a6be5fa0902100315q554dc457j8c8476d3f59a314f@mail.gmail.com> <20090210113234.GE12089@coredump.intra.peff.net> <1a6be5fa0902100458w246f2bfeu5c0c303d18d17a3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git mailing list <git@vger.kernel.org>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 16:32:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWuav-0001dv-Nb
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 16:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbZBJPav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 10:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752797AbZBJPav
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 10:30:51 -0500
Received: from peff.net ([208.65.91.99]:58811 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728AbZBJPau (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 10:30:50 -0500
Received: (qmail 14639 invoked by uid 107); 10 Feb 2009 15:31:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 10:31:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 10:30:48 -0500
Content-Disposition: inline
In-Reply-To: <1a6be5fa0902100458w246f2bfeu5c0c303d18d17a3b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109257>

On Tue, Feb 10, 2009 at 01:58:43PM +0100, Tor Arvid Lund wrote:

> So - after the "+0100" on the committer line, hd tells me (as
> expected) that I have 0a 0a before "[HIA]". On the "faulty" commit I,
> for some reason, have 0a 00 instead. I do not understand why, but I
> guess strchr will return NULL when "\0[HIA]....." is passed to it, and
> segfault on the next iteration.
> 
> So - I am no closer to understanding what got me to this state, but
> your reply was helpful anyway, thanks :-)

Well, it certainly seems like a bug in one of the history-rewriting
programs. Can you try rebasing, cherry-picking, etc on the original
version of the commit to see if you can reproduce the breakage?

-Peff
