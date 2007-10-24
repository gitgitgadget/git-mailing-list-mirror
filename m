From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: git-{diff,ls}-files from a subdirectory fails ...
Date: Wed, 24 Oct 2007 03:20:38 +0200
Message-ID: <20071024012038.GA31326@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 24 03:21:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkUvc-0006Sq-Qm
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 03:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340AbXJXBUt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Oct 2007 21:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755331AbXJXBUt
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 21:20:49 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2885 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640AbXJXBUs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 21:20:48 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IkUvG-0008Di-00; Wed, 24 Oct 2007 02:20:38 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62182>

=2E.. when GIT_DIR is specified.

I have a repository at ~/stgit-lib. With cwd at the top of the tree,
things work as expected when I set all those fancy envoronment
variables:

  kha@yoghurt:~/stgit-lib> git-diff-files --name-only
  stgit/utillib.py

  kha@yoghurt:~/stgit-lib> GIT_DIR=3D/home/kha/stgit-lib/.git GIT_INDEX=
_FILE=3D/home/kha/stgit-lib/.git/index GIT_WORK_TREE=3D/home/kha/stgit-=
lib git-diff-files --name-only
  stgit/utillib.py

However, it doen't seem to work from a subdirectory:

  kha@yoghurt:~/stgit-lib/stgit> git-diff-files --name-only
  stgit/utillib.py

  kha@yoghurt:~/stgit-lib/stgit> GIT_DIR=3D/home/kha/stgit-lib/.git GIT=
_INDEX_FILE=3D/home/kha/stgit-lib/.git/index GIT_WORK_TREE=3D/home/kha/=
stgit-lib git-diff-files --name-only | wc
      170     170    3560

Instead of just the one changed file, I get a list of what looks like
all the files in the project, suggesting that maybe git assumes I'm at
the root of the worktree when I'm not.

git-ls-files seems to behave the same way. Bug or user error?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
