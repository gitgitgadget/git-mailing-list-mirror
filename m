From: Jeff King <peff@peff.net>
Subject: Re: Push merges?
Date: Wed, 26 Mar 2008 23:09:35 -0400
Message-ID: <20080327030935.GA4974@coredump.intra.peff.net>
References: <ba5eca00803261452r4b5a7b6bi600c30e79b945477@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ryan Leigh <ryanl.pi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 04:11:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeiWJ-0002Ec-RZ
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 04:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbYC0DJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 23:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756650AbYC0DJn
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 23:09:43 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4870 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755074AbYC0DJi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 23:09:38 -0400
Received: (qmail 31672 invoked by uid 111); 27 Mar 2008 03:09:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 26 Mar 2008 23:09:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2008 23:09:35 -0400
Content-Disposition: inline
In-Reply-To: <ba5eca00803261452r4b5a7b6bi600c30e79b945477@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78324>

On Wed, Mar 26, 2008 at 02:52:06PM -0700, Ryan Leigh wrote:

> I've been getting to know git and I've stumbled across a "problem" and
> I haven't yet been able to find a solution. For example, say I have a
> branch "base" and two branches of that "foo" and "bar". I make some
> change in "base", commit it, and now I would like to have it in both
> "foo" and "bar". Is there a command that rather than get another
> branch and merge with the current branch will instead take the current
> branch and apply a merge on other branches? I've done google searches

No, there isn't such a command. Merges must be done one at a time
because they use the index and working tree to report conflicts.

So what you are asking for is the moral equivalent of:

  for i in foo bar; do
    git checkout $i && git merge master
  done

and you could do it that way, except that the 'merge' step may fail with
conflicts that need to be fixed up by hand.

-Peff
