From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Trouble building newer git with older
Date: Tue, 8 Aug 2006 11:47:16 -0700
Message-ID: <20060808184716.GC4546@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Aug 08 20:47:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAWbz-0005Nd-Nf
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 20:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWHHSrU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 14:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWHHSrU
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 14:47:20 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:64460 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965032AbWHHSrT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Aug 2006 14:47:19 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k78IlIJu028833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Tue, 8 Aug 2006 14:47:18 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k78IlIE7247512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 8 Aug 2006 14:47:18 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k78IlIgW032144
	for <git@vger.kernel.org>; Tue, 8 Aug 2006 14:47:18 -0400
Received: from arkanoid ([9.12.243.86])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k78IlIb6032117
	for <git@vger.kernel.org>; Tue, 8 Aug 2006 14:47:18 -0400
Received: by arkanoid (Postfix, from userid 1000)
	id 01F1B6769E; Tue,  8 Aug 2006 11:47:16 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
X-Operating-System: Linux 2.6.17.7 (x86_64)
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25081>

Hi all,

I am in the process of updating one of our system's set of git binaries
and noticed the following. When executing

git clone rsync://rsync.kernel.org/pub/scm/git/git.git git
cd git
git checkout
make

I get this error:

kernel:/home/nacc/download/git# make
GIT_VERSION = Usage: git COMMAND [OPTIONS] [TARGET]
 git command 'describe' not found: commands are:
    add apply archimport bisect branch checkout cherry clone
    commit count.objects cvsimport diff fetch format.patch
    fsck.cache get.tar.commit.id init.db log ls.remote octopus
    pack.objects parse.remote patch.id prune pull push rebase
    relink rename repack request.pull reset resolve revert
    send.email shortlog show.branch status tag verify.tag
    whatchanged-dirty
GIT-VERSION-FILE:2: *** multiple target patterns.  Stop.

This is because GIT-VERSION-GEN attempts to invoke `git describe` but
describe is not a valid parameter to the current version of git. This is
not treated as a failure case, though, as output is stored in VN.
Perhaps the return code of `git describe` should also be checked? Or am
I just not supposed to upgrade from this old of a version of git via
git?

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
