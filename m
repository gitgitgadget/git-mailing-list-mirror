From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: t3306 failure with v1.7.5-rc1
Date: Fri, 08 Apr 2011 09:13:01 +0200
Message-ID: <4D9EB57D.1060402@drmicha.warpmail.net>
References: <4D9ECF7C.6010709@drmicha.warpmail.net> <4D9EB406.5080302@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Apr 08 09:13:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q85sU-0003jN-MB
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 09:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027Ab1DHHNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 03:13:05 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57870 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754773Ab1DHHNE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 03:13:04 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1EFEA208B8;
	Fri,  8 Apr 2011 03:13:03 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 08 Apr 2011 03:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=zw4moJ+3pylC+wYTTxZWFgeVpSk=; b=DXVW4OdARVgkl+68R0Q+ZAOrs2K+XXGaDsFJ+n3e6cL+qQYLjzfofHtpKJnQIWWGW/MJeIrnromDstwphbgNlYweDhcYmsoewZLR9L7qYI5eYFr26A5rQoHbWux9cUFBb9A1ZunfMXa/FJETKn3Hu25Bo0HxM6sjFe0SVs32nGQ=
X-Sasl-enc: M/A2qXCOMV5ayZ9eZBkWW1WmqExpsM9kERnQ+k5Opdog 1302246782
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 889F8408711;
	Fri,  8 Apr 2011 03:13:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <4D9EB406.5080302@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171112>

Johannes Sixt venit, vidit, dixit 08.04.2011 09:06:
> Am 4/8/2011 11:03, schrieb Michael J Gruber:
>> I get this stupid test failure in test 3 of t3306. The problem is that a
>> dangling commit does not get pruned away when it should:
>>
>> 3rd
>> test_must_fail: command succeeded: git cat-file -p
>> 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29
>> not ok - 4 verify that commits are gone
>>
>> It's a system where make complains about funny clock (I dunno why) but
>> can we make this more robust? The following helps with "sleep 5" but not
>> with "sleep 4". test_tick does not help. What's going on?
> 
> Looking at the time of day of your last emails (it's ~2 hours in the
> future), I'd say something is fishy with your system's clock. Fix that first.

Well, while you're right about that, an offset should not matter for the
test, right?

About my clock: The result of booting a "different" system on that
box... (In this case even a kubuntu using hw clock in tz...). thanks for
pointing it out!

In any case, that test was on a different box with clean checkout and
make clean. I don't think anyone jumped the clock right in between each
of my 20 or so test runs.

Michael
