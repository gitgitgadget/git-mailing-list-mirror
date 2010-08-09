From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: understanding how remote tracking works
Date: Mon, 9 Aug 2010 10:47:34 +0930
Message-ID: <AANLkTi=J3tDnZUg3k5bzDk2ydzYVVLKLwoW0gpBypYAs@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 09 03:17:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiGzw-0000KG-Dg
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 03:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495Ab0HIBRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 21:17:36 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:37487 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab0HIBRf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 21:17:35 -0400
Received: by wwf26 with SMTP id 26so1823936wwf.1
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 18:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to:date
         :message-id:subject:from:to:content-type;
        bh=ZyB5s/IkT4wdD4pEqty/lo3tMHYR+dRTwqa3CM6Bu1s=;
        b=OJcG+rtJytiPkrcos4vKLNSr8L2dWjnl+10PexE8tbtSXKGYLb2nrD97Qzm0sG3OCC
         ntvSRv1Ic0HAO4KqrsuKqSvJPJsEFpk7pdRzu0uhPFRXVQeJNXsbs4aQabxX/pdrZNnu
         jlblrZRLatpkt6lhG4ESnD9sNNQF5E1S6msT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        b=aNL0GZVJbUMjaocb/b37+dC7XF80PFNoanymII7j2cWcGmL5KOcOhWFrMOSlX2xDl7
         kwIa0ZL/45PpIEpAhiJVilwgeRB/x4dCPvtHdaOcJa5Lrsjvd7ZmsQv9zHIZUpjp9yFd
         FSCkoq0fK81g3JFVWhIIVAyd/drP1oRLyErEY=
Received: by 10.227.154.211 with SMTP id p19mr12854020wbw.19.1281316654093; 
	Sun, 08 Aug 2010 18:17:34 -0700 (PDT)
Received: by 10.216.80.82 with HTTP; Sun, 8 Aug 2010 18:17:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152941>

I'm trying to get my head around tracking/remote repositories.

Why does "git show-ref" show me far more than in
in .git/refs/remotes/origin?

$ ls -l .git/refs/remotes/origin
total 12
-rw-r--r-- 1 geoff ssh 41 2010-08-09 10:17 BBBB
-rw-r--r-- 1 geoff ssh 41 2010-08-09 10:27 CCCC
-rw-r--r-- 1 geoff ssh 32 2010-08-09 10:13 HEAD

$ git show-ref
...
21ff181dc71a2fb0ef161b3f55f93b8197312515 refs/remotes/origin/BBBB
d2e8aa93940f42c4017f0029d94b9e0ead1d392d refs/remotes/origin/BRANCH
e8ee2fb060589114d8fd5cf1d5c568365f2b3dbb refs/remotes/origin/CCCC
979133b0762ed7b4b8b6e0ef0387a2a11e89c8ba refs/remotes/origin/HEAD
2b568d757d92e8fd581a90888dc8b0bc95355565 refs/remotes/origin/LCG
fe91bc2a45753830b832a9ccf24fdea5d7b73b4c refs/remotes/origin/SWAN
83f9795420b54eb23327ec33d1907757ba8141cc refs/remotes/origin/brA
2a0ea3f9823db8fb9f74171e38531f5be3cd66a5 refs/remotes/origin/brB
979133b0762ed7b4b8b6e0ef0387a2a11e89c8ba refs/remotes/origin/master
85bffc07ee7f3b07717c4ed74e0a6a56e52a48e4 refs/remotes/origin/mmmm
e02730027b1b85d515bce08c17010408610061f4 refs/remotes/origin/nnnn



Cheers,
Geoff Russell

P.S. my git is at 1.6.2.3
