From: Kai Schlamp <schlamp@gmx.de>
Subject: Re: Beginner problem with .gitignore
Date: Tue, 21 Apr 2009 14:26:14 +0200
Message-ID: <gske1o$bnf$1@ger.gmane.org>
References: <gsid27$p1$1@ger.gmane.org> <49ED8914.9090808@drmicha.warpmail.net> <49ED988A.6030504@gmx.de> <49EDB167.1030600@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 14:28:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwF5M-0004FL-JQ
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 14:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbZDUM0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 08:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbZDUM0p
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 08:26:45 -0400
Received: from main.gmane.org ([80.91.229.2]:54785 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683AbZDUM0o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 08:26:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LwF3i-0003pa-5w
	for git@vger.kernel.org; Tue, 21 Apr 2009 12:26:42 +0000
Received: from p54a8c166.dip.t-dialin.net ([84.168.193.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 12:26:42 +0000
Received: from schlamp by p54a8c166.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 12:26:42 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p54a8c166.dip.t-dialin.net
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <49EDB167.1030600@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117126>

  > The problem is the recursive way in which git applies those patterns.
> Your patterns above mean that git never recurses into the subdirs.
> 
> In the example above, you probably want
> 
> /a_dir/b_dir/*
> !/a_dir/b_dir/c_dir/

Ok, I see. But that way would not ignore other directories in a_dir 
beside b_dir. For that task I have to use the following in .gitignore:

/a_dir/*
!/a_dir/b_dir/
/a_dir/b_dir/*
!/a_dir/b_dir/c_dir/

This tends to a quite bloated .gitignore when you have a deep directory 
structure and don't want to ignore all subfolders.
I also took a brief look into Mercurial and in my opinion the .hgignore 
is more straightforward. It seems to use regexp on the complete file 
path to find out if the files that should be ignored. So the above four 
lines can be combined to one (and if the directory structure would be 
deeper, it would also be just a one liner).
I know that there for sure is a reason for why git uses it's pattern in 
.gitignore (probably a performance thing). But it would be nice to have 
at least an option that it recurses into subdiretories, or uses regexp 
syntax on the whole file path. Just my two cents.

Best regards,
Kai
