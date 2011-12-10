From: Hao <billhao@gmail.com>
Subject: process committed files in post-receive hook
Date: Sat, 10 Dec 2011 10:29:12 +0000 (UTC)
Message-ID: <loom.20111210T111457-837@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 11:35:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZKH0-00076T-34
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 11:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab1LJKfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 05:35:14 -0500
Received: from lo.gmane.org ([80.91.229.12]:57636 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588Ab1LJKfN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 05:35:13 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RZKGr-00074l-VY
	for git@vger.kernel.org; Sat, 10 Dec 2011 11:35:10 +0100
Received: from cpe-76-170-238-136.socal.res.rr.com ([76.170.238.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 11:35:09 +0100
Received: from billhao by cpe-76-170-238-136.socal.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 11:35:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 76.170.238.136 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.121 Safari/535.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186745>

Hi guys,

I am writing a post-receive hook in Python that examines the content of some 
files (the HEAD rev). Because the repo is a bare one on the server. My current 
approach is to check out a working copy on the server and run 'git pull' in post-
receive to get the most up-to-date version, and then process files in the 
working copy.

I have two questions. First, is there a way that I can access file content in a 
bare repo without checking out a working copy? If this is not possible, my 
approach would be reasonable. However, when 'git pull' was called in the python 
script post-receive when a commit occurs, it gives an error.

remote: fatal: Not a git repository: '.'

The call in python is

subprocess.Popen(["git", "pull"], cwd="/Users/git/ts.git.workingcopy")

I read from a post (http://stackoverflow.com/questions/4043609/) that GIT_DIR is 
causing this error. Is it safe to unset GIT_DIR in post-receive?

Thanks a lot.
