From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: Tracking a branch using StGIT
Date: Fri, 15 Sep 2006 11:58:08 +0100
Message-ID: <450A8740.7000308@shadowen.org>
References: <64de5c8b0609150120h3aeee6dcv976da13134396654@mail.gmail.com> <b0943d9e0609150342y6105d8d1o61abb1934da9f51b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Rajkumar S <rajkumars+git@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 12:58:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOBP7-00044w-Eb
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 12:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWIOK6f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 06:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWIOK6f
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 06:58:35 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:40461 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751234AbWIOK6f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 06:58:35 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GOBOa-0002ki-IN; Fri, 15 Sep 2006 11:58:08 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0609150342y6105d8d1o61abb1934da9f51b@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27075>

Catalin Marinas wrote:
> On 15/09/06, Rajkumar S <rajkumars+git@gmail.com> wrote:
>> I am using StGIT to track a branch of a remote git repository
>> (actually a remote cvs repository, which I am tracking cvsimport)
> [...]
>> The .git/remotes/origin is
>> URL: /usr/local/pfSense/upstream/pfSense/.git
>> Pull: refs/heads/master:refs/heads/origin
>> Pull: refs/heads/avendor:refs/heads/avendor
>> Pull: refs/heads/Package-Reorg-2005:refs/heads/Package-Reorg-2005
>> Pull: refs/heads/RELENG_1:refs/heads/RELENG_1
>>
>> My requirement is to track RELENG_1 branch with StGIT while
>> maintaining my own patches. but when I do a stg pull the messages are:
> [...]
>> It seems StGIT is trying to merge the origin branch from remote to
>> RELENG_1 of local. Is there a way to get RELENG_1 of remote to merge
>> with MyBranch (clone of "RELENG_1") of local?
> 
> After StGIT pops all the patches, it just calls "git pull origin". My
> understanding of GIT is that this should update local RELENG_1 with
> the remote RELENG_1 from the "origin" repository. Anything wrong with
> my assumptions?
> 

Well that will update origin, and then merge the result with the current
branch.  That second part probabally isn't what you had in mind.
Normally you would git fetch origin to stop that happening, but that
also can't update the branch you are on.

Not sure if this helps.

-apw
