From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: git fetch documentation problem or bug
Date: Mon, 8 Oct 2012 20:59:04 +0200
Message-ID: <CAB9Jk9Ac06sfFMGizRq6Ztqd2tKS7BBqGOC891=z4615J3f4hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 20:59:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLIXu-0007kg-9u
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 20:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674Ab2JHS7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 14:59:07 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:46830 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644Ab2JHS7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 14:59:06 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so4984157vcb.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 11:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=kgVSuCaIFwZ7c4sI8wySy08wa13dJz5eSNcSE2N7v9E=;
        b=UXuI5Ao1gWf4dmt8oPLsGYGS32YAI23/c52VzZNXEedAjiPPUz68byM4VxR6kxrEmz
         38EH4hTwTtHbhtZ9CvsIe2k2zsbAJl1A5zg5I35ZFmdipv3gczjI2AzG2dm8AL2qFwy8
         T5WdXc3vQF318VqnbcCVdvDYjDVOficfteh3D5M1wlmB11oi0Q8G66L7MayIhHHZb1VS
         DMoTXs5K+3Q2aeBobEQMBAarNNsV/ttX8x5YmHZntXuYqLNtPCZ7VvPpERlEqz/D92o0
         ZV7271CTHHZVbEY1ZqYCKLRABqzhkS4rfogCtyat9ACjPpWcWLHXuMkqCPl6s+4ljd43
         yKXg==
Received: by 10.52.90.2 with SMTP id bs2mr8345984vdb.23.1349722744829; Mon, 08
 Oct 2012 11:59:04 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Mon, 8 Oct 2012 11:59:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207259>

Hello,

git fetch <repository> <refspec> does not create the remote refs in
the current (local)
repository, as shown by the following script:

git init remote
git clone remote local

# populate the remote repository with a commit
cd remote
touch f1
git add f1
git commit -m A

cd ../local
git fetch origin master
git branch -avv

No ref is created.

However, if a git fetch origin is executed, the refs are properly created:

git fetch origin
 * [new branch]      master     -> origin/master
  remotes/origin/master 8a9186d A

I have not seen any clue in the documentation that tells the user
about this difference. The user may (naively) think that git fetch
origin downloads all branches, while git fetch origin <branch>
downloads only <branch>, but it is not so.
I am wandering if this is a documentation problem or a bug.

-Angelo
