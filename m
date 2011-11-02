From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Escape file:// URL's to meet subversion SVN::Ra requirements
Date: Wed, 02 Nov 2011 15:05:00 -0400
Message-ID: <1320260449-sup-479@pinkfloyd.chass.utoronto.ca>
References: <1320251895-6348-1-git-send-email-bwalton@artsci.utoronto.ca> <1320251895-6348-2-git-send-email-bwalton@artsci.utoronto.ca> <20111102182015.GA11401@elie.hsd1.il.comcast.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: normalperson <normalperson@yhbt.net>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 20:05:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLg7X-0000NT-GV
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 20:05:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553Ab1KBTFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 15:05:01 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:33554 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756326Ab1KBTFB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 15:05:01 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:35381 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RLg7Q-0004Ko-4z; Wed, 02 Nov 2011 15:05:00 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RLg7Q-0002bA-41; Wed, 02 Nov 2011 15:05:00 -0400
In-reply-to: <20111102182015.GA11401@elie.hsd1.il.comcast.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184656>

Excerpts from Jonathan Nieder's message of Wed Nov 02 14:20:38 -0400 2011:

> Thanks for your work on this!  I'm not really sure how one can
> decide that the problem is not in svn --- some existing functions
> changed ABI in such a way as to break existing applications and
> require code changes and a recompile.  It would be better for
> Subversion to silently fix up paths provided by bad callers, or at
> least to return a sensible error code.

Yes, my apologies.  I wrote this commit message before fully realizing
just how wrong the response on the svn list was.  It core dumps, after
all...If the patch is useful, I'll resubmit with a better commit
message.

> So the problem is that nobody who cared was testing prereleases of
> subversion and reporting bugs early enough for it to get this fixed
> before the 1.7 release.  But yes, that's water under the bridge and
> git-svn (and libsvn-perl, and pysvn, and ...) should just adjust to
> the new world order.
> 
> > [1] http://news.gmane.org/gmane.comp.version-control.subversion.devel
> 
> Do you mean
> http://thread.gmane.org/gmane.comp.version-control.subversion.devel/132250
> ?

No, the link should have been:
http://article.gmane.org/gmane.comp.version-control.subversion.devel/132227

I'm not sure how it got mangled like that.

> | # failed 1 among 2 test(s)
> | 1..2
> | make[3]: *** [t9145-git-svn-master-branch.sh] Error 1
> 
> Does it work for you?  This is with a merge of git 1.7.8-rc0 and
> 1.7.7.2.

Yikes...I had svn tests turned off in my global build script still and
only validated this against t9134.  My apologies.  I'll submit
something proper later this evening.  (Assuming I get a working patch
that passes the whole suite.)

Sorry for the clumsy patch.

Thanks
-Ben


--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
