From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [regression?] "git status -a" reports modified for empty submodule
 directory
Date: Tue, 22 Apr 2008 14:15:20 +0200
Message-ID: <480DD6D8.9040900@viscovery.net>
References: <46dff0320804220401h26d2f2ebg1748a4a310acc0f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 14:16:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoHPw-0005yy-0Z
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 14:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbYDVMPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 08:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbYDVMPX
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 08:15:23 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:63801 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbYDVMPX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 08:15:23 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JoHP7-0004Pq-13; Tue, 22 Apr 2008 14:15:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B83796C4; Tue, 22 Apr 2008 14:15:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46dff0320804220401h26d2f2ebg1748a4a310acc0f5@mail.gmail.com>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80105>

Ping Yin schrieb:
> # create a super project super
> $ mkdir super && cd super && git init
> $ touch foo && git add foo && git commit -m "add foo"
> 
> # create a sub project sub
> $ mkdir sub && cd sub && git init
> $ touch bar && git add bar && git commit -m "add bar"
> 
> # add sub project to super project
> $ cd ..
> $ git add sub && git commit -m 'add sub'
> 
> # remote contents of subproject
> $ rm -rf sub/* sub/.git
> 
> # git status -a regression
> $ git status
> # On branch master
> nothing to commit (working directory clean)

This should have reported:

# On branch master
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#
#       deleted:    sub
no changes added to commit (use "git add" and/or "git commit -a")

Right?

> $ git status -a
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #       deleted:    sub
> #

There's nothing wrong with this.

-- Hannes
