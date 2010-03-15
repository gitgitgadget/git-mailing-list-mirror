From: Jeremiah Foster <jeremiah.foster@pelagicore.com>
Subject: git http-backend error message
Date: Mon, 15 Mar 2010 17:13:55 +0100
Message-ID: <A55E5483-425E-4303-87F2-FABC46F6BFE5@pelagicore.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 17:37:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrDIO-0001pR-LP
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 17:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965382Ab0COQhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 12:37:32 -0400
Received: from av10-2-sn2.hy.skanova.net ([81.228.8.182]:48910 "EHLO
	av10-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964955Ab0COQhb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 12:37:31 -0400
X-Greylist: delayed 1405 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Mar 2010 12:37:31 EDT
Received: by av10-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id A6772380F2; Mon, 15 Mar 2010 17:14:03 +0100 (CET)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av10-2-sn2.hy.skanova.net (Postfix) with ESMTP id A967D380DC
	for <git@vger.kernel.org>; Mon, 15 Mar 2010 17:13:56 +0100 (CET)
Received: from [10.8.36.139] (194-237-7-146.customer.telia.com [194.237.7.146])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 6574037E62
	for <git@vger.kernel.org>; Mon, 15 Mar 2010 17:13:56 +0100 (CET)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142220>

Hello,

	I've recently installed git 1.7.0.2 to enable serving git repositories in an efficient fashion over http. Thanks to the excellent documentation here: http://www.kernel.org/pub/software/scm/git/docs/git-http-backend.html I was able to set up the git repo with ldap on debian with apache2 fairly quickly. 

	What I cannot do is push back to the repo. I can check out a complete git repo, add to it, commit. But when I do;

	'git push origin master' 

	I get this error:

error: refusing to update checked out branch: refs/heads/master
error: By default, updating the current branch in a non-bare repository
error: is denied, because it will make the index and work tree inconsistent
error: with what you pushed, and will require 'git reset --hard' to match
error: the work tree to HEAD.
error: 
error: You can set 'receive.denyCurrentBranch' configuration variable to
error: 'ignore' or 'warn' in the remote repository to allow pushing into
error: its current branch; however, this is not recommended unless you
error: arranged to update its work tree to match what you pushed in some
error: other way.
error: 
error: To squelch this message and still keep the default behaviour, set
error: 'receive.denyCurrentBranch' configuration variable to 'refuse'.

	I am unclear about my next move. Should I just set receive.denyCurrentBranch to 'warn' and then my commits locally will go back up to the server? 
	Or is it smarter to just create a bare repository, clone some content into it, and then push?

Thanks,

	Jeremiah