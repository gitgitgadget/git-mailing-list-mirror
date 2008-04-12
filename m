From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: git read-tree ignores GIT_WORK_TREE
Date: Sat, 12 Apr 2008 16:29:40 +0200
Message-ID: <20080412142940.GA14214@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 16:30:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkgkm-0000mz-FL
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 16:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361AbYDLO3w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Apr 2008 10:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbYDLO3w
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 10:29:52 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3211 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbYDLO3v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 10:29:51 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Jkgjc-0003xk-00; Sat, 12 Apr 2008 15:29:40 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79353>

It seems that git merge-recursive recently started honoring
GIT_WORK_TREE. This broke StGit, which was using both
GIT_WORK_TREE=3D$(git rev-parse --show-cdup) _and_ cd $(git rev-parse
--show-cdup) when execing git merge-recursive. (I'm not arguing with
this change -- it's definitely a bug in StGit to use both.)

However, I was doing the same to read-tree -u -m, and that still
works. It seems that read-tree is ignoring GIT_WORK_TREE. Is this
intentional, and if so, what's the rule about when GIT_WORK_TREE is
heeded and when it's ignored?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
