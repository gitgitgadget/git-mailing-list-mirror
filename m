From: "yaneurabeya ." <yanegomi@gmail.com>
Subject: Fwd: Errors when diff'ing arbitrary upstream remotes are not
 intuitive if git pull --all hasn't been done
Date: Thu, 24 Oct 2013 11:07:05 -0700
Message-ID: <CAGH67wRwb1A9CzAfod_XLRVFBRyoEron8tmM+NbMGOeKDVf2Hg@mail.gmail.com>
References: <CAGH67wSf_RQigCmqRZKOpHdV9ELqE=078mkpwA4dfnUr=AvGVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 24 20:07:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZPJR-0000HM-Sf
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 20:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986Ab3JXSHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 14:07:08 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:45116 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755977Ab3JXSHG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 14:07:06 -0400
Received: by mail-wg0-f53.google.com with SMTP id y10so2724396wgg.8
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 11:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=UkR0s4bq7Jf44VCRF0QIH3He2nhpq3O25HOMna6/L0M=;
        b=ZvXjCO6O8GtXODMe1w3uv8L5kPFI7k3CFqjbMbWfceJjfBPHcygA9Yh3T102JcPuKL
         LLttsWJMUpH2dE52wtE+TPMhpNpPqmPReXau7SmZmIInU4kBCMoXkvndU8etutRbdmNm
         we07nsi73JfQlYPifsAy2TwJDYPZpwJQikA+jAJXH4u0mudndhfkDwrkJDEvMx15USkq
         IoSJquaZcBp7TZ7SZftnVRv6XfFvbTcI69NtuulRg0Wj5sfw2HiXcxluUdJpehwU8Zf4
         HudaN5D4rT+0DTo3FlyH8UZj5I1QeixIK+p8tn46nGBiM+t/RZjkSVdoA4sE7a784V1T
         UKlw==
X-Received: by 10.180.10.136 with SMTP id i8mr3341899wib.46.1382638025525;
 Thu, 24 Oct 2013 11:07:05 -0700 (PDT)
Received: by 10.227.21.6 with HTTP; Thu, 24 Oct 2013 11:07:05 -0700 (PDT)
In-Reply-To: <CAGH67wSf_RQigCmqRZKOpHdV9ELqE=078mkpwA4dfnUr=AvGVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236602>

Hi!
    I added an arbitrary upstream remote thinking that I could just
git diff the upstream remote's master. Turns out I needed to run git
pull --all in order to be able to diff the file (I forgot that step).
    Could this error message be improved for interactive commands by
first checking to see whether or not the path starts with a remote,
then recommend that the remote be pulled? If this seems sane, I could
whip up a patch and post it in a github pull request.
Thanks!
-Garrett

$ git remote add pkohut [...]
$ git diff upstream/master -- conf/ | wc -l
16
$ git diff pkohut/master -- conf/ | wc -l
fatal: bad revision 'pkohut/master'
0
$ git pull --all
Fetching origin
Fetching upstream
Fetching pkohut
...
$ git diff pkohut/master -- conf/ | wc -l
46
$ git --version; uname -a
git version 1.7.9
CYGWIN_NT-6.1 ZL00757 1.7.25(0.270/5/3) 2013-08-31 20:37 x86_64 Cygwin
