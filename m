From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Applying .gitattributes text/eol changes
Date: Thu, 13 Jan 2011 15:37:46 +0100
Message-ID: <4D2F0E3A.8090108@drmicha.warpmail.net>
References: <4D220500.2000104@syntevo.com> <4D2C4902.4010705@drmicha.warpmail.net> <4D2C62DF.20706@syntevo.com> <4D2EFCBD.4020402@drmicha.warpmail.net> <4D2F0BF3.2000808@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Thu Jan 13 15:40:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdOLn-0000ku-4Z
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 15:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756773Ab1AMOk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 09:40:26 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58469 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756656Ab1AMOkZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jan 2011 09:40:25 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 90FBE206DE;
	Thu, 13 Jan 2011 09:40:24 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 13 Jan 2011 09:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=+YfUCi38zWBfk4xUn75PoRGxNOU=; b=SSnhoWxPRvAHCY5gaNhbUOVBEZSEmookvv9dHQDpm8+1HwkXSJrfnfdKOGpd28SS/92UKPT749LUmVdvub6ObliSWOBykwl+C5OwxufV4MgAw+ZHR4HkXOKQrEt0qxWE2GGPd5HqEEe4qX81Gp0oOzbTWVAe7FzPoNMlW3wkykA=
X-Sasl-enc: iM9jHsCAc9w7CweamKTtDtLxVNGQWTlGXGAzHZpUnuTG 1294929624
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 16068400628;
	Thu, 13 Jan 2011 09:40:23 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <4D2F0BF3.2000808@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165054>

Marc Strapetz venit, vidit, dixit 13.01.2011 15:28:
>>> case of missing .git/index, Git freshly writes all working tree files,
>>> ignoring already existing files which already have the correct content.
>>> Maybe this behavior is by intention and makes sense in some cases. In my
>>> case it has adverse effects on IDEs and probably other tools which are
>>> monitoring the file system.
>>
>> ...but changing gitattributes is something you don't do routinely in
>> your workflow; so, at worst there would be an occasional unnecessary run
>> of your build process.
> 
> Our Git-SVN bridge does it, potentially on every pull. This is why we
> currently need to run "rm .git/index && git reset --hard" after every
> pull, resp. every checkout (switching to another commit may result in
> changed .gitattributes as well).

OK, now you're telling us what this is about ;)

> If a "git checkout" would (optionally) make sure that all EOLs are
> properly set according to .gitattributes, the problem would be resolved.
> As this might be not so easy to implement, my suggestion was to make
> "git reset --hard" work more unobtrusive. I think we can provide a
> corresponding patch, if it has chances to get accepted.

There have been other cases where git update-index --really-refresh
wasn't enough. You might want to check whether that is a suitable "patch
attack vector". This might be useful not only for you but also for others.

Michael
