From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: support git+mosh for unreliable connections
Date: Thu, 16 Apr 2015 11:29:42 +0200
Message-ID: <552F8106.2060806@drmicha.warpmail.net>
References: <552E628C.7040809@debian.org> <552E6D07.5030903@drmicha.warpmail.net> <552E732E.20107@debian.org> <0cf0485caae569a71a8bd1aa8d1033cb@www.dscho.org> <20150415153317.GA21768@tsaunders-iceball.corp.tor1.mozilla.com> <31749ad9ba57ada7f9c553191ffaddb3@www.dscho.org> <20150415185907.GC21768@tsaunders-iceball.corp.tor1.mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Trevor Saunders <tbsaunde@tbsaunde.org>,
	Pirate Praveen <praveen@debian.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, git-owner@vger.kernel.org
To: Trevor Saunders <tbsaunde+mozilla@tbsaunde.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 16 11:29:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yig7L-0006jK-Bu
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 11:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbbDPJ3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 05:29:48 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36806 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753555AbbDPJ3p (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Apr 2015 05:29:45 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 965F920909
	for <git@vger.kernel.org>; Thu, 16 Apr 2015 05:29:44 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 16 Apr 2015 05:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=0kDeRaDBRPjHXSLjT7Dl0BKfjC4=; b=VMnhgW
	jFauUH+DuuSa56gtBssp21RHOoybZ+NnH/02/puyxXYdE4+2o4ktorllbHG+t8bK
	zcLzBxjPREd/DxblPGT7K4TBPPXnqCNzr2MLXNn2m9lvJrloqLFYr119i39tcbLB
	ZqrBDxEmmSz7v81ANff3zbXe+b49SnE82FIWo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=0kDeRaDBRPjHXSL
	jT7Dl0BKfjC4=; b=FgyXsPUJ4LWs7quX+RlnIW4wVGvt9infVmGV3taZw8Q55sM
	YHuZell5csW6C5w8X/SdE9oM/KOQg/jaLs+uLMuFv3ZHlyv142DRPTGGuye001E0
	1wh1g6beOqKbKKkIZHoz3Mu1gVDiXRNKEh8bPlHVBImKMDZ9CMdic/htiUdQ=
X-Sasl-enc: MeXDOwOGYzfHmP4Hh8Phi/CxakOcw2IuaYyT+7YVt/J5 1429176584
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 92F5E680113;
	Thu, 16 Apr 2015 05:29:43 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150415185907.GC21768@tsaunders-iceball.corp.tor1.mozilla.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267272>

Trevor Saunders venit, vidit, dixit 15.04.2015 20:59:
> On Wed, Apr 15, 2015 at 07:46:15PM +0200, Johannes Schindelin wrote:
>> Hi Trevor,
>>
>> On 2015-04-15 17:33, Trevor Saunders wrote:
>>> On Wed, Apr 15, 2015 at 04:41:42PM +0200, Johannes Schindelin wrote:
>>>>
>>>> On 2015-04-15 16:18, Pirate Praveen wrote:
>>>>> On Wednesday 15 April 2015 07:22 PM, Michael J Gruber wrote:
>>>>>> What would that require git to do, beyond taking whatever you tell it
>>>>>> (using GIT_SSH or _GIT_SSH_COMMAND) to use as a drop in replacement for ssh?
>>>>>
>>>>> May be support git+mosh as a protocol, since it is not a drop in
>>>>> replacement. It is redesigned remote shell. The ideas it uses for
>>>>> session resumption needs to be reimplemented. This will need support
>>>>> from git, because it needs server side to be modified. Use SSP to return
>>>>> the the current progress for a particular session (it uses AES session ids).
>>>>
>>>> It will need support from Git alright, but not as much as from mosh, see my other reply: Mosh was not designed for non-interactive use. That support would have to be added before we can go any further.
>>>
>>> is that really relevent? mosh doesn't support things like X forwarding
>>> or port forwarding, but it certainly does support ssh <host> <command>
>>> and then doing IO.
>>
>> Ah, so mosh's README lied to me!
> 
> I wouldn't say it lied, its just not really clear what is "interactive"
> I'd say git's use of ssh is kind of interactive compared to things like
> port forwarding.
> 
>> If `mosh <user>@<host> <command>` works, then a simple `GIT_SSH=mosh` should work out of the box, too. Have you tried it?
> 
> it does work, I just tried mosh $host cat and then typing stuff and
> having it printed back at me.  However it clears the terminal before
> hand and prints a message on exit.  I tried GIT_SSH=mosh git clone and
> it failed, but I haven't really dug into why.  SO I suspect this can be
> made to work with some work on the mosh side, but I'm not sure exactly
> how ssh and mosh are behaving differently here.
> 
> Trev

First thing you see on mosh.mit.edu:

"Mosh is a replacement for SSH."

I guess that needs a footnote...

Michael
