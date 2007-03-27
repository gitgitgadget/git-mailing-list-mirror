From: David Lang <david.lang@digitalinsight.com>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 12:54:02 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0703271245580.15345@qynat.qvtvafvgr.pbz>
References: <1174825838.12540.5.camel@localhost> 
 <20070326220302.GH22773@admingilde.org><7vfy7rvct2.fsf@assigned-by-dhcp.cox
 .net>  <200703270117.59205.Josef.Weidendorfer@gmx.de><Pine.LNX.4.64.0703270952020.
 6730@woody.linux-foundation.org><Pine.LNX.4.64.0703271338210.6485@iabervon.
 org><Pine.LNX.4.64.0703271115580.6730@woody.linux-foundation.org><Pine.LNX.
 4.64.0703271602110.6485@iabervon.org> <Pine.LNX.4.64.0703271409070.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 23:21:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWJ6G-0005tJ-W2
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 23:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965441AbXC0VVA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 17:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965445AbXC0VVA
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 17:21:00 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:53193 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S965441AbXC0VU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 17:20:59 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 27 Mar 2007 13:20:58 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 27 Mar 2007 14:20:26 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.64.0703271409070.6730@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43307>

On Tue, 27 Mar 2007, Linus Torvalds wrote:

> On Tue, 27 Mar 2007, Daniel Barkalow wrote:
>>
>> Are you talking about submodule history, or submodule state? If they care
>> about any state but not the corresponding history, they need to do a
>> shallow clone of the subproject, right?
>
> I don't see what the confusion is about.
>
> Why would you want a shallow clone, and what does that have to do with
> submodules?
>
> I'm saying that the *normal* case is that of the thousands of submodules,
> you generally care about one or two (the ones you work on).
>
> Those modules you want full history for. The supermodule you want because
> it contains the build infrastructure. You'd generally want full history
> for that too.

if you are working on the submodule then you are correct.

however if you are working on the supermodule it's a different story.

if I'm working on the 'ubuntu superproject' it would be nice to be able to find 
what is different between the 'Jan 2007' and 'April 2007' versions. one could 
have the 2.6.19 kernel and the other would have 2.6.20. I don't care about all 
the individual changes between these two states of the kernel, but I need to be 
able to compile either one as part of my testing. If I bisect the in the 
superproject to the commit that updated the kernel, then I would consider 
getting the 'kernel subproject' history to be able to bisect the bug further (or 
I may just report it to the kernel maintainers for them to check.

> There's absolutely zero reason to think shallow clones have *anything* to
> do with this. It's a totally separate dimension. Sure, you could use
> shallow clones *too*, but it has nothing to do with subprojects.

they are seperate, but if you need to compile the superproject you either need 
to get the full history of every subproject, or you need shallow clones (or some 
third approach).

David Lang
