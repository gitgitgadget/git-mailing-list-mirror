From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 2/5] Introduce new pretty formats %g and %G for
 reflog information
Date: Wed, 14 Oct 2009 00:59:18 -0400
Message-ID: <20091014045918.GA31810@coredump.intra.peff.net>
References: <cover.1255380039.git.trast@student.ethz.ch>
 <e0321a8af8d702d24ace33510daff22d02f4e116.1255380039.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 14 07:04:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxw2Q-0003iP-3u
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 07:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbZJNE7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 00:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753169AbZJNE7z
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 00:59:55 -0400
Received: from peff.net ([208.65.91.99]:56508 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224AbZJNE7y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 00:59:54 -0400
Received: (qmail 24435 invoked by uid 107); 14 Oct 2009 05:02:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Oct 2009 01:02:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Oct 2009 00:59:18 -0400
Content-Disposition: inline
In-Reply-To: <e0321a8af8d702d24ace33510daff22d02f4e116.1255380039.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130246>

On Mon, Oct 12, 2009 at 11:06:04PM +0200, Thomas Rast wrote:

> Unfortunately, we also need to pass down the reflog_walk_info from
> show_log(), so this commit touches a lot of (unrelated) callers to
> pretty_print_commit() and format_commit_message() to accomodate the
> extra argument.

A while back I wanted to add a feature to pretty-printing, and I ran
into the same situation (though my feature never made it to the list).
We really end up passing around the same arguments over and over.  Maybe
it makes sense instead of adding another argument to refactor into a
"pretty_print_context" struct that contains all of the arguments and
current state.

It would be an even more invasive patch, but I think it would make
things more readable, and make future changes much easier to see.

-Peff
