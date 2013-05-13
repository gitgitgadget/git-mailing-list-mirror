From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 0/2] merge-base: add --merge-child option
Date: Mon, 13 May 2013 16:45:43 +0200
Message-ID: <5190FC97.6020800@drmicha.warpmail.net>
References: <cover.1368274689.git.john@keeping.me.uk> <518FB8DE.7070004@bracey.fi> <20130512162823.GK2299@serenity.lan> <20130512163317.GL2299@serenity.lan> <518FCDDE.9040707@bracey.fi> <7vwqr3u9c5.fsf@alter.siamese.dyndns.org> <5190F806.6040207@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon May 13 16:45:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubu0R-0001un-T1
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 16:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057Ab3EMOpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 10:45:36 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41560 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752555Ab3EMOpf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 May 2013 10:45:35 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 63C062082E;
	Mon, 13 May 2013 10:45:34 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 13 May 2013 10:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=gkZczFTzq2jp6JwzMxaz9y
	GUEVU=; b=tlX/0HBJIzCy/GrnbijhcZ1x3qsSGOOiYNywo3X1qogD0MpzZRmR4v
	ni73s9f4Zdbf7Bbm4EzYHtoTOMkeKQUJrqEFYSRez0+3sUZLkBDxPsNevbq87Dip
	kjf3GTqONaCS3ujVJqwAzk5J5tKtxVV3/bqL06Lx2QS/0Bgmlj5+8=
X-Sasl-enc: D20OyiY6gPoqyW3QKO9b79UT/3cGQxLo88VjwbxyG43L 1368456334
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3AA04C80007;
	Mon, 13 May 2013 10:45:33 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <5190F806.6040207@bracey.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224156>

Kevin Bracey venit, vidit, dixit 13.05.2013 16:26:
> On 13/05/2013 01:22, Junio C Hamano wrote:
>> Kevin Bracey <kevin@bracey.fi> writes:
>>
>>>     git log --ancestry-path --left-right E...F --not $(git merge-base
>>> --all E F)
>>>
>>> which looks like we're having to repeat ourselves because it's not
>>> paying attention...
>> You are half wrong; "--left-right" is about "do we show the </>/=
>> marker in the output?", so it is true that it does not make sense
>> without "...", but the reverse is not true: A...B does not and
>> should not imply --left-right.
>>
> The repetition I meant is that by the definition of ancestry-path, the 
> above would seem to be equivalent to
> 
>    git log --ancestry-path --left-right E F --not $(git merge-base --all E F) $(git merge-base --all E F)
> 
> Anyway, revised separated-out version of the patch follows.
> 
> Kevin

It is certainly true that "git log --cherry" needs much less information
than what the merge base machinery provides. I've been experimenting
with that in order to get the speedup which is necessary for replacing
the "git cherry" code with calls into the revision walker using "--cherry".

But I can't wrap my head around the feature proposed here, sorry.

Michael
