From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git branch --contains x y" creates a branch instead of checking
 containment
Date: Thu, 21 Feb 2013 09:48:14 -0800
Message-ID: <7vr4k9v9r5.fsf@alter.siamese.dyndns.org>
References: <51261A6B.5020909@opera.com>
 <20130221155827.GA20640@sigill.intra.peff.net> <512645D1.4040607@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 18:48:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8aGD-0001SA-OO
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 18:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698Ab3BURsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 12:48:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57016 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756604Ab3BURsR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 12:48:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2F55AA69;
	Thu, 21 Feb 2013 12:48:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MMPfx86UFqgf/4hia4an6MP/rBs=; b=C3O0Z7
	hlZnMOdDhG8q+jF2zW3dEu0ZKicyYX0b0bYPdOdSsPbGWKj96+lh4opAN8vOdzia
	NRs7VvanjzAVJ7j8I+coPN/3Udz1QYD9mGObV8ZGgegatew1OCOSnAVuIe27ZJUf
	S0Tgp5zFGya0gK/eq+s0isj5EO+dac8VlKX6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xwVbXTMUNrnSoJ4pMkLC3vuQx7kL4pA7
	t+gWTX7Gjz5sG6QreWVheienhtqFkL9UspyU6IBI0dHHlAw8GdB9jHD5Abb2vLMe
	7m+9f20HaCU6kYXfayZjldLWz6vo7jAvrgIi+hq1pjq08dG/PiYQyiQsS+V+0a1o
	kAo/AkRTMSc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5096AA68;
	Thu, 21 Feb 2013 12:48:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 104FEAA5E; Thu, 21 Feb 2013
 12:48:15 -0500 (EST)
In-Reply-To: <512645D1.4040607@opera.com> (Per Cederqvist's message of "Thu,
 21 Feb 2013 17:05:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DEBE7822-7C4E-11E2-B48F-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216783>

Per Cederqvist <cederp@opera.com> writes:

> On 02/21/13 16:58, Jeff King wrote:
>> On Thu, Feb 21, 2013 at 02:00:27PM +0100, Per Cederqvist wrote:
>>
>>> That command does something completely different,
>>> though. The "--contains x" part is silently ignored,
>>> so it creates a branch named "y" pointing at HEAD.
>>>
>>> Tested in git 1.8.1.1 and 1.8.1.4.
>>>
>>> In my opinion, there are two ways to fix this:
>>>
>>>   - change the "git branch" implementation so
>>>     that --contains implies --list.
>>
>> I think that is the best option, too. In fact, I even wrote a patch. :)
>>
>> It's d040350 (branch: let branch filters imply --list, 2013-01-31), and
>> it's already in v1.8.2-rc0.
>>
>> -Peff
>
> Great! Thanks for the quick fix of my bug report. Negative response
> time... not bad. Not bad at all. :-)

Yeah, Jeff has a time machine ;-)
