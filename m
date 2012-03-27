From: Anjib Mulepati <anjibcs@hotmail.com>
Subject: Re: Definition of working directory
Date: Tue, 27 Mar 2012 17:26:23 -0400
Message-ID: <BLU0-SMTP4376CA011AD4D79C1BAB727B14A0@phx.gbl>
References: <BLU0-SMTP1958653CC391F120060F8B6B14A0@phx.gbl> <7vd37yj7h2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 23:26:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCduS-0008MK-RT
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 23:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594Ab2C0V02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 17:26:28 -0400
Received: from blu0-omc3-s9.blu0.hotmail.com ([65.55.116.84]:4407 "EHLO
	blu0-omc3-s9.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752680Ab2C0V01 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2012 17:26:27 -0400
Received: from BLU0-SMTP437 ([65.55.116.73]) by blu0-omc3-s9.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 27 Mar 2012 14:26:26 -0700
X-Originating-IP: [146.243.44.97]
X-Originating-Email: [anjibcs@hotmail.com]
Received: from [146.243.44.97] ([146.243.44.97]) by BLU0-SMTP437.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 27 Mar 2012 14:26:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:11.0) Gecko/20120312 Thunderbird/11.0
In-Reply-To: <7vd37yj7h2.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 27 Mar 2012 21:26:25.0824 (UTC) FILETIME=[43D81200:01CD0C60]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194088>

So if I have a project called MyProject and inside that I have two 
sub-directories dir1 and dir2. Does that mean working directory is 
*ALWAYS* MyProject.

Also if i create some file in dir1 and do git status without git add 
then it display untracked files as ../dir1/
It doesn't display the untracked file name but after I do git add when I 
did git status it does give me file under changes to be committed. Why 
didn't it shows file with name as untracked in first case?

On 3/27/2012 1:10 PM, Junio C Hamano wrote:
> Anjib Mulepati<anjibcs@hotmail.com>  writes:
>
>> I was reading Git Community Book and came across following definition
>> for working directory
>>
>> The Working Directory
>>
>> The Git 'working directory' is the directory that holds the current
>> checkout of the files you are working on. Files in this directory are
>> often removed or replaced by Git as you switch branches - this is
>> normal. All your history is stored in the Git Directory; the working
>> directory is simply a temporary checkout place where you can modify
>> the files until your next commit.
>>
>> What does it mean by this " Files in this directory are often removed
>> or replaced by Git as you switch branches"?
> I think the common terminology for the concept the above describes is "the
> working tree".
>
>> And does working directory is just a directory we get with $pwd ?
> After you clone, you have one directory that contains all the files from
> one specific version in it.  The files may be organized into directory
> hierarchy, but there is a single top-level directory.
>
> That is the "working tree".  When we want to be absolutely clear, we may
> even say "the top of the working tree", even though it may be redundant.
>
> If you are at such a directory, $(pwd) may match it.  If you chdir to a
> subdirectory from there, e.g. "cd Documentation", $(pwd) and the top of
> the working tree will of course disagree.
>
> The files checked out in the working tree represent the contents of the
> version that was checked out, plus modifications you make locally.  When
> you check out a different branch (people coming from svn background may
> say "switch branch", but it is the same thing), the working tree will need
> to represent the contents of the version at the tip of that different
> branch.  If you have a file in the current branch but not in that
> different branch you are checking out, that file has to go away.  If you
> do not have a file in the current branch but not in that different branch
> you are checking out, that file needs to be created in the working tree.
> If the contents of a file is different between your current branch and the
> branch you are checking out, the file in the working tree needs to be
> updated to match that of the branch you are checking out. That is what the
> "... are often removed or replaced" part is talking about.
>
>
>
>
