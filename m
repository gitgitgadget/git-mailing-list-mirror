From: Egor Ryabkov <egor.ryabkov@gmail.com>
Subject: Git fetch/pull stopped working
Date: Tue, 8 May 2012 02:45:08 +0400
Message-ID: <CADB4Qb1BhWpm1mAwiHy+edySvo7P+YcvrSiTSc8dVzKQsnNCfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 00:45:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRWgP-0003pS-GE
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 00:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757738Ab2EGWpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 18:45:25 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57975 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757710Ab2EGWpY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 18:45:24 -0400
Received: by yhmm54 with SMTP id m54so4729452yhm.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 15:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=VseQARpeJabFY0TbHBFtE4a+SFDlicdsE1X7puiXpGA=;
        b=Tit3+03IKvrFJjrK0gjAQnlEMNwgAtBp/LXWvUPgh2lvZjI2nayLUuNf+DDgbNbmx+
         T1tYyqVWllA3vPC3rxq4mLNqp79HF9ftnjieigKZ8NOov+3V7mEj0xuCSvPziWJwMqcL
         3i2JIkNgkLmaTY2WfH/aW1faQwjhIpEXPzJEpepKz9z7W6h9OyT2FjUz+1cWTLbRNz9H
         dNrEq0gtwO7uNNL8J5AniinvJlHh0d3LMy39JBFAv13Pj91mP05M8oBuSVA+FE5xEBMJ
         p+pZfIDVMRudnr/vToNgi2alJ3P6yxJJ4kK8KF+b7V4GJYCnaXN4bPevJ256Tz2GMhcy
         CIrQ==
Received: by 10.50.222.200 with SMTP id qo8mr2090188igc.20.1336430723861; Mon,
 07 May 2012 15:45:23 -0700 (PDT)
Received: by 10.42.60.200 with HTTP; Mon, 7 May 2012 15:45:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197323>

Hi guys!

git fetch and pull stopped working a few days ago on my server with
the following message:

$ git fetch
ERROR: Repository not found.
fatal: The remote end hung up unexpectedly


fetch/push/pull still work just fine with the same (GitHub) repository
from my local PC, and they also work fine with another GH repo from
another server.

I tried comparing "git remote -v" output for local PC and server,
they're the same.
"$ GIT_TRACE=1 git fetch" gives somewhat different output on local PC
and server:
http://pastecode.com/bd3fc1a79f8e9d1eaf30911d9895938051c472f4
but the output is identical for the two servers I have (both are AWS
instances, if that matters).

There are two clones of the repository on the server in question, both
giving the same error. ssh git@github.com works as it should, so SSH
keys are alright.


One quirk I noticed is that "git pull origin st+[Tab]" used to expand
to a branch name; now it expands to a name of the file in current
directory (and the filename is not the same as branch name).

I guess it's some problem with git install on the server - any ideas
how I could try and diagnose this, besides GIT_TRACE?


A discussion on Stackoverflow:
http://stackoverflow.com/questions/10438082/git-fetch-pull-have-stopped-working

Thanks in advance!

Egor.
