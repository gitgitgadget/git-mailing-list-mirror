From: magnuspalmer <magnus.palmer@jayway.com>
Subject: Re: Migrating from subversion via git svn contains log entry, but
 not the file change in the branch.
Date: Tue, 4 May 2010 08:57:35 -0700 (PDT)
Message-ID: <1272988655082-5004035.post@n2.nabble.com>
References: <1272889536578-4997493.post@n2.nabble.com> <4BDEC3AE.90409@drmicha.warpmail.net> <1272987155533-5003911.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 17:57:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9KVD-0008SE-Hl
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 17:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759308Ab0EDP5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 11:57:37 -0400
Received: from kuber.nabble.com ([216.139.236.158]:56552 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759221Ab0EDP5h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 11:57:37 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <magnus.palmer@jayway.com>)
	id 1O9KV5-0004Sx-2s
	for git@vger.kernel.org; Tue, 04 May 2010 08:57:35 -0700
In-Reply-To: <1272987155533-5003911.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146319>


Sorry for spamming, got it working with the following changes:

It turned out that removing the ignore paths entry for branches and tags did
it the trick.

Previously:
git svn init -s --trunk='' --tags=tags/*/* --branches=branches --prefix=svn/
--ignore-paths="branches|tags|subrepo-a|subrepo-b|" <repo_url>

"Working"
git svn init -s --trunk='' --tags=tags/*/* --branches=branches --prefix=svn/
--ignore-paths="subrepo-a|subrepo-b|" <repo_url>

I also had to change from --trunk='' to explicit
--trunk='file:///home/repo/svn-repo/services/project/clients' or else it
also created the branches and tags dirs.
 
-- 
View this message in context: http://git.661346.n2.nabble.com/Migrating-from-subversion-via-git-svn-contains-log-entry-but-not-the-file-change-in-the-branch-tp4997493p5004035.html
Sent from the git mailing list archive at Nabble.com.
