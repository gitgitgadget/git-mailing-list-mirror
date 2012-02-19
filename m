From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn.perl: perform deletions before anything
 else
Date: Sun, 19 Feb 2012 10:54:42 +0000
Message-ID: <20120219105442.GA11889@dcvr.yhbt.net>
References: <7vzkcrvkfa.fsf@alter.siamese.dyndns.org>
 <1328820742-4795-1-git-send-email-stevenrwalter@gmail.com>
 <1328820742-4795-2-git-send-email-stevenrwalter@gmail.com>
 <20120212070353.GA30477@dcvr.yhbt.net>
 <CAK8d-aKJCBq2xpsz65hA4g8oa_szKaofLpkYB3v3_2dd=BAgiQ@mail.gmail.com>
 <20120212234928.GA4513@dcvr.yhbt.net>
 <CAK8d-a+tdK=Jn6D+X=bJmKTzbESPqd8+S2nJr9_sfdb7MhLN1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 19 11:54:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rz4Pq-0000Ar-J4
	for gcvg-git-2@plane.gmane.org; Sun, 19 Feb 2012 11:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373Ab2BSKyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Feb 2012 05:54:44 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:46963 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310Ab2BSKyn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2012 05:54:43 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E65C71F520;
	Sun, 19 Feb 2012 10:54:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAK8d-a+tdK=Jn6D+X=bJmKTzbESPqd8+S2nJr9_sfdb7MhLN1A@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191023>

Steven Walter <stevenrwalter@gmail.com> wrote:
> I don't think git-svn should artificially fail in the case.  This is
> using svn 1.6.17

> What's the oldest version of svn supported by git-svn?  Perhaps if I
> retry with that version of svn, I would see a failure.  However, if
> libsvn-perl reports the failure correctly, isn't that good enough
> behavior?  No need to fail in git-svn before even trying, IMHO.

Originally (back in 2006/2007), the goal was to support SVN 1.1.x+.
I'm not sure if I we ever lost support for such old versions.

I use Debian stable for testing patches, and SVN is 1.6.12 there.
Otherwise, whatever people are willing to support and send
patches/bugreports for is good.

> Is there a way to validate what the checksums should be, other than to
> look at it and say, "yup, the trees look okay?"

As far as I remember, that's how I originally wrote the tests.

> Assuming you agree with the above analysis, should I squash the test
> changes into my 2/2, or would you prefer a separate patch?

Your analysis seems correct.  I always prefer test changes to be
combined with corresponding commits to avoid breakage during bisect.
Thanks!
