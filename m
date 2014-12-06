From: Jeff King <peff@peff.net>
Subject: Re: Announcing a new (prototype) git-remote-hg tool
Date: Sat, 6 Dec 2014 00:06:29 -0500
Message-ID: <20141206050628.GB31301@peff.net>
References: <20141205205335.GA28935@glandium.org>
 <20141205221319.GK16345@google.com>
 <20141205225930.GA29256@peff.net>
 <20141205231330.GL16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 06:06:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx7Zt-0005xZ-8A
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 06:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbaLFFGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 00:06:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:49284 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750746AbaLFFGa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 00:06:30 -0500
Received: (qmail 5104 invoked by uid 102); 6 Dec 2014 05:06:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Dec 2014 23:06:30 -0600
Received: (qmail 9376 invoked by uid 107); 6 Dec 2014 05:06:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 06 Dec 2014 00:06:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Dec 2014 00:06:29 -0500
Content-Disposition: inline
In-Reply-To: <20141205231330.GL16345@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260935>

On Fri, Dec 05, 2014 at 03:13:30PM -0800, Jonathan Nieder wrote:

> > It's a shame that both squat on the name "remote-hg", because it makes
> > it difficult to tell the two apart. But of course that is the only way
> > to make "git clone hg::..." work. Maybe we need a layer of indirection?
> > :)
> 
> If the helpers are roughly interchangeable (that is, if you can switch
> between fetching using each one into the same on-disk git repository),
> then picking one to symlink as git-remote-hg in your $PATH should be
> enough.

That may be enough. For the most part you do not need to agree with
other members of the project on which implementation to use. My
experience with import tools has been that either:

  1. you are using them personally (because you do not like the
     upstream's choice of VCS and would prefer to transparently work in
     your favorite tool), or

  2. there is a group of developers who want to use git, but
     somebody provides an unofficial git mirror. They do not have to
     agree on the tool, because they just use git directly from the
     mirror.

So it is mostly a personal choice. But the two confusions I'd still
anticipate are:

  a. It's difficult to even _talk_ about the tools, because the names
     are the same (so searching for tips on the tool, reporting bugs,
     etc, are harder than necessary).

  b. You may want different tools for different projects. If one tool is
     much more efficient, you may need it for a large repo (e.g.,
     mozilla). But another tool may provide other features, and you
     would prefer it for smaller repos.

This is largely speculation, though, and I do not actively use the tools
myself. So I'd be happy to push off dealing with it until it itches
enough for somebody to scratch.

-Peff
