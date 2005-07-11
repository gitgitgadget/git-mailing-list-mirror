From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: Re: [PATCH 3/6] git-gnu-progs-Makefile: git Makefile update
Date: Mon, 11 Jul 2005 15:42:26 -0400
Message-ID: <42D2CBA2.8060705@yahoo.com>
References: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local> <20050711101454.10318.70399.sendpatchset@bryan-larsens-ibook-g4.local> <7vk6jxupxs.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507111206240.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, bryan.larsen@gmail.com,
	pasky@suse.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 21:46:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds4Dg-0007x6-FJ
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 21:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVGKTnE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 15:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbVGKTm7
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 15:42:59 -0400
Received: from smtp110.mail.sc5.yahoo.com ([66.163.170.8]:40835 "HELO
	smtp110.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262255AbVGKTm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 15:42:28 -0400
Received: (qmail 64865 invoked from network); 11 Jul 2005 19:42:28 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=b/3NytAuKPe7DxbYlM15XzJ0vYcfBPRHsRzjUe7FOx2Y9dT5mHzAJJLUTPq7d161w4KNisXURNTHPVryCJ8V/wKLYs7CLETrZ6+WX1wfHDcHhuwDPkSrXgOHrQd42aZIw2twnlygh7bPGl3JauQnm7s64EaXWIblA2IsN5owjBA=  ;
Received: from unknown (HELO ?192.168.2.80?) (bryanlarsen@69.159.204.165 with plain)
  by smtp110.mail.sc5.yahoo.com with SMTP; 11 Jul 2005 19:42:27 -0000
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507111206240.17536@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 11 Jul 2005, Junio C Hamano wrote:
> 
>>I am not yet convinced "one variable per GNU program" is the
>>right way to do (I do agree it is a problem and I appreciate
>>your trying to solving it; an obvious alternative cop-out would
>>be to fix this in the user's environment, but there might be a
>>saner solution)
> 
> 
> Yes. As you say, if we do this (and I think it's so ugly that I'm not
> convinced we want to), it should be done in git-sh-setup-script _once_
> instead of editing every single script.

Agreed: I was much happier with my cogito implementation where I just 
put it in cg-Xlib.  Is git-sh-setup-script appropriate?  At first glance 
it had a specific purpose and was not included in a large number of files.

> 
> Most everything includes git-sh-setup-script anyway by now.
> 
> However, what are the features that break the default apple tools anyway? 
> Maybe we should avoid using them? OSX clearly comes with "cp" and "xargs" 
> regardless, what are the flags that don't work with their cruddy versions?

xargs -r, cp -l, cp -u, cp -a.  Git uses the first 2, cogito uses all 4.

Last night, I couldn't think of alternatives to these, but I obviously 
didn't try very hard.  xargs -r can probably happen via a temporary file 
and cp -u can probably be simulated using rsync.

> 
> [ Rant mode on: ..and who the hell is the idiot at Apple who includes the
>   old crappy BSD stuff? They already use gcc, so it's totally pointless to
>   have a NIH thing, when the GNU utilities are just _better_. Maybe 
>   somebody can ask Apple to get with the program and not live in the dark 
>   ages any more. ]
> 

It wasn't long ago that the BSD's and Solaris had the same problems.  If 
only Apple is in the dark ages, shame on them.

Bryan
