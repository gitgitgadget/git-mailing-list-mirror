From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: can Git encrypt/decrypt .gpg on push/fetch?
Date: Fri, 09 Sep 2011 21:12:59 +0200
Message-ID: <4E6A653B.9090007@drmicha.warpmail.net>
References: <87lityxbg7.fsf@lifelogs.com> <CAGhXAGSw3y=cjAHXtwycDifoBPr13AkYtLHRRXejRKue0vkz7A@mail.gmail.com> <4E6A165D.5010703@drmicha.warpmail.net> <20110909184229.GE28480@sigill.intra.peff.net> <7vvct1tu3n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Aneesh Bhasin <contact.aneesh@gmail.com>, tzz@lifelogs.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 21:13:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R26Vp-0002vH-UP
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 21:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759865Ab1IITNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 15:13:07 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:36169 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759859Ab1IITNC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 15:13:02 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 60FB928751;
	Fri,  9 Sep 2011 15:13:02 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 09 Sep 2011 15:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=K0QKU1Pec6yzhPiWp+6tlx
	xC4fo=; b=Dg5qlDGA/SEb+dBKFgbMQSvnIDI2aR2CNJoeDIUj3Il92ObEPKgfJW
	f1w+W6vOcxPoTzA1HXpfD6D2joMv6LndKGg/fkuiNI+niY0xJW/9C9c5ByNFZM+U
	qrxluBdlHuPhlfr5BqpOHBFmmFTDJjF2GsH7RQlLYU7XaJCZskaD8=
X-Sasl-enc: 0OtNbr6bvonO2YmiFshtOqxjSbeKyufVyjpMhFaUfkRR 1315595582
Received: from localhost.localdomain (p548594B4.dip0.t-ipconnect.de [84.133.148.180])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F02B578041E;
	Fri,  9 Sep 2011 15:13:00 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7vvct1tu3n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181109>

Junio C Hamano venit, vidit, dixit 09.09.2011 21:05:
> Jeff King <peff@peff.net> writes:
> 
>>> B) Keep blobs encrypted, checkout decrypted
>>> - Use Use "*.gpg filter=gpg" in your attributes and
>>> [filter "gpg"]
>>> 	smudge = gpg -d
>>> 	clean = gpg -e -r yourgpgkey
>>>   in your config.
>>>
>>> I use A on a regular basis. B is untested (but patterned after a similar
>>> gzip filter I use). You may or may not have better results with "gpg -ea".
>>
>> Yeah, I think that would work but have never tried it either.
> 
> Unless "gpg -e" encrypts the same cleartext into the same cyphertext every
> time, the above "clean" filter probably wouldn't be very useful.
> 

Uh, right, this would only make sense with specific versions of debian's
openssl then. Only that gpg does not use that ;)

I'm not sure whether "gpg --symmetric" has the same issue, but version
A) seemed better before that already.

Michael
