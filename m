From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] [RFC] Introduce Git.pm
Date: Thu, 22 Jun 2006 10:07:58 +0200
Organization: At home
Message-ID: <e7dj4h$cv7$1@sea.gmane.org>
References: <20060622003546.17760.23089.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 22 10:08:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtKEs-0005Zl-Dj
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 10:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWFVII1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 04:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWFVII1
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 04:08:27 -0400
Received: from main.gmane.org ([80.91.229.2]:13705 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932321AbWFVII0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 04:08:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FtKEb-0005Vv-0U
	for git@vger.kernel.org; Thu, 22 Jun 2006 10:08:17 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 10:08:17 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 10:08:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22309>

Petr Baudis wrote:

> Most desirable now is proper error reporting, generic_in() for feeding
> input to Git commands and the repository() constructor doing some poking
> with git-rev-parse to get the git directory and subdirectory prefix.
> Those three are basically the prerequisities for converting git-mv.

I think that repository() constructor (to be converted in the 'new'
constructor I guess) should take 'binbin => "/usr/bin"' argument
optionally, to find where git binary is. 'libexecdir' can be also
supported, or one can get it from 'git --exec-path' and save.
 
> Currently Git.pm just wraps up exec()s of Git commands, but even that
> is not trivial to get right and various Git perl scripts do it in
> various inconsistent ways.

It would be nice to have also wrapers to reading files from git 
repository, ate least some generic read_file/readdir.

For example it might be faster to list branches and/or tags by directly
reading $GIT_DIR/refs directory than using 'git branch' or 'git tag -l'.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
