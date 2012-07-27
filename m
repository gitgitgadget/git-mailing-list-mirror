From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/5] test-lib: filesystem prerequisites
Date: Fri, 27 Jul 2012 11:31:49 +0200
Message-ID: <50126005.7060202@drmicha.warpmail.net>
References: <5001B82B.1060201@web.de> <cover.1343309173.git.git@drmicha.warpmail.net> <7vtxwu75gy.fsf@alter.siamese.dyndns.org> <20120726184337.GB16037@sigill.intra.peff.net> <7vzk6m5ln9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 11:32:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sugtv-0003VP-68
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 11:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889Ab2G0Jb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 05:31:57 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55758 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751813Ab2G0Jb4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jul 2012 05:31:56 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D98A22087F;
	Fri, 27 Jul 2012 05:31:55 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 27 Jul 2012 05:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=BbIYf5aMy5SHc7FvsR2Fwt
	d2Vac=; b=goP8tEeZrkEze5J05Er01oWyigDXqvU1OQYwvAmBJftUFN4KrVSkip
	3P0e4RGKClmvDOQjcTAWSe+PSUsW2AJZG0OxJhXrxuXXJutRPLTFgFY3QoTDSyh0
	NN2vm+Sv2ec/1Zh/1FGE30iET1x5xnBqLJwM0foXWAR+oYz6p8wlw=
X-Sasl-enc: pZFrULn/6Z0+Iz/J1WhgZMg0+5v0Ai3WD1LR/eLr6A74 1343381515
Received: from localhost.localdomain (unknown [79.199.77.140])
	by mail.messagingengine.com (Postfix) with ESMTPA id A665F482754;
	Fri, 27 Jul 2012 05:31:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <7vzk6m5ln9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202347>

Junio C Hamano venit, vidit, dixit 26.07.2012 22:10:
> Jeff King <peff@peff.net> writes:
> 
>> That looks like a maintenance annoyance. Can't we just have the
>> prerequisite-checker lazily perform the test on demand and cache the
>> result?  It should be OK as long as:
>>
>>   1. The prereq is careful about its pre- and post- conditions. We
>>      already make sure to clean up after those tests so as not to taint
>>      later tests. We would probably want to also make them more careful
>>      about preconditions like which directory they are in (so, for
>>      example, refer to "$TRASH_DIRECTORY/junk" and not "junk").
>>
>>   2. The prereq test does not accidentally munge any existing test
>>      state from previous tests. That should not be a big deal as long as
>>      we avoid names like "junk" in favor of more unique names like
>>      "check-case-sensitivity-prereq".
> 
> Yeah, it is very desirable if we could lazy-eval, and we _should_ be
> able to arrange the above.
> 

Yes, lazy-eval looks good and is probably easier than caching.

The adjustments to 1/5 and 4/5 look good.

5/5 needs a fix in the subject line, sorry. It should be:

t3910: use the UTF8_NFD_TO_NFC test prereq

(5/5 hasn't hit next)

Thanks,
Michael
