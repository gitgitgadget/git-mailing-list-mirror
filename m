From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: updating only changed files source directory?
Date: Tue, 24 Oct 2006 11:50:45 +0200
Message-ID: <453DE1F5.5010803@xs4all.nl>
References: <ehjqgf$ggb$1@sea.gmane.org> <ehkgfs$af6$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 24 11:51:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcIw0-0006vE-HV
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 11:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWJXJuq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 05:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWJXJuq
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 05:50:46 -0400
Received: from main.gmane.org ([80.91.229.2]:44931 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030264AbWJXJuo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 05:50:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GcIvi-0006qz-Ha
	for git@vger.kernel.org; Tue, 24 Oct 2006 11:50:42 +0200
Received: from muurbloem.xs4all.nl ([213.84.26.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 11:50:42 +0200
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 11:50:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
In-Reply-To: <ehkgfs$af6$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29957>

Jakub Narebski escreveu:
> Han-Wen Nienhuys wrote:
> 
>> I have some questions and remarks
> 
> I see that you are using fairly low level commands (plumbing commands)
>  
>>    git-http-fetch -a <branch>  <url>
>>    wget <url>/refs/head/<branch>    ## dump to <myrepo>/refs/head/<branch>
> 
> instead of setting $GIT_DIR/remotes/origin file and using "git fetch".
> BTW. "git fetch" will not update branch you are on, unless --update-head-ok
> option is used.

I tried fetch, but was put off by the warnings because I didn't have 
--update-head-ok. Using lowlevel commands is my way of making sure that 
Git doesn't assume it needs to do anything intelligent.

>>    git --git-dir <myrepo> read-tree <committish>
>>
>>    cd <srcdir>
>>    git --git-dir <myrepo> checkout-index -a -f
> 
> instead of 
>      git --git-dir=<myrepo> checkout <branch>
> (-f is Force a re-read of everything)

Yes, however,

   checkout

changes the state of the repository, which is something I want to prevent.

>> * As far as I can see, there is no reason to have only one index in a
>> git repository. Why isn't it possible to specify an alternate
>> index-file with an option similar to --git-dir ?
> 
> --git-dir is alternative to setting GIT_DIR. You can use GIT_INDEX_FILE
> to specify alternate index file. Documented in git(7), section
> "ENVIRONMENT VARIABLES".

Silly me, I overlooked in the manpage. Note that it is standard to put 
the environment section at the end of the manpage. Right now it's 
somewhere in the middle.


-- 
  Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
