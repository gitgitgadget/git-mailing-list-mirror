From: "Alf Clement" <alf.clement@gmail.com>
Subject: problem with branches
Date: Mon, 2 Jun 2008 12:14:07 +0200
Message-ID: <556d90580806020314u7ba60af7kc0176a1867ba32fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 12:15:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K374M-0005mW-0E
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 12:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbYFBKOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 06:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbYFBKOQ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 06:14:16 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:34808 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbYFBKOP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 06:14:15 -0400
Received: by ik-out-1112.google.com with SMTP id c28so245053ika.5
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 03:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=xCrGhverob9tzKUfXEV+XROTSNo34+23LJAclmMP7qU=;
        b=M57ttHyJMIRxY1hZxCXpMHHq8weUp7GbiozwIOZsR2wlGAnpS1qyleQXFSaIgkEWn77BVwab/ZWxkuu10nBPAQeAT+Qu1a/iNZ4DZeCEkEyyAmxudCM5503WOIP9kGs5jF8jiyydq5NQYbcysIx3Mg+CH65zm3t7F8TVVR00Ejk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=xvhwJooxojmMeRDG4X4SEaQkROwyt7VR8DKqBx5qjPOXzVSgj8d1fbe6IH2A6Xeivz7lbC6OQ6oaYAXcEg8Rw9l//+up4ysB2Cey9ZdDhni70MHus0ack4ijB5brbvrSZp9NaDUop7xen3xP1nMdOZfMoTdj5h9e0pc30ysU+eY=
Received: by 10.78.138.6 with SMTP id l6mr190410hud.41.1212401652673;
        Mon, 02 Jun 2008 03:14:12 -0700 (PDT)
Received: by 10.78.144.18 with HTTP; Mon, 2 Jun 2008 03:14:07 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83507>

Hi all,

I created 4 branches with a remote repository on a server.
I've changed some files locally, committed and now try to push... but
it fails with hook declined.
Now the status:
$ git pull -v
From git://XXXX/YY
 = [up to date]      TEST       -> origin/TEST
 = [up to date]      master     -> origin/master
 = [up to date]      v1.03      -> origin/v1.03
 = [up to date]      v2.07      -> origin/v2.07
 = [up to date]      v3.11      -> origin/v3.11
Already up-to-date.

$ git push -v
Pushing to git://XXXX/YY
GIT TRANPORT
Looking up XXXX ... done.
Counting objects: 31, done.
Compressing objects: 100% (14/14), done.
Writing objects: 100% (21/21), 2.02 KiB, done.
Total 21 (delta 8), reused 0 (delta 0)
To git://XXXX/YY
 = [up to date]      TEST -> TEST
 ! [remote rejected] master -> master (hook declined)
 ! [remote rejected] v3.11 -> v3.11 (hook declined)
error: failed to push some refs to 'git://XXXX/YY'

I also get a warning when moving between branches:
$ git checkout v3.11
Switched to branch "v3.11"
Your branch is ahead of the tracked remote branch 'origin/v3.11' by 1 commit.

$ git checkout master
Switched to branch "master"
Your branch is ahead of the tracked remote branch 'origin/master' by 2 commits.

Any ideas how to recover from here?
The git-daemon seems to run fine, as I can commit and push from
another test project.
It would be nice if there were more clean failure messages from the
daemon...(Enhancement)

Thanks,
Alf
