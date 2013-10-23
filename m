From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git grep: search whole tree by default?
Date: Wed, 23 Oct 2013 12:31:14 -0700
Message-ID: <xmqqk3h3pywt.fsf@gitster.dls.corp.google.com>
References: <CAA01CsqgNKdDAc9OL9zdk=3tnK9GAG=6w+wP_XSoiefBOgfzRQ@mail.gmail.com>
	<vpqbo2guff7.fsf@anie.imag.fr>
	<xmqqmwlzrjdh.fsf@gitster.dls.corp.google.com>
	<87hac7hmrb.fsf@mcs.anl.gov>
	<xmqqob6fq0q1.fsf@gitster.dls.corp.google.com>
	<87zjpzg592.fsf@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jed Brown <jed@59A2.org>
X-From: git-owner@vger.kernel.org Wed Oct 23 21:31:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ49M-00029G-Cv
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 21:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788Ab3JWTbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 15:31:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50810 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab3JWTbT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 15:31:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1254D4D82A;
	Wed, 23 Oct 2013 19:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=olYkxH46In/n5gcG4G0RADkQyYw=; b=eckWXW
	kfKjX/Fb6An1XiaAvcKdxIk+7kRVozy365LTwJJGPUm9BYBzRQ900bwKcezDgjhd
	7tAikn1JujMSrH04GRN8EThh1iVrTSoLHtqlw+gNDZHn3kXkU8RyqW8wZLnvCDTN
	U2Eh6rW0K+aVsrglU1gDQNakxIrW2moqj9Fmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V6si5WoMRjNLUimaXZ74gfzTVKZDCohG
	5/lAkln7B/wpTP+TION84nzR+cqlRvv5DKR0Us4QrGiQyLmShW/+CO5LmAyfu/v1
	9aB8k6BK6LpckxeZ9PWol9Ppmelo1buGStrC+kwVl9akTIMJCwA2vtl0f7ItpoUy
	woeo0ZyS2Ho=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECB494D828;
	Wed, 23 Oct 2013 19:31:18 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1384F4D820;
	Wed, 23 Oct 2013 19:31:16 +0000 (UTC)
In-Reply-To: <87zjpzg592.fsf@mcs.anl.gov> (Jed Brown's message of "Wed, 23 Oct
	2013 14:24:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B04D520C-3C19-11E3-99D5-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236551>

Jed Brown <jed@59A2.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jed Brown <jed@59A2.org> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>> I suspect that it would be too late for 2.0 we want to do sometime
>>>> early next year, though.
>>>
>>> How would you manage transition from the current behavior?  Warning
>>> people to explicitly use "." or ":/" during some interim period sounds
>>> worse than just switching the default behavior.
>>
>> "How would I"?
>>
>> You're asking that question only because you omitted too much from
>> the quote ;-)
>
> I meant that if the proposed migration plan were to be "just change it
> and people will learn" (because anything more gradual would actually be
> worse for users) then is it really too late for Git-2.0?

I do not know it that is even a workable plan, but I need to sleep
on it and then hear opinion from others, but in general, if anybody
needs to ask if it is too late, then it already is.
