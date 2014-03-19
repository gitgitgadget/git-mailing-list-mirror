From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-rebase: Teach rebase "-" shorthand.
Date: Wed, 19 Mar 2014 12:02:01 -0700
Message-ID: <xmqqsiqe2es6.fsf@gitster.dls.corp.google.com>
References: <xmqq61nb8fap.fsf@gitster.dls.corp.google.com>
	<1395226935-53044-1-git-send-email-modocache@gmail.com>
	<xmqqob123wjm.fsf@gitster.dls.corp.google.com>
	<20140319180213.GB11018@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Tim Chase <git@tim.thechases.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:02:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQLkk-0001zS-JR
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 20:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbaCSTCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 15:02:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57731 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbaCSTCH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 15:02:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DB7375153;
	Wed, 19 Mar 2014 15:02:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tRmXROLO9/G2Qeu/4mcmYPGxh5o=; b=p5WuyS
	b7oGl2a8160447OygufVVQjJAIJgvL5ETHFnaozfnfw2ToMSPGsAmreyRVBe3udA
	mamOUD7x2u1buzTbkDFyVqKtxD0Q9ZHbiQxmMRtd0iRUK2g9JTIB6WHMkH//5FV/
	BVE3SrehA/86ODLFYMFMNtVOhiily79jsprMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eiciat45vgcoLESMAL9muvBNlH2T/AWA
	1rEx8Rn5l3LCoYKUFeRHXEUJY67ZCpI1twD8/B1dVNF/9gY95Iy/9DostHIKeh4I
	q7ANq8tUB6Qiv8RTbKqylMsnH70Qj1TNjIK1wZmCRBIicx6zYe+/1JOJ8lAFs8PF
	p/fhYp+biBI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E45E475150;
	Wed, 19 Mar 2014 15:02:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A92475149;
	Wed, 19 Mar 2014 15:02:04 -0400 (EDT)
In-Reply-To: <20140319180213.GB11018@serenity.lan> (John Keeping's message of
	"Wed, 19 Mar 2014 18:02:13 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F5D9464E-AF98-11E3-8058-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244478>

John Keeping <john@keeping.me.uk> writes:

> On Wed, Mar 19, 2014 at 10:53:01AM -0700, Junio C Hamano wrote:
>>    "rebase -" with your change still says something like this:
>> 
>>         First, rewinding head to replay your work on top of it...
>>         Fast-forwarded HEAD to @{-1}.
>> 
>>    instead of "Fast-forwarded HEAD to -".  Somebody may later want
>>    to "fix" this, making these two eye-candy output to be different
>>    from each other, and what your test expects will no longer hold
>>    (not that I think it is better to say "-" instead of @{-1}
>>    there).
>
> I don't think either of these is correct.  When using "-" with the
> commands that already support it, I have occasionally found that "-"
> isn't what I thought it was.
>
> Can we use `git name-rev` to put the actual name here, so that people
> who have not done what they intended can hopefully notice sooner?

That sounds like a right thing to do.  It however is totally
orthogonal to the change we are discussing, and should be done as a
separate patch.

Thanks.
