From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: git add --ignore-errors doesn't ignore .gitignore errors
Date: Tue, 24 Apr 2012 13:13:24 +0400
Message-ID: <8A31466D-A791-4FF9-BFDC-029C4644ABE7@jetbrains.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 11:13:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMboT-0001Oy-Kp
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 11:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095Ab2DXJN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 05:13:28 -0400
Received: from mail1.intellij.net ([46.137.178.215]:37523 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756479Ab2DXJN2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2012 05:13:28 -0400
Received: (qmail 18758 invoked by uid 89); 24 Apr 2012 09:13:25 -0000
Received: by simscan 1.1.0 ppid: 18720, pid: 18748, t: 0.0978s
         scanners: regex: 1.1.0 clamav: 0.97/m:53/d:13443
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@195.5.138.42)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 24 Apr 2012 09:13:25 -0000
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196216>


Hi,

git add has '--ignore-errors' parameter which, according to the man entry, allows to continue adding even if one of the files failed to add:

 --ignore-errors
           If some files could not be added because of errors indexing them, do not abort the
           operation, but continue adding the others. The command shall still exit with non-zero
           status. The configuration variable add.ignoreErrors can be set to true to make this
           the default behaviour.

However, if the error happens because a file is ignored by Git, git-add aborts, even if "--ignore-errors" is given:

	# git add --ignore-errors .t test2.txt
	The following paths are ignored by one of your .gitignore files:
	.t
	Use -f if you really want to add them.
	fatal: no files added

(in this example '.t' is ignored while 'test2.txt' is not)

Is it a bug or a lack of documentation?

Thanks.

----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
