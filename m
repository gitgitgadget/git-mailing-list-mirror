From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] Add git-unbundle - unpack objects and references for
 disconnected transfer
Date: Fri, 16 Feb 2007 18:21:30 -0500
Message-ID: <45D63C7A.4050300@verizon.net>
References: <28763990.2658921171630394111.JavaMail.root@vms064.mailsrvcs.net>
 <7vhctl50zc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 17 00:21:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HICOa-00073U-Js
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 00:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946277AbXBPXVg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 18:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbXBPXVg
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 18:21:36 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:52192 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbXBPXVf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 18:21:35 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDK00E6CWVT6GK0@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 16 Feb 2007 17:21:30 -0600 (CST)
In-reply-to: <7vhctl50zc.fsf@assigned-by-dhcp.cox.net>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39959>

Junio C Hamano wrote:
> Mark, how urgent do you want to have "bundle" in my tree?  As I
> understand it, this came out of your working zip based
> implementation your group already use, so I am suspecting that
> you do not have urgent need to have a different one in git.git
> in a half-baked shape.
>   
I can get my work done today with what I have. However, I really believe 
bundle is a good addition to git, and I don't want to maintain an 
out-of-tree patch to git to add this capability.
> Wouldn't it be nice if you can treat a bundle as just a
> different kind of git URL that you can "git fetch"?
>
> 	$ git fetch file.bdl 'refs/heads/*:refs/heads/*'
>   
yes
>
> Then git-ls-remote can be taught about a bundle file and use the
> 'git bundle --list-heads'.  Also, with something like this in
> your config:
>
> 	[remote "bundle"]
>         	url = /home/me/tmp/file.bdl
>                 fetch = refs/heads/*:refs/remotes/origin/*
>
> You can first sneakernet the bundle file to ~/tmp/file.bdl and
> then these commands:
>
> 	$ git ls-remote bundle
>         $ git fetch bundle
> 	$ git pull bundle
>
> would treat it as if it is talking with a remote side over the
> network.
>
> Hmm?
>
>   
As long as I can still do a "git fetch file.bdl" and without having to 
do the config stuff. I'm happy. Integrating this bundle with basic git 
approaches to things is obviously good. The frontend you outlined seems 
a trivial rearrangement of what I already have, but I'll let this 
discussion progress a bit further before I start doing that.

Mark
