From: John Lumby <johnlumby@hotmail.com>
Subject: git  --  how to revert build to as-originally-cloned?
Date: Wed, 18 May 2011 18:53:01 -0400
Message-ID: <4DD44DCD.7010508@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 01:02:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMplE-0007UW-J2
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 01:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755710Ab1ERXCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 19:02:32 -0400
Received: from toip3.srvr.bell.ca ([209.226.175.86]:4265 "EHLO
	toip3.srvr.bell.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350Ab1ERXCb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 19:02:31 -0400
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 May 2011 19:02:31 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArkWAL9L1E2uWXRm/2dsb2JhbACCJoMqkj+ODHindI5chxyJHoYZBJRAimI
Received: from bas3-toronto06-2925098086.dsl.bell.ca (HELO lumbywnt.localdomain) ([174.89.116.102])
  by toip3.srvr.bell.ca with ESMTP; 18 May 2011 18:52:52 -0400
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by lumbywnt.localdomain (8.14.4/8.14.1) with ESMTP id p4IMr1bH004517;
	Wed, 18 May 2011 18:53:02 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173913>

I am stuck trying to revert a private kernel build back to the state in 
which I originally cloned it,
(after probably doing the wrong thing  -  as below).     Hoping someone 
can advise.

Here's what I did   (helpful criticism welcome)

On machine MA in filesystem /a  on 13 May

git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next-2.6.git

(This build built ok and ran ok  and is what I want back)

A few days later on machine MB on filesystem /b  -  same git clone 
command but of course a slightly changed build.

Yesterday  -  I wanted to synch build a/ from b/  :
    git branch jel_r8169  /*  made a new branch --  ok */
    nfs-mounted /b on MA
    git fetch file:///a/.../net-next-2.6/.git   /*  worked  ok  *
    git merge FETCH_HEAD                        /*  worked ok and output 
list of files : */
               output started with
Updating 72a8f97..1b1cb1f
Fast-forward
               then list of files
               output ended with
   56 files changed, 3352 insertions(+), 886 deletions(-)
  create mode 100644 include/net/ping.h
  create mode 100644 net/ipv4/ping.c

I then built this build and built ok but build is broken  -
unresolved syms in some modules  -  I want to undo my merge.

I have tried all the commands I can find that claim to do this
and none of them have done it, e.g. :
   git reset --hard HEAD  /*  did nothing */
   git reset --hard ORIG_HEAD  /*  did nothing */

Not only that,  but none of the various show ,  log  ,  status commands
appear to be aware of the merge at all.    There appears to be no record 
of it -
but the actual files themselves are the updated ones.  (diff with /b 
compares equal)

How can I undo it?

Cheers    John Lumby
