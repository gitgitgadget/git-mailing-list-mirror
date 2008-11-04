From: Bernt Hansen <bernt@norang.ca>
Subject: git log -S doesn't find some commits
Date: Tue, 04 Nov 2008 17:59:40 -0500
Organization: Norang Consulting Inc
Message-ID: <87fxm7rtb7.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 00:01:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxUtc-00069G-Qk
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 00:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789AbYKDW74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 17:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754428AbYKDW74
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 17:59:56 -0500
Received: from main.gmane.org ([80.91.229.2]:41684 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754460AbYKDW74 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 17:59:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KxUsM-00071F-32
	for git@vger.kernel.org; Tue, 04 Nov 2008 22:59:54 +0000
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 22:59:54 +0000
Received: from bernt by cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 22:59:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:QiaaVz8o7Cq1RVDN3kj12WLrOJY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100113>

Hi!

The org-mode repository at git://repo.or.cz/org-mode.git has history
that looks like this:


                  o--o--o--o-------------------M--F--o-- .. --o master
                 /                            /
 A--o-- .. --o--o-------------o--o--B--C--X--D


where commits A, B, C, D, and F all modify lines with
'org-publish-validate-link'.  M is a merge commit and X has an empty log
message.

$ git checkout 8ea076e2de2b3721bd813ea5a2df1b53d0c25055 # commit F
$ git log -Sorg-publish-validate-link

reports 3 commits

F, A, and something earlier than A

Commits B, C, and D are not included in the git log -S output even
though with gitk you can see that 'org-publish-validate-link' is in the
patch.

Am I doing something wrong or is this a bug?

$ git --version
git version 1.6.0.3.523.g304d0

I've marked the commits in column one below.

  $ git log --pretty=oneline

F 8ea076e2de2b3721bd813ea5a2df1b53d0c25055 Updated org-publish.el (now version 1.8
  e322abfd14267a154a06deb1e7ef5a432b17f68a Merge branch 'add-recursion-to-org-publ
  6208fb43cb1bbab852560cf506c7d12674307492 Minor docstring fix.
  df54646ab324b11e99279dc0b6dfa161a1c72c7d Fixed the Timeline node.
D 4dcecb97bf4586c26f7e955980caa7e9630ae9a7 More cleaning.
X eda5a993cab01acd6878ab6c982b075d2cba167b *** empty log message ***
C b05bc10e6794c902df679b906d8bd6ec3f5633a9 Cleaned up code.
B 837c81ce51d90427bbcc32b06d84505b1a1e6b2a Use alist instead of a hashtable.
  960449c9e93725f791bd450d3c85fd71339efb09 Cleaned up the buffer.
  bf09955fec57307616926959b31e19af42520db0 Bugfix for `org-archive-subtree'.
  f247d16417f17140a5bd5d03db164cc74191d9c1 Added support for :maxlevel and :skip-e
  bd172412fafaa0386762826677f9929c9c4fc41c Added support for recursive publication
  96e96fa684585e9916f4d6cdde20d4df7ff3f7d7 Added (require 'erc-log).

Thanks for git!
Bernt
