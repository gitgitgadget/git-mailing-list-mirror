From: Michael Norman <mwnorman@gmail.com>
Subject: git-svn: after fetch , move 'remotes/git-svn' commits to be under 
	'master' ?
Date: Tue, 1 Dec 2009 11:18:05 -0500
Message-ID: <d43c95440912010818j3c0b98e0o504f82c666c7a290@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 17:21:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFVQc-0005oO-He
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 17:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbZLAQSB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 11:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754160AbZLAQSB
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 11:18:01 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:47590 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbZLAQSA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 11:18:00 -0500
Received: by bwz27 with SMTP id 27so3584741bwz.21
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 08:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=aYmMzS+2FRvQQFGNK0qDhE8VophqxjhB2SaOHXxBLdk=;
        b=vRmJVHSicMEFmVOQ7d3qHLLixJhWfDlZy+VD22QNf8Y6a9fYPOkbhtqWbVkBEaRTEs
         F9IYPNUBKWOpNrNBL58efCBjh9ZNwspAkuXaT/rLmW9qRucaG6yG7FdYe0rKWwetkqoi
         LOdDHxYn2kaAePyOTdTDptha9hYJQDDoqyWrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=q1EZ23ApU2+oZ6KR+nJT7r6Xule5zQPwPykF70smvSPp+zVzD3V77++orwa+8WQLn8
         RM11JAjkd8gxHHR99dbBGLdLVKH8SLyCeQBI6N+rFF/YDY58Jhj5abcEi/nUBHW7ZV+8
         u8stuowU2f7+e44M3sWf54hwBqTpRJF55PUMQ=
Received: by 10.204.150.68 with SMTP id x4mr5900857bkv.151.1259684286054; Tue, 
	01 Dec 2009 08:18:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134222>

I don't know if following work-flow makes sense, but here it is:

step 0) clone a (very!) large SVN repository: since --depth=3D1 doesn't
work for git-svn clone,
pick the revision manually. In this case, I picked the revision one
behind HEAD, so I have
only 2 commits in my working copy:

yellow-dot - master
    |
blue-dot=A0   - misc. tweak settings
=A0=A0=A0 |
blue-dot=A0   - bug 295xx - fix

step 1) I then created a few local branches off of master - br1, br2, e=
tc.
           Some local commits are created under each branch

Pick up latest_&_greatest revisions from SVN
step 2) git svn fetch (about ~50 commits)
           These all identify their branch as 'remotes/git-svn'

It is possible to move the fetched commits to be under 'master'? My
local branch commits
do not overlap (adding new functionality only), so if the new commits
are moved to be under
master, then branches br1 and br2 will inherit those changes - correct?

Any advice would be greatly appreciated -  say if for example my work
flow is all wrong and
there is a better way to keep in sync with the remote SVN repository
while still commiting local
work in my working-copy tree

Mike Norman
