From: Olivier Delalleau <shish@keba.be>
Subject: Suggested improvements to the git-p4 documentation (branch-related)
Date: Thu, 3 Jan 2013 15:58:05 -0500
Message-ID: <CAFXk4bqt_pMVDtVKF-JiQuGbSpy2+_rGOg5RTTE+0pNKFcZh3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 21:58:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqrrw-0006Qa-48
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 21:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958Ab3ACU6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 15:58:08 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:43679 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855Ab3ACU6H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 15:58:07 -0500
Received: by mail-la0-f41.google.com with SMTP id em20so8708269lab.0
        for <git@vger.kernel.org>; Thu, 03 Jan 2013 12:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=3pn67GKLWEJEcVmp526QOpZ7PsUtSNzNDC6KOgeLB68=;
        b=YskGr0e8pjw0xZzX1cJSb12IPdUobKXkqndqu86NnkSXOZmxrSmmiJvlRkhG9a4alG
         jwjiewAr6usJWPQUykNQE6N9k/r9rjYEb2siAr+LrP5Myd6eyNtcPDljhRqev6Suon7e
         il4INazzB6trygt7puBpiSYEA+KdV3Lbp4r2EWN6Z9RUI7ZGy4nC+fA1FM/HeANTOBQG
         u9BFZ95FeLDzd0fStncRUO1G4iL2wRZhEbCNC7sJzZML4+ulgHE7S/fAt6xmOfB4wbH5
         8AmZ+awDlfaLCSuzEhBAuSkkzAk5hF+pvHTt8XfwHnm4zQEBuFMSKxckt661WPGCopcr
         8JFw==
Received: by 10.152.132.137 with SMTP id ou9mr48433106lab.7.1357246685868;
 Thu, 03 Jan 2013 12:58:05 -0800 (PST)
Received: by 10.152.131.10 with HTTP; Thu, 3 Jan 2013 12:58:05 -0800 (PST)
X-Google-Sender-Auth: xXi7qxQwafQCn6E9O0hjYF8V5Es
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212613>

Hi,

While struggling to get git-p4 to work properly with branches, I
thought the documentation on http://git-scm.com/docs/git-p4 could use
some improvements:

1. At the end of the "Branch detection" section, the following
commands are provided (for when you want to explicitly provide branch
mappings to git-p4):

git config git-p4.branchList main:branch1
git p4 clone --detect-branches //depot@all

The second command should end with a dot (".") because the first
command only works if you are already in a git-initialized folder.
Thus I would also suggest to add "git init" as first command to type.

2. Even though having a "main" branch is standard in Perforce, it
would be worth mentioning what happens when you don't: there is a
message "Could not detect main branch. No checkout/master branch
created" output by the "git p4 clone" command. However, it will still
work if you manually set the master branch ("git checkout -b master
remotes/p4/my_custom_main_branch").

3. I don't know what I missed for that one, but I haven't been able to
get the example for the --branch option to work. It says that after
"git init", we can import a p4 branch with:

git p4 sync --branch=refs/remotes/p4/proj2 //depot/proj2

However, after doing this, followed by "git checkout -b proj2
remotes/p4/proj2", I am unable to properly use "git p4 sync" or "git
p4 submit" from this branch, as git complains about a missing
refs/remotes/p4/master.
Maybe it only works if "git clone" has been used before? But then why
have "git init" first?

NB: it's quite possible some of my problems were caused by me not
properly understanding the doc / how git/p4 works. My apologies if
that's the case.

-=- Olivier
