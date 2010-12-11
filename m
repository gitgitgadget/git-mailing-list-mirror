From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 11/18] gitweb: add isDumbClient() check
Date: Fri, 10 Dec 2010 17:15:48 -0800
Message-ID: <4D02D0C4.2020207@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net> <4D01A5F3.8030108@eaglescrag.net> <7vzksd9nq2.fsf@alter.siamese.dyndns.org> <201012110115.16225.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 11 02:14:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRE2Y-0004Wg-Rt
	for gcvg-git-2@lo.gmane.org; Sat, 11 Dec 2010 02:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015Ab0LKBOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 20:14:05 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:44739 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab0LKBOE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 20:14:04 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oBB1Dw1t008965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Fri, 10 Dec 2010 17:13:59 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <201012110115.16225.jnareb@gmail.com>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Fri, 10 Dec 2010 17:14:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163454>

On 12/10/2010 04:15 PM, Jakub Narebski wrote:
> Junio C Hamano wrote:
>> "J.H." <warthog9@eaglescrag.net> writes:
>>
>>> My initial look indicated that perl-http-browserdetect wasn't available
>>> for RHEL / CentOS 5 - it is however available in EPEL.
>>>
>>> However there are a couple of things to note about User Agents at all:
>>> 	- They lie... a lot
>>> 	- Robots lie even more
>>>
>>> Blacklisting is still the better option, by a lot.  I'll re-work this
>>> some in v9, as I'm fine with the added dependency.
>>
>> Thanks, both.  I sense that we finally are going to get a single version
>> of gitweb that can be used at larger sites ;-)
> 
> I wouldn't be so optimistic.  While we borrow features and ideas from
> each other, the difference still remains that J.H. patches are bit hacky
> but are tested, while my rewrite is IMHO cleaner but untested (well, 
> untested on real life load).

At this point I'm not sure there is a way to rectify the two patch
series, and while we may borrow ideas from each other it's becoming
clear that we are both, generally speaking, heading in different
directions for what we want and need out of gitweb.  Jakub's patches for
the admin page are indicative of that.

> Anyway the main issue that was discovered by PATCHv6 by me, and v8 by J.H.
> is that die_error sucks... well, at least if background caching is enabled.

I'd agree with that, and as such I'm working on a complete re-work of
error handling in gitweb for v9.  Things are looking pretty good so far,
but to claim that it's a non-invasive patch would be akin to selling
someone the Brooklyn bridge.

That said, the way Gitweb handles it's errors and things like exit are
appalling and this has been something that's needed doing for a while
anyway.  Guess now's the time to do it.  Might be a few days for me to
get far enough for any of it to be worthwhile sharing, late next week
maybe.  That said I hit vacation starting on the 20th so it might be
next year before that is finalized.

- John 'Warthog9' Hawley
