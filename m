From: Ain Valtin <ain.valtin@gmail.com>
Subject: separate-git-dir doesn't work with mapped drive
Date: Sat, 19 Oct 2013 11:49:27 +0300
Message-ID: <CADgy815BJAJrbW0JJ2a9vZ4NwzGersceg6b96TPAey_pR+mOiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 19 10:49:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXSE5-0007Sg-F0
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 10:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326Ab3JSIt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 04:49:29 -0400
Received: from mail-ve0-f169.google.com ([209.85.128.169]:65431 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270Ab3JSIt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 04:49:28 -0400
Received: by mail-ve0-f169.google.com with SMTP id oy12so2782181veb.28
        for <git@vger.kernel.org>; Sat, 19 Oct 2013 01:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=AZc6oeRpok7w90eEAuppDTWqU04ijjKqFcOFTVhaLy8=;
        b=hOATb61CYwM43UT+de3AlOqLLoKnjxk0jBEwMgpgpNs1tQM/7X++y+0iaHa77swGYt
         xlmFKWhew10ieRqUE2KCBaacXGbQDngLRCzXQfwH3NQrWTNLSlwPkM7wTE6ArIYvDQ9j
         u/xBnDMLToxx2Srsism8TQidoPdjgzZ+FfzYG3pwu7kOcG0F3XWjLqRK+m+kJRCkoElH
         6tyCeKwVnQLPE59vm9xqYLK8IFdo2zFnELKWVtsQrSy7DShzbWpOmIbDFk7R9ZxjXVSa
         opK+xfLB33BH91w/YnMeNYTpK/tPjTjZcq5P2zPGFZkwJ8XwFBttg5397d989hfdoLsj
         6t5w==
X-Received: by 10.58.207.15 with SMTP id ls15mr3989951vec.17.1382172567425;
 Sat, 19 Oct 2013 01:49:27 -0700 (PDT)
Received: by 10.220.215.74 with HTTP; Sat, 19 Oct 2013 01:49:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236391>

Hi

I want to use git in a VirtualBox guest so that the repository is on
the host drive. So in the VB settings for the guest I set up a shared
folder "gitRepos" to /home/ain with full access rights. Then in the
guest OS (Windows XP) I map this shared folder as G drive. Now in the
project dir I execute

C:\...\TPP>git init --separate-git-dir g:/TPP
Initialized empty Git repository in g:/TPP/

Checked, the repo structure is in the "g:/TPP/" (thus the guest OS can
write to the mapped dir) and in the .git file created to the project
dir there is line

gitdir: g:/TPP

However when tring to use the repo it fails to recognise the g:/TPP path, ie

C:\...\TPP>git add .
fatal: unable to access '../../../../../../g:/TPP/config': Invalid argument

Also tryed "gitdir: //VBOXSVR/gitRepos/TPP" but this fails too:

C:\...\TPP>git add .
fatal: Unable to create 'C:/Documents and
Settings/Ain/prog/AVT/TPP/../../../../../..///VBOXSVR/gitRepos/TPP/index.lock':
No such file or directory

Am I doing something wrong or is it a bug? Any idea how to get it to work?

BTW the VB is 3.0.14 ie rather old version but it seems that this
isn't the problem as the git init recognises the mapped drive but
other commands fail.
git version is 1.8.4.msysgit.0


TIA
ain
