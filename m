From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Linear history *and* share a branch?
Date: Thu, 5 Apr 2012 13:48:23 -0700
Message-ID: <CAE1pOi0-uSaQwgJHMTkw3nqp=idxZxMbyfKtLni0=Xwu-L-_hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 22:49:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFtc5-00014c-Eb
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 22:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223Ab2DEUsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 16:48:32 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35904 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380Ab2DEUsY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 16:48:24 -0400
Received: by yenl12 with SMTP id l12so999158yen.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 13:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=jr7KY0rpjnugRjjWPDTfRC5vRBb9O2oC6vBTfR8L+tU=;
        b=Ji63JD99jcvRq+D9/9Y9prbfxsQAscRk8iEv2FyGLqg/5N5x7p5xN7RUCMB86K07+a
         tYXA37n5J5XTo3rJuAMSBKIECYAMfcTA16yBkkMFYyO2oqW8RZN1NUFWLi1iHDg3S2Nr
         JqoNb2kuo0PO6CvSmfyKlaMbrO19j2KdSYmPoi/aIbDQAkjckH8/WAprrhVFo/yjI79r
         BLI2E3JhKZGuRgnB9v+CVAXGiY7HOLabMdAawFSkjna7gaGg87qXEIYGiOgkOMz4LAns
         /0uIkKYYgfs3nFmriYchSGfFF9QNb8NJz75DrzyxJvbjJ+PT16kZvzJpolu2wA5NRQ+R
         LjoQ==
Received: by 10.236.193.36 with SMTP id j24mr4038418yhn.34.1333658903708; Thu,
 05 Apr 2012 13:48:23 -0700 (PDT)
Received: by 10.236.154.104 with HTTP; Thu, 5 Apr 2012 13:48:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194808>

Hi all,

We have been using Git for about a year now in a very small team. So
far, everyone has worked on their own local branches and been doing
"git rebase master" to make sure their local branches stay in synch.
This way we have a nice linear history in master.

Recently, it has become useful to share one of these local branches
between two devs. Of course, when one of the devs does his usual "git
rebase master", he screws up the other dev's environment. Our solution
has been to keep rebasing the shared branch but to actually work on a
local branch that is rebased on the shared branch. By judiciously
using "git reset" and "git pull" on the shared branch the two devs can
keep the shared branch in synch and then use "git rebase
shared-branch" on their local branch to keep it in synch to. While
this works, there is probably a better/simpler solution.

Should we simply do "git merge master" instead of "git rebase master"?
And then do something at the end when we are about to merge the shared
branch back into master to guarantee linear history? Your thoughts and
ideas would be greatly appreciated.

Cheers,
Hilco
