From: "Alfred M\. Szmidt" <ams@gnu.org>
Subject: Re: git-svn -- out of memory
Date: Mon, 16 Feb 2009 10:37:41 +0100
Message-ID: <1234777061.090819.2512.nullmailer@beryx.hq.kred>
Reply-To: ams@gnu.org
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 10:39:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYzwX-0003g9-Ql
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 10:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbZBPJhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 04:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbZBPJhq
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 04:37:46 -0500
Received: from hq.kreditor.se ([213.136.42.58]:1061 "EHLO auxid.hq.kred"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752525AbZBPJhp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 04:37:45 -0500
Received: by auxid.hq.kred (Postfix, from userid 118)
	id AA5C51379485; Mon, 16 Feb 2009 10:37:43 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on auxid.hq.kred
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb
Received: from beryx.hq.kred (unknown [10.16.0.106])
	by auxid.hq.kred (Postfix) with SMTP id 8D0EC13792A2;
	Mon, 16 Feb 2009 10:37:43 +0100 (CET)
Received: (nullmailer pid 2513 invoked by uid 1000);
	Mon, 16 Feb 2009 09:37:41 -0000
In-reply-to: message from Eric Wong on Sun, 15 Feb 2009 16:38:35 -0800
References: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110153>

   > when doing a `git svn clone' on a subversion repository that contains
   > a large file (>1GiB), `git svn' dies with the following:
   > 
   > ams@trillian:~$ git svn clone REPO -T trunk -b branches -t tags
   > [...]
   > fatal: Out of memory? mmap failed: Cannot allocate memory
   > hash-object -w --stdin-paths: command returned error: 128
   > 
   > error closing pipe: Bad file descriptor at /usr/local/bin/libexec/git-core//git-svn line 0
   > error closing pipe: Bad file descriptor at /usr/local/bin/libexec/git-core//git-svn line 0
   > 
   > Doing a `git repack' doesn't help either.  Anyone got a clue how to
   > either solve, or work around this?
   > 
   > git version 1.6.1.3

   Hi Alfred,

   Core git requires objects to be able to fit into (virtual) memory.
   Adding more swap space should solve the problem for you, but this is not
   only a git-svn problem.

In this case, the machine has 32G RAM, including ~20G swap.  So I do
not think that this is the case, it could be I suppose...

Cheers.
