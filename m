From: Jeff King <peff@peff.net>
Subject: Re: Undo a git stash clear
Date: Tue, 16 Dec 2008 07:12:49 -0500
Message-ID: <20081216121245.GA8432@coredump.intra.peff.net>
References: <c6c947f60812160407l1b2593e1pde817f5cfb091d59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, git-users@googlegroups.com
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 13:14:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCYoV-0007lM-5P
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 13:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbYLPMMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 07:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753749AbYLPMMw
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 07:12:52 -0500
Received: from peff.net ([208.65.91.99]:1918 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753521AbYLPMMw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 07:12:52 -0500
Received: (qmail 15581 invoked by uid 111); 16 Dec 2008 12:12:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 16 Dec 2008 07:12:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Dec 2008 07:12:49 -0500
Content-Disposition: inline
In-Reply-To: <c6c947f60812160407l1b2593e1pde817f5cfb091d59@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103275>

On Tue, Dec 16, 2008 at 03:07:28PM +0300, Alexander Gladysh wrote:

> I've stashed some valuable changes and then I accidentally did git
> stash clear. (Yes, today is not my day).
> 
> Is it possible to restore stashed changes?

Try git-fsck; it should report some dangling commits (i.e., commits that
are in the object db but aren't reachable by any refs). Then you can
either pull the changes out directly (try git cherry-pick -m1 $sha1) or you
can even restore it as a stash (git update-ref -m oops refs/stash
$sha1).

-Peff
