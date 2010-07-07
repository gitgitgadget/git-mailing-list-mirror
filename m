From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse: fix --parse-opt --keep-dashdash
 --stop-at-non-option
Date: Wed, 07 Jul 2010 14:41:33 -0700
Message-ID: <7vr5jfrmuq.fsf@alter.siamese.dyndns.org>
References: <1278427565-11057-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Jul 07 23:42:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWcNi-0002M1-Mc
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 23:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757944Ab0GGVln convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 17:41:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757861Ab0GGVll convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jul 2010 17:41:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CC15DC204C;
	Wed,  7 Jul 2010 17:41:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=iNUBJ56HIqZygAS+WpBo9BW6u
	jk=; b=Q21x5hiGpCYZ+Z6tK/kwu3jlzkoyP5yFQqitB7/lgYkI42lqLq/QK+auV
	bSH16lc60aG6eU0bWD0GYGzGRBCcprVM96IojwWelpvUkl8E8qgo69p8JASg99Aj
	AC6TmttGZJNYY3z654KS8H9vHn6Os9nSM/E+pqymx62ZdIJ7Ac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=ZaDy/W67NwFfMIrYJNP
	L+EYq4b5EENv9otwezn2YSOdEQhQs2a9nJGh9QNUl86mN+SsC52Q6ORM7BMprjZI
	BifRtrHIjSOsb3pPv+DqSD38gPA9Y3eegDDmlfm5115HX2vvKqGYg6FUkINUB34+
	yvuGL6DgF/hfbMDLTBPqqvV0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F13DC2046;
	Wed,  7 Jul 2010 17:41:38 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED647C2043; Wed,  7 Jul
 2010 17:41:35 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6C572550-8A10-11DF-9AC8-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150510>

Uwe Kleine-K=C3=B6nig  <u.kleine-koenig@pengutronix.de> writes:

> The ?: operator has a lower priority than |, so the implicit associat=
ivity
> made the 6th argument of parse_options be PARSE_OPT_KEEP_DASHDASH if
> keep_dashdash was true discarding PARSE_OPT_STOP_AT_NON_OPTION and
> PARSE_OPT_SHELL_EVAL.

Wow, this is an age-old breakage dating back to 6e0800e (parse-opt: mak=
e
PARSE_OPT_STOP_AT_NON_OPTION available to git rev-parse, 2009-06-14) th=
at
dates back to the very original --stop-at-non-option patch, isn't it?

I wonder if I should issue an updated maintenance release v1.6.4.5 ;-)

Thanks.
