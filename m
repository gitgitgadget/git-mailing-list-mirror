From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: need to create new repository initially seeded with several branches
Date: Wed, 31 Aug 2011 12:01:57 -0500
Message-ID: <XWAITZ7y0RejBGQezy-miO4ykUsgbNWA0mNtHRto22msjs3PP6WSZlN-pPueaz0duxAP6dCio3ZH2lna0K_g79NKdL0q7sJbzjj8sEKicYM@cipher.nrlssc.navy.mil>
References: <1314804325568-6746957.post@n2.nabble.com> <uvMkLVapQYcSvOHVhcHX8CqGzEDajPEPvBbkL_DctzZvxm7aI-PjCQ@cipher.nrlssc.navy.mil> <20110831165405.GB4356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "ryan@iridiumsuite.com" <ryan@iridiumsuite.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 31 19:02:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyoB2-0001EV-7v
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 19:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131Ab1HaRCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 13:02:07 -0400
Received: from mail3.nrlssc.navy.mil ([128.160.11.249]:54546 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117Ab1HaRCF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 13:02:05 -0400
Received: by mail3.nrlssc.navy.mil id p7VH1wW4022696; Wed, 31 Aug 2011 12:01:58 -0500
In-Reply-To: <20110831165405.GB4356@sigill.intra.peff.net>
X-OriginalArrivalTime: 31 Aug 2011 17:01:58.0177 (UTC) FILETIME=[B1A78910:01CC67FF]
X-Virus-Scanned: clamav-milter 0.97.2 at mail3
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180491>

On 08/31/2011 11:54 AM, Jeff King wrote:
> On Wed, Aug 31, 2011 at 11:14:48AM -0500, Brandon Casey wrote:
> 
>>    git checkout -b devel &&  # make a new branch named "devel"
>>                              # which has the same state as the
>>                              # currently checked out branch: "master"
>>                              # i.e. devel and master point to the
>>                              # same tip commit.
>>    rm -rf * &&               # remove the files in the working dir
>>    cp -a $devel_dir/* . &&   # cp devel source code to working dir
>>    git add -A . &&           # add new/removed files to the index
>>                              # to be committed on next 'git commit'
>>    git commit
>>    # use editor to give descriptive commit message
>>
>> Repeat for your topic branch based off of devel.
> 
> I am probably just going to confuse the original poster more, but here
> is how I would do it. It's slightly more efficient, as it doesn't
> involve removing and copying files for the intermediate states:
> 
>   # make a repo and switch to it
>   git init repo && cd repo
> 
>   # and now add everything from the "master" version, and
>   # make a commit out of it
>   GIT_WORK_TREE=/path/to/master git add -A
>   git commit
> 
>   # now make the devel branch and do the same
>   git checkout -b devel
>   GIT_WORK_TREE=/path/to/devel git add -A
>   git commit
> 
>   # and then check out the result in the working tree of
>   # your newly created repo
>   git checkout -f

Better.

-Brandon
