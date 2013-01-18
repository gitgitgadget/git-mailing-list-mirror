From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] CodingGuidelines: add Python code guidelines
Date: Fri, 18 Jan 2013 14:26:06 -0800
Message-ID: <7vwqvap1q9.fsf@alter.siamese.dyndns.org>
References: <20130118180639.GD31172@serenity.lan>
 <7vvcauqpn4.fsf@alter.siamese.dyndns.org>
 <20130118193501.GE31172@serenity.lan>
 <7vip6uqlvl.fsf@alter.siamese.dyndns.org>
 <20130118220552.GF31172@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Pete Wyckoff <pw@padd.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jan 18 23:26:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwKOM-00029h-Uu
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 23:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381Ab3ARW0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 17:26:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57852 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751881Ab3ARW0J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 17:26:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CFBBB691;
	Fri, 18 Jan 2013 17:26:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sRHtjWICFQp3+7h2rYjeu7t6dew=; b=PxlMVm
	qnq3lp/XkrTeRdQnmaNsiJ2+SpjUQsDZ9FmNlvHXFV1d5SenJkU8S0mECjBclOh6
	HAru8xNv/eM3DgKCfevXC0CZFiqF4tSs4e+PQKKojez15lGsNIdTgHVWipmd1Fh/
	UVlC/yHY/G/uUmG3Yzwdomw0R9Tsexc6p8fMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EUpfoQIfrCb/uV6WychqSQRRww1L/x9m
	VMIWQsnNKZpSrxuk518oPDPFBEWsDu2cj6CVlMsac0kqg9lFM5QG9o187AqtwIFt
	9ccoBXAqSjzLJQPjO+E9XG5Si1ySH65Nn+WtgzNo2tITNwGujfCVB3iMNgF/Q7wF
	Bl3OAQF/+kE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41C97B690;
	Fri, 18 Jan 2013 17:26:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1183B682; Fri, 18 Jan 2013
 17:26:07 -0500 (EST)
In-Reply-To: <20130118220552.GF31172@serenity.lan> (John Keeping's message of
 "Fri, 18 Jan 2013 22:05:52 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0DC92BE0-61BE-11E2-9A4A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213944>

John Keeping <john@keeping.me.uk> writes:

> On Fri, Jan 18, 2013 at 12:25:34PM -0800, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>>> As more people have started trying to support Python 3 in the wild, it
>>> has become clear that it is often easier to have a single codebase that
>>> works with both Python 2 and Python 3, and not use 2to3.
>>>
>>> It is for this reason that the Unicode literal prefix was reintroduced.
>> 
>> Yes, and from that perspective, placing floor on earlier 3.x makes
>> tons of sense, no?
>> 
>> These early versions may not be unstable in the "this does not
>> behave as specified in the language specification for 3.x" sense,
>> but for the purpose of running scripts meant to be executable by
>> both 2.x and 3.x series, the early 3.x versions are not as good as
>> later versions where Python folks started making deliberate effort
>> to support them.
>
> As far as I'm aware (and having reviewed the release notes for 3.1, 3.2
> and 3.3 as well as the planned features for 3.4), Unicode literals are
> the only feature to have been added that was intended to make it easier
> to support Python 2 and 3 in the same codebase.

So there may be some other incompatibility lurking that we may run
into later?

> Given that no code currently on pu uses Unicode literals, I don't see a
> reason to specify a minimum version of Python 3 since we're already
> restricting ourselves to features in 2.6.

OK, at least that reasoning need to be kept somewhere, either in the
documentation of in the log message.

Thanks.
