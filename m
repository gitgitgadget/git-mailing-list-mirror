From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: don't output non-errors on stderr
Date: Fri, 25 Jun 2010 14:43:27 -0700
Message-ID: <7v1vbukcu8.fsf@alter.siamese.dyndns.org>
References: <AANLkTingtgeWuTrocesTIhTPsVz4dfU8CbwZF1TEl6AI@mail.gmail.com>
 <1277418881-11286-1-git-send-email-avarab@gmail.com>
 <7v1vbvkorf.fsf@alter.siamese.dyndns.org>
 <AANLkTilToJ2ekKVgIeka5qx9_lasw6DKSy8bOhTrP4dC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 23:43:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSGgY-0005Mq-EQ
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 23:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570Ab0FYVnh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jun 2010 17:43:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab0FYVng convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 17:43:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A0A68BFF1B;
	Fri, 25 Jun 2010 17:43:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=erESnDgEEoI2
	7cOq8fQZYUKZH4M=; b=fgeJ4W/NA3AEdbp7fauoiXayTNaGeqaIK0ZP+xaPaRdD
	Ye3/CL9w1cdp/FK2EqdK0HU4svSchEVhAqJ6f1M7VnKkKRTJxk8l49pFQadZ6Es0
	Vz43z7bpXQhdugvGqNRDPNXFxUp+7VwVsqXJdqZIj9a1bFACEfLDbJAXTPqxwJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JG/9MB
	XdAsI2748cv8YWJ0FIu80HVrq6bo0Jq2OeRoMP8sCmkSIPJ+9zgjgSMiuA8LP49N
	bAnDJHlbRl+RvqFrU/M/VMbaS2UioQj2rKHGzdjqTlmPB7Okt/RgPwvdZyGXIr2S
	pnlp+emizdYprxYM5i/f9Ec+Pnn/Agrw87wIQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67032BFF16;
	Fri, 25 Jun 2010 17:43:32 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A40C4BFF14; Fri, 25 Jun
 2010 17:43:28 -0400 (EDT)
In-Reply-To: <AANLkTilToJ2ekKVgIeka5qx9_lasw6DKSy8bOhTrP4dC@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 25 Jun
 2010 21\:28\:16 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B332D928-80A2-11DF-8F8F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149712>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Jun 25, 2010 at 17:25, Junio C Hamano <gitster@pobox.com> wro=
te:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> Before the change error messages were drowned out by git-fetch's
>>> non-error update notices, which didn't need my attention.
>>
>> I don't understand this part; care to elaborate?
>
> I have a cron job (github-backup) that calls git fetch. Without this
> patch I have to run it as '> /dev/null 2>&1' and just rely on the exi=
t
> code,

Signaling failure with exit code is _the_ standard practice, no?

Some people seem to think unclean standard error means some error (most
notably tcl ;-), but I think they are mistaken.

Not that I care too much about this issue, though.  I might end up queu=
ing
it, but we need to think about things like advice messages and such
(e.g. 011fe98 (git-push: fix an advice message so it goes to stderr,
2010-02-26)).
