From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: git-diff-tree -z HEAD | git-diff-helper -z fails for me
Date: Mon, 23 May 2005 11:02:06 +0200
Message-ID: <20050523090206.GJ23388@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 23 11:03:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Da8ns-000598-4e
	for gcvg-git@gmane.org; Mon, 23 May 2005 11:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVEWJCO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 05:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVEWJCO
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 05:02:14 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:63448 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261870AbVEWJCH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 05:02:07 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4N926S8024322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 23 May 2005 09:02:06 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4N926gu024321
	for git@vger.kernel.org; Mon, 23 May 2005 11:02:06 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
this fails:

	(faui00u) [~/work/git/yagf] git-diff-tree -z HEAD | git-diff-helper -z
	03c70739ae572ea9832b97dfcf9ca2594702efe8 (from 30e756ea8569bb429b7073b304acd8a960f77e4b)
	:100755 100755 f2e04c3b45b2a5ab5cf53228025158902c9de5be b93fd0310e51eea4d48d42c6ad83399cff8ab56egitgit(faui00u) [~/work/git/yagf]

But:

	(faui00u) [~/work/git/yagf] git-diff-tree -z HEAD 30e756ea8569bb429b7073b304acd8a960f77e4b | git-diff-helper -z
	diff --git a/git b/git
	--- a/git
	+++ b/git
	@@ -540,11 +540,11 @@ changes

		if (defined ($options{'L'})) {
			pull('-o', shift);
	-               system("git-rev-tree HEAD '^REMOTE_HEAD' | sed -e 's/^[0-9]* //' | git-diff-tree --stdin -v $git_diff_tree_options");
	+               system("git-rev-tree HEAD ^REMOTE_HEAD | sed -e 's/^[0-9]* //' | git-diff-tree --stdin -v $git_diff_tree_options");

		} elsif (defined ($options{'R'})) {
			pull('-o', shift);
	-               system("git-rev-tree REMOTE_HEAD '^HEAD' | sed -e 's/^[0-9]* //' | git-diff-tree --stdin -v $git_diff_tree_options");
	+               system("git-rev-tree REMOTE_HEAD ^HEAD | sed -e 's/^[0-9]* //' | git-diff-tree --stdin -v $git_diff_tree_options");

		} else {
			system("git-rev-list HEAD | git-diff-tree --stdin -v $git_diff_tree_options");

works? What I am doing wrong here?

	Thomas
