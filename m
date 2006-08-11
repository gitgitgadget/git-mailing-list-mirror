From: Steve French <smfrench@austin.rr.com>
Subject: git rebase syntax question
Date: Fri, 11 Aug 2006 13:12:16 -0500
Message-ID: <44DCC880.1080108@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 11 20:11:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBbU7-0002nw-II
	for gcvg-git@gmane.org; Fri, 11 Aug 2006 20:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWHKSLm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 14:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWHKSLm
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 14:11:42 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:14497 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932194AbWHKSLl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Aug 2006 14:11:41 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k7BIBbRb004397
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 11 Aug 2006 14:11:37 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k7BIBaCQ272294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 11 Aug 2006 14:11:36 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7BIBa5A013356
	for <git@vger.kernel.org>; Fri, 11 Aug 2006 14:11:36 -0400
Received: from [9.41.38.127] (smf-t41p.austin.ibm.com [9.41.38.127])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k7BIBa68013322
	for <git@vger.kernel.org>; Fri, 11 Aug 2006 14:11:36 -0400
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25235>

I am missing something in the git rebase syntax ... am simply trying to 
remove some "empty" merge messages from my tree like:

commit 7538943ddf992b6ee5ec21d460f1eecc0afdb6f3
Merge: 9f73763... bbab152...
Author: Steve French <sfrench@us.ibm.com>
Date:   Fri Aug 11 17:46:20 2006 +0000

    Merge ../cifs-tmp/

and reorder the commits so my commits that are not in the parent are the 
most recent

The git repository is cloned from 
/pub/scm/linux/kernel/git/torvalds/linux-2.6.git and has one branch and 
history like
         ...->A->MyCommits->B->MoreOfMyCommits->C->EmptyMergeMessages
and I want to make my master look like
         ...->A->B->C->MyCommits->MoreOfMyCommits
   

where "MyCommits" and "MoreOfMyCommits" are not in 2.6.18-rc4 yet, and  
A, B, and C are the parent's (mainline kernel) commits (e.g. A is up to 
about 2.6.18-rc1, B are those between rc1 and rc3, C would be rc4 and 
later etc.)

I tried doing the obvious
    "git rebase master"
but that appears to be a no op
    stevef@smf-t41p:~/cifs-2.6> git-rebase master
    Current branch master is up to date.
    stevef@smf-t41p:~/cifs-2.6> git-rebase origin
    Current branch master is up to date.



How does one do this?
