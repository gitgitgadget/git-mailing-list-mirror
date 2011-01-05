From: Seth Robertson <in-git@baka.org>
Subject: Re: [BUG?] "git submodule foreach" when command is ssh
Date: Wed, 05 Jan 2011 18:02:14 -0500
Message-ID: <201101052302.p05N2E0v002551@no.baka.org>
References: <AANLkTi=x2i6NvDNRzbszhk-a-z5AYe46-iUBxQsxJJHC@mail.gmail.com>
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 00:36:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PacuJ-0006M1-GQ
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 00:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169Ab1AEXgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 18:36:36 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:48965 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074Ab1AEXgg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 18:36:36 -0500
X-Greylist: delayed 2058 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jan 2011 18:36:36 EST
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id p05N2EYC024988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 5 Jan 2011 18:02:14 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id p05N2E0v002551;
	Wed, 5 Jan 2011 18:02:14 -0500
In-reply-to: <AANLkTi=x2i6NvDNRzbszhk-a-z5AYe46-iUBxQsxJJHC@mail.gmail.com>
Comments: In reply to a message from "Chris Packham <judge.packham@gmail.com>" dated "Thu, 06 Jan 2011 11:32:27 +1300."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164610>


In message <AANLkTi=x2i6NvDNRzbszhk-a-z5AYe46-iUBxQsxJJHC@mail.gmail.com>, Chri
s Packham writes:

    I just noticed something odd with "git submodule foreach". I was
    running a script to create a backup of each submodule on a server I
    have ssh access to. I was surprised to find that git submodule foreach
    stopped silently after the first submodule.

    A little debugging and I find that

    git submodule foreach 'ssh localhost "ls /"' - stops silently after

Putting some input redirection will work around the problem.
Presumably some pipe input is going into the ssh accidentally.

git submodule foreach 'ssh localhost "ls /" < /dev/null'

I'll also just take this moment to advertise gitslave
(http://gitslave.sf.net) as an alternate to submodules which may help
(or hinder) you--depending on your workflow.  It doesn't suffer from
this particular problem in any case.

					-Seth Robertson
