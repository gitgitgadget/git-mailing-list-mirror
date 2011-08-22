From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git svn --stdlayout 's little quirk.
Date: Mon, 22 Aug 2011 17:28:30 +0200
Message-ID: <4E52759E.3020005@drmicha.warpmail.net>
References: <1314025898.45043.YahooMailClassic@web29503.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, madduck@madduck.net,
	git@vger.kernel.org
To: htl10@users.sourceforge.net
X-From: git-owner@vger.kernel.org Mon Aug 22 17:28:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvWQa-0001cG-UA
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 17:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233Ab1HVP2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 11:28:36 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:55531 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752598Ab1HVP2d (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Aug 2011 11:28:33 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8AB32202BB;
	Mon, 22 Aug 2011 11:28:32 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 22 Aug 2011 11:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=1IfAX75vQFiy/+cA0UXVo8
	WqzzE=; b=Hl20FSPz+VZBY6ala0C0S8XXqMbR2WhEHIRYE3n4+EMCdOOFVCENiV
	VA0Wamrg343o2B0cKFlFEJaXMkwjPOcsql0wKBqU7OvFF2din485rIbAcG/Y+VAy
	OMXaEQ3XHrbF8YgmYb2LI4urE1IT1k4E0Bg69NcOugiU5qfuZTMxc=
X-Sasl-enc: dI/c2kI436zwGBly3OzC5VPeg7645AIYfgdFNiB6+Xjx 1314026912
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C36C8860E16;
	Mon, 22 Aug 2011 11:28:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <1314025898.45043.YahooMailClassic@web29503.mail.ird.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179867>

Hin-Tak Leung venit, vidit, dixit 22.08.2011 17:11:
> --- On Mon, 22/8/11, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> 
>> Hin-Tak Leung venit, vidit, dixit
>> 21.08.2011 11:38:
>>> --- On Sat, 20/8/11, Eric Wong <normalperson@yhbt.net>
>> wrote:
>>>
>>>>> I think I found a small bug in git 1.7.6.
>> Having
>>>> "trunk" at the end of
>>>>> the url in combination of --stdlayout is
>> wrong, but it
>>>> looks like that
>>>>> git-svn tries to cope, but doesn't go try far
>> enough:
>>>>>
>>>>> Doing this:
>>>>> ----------------
>>>>> git svn clone --stdlayout http://quick-settings.googlecode.com/svn/trunk/
>>>> android-quick-settings
>>>>
>>>> --stdlayout expects the "root" path of the code
>> you're
>>>> interested
>>>> in (not necessarily the SVN repository root, but
>> in this
>>>> case they
>>>> could be the same).
>>>>
>>>> Try the following instead:
>>>>
>>>> git svn clone --stdlayout \
>>>>    http://quick-settings.googlecode.com/svn
>>>> android-quick-settings
>>>
>>> I know this is the correct way - what I meant was
>> that, having "trunk" at the end is wrong but git-svn appears
>> to try to correct it automatically, but haven't quite
>> succceeded.
>>
>> It is not trying to do that at all. git-svn is trying to
>> figure out what
>> the "base path" is in an svn repo which possibly hosts
>> multiple repos,
>> and that is what the message reports.
> 
> Okay... thanks for clarifying that. Maybe it could try to be clever? Afterall, --stdlayout isn't compatible with a URL ending in "trunk" (or having 'trunk' as part of the URL). Just a suggestion.

You *could* have this layout:

foo/trunk/trunk
foo/trunk/tags/v1
foo/trunk/tags/v2

That's a perfectly valid layout. The fact that it is stupidly named
should not activate git-svn magic.

Michael
