From: "Chris Riddoch" <riddochc@gmail.com>
Subject: Initializing svn repo from git
Date: Fri, 16 Mar 2007 15:40:46 -0600
Message-ID: <6efbd9b70703161440h762bd340x787f3258bc8dfcdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 16 22:40:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSKAO-0003Ub-Bd
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 22:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbXCPVks (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 17:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbXCPVks
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 17:40:48 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:16670 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298AbXCPVkr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 17:40:47 -0400
Received: by wr-out-0506.google.com with SMTP id 41so687444wry
        for <git@vger.kernel.org>; Fri, 16 Mar 2007 14:40:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NaqwuuEKYtecOry06xVXuvFkTMrfq3TZxWA4WaJXEwgzdCXBLXfRJ9JZhjWOndeq7KWZE4ox5ukLOtLZGKMi0aLNpYYl5aD7yhVA2tHpjahbYRfTQxuyvMlBIqrUBGx2dRFg/Pt6WHrdDjBtemLLFoThWd2BPfeKAms13vSuCsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FLBCIv0DQ28CMedyXyk2UdBbgMuZvFaWEn3QARDDeUO2QrzmzlOB7690CIaMgEGTUjFXIip/ws2EUdzWNNEviwz0JzoSv/zjKSMrZiu8OSoW7iK1lJNBZfpwP4pKZkP8KUmv0WQB/g3H37hLTFJpkJA0evUMRpuGiA64U/+ivDo=
Received: by 10.114.202.15 with SMTP id z15mr911869waf.1174081246501;
        Fri, 16 Mar 2007 14:40:46 -0700 (PDT)
Received: by 10.114.254.4 with HTTP; Fri, 16 Mar 2007 14:40:46 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42399>

Hi, folks.  This is probably targeted at Eric Wong, but any assistance
is welcome.  I asked on #git, and decideded that a larger audience
might be interested in this question, and whatever its answer turns
out to be.

I've been working on a project, and tracking its history in git.  Due
to lack of windows support, and windows-only developers joining my
project, my higher-ups decided that we needed to use SVN.  I expect
I'll probably use git-svn, myself, but I'm faced with a task:

I need to use the contents of my git repository, which is *very*
linear with only one branch, to fill in some history for a new, empty
svn repository.

My current steps, which isn't complete (identifiers cleaned out to
protect... well, me.)

$ git svn init  svn://server/project project
$ cd project
project$ git svn fetch
Fetching git-svn
r0 = df2d1a798e85c75b9abbfd22fe06ff651a8fa9dd
project$ git pull /git/project
warning: no common commits
remote: Generating pack...
remote: Done counting 850 objects.
remote: Deltifying 850 objects.
...

project$ git log
commit <sha>
Merge: <sha>... <sha>...
Author: Chris Riddoch
Date: Fri Mar 16 15:13:58 2007 -0600

    Merge /git/project/

commit <sha>
Author: (no author) <(no author)@641bd306-a92b-0410-b27c-7dcbb122c54d>
Date:   Wed Mar 14 20:41:10 2007 +0000

    git-svn-id: svn://server/project@0 641bd306-a92b-0410-b27c-7dcbb122c54d

commit <sha>
Author: Chris Riddoch
Date:   Tue Mar 13 13:54:21 2007 -0600

    Most recent commit

<skipping a bunch>

commit <sha>
Author: Chris Riddoch
Date:   Thu Feb 1 10:55:42 2007 -0700

    Initial commit of project



Um... now what?  Can someone walk me through this?

Oh, how I wish for a native Windows version of git.  That's the
*right* solution, I know.

-- 
epistemological humility
  Chris Riddoch
