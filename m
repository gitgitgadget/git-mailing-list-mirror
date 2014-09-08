From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2 1/2] Makefile: add check-headers target
Date: Mon, 08 Sep 2014 12:57:46 -0700
Message-ID: <xmqqa969nav9.fsf@gitster.dls.corp.google.com>
References: <1410049821-49861-1-git-send-email-davvid@gmail.com>
	<xmqqiokylz46.fsf@gitster.dls.corp.google.com>
	<vpqsik13o84.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 08 22:04:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR54T-0001Yq-8N
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 21:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbaIHT5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 15:57:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59407 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753924AbaIHT5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 15:57:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A44B836B68;
	Mon,  8 Sep 2014 15:57:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aCD4RSRYSL61Y6UC+gl7BrLN8X8=; b=mk1JKz
	4IueEw9OlKWZfkuaGH8RiXE1SMjrjsrIomjkKPyE4Vv/8pRLqAynNfs8fsfJlGVn
	OU+HgNxNENqbFmexxHrdEzetOGNiPcrdTqJQ3lEQEyIpUGGexoPEydQ0GwlV8wwm
	QlMT24FJq6y6jwRWhY8Yb8my/rvVp3vQz0eVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d/z3M1EvmTkot+wk2LX1RBE243x72QmB
	9r3FQOqM+MFCG+HaMMs8VYdp1xucVOXCevTRlBEL9kS7FrUosv//kVgFjUXPJY02
	Q5z/iQR9xm9DG5sE8DnNB23FRsEWdjm5HGmNid4pXFfmenh3eOclnJO6H40QwkvP
	wsRL2SLxI+Q=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 993F636B67;
	Mon,  8 Sep 2014 15:57:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 11ACB36B66;
	Mon,  8 Sep 2014 15:57:48 -0400 (EDT)
In-Reply-To: <vpqsik13o84.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	08 Sep 2014 21:29:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 683C7482-3792-11E4-861D-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256674>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> David Aguilar <davvid@gmail.com> writes:
>>
>>> +IFS='
>>> +'
>>> +git ls-files *.h ewah/*.h vcs-svn/*.h xdiff/*.h |
>>
>> Hmm.  This is only for true developers (not one who merely compiles
>> after expanding a tarball), so "git ls-files" may probably be OK.
>>
>> But "/bin/ls" would be equally fine for that, no?
>
> Actually, since this is "| while read header", I have to wonder why this
> is not written as
>
> for header in .h ewah/*.h vcs-svn/*.h xdiff/*.h
> do
> 	...
> done

Yes, that would be even better.  Then you wouldn't even have to
worry about $IFS dance.
