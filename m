From: Auke Kok <auke-jan.h.kok@intel.com>
Subject: stgit: cannot push a patch - Python trace dump
Date: Thu, 14 Sep 2006 22:07:48 -0700
Message-ID: <450A3524.5040403@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 15 07:10:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO5yT-00065v-8V
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 07:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWIOFKa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 01:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWIOFK3
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 01:10:29 -0400
Received: from mga03.intel.com ([143.182.124.21]:14754 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1750706AbWIOFK2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Sep 2006 01:10:28 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by mga03.intel.com with ESMTP; 14 Sep 2006 22:10:27 -0700
Received: from saspjf01.jf.intel.com (HELO ahkok-mobl.jf.intel.com) ([10.24.220.9])
  by azsmga001.ch.intel.com with ESMTP; 14 Sep 2006 22:09:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,167,1157353200"; 
   d="scan'208"; a="116843186:sNHT639716000"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by ahkok-mobl.jf.intel.com (Postfix) with ESMTP id 5170A3FF45
	for <git@vger.kernel.org>; Thu, 14 Sep 2006 22:07:48 -0700 (PDT)
User-Agent: Mail/News 1.5.0.5 (X11/20060728)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27060>


Hi all,

I'm preparing patches for upstream and am haunted by an apparent patch breaking
stg. The problem appears to be one or more of my patches breaking a push:

$ stg push
Traceback (most recent call last):
   File "/usr/bin/stg", line 43, in ?
     main()
   File "/usr/lib/python2.4/site-packages/stgit/main.py", line 255, in main
     command.func(parser, options, args)
   File "/usr/lib/python2.4/site-packages/stgit/commands/push.py", line 101, in
func
     push_patches(patches, options.merged)
   File "/usr/lib/python2.4/site-packages/stgit/commands/common.py", line 160,
in push_patches
     forwarded = crt_series.forward_patches(patches)
   File "/usr/lib/python2.4/site-packages/stgit/stack.py", line 789, in
forward_patches
     committer_email = committer_email)
   File "/usr/lib/python2.4/site-packages/stgit/git.py", line 439, in commit
     if message[-1:] != '\n':
TypeError: unsubscriptable object


I've been abusing stg by leaving the commit messages empty so I assume that
that's the cause here, or related to the problem.

This happens with today's stg as well as stg-0.10

After scraping all my patches out manually and adding meaningfull (non-empty) 
commit messages I seem to be able to push and pop them all again.

Cheers,

Auke
