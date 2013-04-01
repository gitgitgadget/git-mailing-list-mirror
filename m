From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/6] Support triangular workflows
Date: Sun, 31 Mar 2013 22:35:05 -0700
Message-ID: <7vhajqlsom.fsf@alter.siamese.dyndns.org>
References: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
 <20130328153547.GA3337@sigill.intra.peff.net>
 <7vhajvv51f.fsf@alter.siamese.dyndns.org>
 <CALkWK0=+7ctiiYJSs3SQvV8aywT4tvwGLZ02KLozP8zjU-LQ2g@mail.gmail.com>
 <7vhajrnhco.fsf@alter.siamese.dyndns.org>
 <7vppyeltz7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 07:35:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMXPM-0001cB-UL
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 07:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757314Ab3DAFfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 01:35:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48696 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753446Ab3DAFfI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 01:35:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06016E73D;
	Mon,  1 Apr 2013 05:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TnVhl43UxzeZfVwEeIaclmzIHME=; b=Qk0giv
	QXKi8hhNSkz6+KRHY+zANYcyeJSHFEkP0zdIBk9Udum5pYDWQS82vy+cijZWrDxa
	2JmIeUZHJvYBt9MiHj6yyoOrqJyPVRxbW9Co+5vPkUJIDUppacObq+kPaHKzksoM
	OYT4zNs6W3gchnTLpiI1V4XxXuZ1SoRnow3BM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eCsCdQnsryxV0q/140tH3Pmm/mQ0PAeB
	KYpCt9svCBen1CUCAT6+b3gKElPx8nhr+OyxbmgnH68EftPWWojH00tz8wHcqOIt
	0hibmpaGUTdsmbLpxqZjlRNTWYKTtNBwgLe6st4Xa84QuuFvKAJe3cXHMD+J8MHs
	33mk0GvFtSg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDE9CE73B;
	Mon,  1 Apr 2013 05:35:07 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56228E73A; Mon,  1 Apr 2013
 05:35:07 +0000 (UTC)
In-Reply-To: <7vppyeltz7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 31 Mar 2013 22:07:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E9886DA0-9A8D-11E2-BA51-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219672>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>
>>> Junio C Hamano wrote:
>>>> Jeff King <peff@peff.net> writes:
>>>>> [...]
>>>> Thanks.  That is one of the reasons why we do not want to see too
>>>> many custom test helper functions.
>>>
>>> I noticed that you queued my original series without modification in
>>> rr/triangle.  Should I submit a re-roll with Peff's suggestion
>>> incorporated?
>>
>> If you want the topic to make progress, yes.
>
> By the way, this series seems to break a few tests in the test
> suite,...

I suspect this could be interaction with push-default change near
the tip of 'pu'.  Setting push.default explicitly to matching in the
test may be necessary.

Also the t5516 is involved in in-flight churns, so there could be
some merge mixups.
