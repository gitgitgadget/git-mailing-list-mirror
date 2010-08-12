From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 2/2] pull --rebase: Avoid spurious conflicts and
 reapplying unnecessary patches
Date: Thu, 12 Aug 2010 15:29:23 -0700
Message-ID: <7vhbizpirg.fsf@alter.siamese.dyndns.org>
References: <1281592569-740-1-git-send-email-newren@gmail.com>
 <1281592569-740-3-git-send-email-newren@gmail.com>
 <AANLkTimHiYUPyNTtT4SwapqN8YZGB1wjxJPwTTaPZhEa@mail.gmail.com>
 <AANLkTimoB=__-FmuFYa_rKqMjoYwWQS9hzziuk9Jseyx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	martinvz <martin.von.zweigbergk@gmail.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 00:29:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjgHN-0000dJ-MV
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 00:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934017Ab0HLW3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 18:29:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48246 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760958Ab0HLW3g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 18:29:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AB99CC591;
	Thu, 12 Aug 2010 18:29:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rTgoQhQNF0V2DJKuna+u1TPK/QA=; b=eiUP8m
	nBwYe0TGIqXp4gqSwBqwdkT/LnsADJyHLSKr8CCDydGf9XE/2D0Lv8IcNoaW+bCO
	lZs8PrGWI4GFN/zhKHBnD935lrHj0IANsZIkF3SflonjZMcZI/WQEV0ovkZBPRSo
	LMBvT4ho6rj+GMRirrOl1KUdqfM9UwuBIv/C0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YNdTOX7knRdeqxhdNQPhWqh56OIDGcH4
	WtPO25qQHS/+Dfm/CH3fPqRJaSAipH/PD9tofWXeA9RIxII/aACAhFUN5OPJCIfX
	IGZq3ZXPMH6bStnqGt7vmyA/KmB6wYFAb4WNR5Z7W3EUdx5DE2Wf6NMATM/sRNoU
	RpfJVxFycGw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB185CC58C;
	Thu, 12 Aug 2010 18:29:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B044FCC58A; Thu, 12 Aug
 2010 18:29:24 -0400 (EDT)
In-Reply-To: <AANLkTimoB=__-FmuFYa_rKqMjoYwWQS9hzziuk9Jseyx@mail.gmail.com>
 (Elijah Newren's message of "Thu\, 12 Aug 2010 14\:19\:55 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 13166A56-A661-11DF-9D13-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153434>

Elijah Newren <newren@gmail.com> writes:

>> Can you refer to commits with something like this?
>>
>> c85c792 (pull --rebase: be cleverer with rebased upstream branches, 2008-01-26)
>
> Sure, I'll start doing that.
>
>> You've moved all the lines after the call to "git fetch". It changes
>> the behavior when the reflog is not enabled, as the old value of
>> remoteref is lost.
>
> Doh.  That's what I get for trying to 'clean up' some code and put all
> the references to setting oldremoteref together.  I should have stuck
> with my original 7-line addition patch.  I'll resend the simplified
> patch.

Then I'll wait for the re-roll of 2/2 with updated message and
corrected code; thanks.
