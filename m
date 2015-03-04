From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t5516-fetch-push: Correct misspelled pushInsteadOf
Date: Wed, 04 Mar 2015 11:10:14 +0100
Message-ID: <54F6DA06.7000602@drmicha.warpmail.net>
References: <alpine.DEB.2.10.1502282316150.7008@buzzword-bingo.mit.edu> <xmqq385nb2yg.fsf@gitster.dls.corp.google.com> <54F5D869.4010104@drmicha.warpmail.net> <xmqq8ufdc0c7.fsf@gitster.dls.corp.google.com> <54F6D20D.903@drmicha.warpmail.net> <alpine.DEB.2.10.1503040439100.60859@buzzword-bingo.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Anders Kaseorg <andersk@mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 04 11:10:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT6G2-0006ut-M6
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 11:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757897AbbCDKKU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2015 05:10:20 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49256 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755235AbbCDKKQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2015 05:10:16 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 1B82B20A02
	for <git@vger.kernel.org>; Wed,  4 Mar 2015 05:10:15 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 04 Mar 2015 05:10:16 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=0oUM1+lqco1rIkx3XVKh5W
	A24uU=; b=mL62DKeS9KiT7qAvpfOzavZ3JFoGdyIqzHH+UEzdnDyY9niv+2pI1+
	3pa+50PBVlOCjdOT9US4usWlqScYUBekL35E2mBNoBlcPjGOEJhX3kzcNQVl/zBx
	Hr0I16fCwfFYkf4+C69M5MuFMfmazXq8/ECgh1aR+GjcSxLz/JK/o=
X-Sasl-enc: wzK7xyagGUpdZeTYRY06L7Z+m6C0ftkvZPijuXWd49t7 1425463815
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 995BC680089;
	Wed,  4 Mar 2015 05:10:15 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <alpine.DEB.2.10.1503040439100.60859@buzzword-bingo.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264746>

Anders Kaseorg venit, vidit, dixit 04.03.2015 10:43:
> On Wed, 4 Mar 2015, Michael J Gruber wrote:
>> If there is no "pushurl":
>>   "url" will be used as the "URL for fetch" and as the "URL for push=
".
>>   if we are pushing and there is "pushinsteadof" for (part of) "url"
>>     subsitute that within "url"
>>   else if there is "insteadof" for (part of) "url"
>>     substitute that within "url"
>>
>> If there is a "pushurl":
>>   "url" will be used as the "URL for fetch" and "pushurl" as the "UR=
L for push".
>>   if we are pushing and there is "insteadof" for (part of) "pushurl"
>>     substitute that within "pushurl"
>>   else if we are fetching and there is "insteadof" for (part of) "ur=
l"
>>     substiute that within "url"
>=20
> Speaking of that, I recently had to reimplement most of this logic fo=
r the=20
> openstack git-review tool (https://review.openstack.org/160152), whic=
h is=20
> why I was staring too closely at t5516 in the first place.  It would =
be=20
> nice to have a =E2=80=98git ls-remote --get-push-url=E2=80=99 analogo=
us to the existing=20
> =E2=80=98git ls-remote --get-url=E2=80=99.
>=20
> Anders
>=20

And vice-versa, it would be nice if "git remote" explained where the
resulting URLs come from. I vaguely remember looking into this, but I
don't think it was simple.

ls-remote and remote don't share code, which is a pitty. GSOC...

Michael
