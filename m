From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: contrib/mw-to-git/Git/Mediawiki.pm
Date: Thu, 27 Jun 2013 18:00:09 +0200
Message-ID: <51CC6189.6030701@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: benoit.person@ensimag.fr, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 27 18:00:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsEcO-0004Hb-BJ
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 18:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197Ab3F0QAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 12:00:13 -0400
Received: from mout.web.de ([212.227.15.3]:64781 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541Ab3F0QAM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 12:00:12 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0MCeX4-1V1YHw3Uqg-009O2l; Thu, 27 Jun 2013 18:00:11
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
X-Provags-ID: V03:K0:aCJuAdAGpGhMB4nZ+vUr6sOcQ8cGaSiMH0DMhxRS69uQCAniK9A
 rymGiwkZ3OSIHWalAKEXvWfxw9CNNw/bbSsprAYa7Lk0JWyudedBO4YdUlEN9ZFrqmN9c/e
 /DVYSoOqHAFgCkSxrTOs+ubgKR19ToXGYhLd8QYj4TIaXl5n+BuQlGKSHsraGhcz8AjDpPb
 8DNnzPd7RrjZ9aaBh67sA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229112>


I just discovered a major problem for
Mac OS and Windows people:

In contrib/mw-to-git/ there is a file called "git".
And there is a directory called "Git".

This does not work very well on case insensitive file systems.
When the file "git" is created, we can not create a directory
called "Git", as "Git" is mapped to "git".
And vice versa.

Can we try to rename one of them ?


The other interesting thing is that git 1.8.3 didn't like the
situation:
After checking out the pu branch, 
git status says:
deleted:    contrib/mw-to-git/Git/Mediawiki.pm

So I could not change to another branch/commit...
git stash didn't resolve the situation either.

The following saved my repo:
git mv contrib/mw-to-git/git contrib/mw-to-git/git.exe
git checkout contrib/mw-to-git/Git/Mediawiki.pm
git checkout -b xxx_git_Git_conflict
git commit -a -m xxx_git_Git_conflict

/Torsten
