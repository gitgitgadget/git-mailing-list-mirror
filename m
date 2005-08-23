From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: cogito and merging in steps.
Date: Tue, 23 Aug 2005 18:29:46 +1200
Message-ID: <46a038f9050822232961140d4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Aug 23 08:30:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7SIG-0008BI-Oi
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 08:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVHWG3x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 02:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVHWG3x
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 02:29:53 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:12568 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750785AbVHWG3x convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 02:29:53 -0400
Received: by rproxy.gmail.com with SMTP id i8so1101411rne
        for <git@vger.kernel.org>; Mon, 22 Aug 2005 23:29:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EyDcHBz1+Kk9nNrY8KOO2x7JHz+jrx8k4d0dpijJRadSeRLLr6vYXDNWo0wUhVhoFclTEyInzlCG83xqjWMXfNIXbH3FCsWr2Px7Lbmc7Q3DQLFiLbGHy1O1dUPH6fBOTSeG9KoHyX0coLfCGh4+Ms0uAkLt33kG+ETnni4GUU8=
Received: by 10.39.2.24 with SMTP id e24mr297232rni;
        Mon, 22 Aug 2005 23:29:46 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Mon, 22 Aug 2005 23:29:46 -0700 (PDT)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Is there any way to merge patches "selectively"? 

I have found that if I do 

   cg-pull
   cg-log -r master:origin

I can review the commits that will be merged if I do cg-update. 

Say I do cg-update, it brings a lot of commits and there is a messy
conflict. I immediately can  narrow down on which commit I am merging
it is that has a conflict.

With this info, it'd be interesting to be able to merge not to the tip
of the head (head of the head? =- bah, tip of the branch! :) but to an
earlier commit, so I can resolve the conflict with a more specific
commit.

Say I am merging a series of 10 commits that happened in the shared
repo to the project while I worked disconnected (and did lots of local
commits). The first 8 commits merge cleanly, the 9th is an ugly
conflict I have to resolve, and the 10th is clean and unrelated.

I want to be able to 
 - cg-update
 - oops! this is a mess! review with cg-log -r master:origin
 - aha! Here is the conflict in the 9th commit from MacFroz, fire off
email / open irc session
 - in the meantime, reset the working copy and merge the 8 clean ones
with something like: cg-restore ; cg-update origin^^^ ; cg-commit
 - cg-update origin^ ; emacs file-with-conflict.c ; cg-commit 
 - cg-update # bring in the last pending commit from origin. 

How can I achieve the cg-update <somepointinthebranch> ; cg-commit ? I
mean, without faking a head with

  echo <somepointinthebranch> > .git/refs/heads/temphead 

cheers,


martin
cheers,


martin
