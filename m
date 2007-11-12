From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Local branch to remote branch translation
Date: Mon, 12 Nov 2007 07:25:41 +0100
Message-ID: <1310ED7B-9DA5-47EC-8523-F609A1866384@zib.de>
References: <9e4733910711110954m3ed3f9adtf19ca15dff61f0@mail.gmail.com> <9e4733910711111002x2f8cabf7yce263faf7b33bde1@mail.gmail.com> <A1B9CE91-15E0-4298-A606-68BB31541574@zib.de> <9e4733910711111136s20616468sd70b4bb19e7f3d0c@mail.gmail.com> <B5C127C0-04B8-4469-B6DD-C8B5335BBA88@zib.de> <9e4733910711111320u1deafe69r96d64babbb893adf@mail.gmail.com> <A7871D5B-9E05-4F9B-92AC-B74ECF35460B@zib.de> <9e4733910711111446u3e19be7ch90cf79f1d3efc3ef@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 07:24:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrSiy-0007pB-W7
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 07:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbXKLGY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 01:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbXKLGY1
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 01:24:27 -0500
Received: from mailer.zib.de ([130.73.108.11]:35591 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbXKLGY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 01:24:27 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAC6OOGl010898;
	Mon, 12 Nov 2007 07:24:24 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1060f.pool.einsundeins.de [77.177.6.15])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAC6ONlK013820
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 12 Nov 2007 07:24:23 +0100 (MET)
In-Reply-To: <9e4733910711111446u3e19be7ch90cf79f1d3efc3ef@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64563>


On Nov 11, 2007, at 11:46 PM, Jon Smirl wrote:

> On 11/11/07, Steffen Prohaska <prohaska@zib.de> wrote:
>>
>> On Nov 11, 2007, at 10:20 PM, Jon Smirl wrote:
>>
>>> On 11/11/07, Steffen Prohaska <prohaska@zib.de> wrote:
>>>>> jonsmirl@terra:~/mpc5200b$ git remote show linus
>>>>> * remote linus
>>>>>   URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/
>>>>> linux-2.6.git
>>>>>
>>>>> How do I push the definition of the linus remote repo?
>>>>
>>>> You can't. Remotes are local to a repository. They cannot be
>>>> "pushed" nor will they be "cloned" or "fetched".
>>>
>>> Dreamhost is way slow compared to kernel.org, so it is better to  
>>> clone
>>> from kernel.org first and then pull from dreamhost. What is the  
>>> right
>>> sequence of commands so that a new user will end up with a kernel  
>>> they
>>> can use 'git pull' on to get updates from dreamhost? I'll add  
>>> these to
>>> the repo description page.
>>>
>>> I'm trying this locally and I can't figure out the right sequence of
>>> git command to redirect origin from kernel.org to dreamhost.
>>
>> How about the following (untested sequence)
>>
>>         mkdir linux-2.6
>>         cd linux-2.6
>>         git init
>>         git remote add linus git://git.kernel.org/pub/scm/linux/ 
>> kernel/git/
>> torvalds/linux-2.6.git
>>         git remote add origin ssh://jonsmirl1@git.digispeaker.com/~/
>> mpc5200b.git
>>         git fetch linus
>>         git fetch origin
>>         git checkout -b master origin/master
>>
>> The general idea should be correct. You have a non-standard
>> setup, so avoid git-clone.
>
> What should I do to standardize the setup so that 'clone/pull' will
> work on it?

Pull should work after you checked out origin/master. Pull should
fetch from origin and merge to local master.

But I don't see a way how you could use clone for your setup.


> I created a master branch. I gave up on fighting with
> gitweb and no branch named master.

I don't understand your comment about gitweb.


> I'd like to do this, but I can't figure out how.
>
> git clone linus
> move origin to digispeaker
> git pull
>
> There doesn't seem to be a simple way to redirect the origin.

I don't know a simple way.

	Steffen
