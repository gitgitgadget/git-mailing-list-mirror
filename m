From: "Alfred M\. Szmidt" <ams@gnu.org>
Subject: git-svn -- out of memory
Date: Sat, 14 Feb 2009 11:40:03 +0100
Message-ID: <1234608003.115771.3468.nullmailer@beryx.hq.kred>
Reply-To: ams@gnu.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 12:07:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYINI-0001if-3m
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 12:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbZBNLG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 06:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbZBNLG1
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 06:06:27 -0500
Received: from hq.kreditor.se ([213.136.42.58]:2445 "EHLO auxid.hq.kred"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750978AbZBNLG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 06:06:27 -0500
X-Greylist: delayed 1580 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Feb 2009 06:06:26 EST
Received: by auxid.hq.kred (Postfix, from userid 118)
	id 337451378CA8; Sat, 14 Feb 2009 11:40:04 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on auxid.hq.kred
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb
Received: from beryx.hq.kred (unknown [10.16.0.106])
	by auxid.hq.kred (Postfix) with SMTP id 14D941378C83
	for <git@vger.kernel.org>; Sat, 14 Feb 2009 11:40:04 +0100 (CET)
Received: (nullmailer pid 3469 invoked by uid 1000);
	Sat, 14 Feb 2009 10:40:03 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109859>

Hi,

when doing a `git svn clone' on a subversion repository that contains
a large file (>1GiB), `git svn' dies with the following:

ams@trillian:~$ git svn clone REPO -T trunk -b branches -t tags
[...]
fatal: Out of memory? mmap failed: Cannot allocate memory
hash-object -w --stdin-paths: command returned error: 128

error closing pipe: Bad file descriptor at /usr/local/bin/libexec/git-core//git-svn line 0
error closing pipe: Bad file descriptor at /usr/local/bin/libexec/git-core//git-svn line 0

Doing a `git repack' doesn't help either.  Anyone got a clue how to
either solve, or work around this?

git version 1.6.1.3

Cheers.
