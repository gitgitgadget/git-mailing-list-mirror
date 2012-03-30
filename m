From: Daniel Pocock <daniel@pocock.com.au>
Subject: Re: git-svn: cloning an SVN repo with sub-branches and sub-tags
Date: Fri, 30 Mar 2012 13:22:09 +0100
Message-ID: <4F75A571.2020304@pocock.com.au>
References: <4F7467E1.3090004@pocock.com.au> <CALkWK0mn=vWexhYMNPV5iKf-hX5gTHYjOS4o+E1mFjUtL49hmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 14:28:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDawR-0001kr-TS
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 14:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543Ab2C3M21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 08:28:27 -0400
Received: from mail1.trendhosting.net ([195.8.117.5]:43111 "EHLO
	mail1.trendhosting.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872Ab2C3M20 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 08:28:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail1.trendhosting.net (Postfix) with ESMTP id 5A76615782;
	Fri, 30 Mar 2012 13:28:25 +0100 (BST)
Received: from mail1.trendhosting.net ([127.0.0.1])
	by localhost (thp003.trendhosting.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0gY4z-+8kZTD; Fri, 30 Mar 2012 13:28:19 +0100 (BST)
Received: from [192.168.5.2] (thp001.trendhosting.net [195.8.117.3])
	by mail1.trendhosting.net (Postfix) with ESMTP id B8C9015765;
	Fri, 30 Mar 2012 13:28:18 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.20) Gecko/20110804 Lightning/1.0b2 Thunderbird/3.1.12
In-Reply-To: <CALkWK0mn=vWexhYMNPV5iKf-hX5gTHYjOS4o+E1mFjUtL49hmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194352>

On 29/03/2012 16:32, Ramkumar Ramachandra wrote:
> Hi Daniel,
>
> Daniel Pocock wrote:
>> git svn clone \
>>   -T trunk \
>>   -t tags \
>>   -b branches \
>>   https://flactag.svn.sourceforge.net/svnroot/flactag \
>>   flactag-git1
>>
>> I don't get any of the branches or tags, and I get numerous warnings like
>> this:
>>
>> W: -empty_dir: branches/d_pocock/autotools/HTTPFetch.cc
>> W: -empty_dir: branches/d_pocock/autotools/HTTPFetch.h
>> W: Cannot find common ancestor between
>> f475b655c10b55b36df8376a396c0d9534418617 and
>> 7e277bfd626a1caa84681e93a7af73e0160eb2eb. Ignoring merge info.
>> W: Cannot find common ancestor between
>> f475b655c10b55b36df8376a396c0d9534418617 and
>> a82cd9bd2197a89303558af9aad43fa0c23d1ddb. Ignoring merge info.
>
> These look like genuine warnings; git-svn probably doesn't like your
> repository (nested branches/ tags, missing mergeinfo etc)
>
>> I have the impression that git-svn does not like the repository layout, and
>> it is not clear from the manual page how to make it work.  Can anyone share
>> any advice about this?
>
> Off the top of my head, you could try doing two things:
> 1. Try exporting the branches and tags by hand one-by-one.
> 2. You could try using reposurgeon [1] to fix the repository.
>
> [1]: http://esr.ibiblio.org/?p=4071


The flactag project is not something of a commercial nature, so we were 
really looking at quick solutions

One other factor I didn't mention in the original email, some of the 
branches have been renamed/moved within the SVN repo - is that a problem 
for git-svn?

One compromise I have thought about would be just extracting trunk, and 
forgetting about the branches, and manually tagging the official 
releases (as there were very few of them, this is quick)

However, based on the errors/warnings, is it possible that there is any 
corruption in the gitified version of trunk (or the history of trunk)?
