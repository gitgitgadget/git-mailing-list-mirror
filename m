From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Clone a repo and checkout a specifc remote branch
Date: Sat, 7 Mar 2009 12:42:37 +0100
Message-ID: <4d8e3fd30903070342q584315cjcd059dcfe558dcfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 12:44:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfuws-0003JC-CC
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 12:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375AbZCGLmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 06:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753747AbZCGLmm
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 06:42:42 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:3534 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622AbZCGLml (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 06:42:41 -0500
Received: by fg-out-1718.google.com with SMTP id 16so636424fgg.17
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 03:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=RpJ8BuOOq2OBKDXzBtOPVwVXkxyTn8uOby6fMWC+HOM=;
        b=KL0cENtkyfqmcQuzuygX14HQCiDx43U7Z/43cCB/QEE9RUl0U2fmz7Ug79FK7TbUqK
         dqCPIU/S4hP7cZPMJ7V1au6C+NNOAu3WWKrzNW5+i8GqUv6IrNTihKVAxzQM2EWfG+mx
         zpnR0ezZylBnTd2QsHk3qNDcNO1WXh229Mcmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Zf04IKDSZhLAgpbfKFqqhC/asuuw4Qcy38pLhx161i3abzNXCf7lahfYILW/hJLZjv
         Os3u7hjLpRGB+pNbAeHAyJbDmbTdC0DPWqu16S0V/5FSMoqESp+NXl4hCX/RmKWDS6Fg
         I/mW/CaYpJvwL3oaK8yksiVRR1PFN8II/LlLY=
Received: by 10.86.74.4 with SMTP id w4mr2611203fga.52.1236426157481; Sat, 07 
	Mar 2009 03:42:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112527>

Hi list,
I've got a few questions from a friend that used git for the first
time, I answered to all of them but the following.

Scenario:
He knows the URl of a git repository which contains a few branches. He
is interested only to a single specific branch.
He expected to manage to clone the specific remote branch with a
single command, instead he had to learn the following procedure:

$ git clone git://uri_of_the_repo localdir
$ cd localdir
$ git branch
* master
# OK, so now he cloned the whole repository and checked out the master branch
$ git checkout mybranch origin/coolbranch

Wouldn't be an improvement to let the user to specify which remote
branch he want to be checked out after a clone?
Something like:
$ git clone git://uri_of_the_repo:coolbranch localdir
to get a clone of the whole repository and to check out the
origin/coolbranch remote branch?

I quickly discussed this scenario on the #git channel and a user
suggested to use the following procedure:
$ git init
$ git fetch git://uri_of_the_repo coolbranch
which was new to me, I tried it as follow:
$ git fetch git://git.kernel.org/pub/scm/git/git.git man
remote: Counting objects: 7319, done.←[K
remote: Compressing objects: 100% (1536/1536), done.←[K
remote: Total 7319 (delta 5640), reused 7290 (delta 5625)←[K
Receiving objects: 100% (7319/7319), 1.40 MiB | 110 KiB/s, done.
Resolving deltas: 100% (5640/5640), done.
From git://git.kernel.org/pub/scm/git/git
 * branch            man        -> FETCH_HEAD

but now I don't understand how to checkout the branch :-/

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
http://mypage.vodafone.it/
