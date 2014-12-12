From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/1] skip RFC1991 tests with gnupg 2.1.x
Date: Fri, 12 Dec 2014 17:00:41 +0100
Message-ID: <548B1129.80202@drmicha.warpmail.net>
References: <1418290234-21516-1-git-send-email-mail@eworm.de>	<5489B90B.6070706@web.de>	<5489CC60.7080704@drmicha.warpmail.net>	<20141211234405.3513d5d7@leda.localdomain>	<xmqqegs5dbqu.fsf@gitster.dls.corp.google.com>	<20141212093543.5175e7a5@leda.localdomain> <20141212105444.50adca35@leda.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Christian Hesse <mail@eworm.de>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 17:00:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzSe9-0003yb-1g
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 17:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933677AbaLLQAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 11:00:45 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47496 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757971AbaLLQAo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 11:00:44 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 883F4209F7
	for <git@vger.kernel.org>; Fri, 12 Dec 2014 11:00:43 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 12 Dec 2014 11:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=r6n/Bo6AVl6dvR5s9s63hW
	lUjMk=; b=j+mZElHCqBpxBZi1aykjN/d6295Ma2MlLF0YhHFXiesKxY7rZaDpLW
	/OiC035PqR3RWJK+S9UTukc0q++WhJLcwSfadDrwBzmdMqZN5tKTf67vecm4Iq6q
	MFATDGpgdcPaZlsbIDO4Yj5AlakPz9zg1a92yKw8Avdl06VxWeGh0=
X-Sasl-enc: MR8NMXfzCKjBPWhF1mumqtcGv2EvULjLGK+cK1OfgN3r 1418400043
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B2C16C00285;
	Fri, 12 Dec 2014 11:00:42 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <20141212105444.50adca35@leda.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261349>

Christian Hesse schrieb am 12.12.2014 um 10:54:
> Christian Hesse <mail@eworm.de> on Fri, 2014/12/12 09:35:
>> Junio C Hamano <gitster@pobox.com> on Thu, 2014/12/11 15:10:
>>> Christian Hesse <mail@eworm.de> writes:
>>>   
>>>> However... Even if GnuPG 2.2.x (or whatever future release) will become
>>>> next stable: It will not reintroduce support for rfc1991.  
>>>
>>> How certain are we about the deprecation?  
>>
>> The sixth beta of GnuPG [0] had this change:
>>
>>  * gpg: Removed the option --pgp2 and --rfc1991 and the ability to
>>    create PGP-2 compatible messages.
> 
> This is the corresponding commit:
> 
> http://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=commit;h=2b8d8369d59249b89526c18c5ac276e6445dc35e
> 

So, in fact, gpg2.1 removes support for creating pgp2 (rfc1991)
signatures only. That is: We could put an armor exported signature
into our test suite, test verification against that signature,
and restrict the test for creation of that signature by gpg version (or
skip it completely).

Michael
