From: linux@horizon.com
Subject: Re: How to checkout a tag?
Date: 5 Oct 2006 08:00:37 -0400
Message-ID: <20061005120037.16181.qmail@science.horizon.com>
Cc: linux@horizon.com
X-From: git-owner@vger.kernel.org Thu Oct 05 14:01:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVRul-00067A-Ac
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 14:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWJEMAj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 08:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWJEMAj
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 08:00:39 -0400
Received: from science.horizon.com ([192.35.100.1]:40505 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751095AbWJEMAi
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 Oct 2006 08:00:38 -0400
Received: (qmail 16182 invoked by uid 1000); 5 Oct 2006 08:00:37 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28358>

> A tag is a ref like any other:
> 
> 	git checkout -b branchname tag

For some operations, "git pull" in particular, I need
to include a "tags/" prefix.  E.g.

$ git fetch
remote: Generating pack...
remote: Done counting 27780 objects.
remote: Result has 22237 objects.
remote: Deltifying 22237 objects.
remote:  100% (22237/22237) done
Unpacking 22237 objects
remote: Total 22237, written 22237 (delta 18295), reused 17624 (delta 14183)
 100% (22237/22237) done
* refs/heads/origin: fast forward to branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
  from a77c64c1a641950626181b4857abb701d8f38ccc to d223a60106891bfe46febfacf46b20cd8509aaad
Auto-following refs/tags/v2.6.19-rc1
remote: Generating pack...
remote: Done counting 1 objects.
remote: Deltifying 1 objects.
remote:  100% (1/1) done
remote: Total 1, written 1 (delta 0), reused 1 (delta 0)
Unpacking 1 objects
 100% (1/1) done
* refs/tags/v2.6.19-rc1: storing tag 'v2.6.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6

$ git pull . v2.6.19-rc1
error: no such remote ref refs/heads/v2.6.19-rc1
Fetch failure: .

$ git pull -n . tags/v2.6.19-rc1
Updating from e478bec0ba0a83a48a0f6982934b6de079e7e6b3 to d223a60106891bfe46febfacf46b20cd8509aaad
Checking files out...
Checking files out...
 100% (6590/6590) done
Fast forward
