From: Jeff King <peff@peff.net>
Subject: Re: Managing /etc with git: Store ownership and time in git?
Date: Thu, 1 Nov 2007 09:10:44 -0400
Message-ID: <20071101131043.GA19914@coredump.intra.peff.net>
References: <loom.20071101T123817-247@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Skwar <listen@alexander.skwar.name>
X-From: git-owner@vger.kernel.org Thu Nov 01 14:11:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InZp4-0007B7-Uu
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 14:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758509AbXKANKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 09:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756913AbXKANKr
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 09:10:47 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3411 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755026AbXKANKq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 09:10:46 -0400
Received: (qmail 5784 invoked by uid 111); 1 Nov 2007 13:10:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 01 Nov 2007 09:10:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Nov 2007 09:10:44 -0400
Content-Disposition: inline
In-Reply-To: <loom.20071101T123817-247@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62954>

On Thu, Nov 01, 2007 at 12:55:57PM +0000, Alexander Skwar wrote:

> I'd like to use git to manage the /etc directories of some servers.
> What's quite nice with git (in comparison to svn) is, that it
> out-of-the-box stores the permissions of a file. But it doesn't seem

It doesn't; git stores only the executable bit.

> like it stores the ownership (ie. user/group) of tracked content.
> Does anyone know how to cope with that "problem"?

Yes, convert your file metadata into a text format in a file in the
repository, and commit that.

> Oh, and it also seems that Git doesn't store the time information of
> files, does it? For tracking /etc, this would be very useful. Would
> anyone have a solution for this as well?

Same as above.

> What I'm thinking about right now is, to write a "hook" script which
> "dumps" the stats of the to-be added files in some "index" file. But
> that seems like a rather clumsy soltion...

That's more or less the solution that has been advocated. Search in the
list archives for /etc solutions; this topic comes up every few months.

-Peff
