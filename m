From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: updating only changed files source directory?
Date: Tue, 24 Oct 2006 09:48:39 +0200
Organization: At home
Message-ID: <ehkgfs$af6$1@sea.gmane.org>
References: <ehjqgf$ggb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Oct 24 09:48:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcH1b-0007D6-CC
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 09:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbWJXHsg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 03:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbWJXHsg
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 03:48:36 -0400
Received: from main.gmane.org ([80.91.229.2]:61594 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1752096AbWJXHsf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 03:48:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GcH1M-00079K-Uw
	for git@vger.kernel.org; Tue, 24 Oct 2006 09:48:24 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 09:48:24 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 09:48:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29940>

Han-Wen Nienhuys wrote:

> I have some questions and remarks

I see that you are using fairly low level commands (plumbing commands)
 
>    git-http-fetch -a <branch>  <url>
>    wget <url>/refs/head/<branch>    ## dump to <myrepo>/refs/head/<branch>

instead of setting $GIT_DIR/remotes/origin file and using "git fetch".
BTW. "git fetch" will not update branch you are on, unless --update-head-ok
option is used.

>    git --git-dir <myrepo> read-tree <committish>
> 
>    cd <srcdir>
>    git --git-dir <myrepo> checkout-index -a -f

instead of 
     git --git-dir=<myrepo> checkout <branch>
(-f is Force a re-read of everything)
 
> * As far as I can see, there is no reason to have only one index in a
> git repository. Why isn't it possible to specify an alternate
> index-file with an option similar to --git-dir ?

--git-dir is alternative to setting GIT_DIR. You can use GIT_INDEX_FILE
to specify alternate index file. Documented in git(7), section
"ENVIRONMENT VARIABLES".
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
