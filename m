From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] merge: indicate remote tracking branches in merge
 message
Date: Sun, 9 Aug 2009 06:00:45 -0400
Message-ID: <20090809100045.GA25197@coredump.intra.peff.net>
References: <20090809065936.GA24112@coredump.intra.peff.net>
 <7vab29a1fr.fsf@alter.siamese.dyndns.org>
 <20090809074035.GA4778@coredump.intra.peff.net>
 <20090809091443.GA676@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 12:00:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma5Cx-0004Fc-Sx
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 12:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743AbZHIKAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 06:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753738AbZHIKAr
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 06:00:47 -0400
Received: from peff.net ([208.65.91.99]:52366 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753683AbZHIKAq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 06:00:46 -0400
Received: (qmail 3076 invoked by uid 107); 9 Aug 2009 10:03:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 09 Aug 2009 06:03:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2009 06:00:45 -0400
Content-Disposition: inline
In-Reply-To: <20090809091443.GA676@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125337>

On Sun, Aug 09, 2009 at 05:14:43AM -0400, Jeff King wrote:

> In t4202, we have a branch name and a tag name that are the same
> (octopus-a), and we "git merge octopus-a". This actually merges the tag,
> but because the branch name existed, we write "Merge branch 'octopus-a'"
> in the log, which is not true. With your patch, it does the right thing
> and says "Merge commit 'octopus-a'".
> 
> The simple thing is to just update the "expect" text. Though the current
> behavior does show off the ability to collape the two branches and say
> 
>   Merge branches 'octopus-a' and 'octopus-b'
> 
> instead of
> 
>   Merge commit 'octopus-a'; commit 'octopus-b'

Thinking about it for a few seconds, it's silly to try to test something
that happens to occur in a totally unrelated test. The right thing to do
is to write actual tests for this area, fix the bug, and then add the
new feature. So how about this series:

  [1/3] add tests for merge message headings
  [2/3] merge: fix incorrect merge message for ambiguous tag/branch
  [3/3] merge: indicate remote tracking branches in merge message

-Peff
