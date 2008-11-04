From: "Andrew Arnott" <andrewarnott@gmail.com>
Subject: Repo corrupted somehow?
Date: Mon, 3 Nov 2008 23:09:03 -0800
Message-ID: <216e54900811032309s51c8cb1fr64054ff18c450b1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 08:10:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxG3U-00062c-Qh
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 08:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbYKDHJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 02:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbYKDHJH
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 02:09:07 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:34445 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbYKDHJF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 02:09:05 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1122446yxm.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 23:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=QWyVkp6pTnnKMa8DXYw2CTU2zDvkRL0nHSTA21thdnY=;
        b=dRTIEDfoXw/QJ5ja4I7WB8NYDlLhe8ZuW/dv1oTUdvhcAedqGawlUYtiy3L6xS9Gfx
         M7lyZT2gkMVNQozmN27vl2bk/ogdimuI1pELyTOvFSnudn7qDcTwwYqnpjeM0AvZx74D
         ana68lpuar0fFJZi3cS9596ZcYyM2cVy62OtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=RRchGP7WzfzJfB5E+mzaWThEUuRyXR0VtdbUJDa5lXe8Dgq91T9LGGh3Bg8dXWx3ez
         C6QuGCxgJpXzVnzHvNEWGlEHcupgDqDMJ8hTUSlaBsIId/7/VY28ixoQA/Qz9L55h5Wc
         xpTvLKA8FSYlX6fZiQpe/m/DzHQ2s2Efy/htw=
Received: by 10.151.156.19 with SMTP id i19mr1869335ybo.118.1225782543669;
        Mon, 03 Nov 2008 23:09:03 -0800 (PST)
Received: by 10.151.142.12 with HTTP; Mon, 3 Nov 2008 23:09:03 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100046>

I was just git commit'ing, and then I was doing a git rebase to squash
several commits into one when the rebase failed.  I then did a
git checkout -f master
git reset --hard
but no matter what I do, git thinks that several files have changed.
The diff shows all the lines in these several files removed and then
added, yet without any changes made to them.  git reset --hard doesn't
revert the change. When I jump around history with git checkout these
files remain in their "changed" state.  I even tried "git clone" to
create a whole new repo, but one of these several files STILL
registered as changed before I made any changes.

Any idea what's wrong and how to recover?

Observe the below command buffer: (I can upload my repo so you can
clone it and perhaps repro it if you want).

Andrew@LACKY /c/git/dotnetoauth
$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   tools/Documentation.targets
#       modified:   tools/DotNetOpenAuth.Common.Settings.targets
#       modified:   tools/DotNetOpenAuth.Versioning.targets
#       modified:
tools/Sandcastle/Presentation/vs2005/Content/reference_content.xml
#       modified:   tools/libcheck.ps1
#       modified:   tools/sandcastle.targets
#
no changes added to commit (use "git add" and/or "git commit -a")

Andrew@LACKY /c/git/dotnetoauth
$ git reset --hard
HEAD is now at 13d37b8 Patching up the bad merges in the phases.

Andrew@LACKY /c/git/dotnetoauth
$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   tools/Documentation.targets
#       modified:   tools/DotNetOpenAuth.Common.Settings.targets
#       modified:   tools/DotNetOpenAuth.Versioning.targets
#       modified:
tools/Sandcastle/Presentation/vs2005/Content/reference_content.xml
#       modified:   tools/libcheck.ps1
#       modified:   tools/sandcastle.targets
#
no changes added to commit (use "git add" and/or "git commit -a")
