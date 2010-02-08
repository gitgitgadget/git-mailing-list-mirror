From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: error: packfile size changed
Date: Mon, 8 Feb 2010 18:17:17 +0100
Message-ID: <40aa078e1002080917s1c23580bo815de0c1afa4922@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 18:17:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeXEi-0004Dr-Jj
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 18:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086Ab0BHRRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 12:17:19 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:39244 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791Ab0BHRRS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 12:17:18 -0500
Received: by ewy28 with SMTP id 28so2756006ewy.28
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 09:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:date:message-id
         :subject:from:to:content-type;
        bh=yxurw+9k+L4fGpk4pVFSQCSAywUOmW4feVehk78exOI=;
        b=gIdsOwTxK0kAza+TWAHnIzZVf3fJnLQu1Bt5/NFMxJZf/Km3xLLu/Fc8WFPbPBGM0c
         SwCleXz9BfP6wmqTDDawMc+5/lHeaDnuLrEqbNVQIpllHHngrk1uxK0N8/BCTs0Z09nX
         +uqlxVwdHhca5QGPK6WYHcmo3RJT3agHqryoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        b=GJhv5SPdF7Q8CyT8YclvmLCkp+qcxU9EFDxMdsL7Ra2qbPKiGODGDBIMg413695Jkp
         QYkRC6Oq8mlOdApC804SXvdi58JbVtjGnuRPSs0ZIrKXvk1/ld0asQWZM2DNejVNtGpJ
         mJboevuwkx5pYHXracmJiPBWLFNbCsjPNI0ow=
Received: by 10.216.88.208 with SMTP id a58mr1485890wef.35.1265649437175; Mon, 
	08 Feb 2010 09:17:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139298>

I was just about to push out a branch to a remote repo, and got a
quite worrying error message:

$ git push kusma work/git-svn-autocrlf
Counting objects: 3475, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (1132/1132), done.
Writing objects: 100% (2503/2503), 933.82 KiB, done.
Total 2503 (delta 1909), reused 1927 (delta 1362)
error: packfile
./objects/pack/pack-165dacbd05ac0aa1634eb220f2b6d3be05b2bd3c.pack size
changed
error: packfile
./objects/pack/pack-165dacbd05ac0aa1634eb220f2b6d3be05b2bd3c.pack
cannot be accessed
error: unpack should have generated
83d114b6781e06b422a2062854dd3dede3795079, but I can't find it!
To ssh://kusma@repo.or.cz/srv/git/git/kusma.git
 ! [remote rejected] work/git-svn-autocrlf -> work/git-svn-autocrlf (bad pack)
error: failed to push some refs to
'ssh://kusma@repo.or.cz/srv/git/git/kusma.git'

The push was attempted with git v1.7.0.rc2. It fails with v1.6.6.1
(and msysgit's devel-branch, 1.6.5.1.1375.gc836) as well.

I tried running "git fsck --full", but it didn't report anything apart
from dangling objects.

Any ideas, anyone?

-- 
Erik "kusma" Faye-Lund
