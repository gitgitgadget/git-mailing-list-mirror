From: david@lang.hm
Subject: Re: Performance impact of a large number of commits
Date: Fri, 24 Oct 2008 13:11:01 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0810241301430.27333@asgard.lang.hm>
References: <1224874946.7566.13.camel@localhost>  <alpine.DEB.1.10.0810241240100.27333@asgard.lang.hm> <1224878202.7566.25.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Samuel Abels <newsgroups@debain.org>
X-From: git-owner@vger.kernel.org Fri Oct 24 22:11:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtT0R-0006Ky-1o
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 22:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbYJXUKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 16:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752757AbYJXUKW
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 16:10:22 -0400
Received: from mail.lang.hm ([64.81.33.126]:34020 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273AbYJXUKW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 16:10:22 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m9OKAJ73020738;
	Fri, 24 Oct 2008 13:10:19 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <1224878202.7566.25.camel@localhost>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99061>

On Fri, 24 Oct 2008, Samuel Abels wrote:

> On Fri, 2008-10-24 at 12:43 -0700, david@lang.hm wrote:
>> 100,000 commits per day??
>>
>> that's 1.5 commits/second. what is updating files that quickly?
>
> This is an automated process taking snapshots of rapidly changing files
> containing statistical data. Unfortunately, our needs go beyond what a
> versioning file system has to offer, and the data is an unstructured
> text file (in other words, using a relational database is not a good
> option).
>
>> I suspect that you will have some issues here, but it's going to depend on
>> how many files get updated each 3/4 of a second.
>
> That would be 5 to 10 changed files per commit, and those are passed to
> git commit explicitly (i.e., walking the tree to stat files for finding
> changes is not necessary).

I suspect that your limits would be filesystem/OS limits more than git 
limits

at 5-10 files/commit you are going to be creating .5-1m files/day, even 
spread across 256 directories this is going to be a _lot_ of files.

packing this may help (depending on how much the files change), but with 
this many files the work of doing the packing would be expensive.

David Lang
