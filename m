From: Dov Grobgeld <dov.grobgeld@gmail.com>
Subject: Why do some commits not appear in "git log"?
Date: Tue, 2 Aug 2011 18:38:14 +0300
Message-ID: <CA++fsGEht+UDp9EnFyfvn-uT1DYPcnhpwmPy_H4PTWvsvUceAQ@mail.gmail.com>
References: <CA++fsGGG7pLt4xoeJozGnYEwOrs6NuzStYPKF_L5k49uzFB-4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 02 17:38:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoH2y-00071V-IL
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 17:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699Ab1HBPiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 11:38:16 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47587 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab1HBPiP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 11:38:15 -0400
Received: by iyb12 with SMTP id 12so8174149iyb.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=DwwbwLBc8fL7euDwGz8iEiSgI0KGBYzcLYnzU4ed3g4=;
        b=PBOReNpumKOmrL9PmCAkDq9f1VEXMreEYUiwB3VdfJhpbZgoJjlptKmgPz3LbQCHX8
         wd43ikEO4nwMpwEuLf96pz0DhBhy/N46XB869BJMz0TVFwN3cVOm+P/0Wt3fojzMWLj/
         64XAIIJg7uVUrtNsuYNz+BhNWq0Jr7p0DOetg=
Received: by 10.42.167.9 with SMTP id q9mr667455icy.310.1312299494781; Tue, 02
 Aug 2011 08:38:14 -0700 (PDT)
Received: by 10.42.219.131 with HTTP; Tue, 2 Aug 2011 08:38:14 -0700 (PDT)
In-Reply-To: <CA++fsGGG7pLt4xoeJozGnYEwOrs6NuzStYPKF_L5k49uzFB-4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178477>

Hi,

This is my first post to this list, so I hope this is the appropriate place.

I'm having a problem understanding why "git log file" does not show
some of the commits where file is changed. Consider the following
commit history:

> git log --pretty=oneline --abbrev-commit | head -20
e86d3b1 Merge remote-tracking branch 'git-svn' into MultiDataPath
05e7103 Made the system convert DP geometric info to MultiDP info and
load it at machine start.
2de7375 Fixed compilation under Linux.
b520873 Error handling!!
73110bd New Group manager for multi data processor
dce3ae9 Merge branch 'MultiDataPath' of
ssh://swteam/home/machine/git/SolarJet into MultiDataPath
25dff3c Merge branch 'MultiDataPath' of
ssh://swteam/home/machine/git/SolarJet into MultiDataPath
247f418 Rewrite of the Finger heightmap nozzle selection algorithm for
better load balancing.
026fec8 Stop all the jobs on async stop or on exception Choice nozzles
using max nozzles number
84a60b7 avoid CarouselSimulationParams
c40df74 git-svn-id: svn://swteam/SolarJet/trunk@4684
d8e1dcc2-e5e0-4eb0-83da-8cedbf775ddd
:

Now let's limit this to the history of a single file:

> git log --pretty=oneline --abbrev-commit Apps/SolarJet/Project/qt/SysScripts/init.py | head
84a60b7 avoid CarouselSimulationParams
c40df74 git-svn-id: svn://swteam/SolarJet/trunk@4684
d8e1dcc2-e5e0-4eb0-83da-8cedbf775ddd
:

As can be see above there were lots of commits omitted now. E.g.
05e7103 (the second commit above). But if I list the changes in
05e7103 I then get:

> git show 05e7103 --name-only | grep init.py
Apps/SolarJet/Project/qt/SysScripts/init.py

Running without --name-only show that there is a substantial change in init.py

So why does this commit not show up in in "git log file"?

One interesting observation is that the only commits that appear in
the "git log file" command are the commits that were imported from
svn. All other commits are filtered out.

So is this a bug, or am I doing something wrong?

Thanks in advance!
Dov
