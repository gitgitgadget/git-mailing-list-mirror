From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Workflow question: A case for git-rebase?
Date: Wed, 8 Aug 2007 22:11:22 +0100
Message-ID: <18071eea0708081411p41eaa44ai105adaef0e4b10a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 23:11:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIsoT-0008Vo-Bt
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 23:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763799AbXHHVLY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 17:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763071AbXHHVLX
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 17:11:23 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:40612 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760884AbXHHVLW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 17:11:22 -0400
Received: by wa-out-1112.google.com with SMTP id v27so324638wah
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 14:11:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=X2OdmIA2miOWxp+zu3DSmbDV1rXIxJknKe10JpBKUCTy5ju/XDry7W96m4zV+id1NIigvYrnY9B4WJaPDQ8UluQiiOY7AtMRgUlZ/qhjU+idPhcZyro0x9BX4EMkd5K6NAXPqYcj9cI/K/AIJjKu8DuEqEspTi0xZDPr6loCTpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ox55xoGtVT16beod0csMfZrxcRmkTQ1pC1jKVRMqMi+AyAY1WplgLpv7rXaw7yy3MW+XI4lJhvPP8hii30VXrVgT6Yc/lrB4Nmv3V0E4RW0Z3HRED3Ic5FalJRc1fbxkIP4Nmw2RJUYt8197vDdidOcStPjzykWQwCq2JGOqtUI=
Received: by 10.115.46.9 with SMTP id y9mr1648007waj.1186607482501;
        Wed, 08 Aug 2007 14:11:22 -0700 (PDT)
Received: by 10.114.135.16 with HTTP; Wed, 8 Aug 2007 14:11:22 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55367>

Hello all,

So we've (as in my place of work) have switched from SVN to GIT
although I do have a few questions -- hopefully they're not too
obvious.  :)

We have our master branch which is where all the latest changes are
added to as a "remote shared repository which everyone pushes and
pulls to.   That's emulating pretty much what SVN did -- which is
fine.

As for myself, I maintain _locally_ a few branches (branchX, branchY)
which dictate some bits and pieces I'm working on.  Periodically, I
will tend to merge either merge to master and then push those changes
out.  So far so good...

But, I've now come up against a case whereby if one of my colleagues
changes a file (call it fileA) in branch master, and, in the course of
my working in branchX means i modify fileA also, when I come to merge
branchX into master I find the original change in master (as submitted
by my colleague) being reverted by my changes in branchX.  Luckily I
don't commit that since I do a git-diff beforehand.   :)

One suggest solution to this is to merge master into branchX/branchY
periodically, although this has the same problems as described when I
try to merge -- if I'm going to make branchX the same as master, I
might as well just work in master and be done with it, right?

So I was wondering if it's fine to branch from master at any given
point and perhaps use git-rebasse when I come to merge?  Is this even
the correct mode of working?  Indeed, there might be times when
git-rebase isn't necessary if a merge to master from branchX or
branchY won't revert a commit in master because that file had been
edited, so how do I determine when to use git-rebase in this case?  Or
is that the correct indicator?

I do hope that makes sense.

Kindly,

Thomas Adam
