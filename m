From: David Lang <david.lang@digitalinsight.com>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 15:36:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704031532390.21680@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org><db
 69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com><Pine.LNX.4.64.07
 04031304420.6730@woody.linux-foundation.org><Pine.LNX.4.64.0704031322490.67
 30@woody.linux-foundation.org><alpine.LFD.0.98.0704031657130.28181@xanadu.h
 ome><Pine.LNX.4.64.0704031413200.6730@woody.linux-foundation.org><alpine.LF
 D.0.98.0704031735470.28181@xanadu.home><Pine.LNX.4.64.0704031511580.6730@wo
 ody.linux-foundation.org> <alpine.LFD.0.98.0704031836350.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Lee <clee@kde.org>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 01:05:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYs41-0001u6-4D
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 01:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992461AbXDCXFM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 19:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992486AbXDCXFM
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 19:05:12 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:35509 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S2992461AbXDCXFK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 19:05:10 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 3 Apr 2007 16:05:09 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 03 Apr 2007 16:04:20 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <alpine.LFD.0.98.0704031836350.28181@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43692>

On Tue, 3 Apr 2007, Nicolas Pitre wrote:

> On Tue, 3 Apr 2007, Linus Torvalds wrote:
>
>> I don't care *what* it is conditional on, but your arguments suck. You
>> claim that it's not a normal case to already have the objects, when it
>> *is* a normal case for alternates, etc.
>>
>> I don't understand why you argue against hard numbers. You have none of
>> your own.
>
> Are hard numbers like 7% overhead (because right now that's all we have)
> really worth it against bad _perceptions_?

plus 1s overhead on what's otherwise a noop command.

> The keeping of fetched packs broke that presumption of trust towards
> local objects and it opened a real path for potential future attacks.
> Those attacks are still fairly theoretical of course.  But for how
> _long_?  Do we want GIT to be considered backdoor prone in a couple
> years from now just because we were obsessed by a 7% CPU overhead?
>
> I think we have much more to gain by playing it safe and being more
> secure and paranoid than trying to squeeze some CPU cycles out of an
> operation that is likely to ever be bounded by network speed for most
> people.

this is why -paranoid should be left on for network pulls, but having it on for 
the local uses means that the cost isn't hidden in the network limits isn't 
good.

David Lang
