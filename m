From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] C implementation of the 'git' program.
Date: Thu, 10 Nov 2005 23:50:16 +0100
Message-ID: <4373CEA8.1020900@op5.se>
References: <20051110182631.3C5615BF90@nox.op5.se> <Pine.LNX.4.64.0511101133550.4627@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 10 23:51:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaLFX-0004y4-L0
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 23:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVKJWuS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 17:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVKJWuS
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 17:50:18 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:59300 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932122AbVKJWuS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 17:50:18 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id A35866BCFF
	for <git@vger.kernel.org>; Thu, 10 Nov 2005 23:50:16 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0511101133550.4627@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11531>

Linus Torvalds wrote:
> 
> And the performance difference does seem to be quite noticeable too..
> 

Yes. I was quite astonished when I noticed first, thinking the shell 
kept the parsed script in cache or some such. Apparently it doesn't.

> 
>>The location of the GIT_LIB can be obtained by running
>>
>>	git --lib
> 
> 
> I think this might be a bit ambiguous. When I see "GIT_LIB", to me it 
> implies traditional libraries (ie a "libgit.a" kind of thing), not the 
> kind of "git executable plugin" directory.
> 
> So I'd suggest renaming "--lib" and "GIT_LIB" to be more of a "--libexec" 
> kind of flavor, if only to avoid that confusion.


Someone said libexec was moving out (of Linux, at least), so I thought 
I'd better avoid that. Perhaps GIT_LIBDIR?

Btw, I re-visited ye ole "git binary directory?" thread and noticed the 
nifty trick you did with PATH from the wrapper. I'll add that to git.c 
and, unless I get a better suggestion, rename GIT_LIB to GIT_LIBDIR (and 
git --libdir).


> Even if the actual 
> directory ends up being /usr/lib/git-<version>/ as in my original 
> suggestion, I think it's good to make it clear that it's not just some 
> kind of "link type" library, but more of a combination of libraries and 
> plugins and executables.
> 
> But maybe that's just me?
> 

It's not just you, but GIT_DIR was taken and I felt lazy.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
