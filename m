From: Paul Mackerras <paulus@samba.org>
Subject: problem with http clone/pull
Date: Wed, 13 Sep 2006 09:23:17 +1000
Message-ID: <17671.16741.995661.664789@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 01:23:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNHbD-0006nD-IX
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 01:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWILXXZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Sep 2006 19:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWILXXZ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Sep 2006 19:23:25 -0400
Received: from ozlabs.org ([203.10.76.45]:64140 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932360AbWILXXY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Sep 2006 19:23:24 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 92DD767B56; Wed, 13 Sep 2006 09:23:23 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26893>

Junio,

Users are having problems doing clones or pulls of my powerpc.git tree
on kernel.org with version 1.4.2 of git.  Apparently earlier versions
work OK.

When I do:

git clone http://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

it produces the following output:

Getting alternates list for http://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git/
Also look at http://git.kernel.or
error: Couldn't resolve host 'git.kernel.orobjects' (curl_result = 6, http_code = 0, sha1 = c336923b668fdcf0312efbec3b44895d713f4d81)
Getting pack list for http://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git/
Getting pack list for http://git.kernel.or
error: Couldn't resolve host 'git.kernel.or'
error: Unable to find c336923b668fdcf0312efbec3b44895d713f4d81 under http://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git/
Cannot obtain needed none c336923b668fdcf0312efbec3b44895d713f4d81
while processing commit 0000000000000000000000000000000000000000.

Now, this repository has a objects/info/alternates file that contains
the single line:

/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects

I also have a hooks/post-update with execute permission, that does
exec git-update-server-info.

Is there anything obviously wrong in how I have set this up, or is it
a new bug in git 1.4.2?

Thanks,
Paul.
