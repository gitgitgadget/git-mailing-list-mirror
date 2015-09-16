From: Jeff King <peff@peff.net>
Subject: Re: git-svn: cat-file memory usage
Date: Wed, 16 Sep 2015 12:31:47 -0400
Message-ID: <20150916163146.GA28401@sigill.intra.peff.net>
References: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9CB@mail.accesssoftek.com>
 <20150916115642.GA5104@sigill.intra.peff.net>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9CD@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 18:32:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcFd2-0000Lr-O5
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 18:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbbIPQcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 12:32:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:60047 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752984AbbIPQbz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 12:31:55 -0400
Received: (qmail 10415 invoked by uid 102); 16 Sep 2015 16:31:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 11:31:55 -0500
Received: (qmail 19401 invoked by uid 107); 16 Sep 2015 16:31:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 12:31:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 12:31:47 -0400
Content-Disposition: inline
In-Reply-To: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9CD@mail.accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278035>

On Wed, Sep 16, 2015 at 06:40:23AM -0700, Victor Leschuk wrote:

> Unfortunately using patch didn't change the situation. I will run some
> tests with alternate allocators (looking at jemalloc and tcmalloc). As
> for alternate tools: as far as I understood svn2git calls 'git svn'
> itself. So I assume it can't fix the memory usage or speed up clone
> process... Correct me if I'm wrong.

I think there are actually several tools calling themselves svn2git.
There was a C tool once upon a time, but it looks fairly inactive, and
the top search hit for svn2git does turn up a git-svn wrapper. Like I
said, I am not very up on the current state of affairs.

> Btw, what do you think of getting rid of batch mode for clone/fetch in
> perl code. It really hardly has any impact on performance but reduces
> memory usage a lot.

I'd worry there are other cases where it does impact performance (e.g.,
perhaps smaller blobs), but I don't know enough about the git-svn
internals to say much more.

-Peff
