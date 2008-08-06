From: "Matt Graham" <mdg149@gmail.com>
Subject: git reset --hard isn't resetting
Date: Wed, 6 Aug 2008 12:41:43 -0400
Message-ID: <1c5969370808060941q59cb8f7fhabee3ef3c5107715@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 06 18:42:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQm65-0003v6-1Q
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 18:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbYHFQlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 12:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754913AbYHFQlq
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 12:41:46 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:54028 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbYHFQlp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 12:41:45 -0400
Received: by wf-out-1314.google.com with SMTP id 27so7607wfd.4
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=XBt2sGWEwjch0K5soer6C/qJhogQhhKAmI1QkcBCgLE=;
        b=XvbjHoHM/A1YbLUIDtsHxY2rPxenh2125Ba7EL0mok07nCduHEnzWQvBKvE+yVyl8t
         pFTtckWmLZ2d8DEHz1qbJ3qq3+jlehdn8jNrF/4V6cRCHHE1OjFt1bObBMut0UeACfL1
         697BHjfgosOB3iq7zFPJEvUVqObMaWTi1+juU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=RTmf0h8onIHWUmQASzOzw8MUg5pEPUIylLXyhNGT6CIdtnGxQnExM7ybAfbJH76rnn
         C+iepln/IREgTgPTc4dKLu9kcvMpPC28oQeVFFYJkMQBxNrETo6Z93k9EI/0weP1oXZY
         tOWOOIPdzpiy49lxTEI/95vI3CJz63jsa6pSw=
Received: by 10.142.199.16 with SMTP id w16mr72282wff.268.1218040903946;
        Wed, 06 Aug 2008 09:41:43 -0700 (PDT)
Received: by 10.142.204.21 with HTTP; Wed, 6 Aug 2008 09:41:43 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91527>

Hi,
I'm using a git svn tree in Cygwin.  I tried doing an svn rebase and
got in some weird state with local changes I can't get rid of.  It's
not an issue w/ the same repository on my linux machine.

git reset --hard
toggles 4 files between capitalization.  The files don't appear to
have changed case in svn, but it's a huge repository and not easy to
determine with certainty.

I first encountered this during a rebase, so I rebranched master from
git-svn HEAD and the problem followed me there.

Any tips about how to work around it or investigate further would be
appreciated.

scrollback of toggling filenames is pasted below.

thanks


mgraham@mgraham-wks /src/project.git
$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   dim_grade.dsx
#       modified:   dim_institution.dsx
#       modified:   dim_section.dsx
#       modified:   dim_term.dsx
#
no changes added to commit (use "git add" and/or "git commit -a")

mgraham@mgraham-wks /src/project.git
$ git reset --hard
HEAD is now at 6170b8f RPrasad - For the time being switched to
MockAuthenticator; while working on resolving the LDAP issue.

mgraham@mgraham-wks /src/project.git
$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   DIM_GRADE.dsx
#       modified:   DIM_INSTITUTION.dsx
#       modified:   DIM_SECTION.dsx
#       modified:   DIM_TERM.dsx
#
no changes added to commit (use "git add" and/or "git commit -a")
