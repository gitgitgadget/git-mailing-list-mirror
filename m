From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Local branch to remote branch translation
Date: Sun, 11 Nov 2007 23:01:44 +0100
Message-ID: <A7871D5B-9E05-4F9B-92AC-B74ECF35460B@zib.de>
References: <9e4733910711110954m3ed3f9adtf19ca15dff61f0@mail.gmail.com> <9e4733910711111002x2f8cabf7yce263faf7b33bde1@mail.gmail.com> <A1B9CE91-15E0-4298-A606-68BB31541574@zib.de> <9e4733910711111136s20616468sd70b4bb19e7f3d0c@mail.gmail.com> <B5C127C0-04B8-4469-B6DD-C8B5335BBA88@zib.de> <9e4733910711111320u1deafe69r96d64babbb893adf@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 23:01:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrKrG-0004o5-SV
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 23:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683AbXKKWAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 17:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754627AbXKKWAa
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 17:00:30 -0500
Received: from mailer.zib.de ([130.73.108.11]:65039 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754565AbXKKWAa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 17:00:30 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lABM0RBh001319;
	Sun, 11 Nov 2007 23:00:27 +0100 (CET)
Received: from [192.168.178.21] (brln-4db82006.pool.einsundeins.de [77.184.32.6])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lABM0Qgp021980
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 11 Nov 2007 23:00:27 +0100 (MET)
In-Reply-To: <9e4733910711111320u1deafe69r96d64babbb893adf@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64522>


On Nov 11, 2007, at 10:20 PM, Jon Smirl wrote:

> On 11/11/07, Steffen Prohaska <prohaska@zib.de> wrote:
>>> jonsmirl@terra:~/mpc5200b$ git remote show linus
>>> * remote linus
>>>   URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/
>>> linux-2.6.git
>>>
>>> How do I push the definition of the linus remote repo?
>>
>> You can't. Remotes are local to a repository. They cannot be
>> "pushed" nor will they be "cloned" or "fetched".
>
> Dreamhost is way slow compared to kernel.org, so it is better to clone
> from kernel.org first and then pull from dreamhost. What is the right
> sequence of commands so that a new user will end up with a kernel they
> can use 'git pull' on to get updates from dreamhost? I'll add these to
> the repo description page.
>
> I'm trying this locally and I can't figure out the right sequence of
> git command to redirect origin from kernel.org to dreamhost.

How about the following (untested sequence)

	mkdir linux-2.6
	cd linux-2.6
	git init
	git remote add linus git://git.kernel.org/pub/scm/linux/kernel/git/ 
torvalds/linux-2.6.git
	git remote add origin ssh://jonsmirl1@git.digispeaker.com/~/ 
mpc5200b.git
	git fetch linus
	git fetch origin
	git checkout -b master origin/master

The general idea should be correct. You have a non-standard
setup, so avoid git-clone.

	Steffen
