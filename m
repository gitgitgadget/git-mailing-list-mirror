From: David Lang <david@lang.hm>
Subject: Re: question about: Facebook makes Mercurial faster than Git
Date: Mon, 10 Mar 2014 03:13:45 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1403100310080.25193@nftneq.ynat.uz>
References: <531D8ED9.7040305@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Dennis Luehring <dl.soluz@gmx.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 11:14:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMxDc-0007ct-3D
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 11:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbaCJKNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 06:13:52 -0400
Received: from mail.lang.hm ([64.81.33.126]:42494 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011AbaCJKNu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 06:13:50 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id s2AADk7S032099;
	Mon, 10 Mar 2014 02:13:46 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <531D8ED9.7040305@gmx.net>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243724>

On Mon, 10 Mar 2014, Dennis Luehring wrote:

> according to these blog posts
>
> http://www.infoq.com/news/2014/01/facebook-scaling-hg
> https://code.facebook.com/posts/218678814984400/scaling-mercurial-at-facebook/
>
> mercurial "can" be faster then git
>
> but i don't found any reply from the git community if it is a real problem
> or if there a ongoing (maybe git 2.0) changes to compete better in this case

As I understand this, the biggest part of what happened is that Facebook made a 
tweak to mercurial so that when it needs to know what files have changed in 
their massive tree, their version asks their special storage array, while git 
would have to look at it through the filesystem interface (by doing stat calls 
on the directories and files to see if anything has changed)

In other words, unless you have a very high end storage system that can keep 
track of such things for you, the Facebook 'fix' won't help you. And even if it 
does have such a capability, unless you use the same storage system that 
Facebook uses, you would have to port it to your class of device.

Now, in addition to this, they did some other tweaks and changes, but compared 
to this status change, everything else is minor.

David Lang
