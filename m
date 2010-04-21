From: Blair Zajac <Blair@orcaware.com>
Subject: git svn clone of subversion's own code failing
Date: Wed, 21 Apr 2010 11:55:46 -0700
Message-ID: <B3F7BC3A-9606-48BF-A0C8-093CA42B3720@orcaware.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 21 21:07:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4fH8-0001XO-40
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 21:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab0DUTHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 15:07:48 -0400
Received: from orca3.orcaware.com ([12.11.234.124]:59476 "EHLO
	orca3.orcaware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594Ab0DUTHr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 15:07:47 -0400
X-Greylist: delayed 719 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Apr 2010 15:07:47 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by orca3.orcaware.com (8.14.3/8.14.3/Debian-9ubuntu1) with ESMTP id o3LItkNZ030115;
	Wed, 21 Apr 2010 11:55:46 -0700
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145448>

Using MacPorts with git 1.7.0.4 and Subversion 1.6.11, ironically, cloning Subversion's own source code is failing.  I'm using a larger log window size to make the scan to svn's first commit in the repository much faster:

$ git svn clone --log-window-size 5000 -s https://svn.apache.org/repos/asf/subversion

It ends up failing with:

r855619 = c93a05b8f94c53b8748ffe9352445209fe648e87 (refs/remotes/trunk)
	M	contrib/client-side/svn-clean
r855620 = a6b138d3112b1ea0b51b112c6598aae5644369ae (refs/remotes/trunk)
	M	subversion/bindings/swig/core.i
	M	subversion/bindings/swig/python/libsvn_swig_py/swigutil_py.c
	A	subversion/bindings/swig/python/libsvn_swig_py/svn_old_swig.h
	M	subversion/bindings/swig/python/libsvn_swig_py/swigutil_py.h
	M	subversion/bindings/swig/include/svn_global.swg
	M	subversion/bindings/swig/include/svn_types.swg
r855621 = 41bbc61c035218937f1032381f02c481c8653a22 (refs/remotes/python-bindings-improvements)
W:svn cherry-pick ignored (subversion/trunk:855604) - missing 79 commit(s) (eg 462871a2ededa70304eeb99affe550fd029557b5)
r855622 = 2c62a0cca702ffe59dabee92220cf28aedfe1c84 (refs/remotes/python-bindings-improvements)
fatal: ambiguous argument '3b290983fbd7b401e4d1d20256378ba3657cf7d6^..862ea856c2acad5035ce14758fb928c07d7b7f6b': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
rev-list 3b290983fbd7b401e4d1d20256378ba3657cf7d6^..862ea856c2acad5035ce14758fb928c07d7b7f6b: command returned error: 128

I've tried two separate clones with the exact same error.

Trying to finish the clone then gets this:

$ cd subversion
$ git svn fetch && git svn rebase
fatal: ambiguous argument '3b290983fbd7b401e4d1d20256378ba3657cf7d6^..862ea856c2acad5035ce14758fb928c07d7b7f6b': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
rev-list 3b290983fbd7b401e4d1d20256378ba3657cf7d6^..862ea856c2acad5035ce14758fb928c07d7b7f6b: command returned error: 128

Regards,
Blair
