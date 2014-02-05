From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] userdiff: update Ada patterns
Date: Wed, 05 Feb 2014 09:17:47 -0800
Message-ID: <xmqqk3d95vic.fsf@gitster.dls.corp.google.com>
References: <52EE234C.1060002@redneon.com>
	<20140202233531.GE16196@sigill.intra.peff.net>
	<52EF7E7C.3070504@redneon.com>
	<xmqqppn4dl0k.fsf@gitster.dls.corp.google.com>
	<52F2160D.1040006@redneon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Adrian Johnson <ajohnson@redneon.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 18:17:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB66k-0000Rg-Ei
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 18:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbaBERRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 12:17:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52976 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055AbaBERRu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 12:17:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C934F677F1;
	Wed,  5 Feb 2014 12:17:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b4CnShx94feYv/DBkWNKuJeQFoE=; b=uj+ypk
	CyHrOdgijkd5Carsy6xsW5ZmLO9fJiedkb4Fu/sKk93P6xMYAvttLBggYZOpZy+y
	rYCZYXtmCSwbRKq4E8MurTuts5oSciQfClWM5/1qRhKDu387Z2DIg9YnRUjR9RaJ
	hxLlNh8pbx4Um+b8ZQbznIYi3c9sWwGQHUlIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gtaTby9mn7PwMI+PwFx/61s+41WTY8Bl
	4apSUkZo2GEhEAQ7amXk5spFD7f0pVn2OzGIrwEsVPX69amlKp7ZHP/yX/pUQjyk
	IMpkR7gNW5HTJdxgVly/G2DKT01ERWFADynb45I4Ph1M5AlXciqgKGTmpVB0rQgm
	8LyEoup7JaA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA802677F0;
	Wed,  5 Feb 2014 12:17:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F29F5677ED;
	Wed,  5 Feb 2014 12:17:48 -0500 (EST)
In-Reply-To: <52F2160D.1040006@redneon.com> (Adrian Johnson's message of "Wed,
	05 Feb 2014 21:14:29 +1030")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6FE25380-8E89-11E3-9524-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241612>

Adrian Johnson <ajohnson@redneon.com> writes:

>>> -	 "|[0-9][-+0-9#_.eE]"
>>> +	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
>> 
>> This would match a lot wider than what I read you said you wanted to
>> match in your previous message.  Does "-04##4_3_2Ee-9" count as a
>> number, for example, or can we just ignore such syntactically
>> incorrect sequence?
>
> Maybe I am misunderstanding the purpose of the word diff regexes. I
> thought the purpose of the word regex is to split lines into words, not
> determine what is syntactically correct.

I agree that the purpose is former---So you could have just said
"the latter" ;-).

Any other nitpick, anybody?  Otherwise I'll queue this version.
