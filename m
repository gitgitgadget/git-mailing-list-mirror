From: Neil Macneale <mac4-git@theory.org>
Subject: Re: Stashing untracked files
Date: Sat, 29 Sep 2007 14:46:01 -0700
Message-ID: <46FEC799.30803@theory.org>
References: <46FE9924.7080006@theory.org> <Pine.LNX.4.64.0709292201400.28395@racer.site> <EEE8F630-AE62-4425-96A0-239D54724DF4@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 23:47:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibk9Q-000809-Kp
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 23:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbXI2VqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 17:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753520AbXI2VqG
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 17:46:06 -0400
Received: from bucky.theory.org ([64.147.163.245]:38849 "EHLO bucky.theory.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270AbXI2VqF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 17:46:05 -0400
Received: by bucky.theory.org (Postfix, from userid 8000)
	id C6BB9DB44; Sat, 29 Sep 2007 14:46:04 -0700 (PDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	bucky.theory.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.5 tests=AWL,BAYES_00,
	RCVD_IN_NJABL_DUL,RCVD_IN_PBL,RCVD_IN_SORBS_DUL autolearn=no 
	version=3.1.7-deb
Received: from [10.0.1.199] (71-35-171-1.tukw.qwest.net [71.35.171.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bucky.theory.org (Postfix) with ESMTP id 76DEE142C;
	Sat, 29 Sep 2007 14:46:01 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <EEE8F630-AE62-4425-96A0-239D54724DF4@lrde.epita.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59494>

Benoit SIGOURE wrote:
> On Sep 29, 2007, at 11:03 PM, Johannes Schindelin wrote:
> 
>> Hi,
>>
>> On Sat, 29 Sep 2007, Neil Macneale wrote:
>>
>>> When using "git stash," in some cases I'd like to stash away files that
>>> are currently untracked. It seems to me like there should be a way to
>>> stash everything in a working directory so that the end result is a
>>> pristine tree. Then applying the stash will reinstate those file as
>>> untracked.
>>
>> Funny how the same ideas always come in packs: I had the same discussions
>> a few nights ago on IRC.
>>
>> Here is why I think it is _wrong_ to stash untracked files: this would
>> include *.o and *.a, as well as all those binary files, too.
>>
>> Instead this is what you _should_ do:
>>
>> git add <the files that you care about>
>> git stash
> 
> You could stash untracked files that are not ignored (I personally 
> ignore *.o, *.a and the like).
> 
Yeah, I wouldn't want the ignored files. I'm interested in the files 
listed as untracked when I run git status.

Performing an add would require me to remove those file from the index 
at a later date in the event that I don't want to commit them on the 
next commit.

In the case I'm dealing with right now, I working on content files 
(html/perl). It's not uncommon for me to have files which are untracked 
and will remain that way for an extended period of time (a few commits, 
say). When I need to do a stash, I generally don't want those files 
around afterward.

( Here is the full story. I'm using git to make my life working with 
perforce a little less painful. It's not uncommon for me to jump to my 
master branch to do a perforce sync. When I do that, I want all of my 
changes in working branches stashed away. I selectively add new files on 
each commit so that what is committed to the working branch syncs up 
with what I end up submitting to perforce. And to make my life even more 
difficult, my co-workers are not using git. So it's not uncommon for 
someone to send me a file for my sandbox which I will never submit to 
perforce because it's their job to do so. I can't tell you how many 
times I've told them "this would be a lot easier if we all just used 
git" but I digress... )

Thanks,
Neil
