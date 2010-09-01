From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make sure show_all_errors when using porcelain error
 messages
Date: Wed, 01 Sep 2010 10:54:33 -0700
Message-ID: <7vfwxt5oyu.fsf@alter.siamese.dyndns.org>
References: <vpqeide0zkx.fsf@bauges.imag.fr>
 <1283321153-24745-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vsk1t7bn2.fsf@alter.siamese.dyndns.org> <vpq39ttxumz.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 01 19:54:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqrWU-0002Sz-2E
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 19:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075Ab0IARyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 13:54:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861Ab0IARym (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 13:54:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 79D65D28A2;
	Wed,  1 Sep 2010 13:54:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=27FpG4+1HmH3++GF4wTsq6TGFck=; b=s/m3Si
	+m95z/DqUnDMKPOog+qt74fwhCR3qpjnhEOxDCQsQsPAB7AEzvMv/NPOjcotZ66F
	kabTS42q5+pbc0bMdPYWp7B69WW/drTA2239vR/cWG4sKz7mb4DCvgrfIVO073cs
	2an39vKoG9gfMLoIdQIyRvFcd5MYxSHycGeqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ogM5koBcgEMUhXtxaG2fO34t+hmWVKav
	ETNBLrmE8IiUsDtIYjteaUR9K2x3SLt48Et8NRfQmkstrwrnuYnJ0xZN20E+LvYm
	mVGRnHuq9P/jRmKjuDYV3jOEHXPLA7T2qF7HZAX+OOzRoxcs0ZSHE5q1i8hGgas9
	LSLPIrCbqyg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 54FB1D289F;
	Wed,  1 Sep 2010 13:54:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C0F4D289C; Wed,  1 Sep
 2010 13:54:35 -0400 (EDT)
In-Reply-To: <vpq39ttxumz.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed\, 01 Sep 2010 19\:04\:36 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FDBD4256-B5F1-11DF-8AAB-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155067>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>
>>> opts.show_all_errors controls the number of errors that can be displayed,
>>> and set_porcelain_error_msgs gives the format. But the formatting would
>>> be incorrect if set_porcelain_error_msgs is called without setting
>>> opts.show_all_errors.
>>
>> That makes it sound like a design bug of set_porcelain_error_msgs(), in
>> that the caller _cannot_ choose to stop at the first error if it wants to
>> use friendlier message than the plumbing one.
>
> You're right that the caller cannot stop at the first error and get
> friendly message, but I don't think this is a bug.

I am not saying it is a bug.  The description makes it sound like it is a
bug and I was wondering if it can be worded better not to do so.
