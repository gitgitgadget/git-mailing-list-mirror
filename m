From: "Michael Johnson" <redbeard@mdjohnson.us>
Subject: Segfault on merge with 1.6.2.1
Date: Sat, 28 Mar 2009 11:19:31 -0500
Message-ID: <op.urifmtkkso3nzr@sulidor.mdjohnson.us>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 17:47:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnbgc-0001KI-Bc
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 17:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbZC1Qpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 12:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbZC1Qpk
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 12:45:40 -0400
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:50467 "EHLO
	looneymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751211AbZC1Qpj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2009 12:45:39 -0400
X-Greylist: delayed 1559 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Mar 2009 12:45:39 EDT
Received: from sulidor.mdjohnson.us (216.49.248-IP-55.ckt.net [216.49.248.55])
	by looneymail-a2.g.dreamhost.com (Postfix) with ESMTP id 3058816D45D
	for <git@vger.kernel.org>; Sat, 28 Mar 2009 09:19:38 -0700 (PDT)
User-Agent: Opera Mail/9.64 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114968>

Greetings.

I'm trying to figure out what's going on with a merge I'm trying to do. As  
far as I know, it's a fairly standard situation, just merging two  
branches. But I get a segfault each time. This occurs with 1.5.6.5 and  
1.6.2.1. The earlier version is on a Debian Etch box with  
backports.debian.org. The latter is Debian Sid. I also tried on a Windows  
box with MSysGit 1.6.2.1-preview20090322.exe.

The 1.6.2.1 version just segfaults, but 1.5.6.5 says:

/usr/bin/git-merge: line 438: 32335 Segmentation fault       
git-merge-$strategy $common -- "$head_arg" "$@"
Merge with strategy recursive failed.

In all cases, .git/index.lock is left behind.

I'm using the default configuration, with only a few basic options in my  
person .gitconfig.

Unfortunately, I cannot post the archive, but I can tar the archive and  
share that with individuals, if need be.

The problems started with a weird merge by another developer a while ago  
that somehow reapplied earlier commits. It looked like he had done some  
commits that wiped some earlier commits but then a commit or two latter  
the old commits were added back. When I tried to merge the resulting  
master into my working branch it segfaulted. I didn't have time (or the  
immediate need) to look into it then and it's been forgotten until now  
(when, of course, it needs to be done in the next few days :( ).

I have run git gc and also pruned a couple of minor dangling objects.  
Running git fsck --full reveals no problems. The largest file is about  
6MiB.

I've asked on #git, and drizzd there suggested I try here. At this point  
I'm completely at a loss.

Any help would be greatly appreciated.

Thanks,
Michael

-- 
Michael D Johnson   <redbeard@mdjohnson.us>    
redbeardcreator.deviantart.com

"Marketing research...[has] shown that energy weapons that make sounds sell
  better..." - Kevin Siembieda (Rifts Game Master Guide, pg 111)
