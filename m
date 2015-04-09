From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] t/lib-httpd: load mod_unixd
Date: Thu, 09 Apr 2015 11:27:49 +0200
Message-ID: <55264615.2050107@drmicha.warpmail.net>
References: <cover.1428505184.git.git@drmicha.warpmail.net> <53b238530469330255d13209c2df4f11ef5b2edc.1428505184.git.git@drmicha.warpmail.net> <5525A208.6060807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 09 11:28:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yg8l4-0006IA-LB
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 11:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934505AbbDIJ17 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2015 05:27:59 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37701 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964890AbbDIJ1w (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2015 05:27:52 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 0B7DA20722
	for <git@vger.kernel.org>; Thu,  9 Apr 2015 05:27:47 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 09 Apr 2015 05:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=H34RSFqcxihuN7DYgTBgunPju2Q=; b=hZEl1R
	sbWS+2Rh2bWtgbuLydBawCqEW3ulBK6BETpb7/Ub073yGlarZ+fWxc6NcbVBcbbn
	PNIbLdshruWmOHTXHEEfC2L95BYHsUqzJhzuwK7N2UlPZTsSHTTbKiQxOgTBxxrK
	JAKIDhsXqRH5Olrm27+1VqoDkrFwuwkceUT3A=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=H34RSFqcxihuN7D
	YgTBgunPju2Q=; b=XPXFZL0nA8Kjr+nLLf5yV8WPx8esPs9zmSypvkdnctKbBaq
	8U5z7GZm9TxYc8msaBAY2tdy4fc5WCUs50OMV7OnG+9mZcGx5y80PuA3qEJYQi0Z
	hYebIrhA9HBPJaJFpQMiGFjJwV2bHU7puMxLZseLw/5pqqk1OczHTery5kPo=
X-Sasl-enc: y/BmMp3WH+ZnkVa6aZMmDFb4zqJA3clPNkk2fXlSHH7l 1428571670
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 82F72C00011;
	Thu,  9 Apr 2015 05:27:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <5525A208.6060807@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266987>

Torsten B=F6gershausen venit, vidit, dixit 08.04.2015 23:47:
> On 2015-04-08 17.05, Michael J Gruber wrote:
>> With the current config, apache 2.4.10 will not be started and the h=
ttpd
>> tests will not run.
>>
>> Enable mod_unixd to make the httpd tests run.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>
>> Notes:
>>     Basically, this is required since the switch from 2.2 to 2.4.
>>     I'm wondering whether noone is running these tests, or other
>>     distros (than Fedora) use different default configs.
> Do you have any special test numbers in mind  ?
> The following are running under Debian:
>=20
> *** t5541-http-push-smart.sh ***
> *** t5542-push-http-shallow.sh ***
> *** t5550-http-fetch-dumb.sh ***
> *** t5551-http-fetch-smart.sh ***
> *** t5560-http-backend-noserver.sh ***
>=20
> (Then I stopped digging)
>=20
> And this under Mac OS,=20
> *** t5541-http-push-smart.sh ***
> You do not seem to have gpg installed
> ok 1 - setup remote repository
> ....

Is this with apache 2.4?

In my case (apache 2.4, fedora 21), t/lib-http.sh failed to start the
web server, so the tests above would (succeed trivially but) not run.

Maybe debian is using an apache default config that has mod_unixd built
in, to ease the transition from apache 2.2? Many were bitten by these
new requirements after the switch to 2.4, and some distros may have
worked around that.

Do your tests run with this patch applied?

Michael
