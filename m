From: morgflast <daniel@sibblingz.com>
Subject: git subtree issues
Date: Mon, 2 Nov 2009 19:56:28 -0800 (PST)
Message-ID: <26159961.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 04:57:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5AWV-0000YJ-DI
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 04:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757756AbZKCD4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 22:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757624AbZKCD4Y
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 22:56:24 -0500
Received: from kuber.nabble.com ([216.139.236.158]:55929 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757554AbZKCD4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 22:56:24 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1N5AVQ-0000eV-Ps
	for git@vger.kernel.org; Mon, 02 Nov 2009 19:56:28 -0800
X-Nabble-From: daniel@sibblingz.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131942>


So, I went ahead and did this

$ git remote add -f vw_extensions git@github.com:sibblingz/vw_extensions.git
(1)
$ git merge -s ours --no-commit vw_extensions/master (2)
$ git read-tree --prefix=some/directory/vw_extensions -u
vw_extensions/master (3)
$ git commit -m "Merge B project as our subdirectory" 

And that all seems to work ok.

Then, I went to another directory where i had vw_extensions cloned, and made
a change to the README file, and pushed it.

I went back to my first project, and did this, to try to pull those changes:

git pull -s subtree vw_extensions master remote: Counting objects: 5, done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 3 (delta 2), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From git@github.com:sibblingz/vw_extensions
 * branch            master     -> FETCH_HEAD
Already uptodate!
Merge made by subtree.

However, when I looked at the README file in the first project, the changes
weren't there.  I was wondering if anyone might have any suggestions about
what to do.

Thanks!
Daniel

-- 
View this message in context: http://old.nabble.com/git-subtree-issues-tp26159961p26159961.html
Sent from the git mailing list archive at Nabble.com.
