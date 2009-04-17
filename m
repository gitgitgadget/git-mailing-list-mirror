From: Jeff King <peff@peff.net>
Subject: Re: renaming remote branches
Date: Fri, 17 Apr 2009 08:07:41 -0400
Message-ID: <20090417120741.GD29121@coredump.intra.peff.net>
References: <buo3ac9jn18.fsf@dhlpc061.dev.necel.com> <20090416065934.GA20071@coredump.intra.peff.net> <76718490904160609s1ef9c1e0m6f19ff169666fa3@mail.gmail.com> <20090416135037.GA7770@coredump.intra.peff.net> <buomyagf6g7.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Apr 17 14:09:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lumsj-0008WD-Ag
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 14:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758391AbZDQMHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 08:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754298AbZDQMHs
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 08:07:48 -0400
Received: from peff.net ([208.65.91.99]:41264 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753787AbZDQMHs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 08:07:48 -0400
Received: (qmail 16880 invoked by uid 107); 17 Apr 2009 12:07:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 17 Apr 2009 08:07:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Apr 2009 08:07:41 -0400
Content-Disposition: inline
In-Reply-To: <buomyagf6g7.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116736>

On Fri, Apr 17, 2009 at 09:51:36AM +0900, Miles Bader wrote:

> E.g., a project has a long-term public branch "oink" which is finally
> merged to master, and thereafter ceases to be kept up-to-date.
> Sometimes the developers are reluctant to delete it becaue they want to
> keep the history around.  However simply leaving it in place can be

For some definition of "history", I suppose. Everything of interest
should now be part of the history of "master", except:

  1.  you can no longer refer to the branch by name (but why would you
      want to, if it is now obsolete?)

  2. the reflog history for oink would be gone (but that will be gone
     anyway after the 90-day expiration period)

So I think it is a case of those developers being overly cautious. But I
respect the fact that it is sometimes easier to simply move the branches
than try to convince them otherwise.

If you were keeping reflogs forever for auditing purposes (as has been
discussed elsewhere in the thread about gentoo), then I can see some
point to (2). But in such a workflow, your "delete and create" strategy
doesn't help at all, as the reflog is still purged. You would want to
disable branch deletion entirely in such a workflow, and use a
first-class move command. So a first-class "move remote branch"
operation would be useful there.

-Peff
