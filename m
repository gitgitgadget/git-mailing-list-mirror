From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: --inline-single
Date: Thu, 21 Feb 2013 15:47:01 -0800
Message-ID: <7v38wptekq.fsf@alter.siamese.dyndns.org>
References: <1361282783-1413-1-git-send-email-git@adamspiers.org>
 <1361282783-1413-2-git-send-email-git@adamspiers.org>
 <7v1ucc6vgd.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
 <7v1ucc5b7n.fsf_-_@alter.siamese.dyndns.org>
 <20130220020046.GC7860@pacific.linksys.moosehall>
 <7vppzv3dd8.fsf@alter.siamese.dyndns.org>
 <20130220104720.GD7860@pacific.linksys.moosehall>
 <7vehg9v2xj.fsf@alter.siamese.dyndns.org>
 <7v4nh5v2fl.fsf_-_@alter.siamese.dyndns.org>
 <20130221231328.GA19808@sigill.intra.peff.net>
 <7v7gm1teuf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Adam Spiers <git@adamspiers.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 00:47:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8frP-0003li-BM
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 00:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340Ab3BUXrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 18:47:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34773 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754082Ab3BUXrE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 18:47:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC49AB9D6;
	Thu, 21 Feb 2013 18:47:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nm4fZKRYFEfuFICW1s+xvDV8JHM=; b=IaFDkD
	r9xDRR2JUZtZvuIiSvGtd5pfMCBlErQtRY/jEBtWG192mWVUGJSqlnNnUhkBwnv8
	NE/DCkRn+SVoq5jFBvVy8WAmNpY5zQy5oWM1+LFWvMV/QP4fHTRynt9agtFZTgeB
	UhX0JjOtjq1aqUsPsLLIbeRVLiEpCx7PnOu6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rGsuhr4R0RmW6kcYq7KKF605V7v9RJdz
	dFKZI3Aos0xz/3+s9xH0t6tuBZQS8D0K6HYrx0ciZ39Z9ugGX4p9UEhWwwlk/mfm
	0SNbN9EyYL8sMzCxHTW6ZlqvEvMLkKVoEinZizdrRfpEjT10mzleZyeW1YGAmMh/
	diTGJZzj+CA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C16B6B9D5;
	Thu, 21 Feb 2013 18:47:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BDB5B9D4; Thu, 21 Feb 2013
 18:47:03 -0500 (EST)
In-Reply-To: <7v7gm1teuf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 21 Feb 2013 15:41:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDE584DE-7C80-11E2-B5E3-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216811>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>> @@ -421,6 +443,9 @@ void pp_user_info(const struct pretty_print_context *pp,
>>>  	if (pp->mailmap)
>>>  		map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
>>>  
>>> +	if (pp->inline_single && is_current_user(pp, mailbuf, maillen, namebuf, namelen))
>>> +		return;
>>> +
>>>  	strbuf_init(&mail, 0);
>>>  	strbuf_init(&name, 0);
>>
>> This makes sense to suppress the user line when it is not necessary. But
>> we should probably always be suppressing the Date line, as it is almost
>> always useless.
>
> When I (figuratively) am sending my patch in a discussion, saying
> "You could do it this way", on the other hand, I agree that the date
> is uninteresting.

Just in case somebody is wondering, please s/, on the other hand//;
above.  I swapped the paragraphs after I wrote them X-<.
