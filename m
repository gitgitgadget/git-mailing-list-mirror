From: skillzero@gmail.com
Subject: git rebase --continue automatic --skip?
Date: Fri, 8 Apr 2011 13:30:01 -0700
Message-ID: <BANLkTi=Vc6kB5fvZrqMwDD+yHFb5qENQ8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 08 22:30:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8IJm-0004gt-Ed
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 22:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757780Ab1DHUaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 16:30:03 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46222 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401Ab1DHUaC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 16:30:02 -0400
Received: by pvg12 with SMTP id 12so1363425pvg.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 13:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=TCBEYscMddeO4a1O3unFELsqqBO1GW4KNawnBXyOF2A=;
        b=CDz9lXGIafMvChXUQp+dwD+oR9+Jf0Ckc0N1TuF6lUEl/vcMnieGFK3l7B0fUoz+e1
         wC9H8QWbS14adIHJRb0vRbyaHAaXCn1jsE7Vx2zcnYRtWoy2b3bvFDqb6YhQecRiSPtb
         qDSzcp1deVRsYx889TAiAgIVSkq2Y2Db280W8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=WUVf9AIMvm0Ibj2TBJuwXU966oeJiiOSKIchpCq/K/6cHxhejacA2FsmMytlTabIm3
         HFxR3tTyOfMcBkFCBoa4eUfXyXDwxNx95Okx9edUpVTZit+POXspRaEpv4w/RuizsoaQ
         dioRx/JBBbHgDdoaq9aa08HvZm1gKZ7aMrj/k=
Received: by 10.142.191.5 with SMTP id o5mr359692wff.28.1302294601420; Fri, 08
 Apr 2011 13:30:01 -0700 (PDT)
Received: by 10.68.41.225 with HTTP; Fri, 8 Apr 2011 13:30:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171160>

Is there a way to make git rebase --continue automatically do a --skip
if a conflict resolution ends up not needing the patch? Normally, git
rebase will just silently skip a patch if it's not needed, but if a
patch results in a conflict and I use git mergetool and end up
deleting all the changes, git rebase --continue stops and makes me
explicitly use --skip.

It's a not a big deal, but it happens a lot to me because I do work on
a branch that really should have gone on master, but I don't want to
disrupt my branch work (i.e. I'm lazy) so I do it directly on the
branch then later clean up those commits by isolating the parts that
are truly part of the topic vs parts that are unrelated. So I hit a
conflict, but want to take the version from master (so the commit
disappears from the branch).
