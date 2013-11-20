From: Alexander GQ Gerasiov <gq@cs.msu.su>
Subject: How to put tree into index
Date: Wed, 20 Nov 2013 15:47:14 +0400
Organization: lvk.cs.msu.su
Message-ID: <20131120154714.39fc5202@snail>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 20 12:56:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vj6LI-0005p6-Ea
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 12:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140Ab3KTLxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 06:53:08 -0500
Received: from eol.lvk.cs.msu.su ([158.250.17.73]:34434 "EHLO
	eol.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab3KTLxH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Nov 2013 06:53:07 -0500
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Nov 2013 06:53:07 EST
Received: from snail (guest-32.lvknet [192.168.131.32])
	by eol.lvk.cs.msu.su (Postfix) with ESMTPSA id CEE3C5D9
	for <git@vger.kernel.org>; Wed, 20 Nov 2013 15:47:15 +0400 (MSK)
X-Mailer: Claws Mail 3.9.2 (GTK+ 2.24.21; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238071>

Hello there.

I need to realize the following scenario with git.

1. I have repository with tree like this:

dir1/
	file1
	file2
	file3

dir2/
	subdir1/
		some files


2. Current branch is B.

3. I want to get dir1 from branch A, and save it's content on current
branch (B) as dir2/subdir1



>From my point I should do the following

1. Get tree-object sha1 of dir1 from A with git ls-tree
2. Put into index new tree-object with the same sha1/content, but under
the name dir2/subdir1
3. Commit index.


But it doesn't work for me. It works with blob object, but not with
tree object.

I tried the following commands:

git ls-tree A dir1 | 
sed 's#dir1#dir2/subdir1#' | 
git update-index --index-info

But after this I see in the index not tree-object with mode 040000, but
commit-object with mode 160000.



So my question is
How to put into index tree-object with known sha1 and given name?


PS I was able to do what I need when copied files, not tree-itself.
Just add -r to git ls-tree, and put into index blobs/files, not tree.
But I'm interested: is it possible to put tree-object into index?
