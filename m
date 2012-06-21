From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: start warning upcoming default change for
 push.default
Date: Thu, 21 Jun 2012 10:46:56 -0700
Message-ID: <7v62aksgkv.fsf@alter.siamese.dyndns.org>
References: <7vbokeyie3.fsf@alter.siamese.dyndns.org>
 <1340195750-846-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vehp9x3yz.fsf@alter.siamese.dyndns.org> <vpqpq8t96zw.fsf@bauges.imag.fr>
 <7va9zxvkyp.fsf@alter.siamese.dyndns.org>
 <7v62alvk2e.fsf@alter.siamese.dyndns.org> <vpqd34su0io.fsf@bauges.imag.fr>
 <7vobocsipo.fsf@alter.siamese.dyndns.org> <vpq62aksicy.fsf@bauges.imag.fr>
 <7vk3z0shri.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 21 19:47:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShlTj-0002Rk-IK
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 19:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760035Ab2FURrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 13:47:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49644 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760027Ab2FURrB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 13:47:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AEEE9785;
	Thu, 21 Jun 2012 13:46:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ld7RsapRAK6SmPPubCWDPVW2NtQ=; b=XmEAkf
	LpoTf6UcM8TEMjc8gyuJnn+TlWr8E7yLpFk1NyAP4+WR5R4V+iqSoplHAprtwAAj
	WJwk7n8w4AJaBHcbNAmNZvlm8iKspBgucr7TgydIqLPy216/aN88iEarnnFNssz0
	fmKLQE7FKT2dOTrIT43ePb1Faq58hrz43b39g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sZHDl25fz6+t2Td77MxXZ7bLBoR6IUcG
	wacKKnV8Eu4mIJgzpziSZHLsqkXa82q+dwFPvOW1h6uEPWGYW0OyEfSQfwkeUFb8
	bRD6BhlWnhXEfVZffBoFxSLsZLykwrQr964sYkvm4QBar8cIClRK88cHCPfCJmUk
	udYHV/uQ+Pg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02B349784;
	Thu, 21 Jun 2012 13:46:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 810EA9783; Thu, 21 Jun 2012
 13:46:58 -0400 (EDT)
In-Reply-To: <7vk3z0shri.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 21 Jun 2012 10:21:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1950FC4A-BBC9-11E1-A107-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200411>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Re-read the part you omitted with [...].  Doesn't it say something
>>> about "only available"?
>>
>> It does, but it seems you're trying hard to avoid telling the user "you
>> should use 'current'", where 'current' is the only reasonable option for
>> this user. I still don't understand what problem you're trying to solve.
>
> I am avoiding to say "you should use simple/current".  Choice
> between matching and simple/current is for the user to make (mostly
> dictated by the project's workflow) and we cannot make a suggestion
> better than what user knows.
>
> Choice between simple and current is mechanically derivable. If the
> user also uses older version of git, simple is not an option.

To put it another way, I am questioning your "where 'current is the
only reasonable option for this user".  If it were truly the case,
why would we be issuing a warning message?  Wouldn't we be instead
silently doing what 'simple' or 'current' would do?

The reason why we have this message is because either "push the
current one and not others" or "push all relevant ones, regardless
of the current" are reasonable choices depending on the user, and
because we had to choose one for the default, we previously chose
the latter but we are changing our mind and will default to the
other one, no?
