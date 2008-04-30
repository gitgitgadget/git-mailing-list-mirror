From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Importing a strange svn repo layout w/ git-svn
Date: Wed, 30 Apr 2008 00:20:58 -0400 (EDT)
Message-ID: <alpine.DEB.1.00.0804300011390.29172@rose.makesad.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 06:21:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr3pD-0002ny-W4
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 06:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbYD3EVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 00:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbYD3EVA
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 00:21:00 -0400
Received: from wide-rose.makesad.us ([203.178.130.147]:51447 "EHLO
	rose.makesad.us" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752579AbYD3EU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 00:20:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id 01CB4334049
	for <git@vger.kernel.org>; Wed, 30 Apr 2008 00:20:58 -0400 (EDT)
X-X-Sender: paulproteus@rose.makesad.us
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80786>

I'm working on cloning the MediaWiki (a common wiki engine, used to power 
e.g. wikipedia.org) Subversion tree using git-svn.  It has this peculiar 
layout:

$BASE/trunk/phase3 is the project trunk
$BASE/tags/TAG_NAME/phase3 is the tag TAG_NAME
$BASE/branches/BRANCH_NAME/phase3 is the branch BRANCH_NAME

"phase3" is not the only directory in e.g. 
http://svn.wikimedia.org/svnroot/mediawiki/branches/REL1_12/ - there is 
also an "extensions" directory, a snapshot of MediaWiki extensions for 
that branch.  But those are truly separate projects with separate 
contributors, and have to be installed in a separate place.

When cloning other svn repositories, I saw that strange layouts can be 
accommodated by just cloning the trunk.  But in this case,

I considered using git-svn like this:

$ git svn http://svn.wikimedia.org/svnroot/mediawiki/ -t 
tags/phase3/ -b branches/phase3/ -T trunk/phase3/

But that wouldn't be correct, since it wouldn't actually pick up the tag 
or branch names!

Is there a way to get git-svn to handle this situation?  Perhaps git-svn 
has a "suffix $DIR to the repository URL" option that I missed.  If not, 
is it conceivable it could?

-- Asheesh.

-- 
Beauty?  What's that?
 		-- Larry Wall in <199710221937.MAA25131@wall.org>
