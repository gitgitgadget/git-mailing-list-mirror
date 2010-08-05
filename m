From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: add exec command to launch a shell command
Date: Thu, 05 Aug 2010 13:16:25 -0700
Message-ID: <7vpqxwddd2.fsf@alter.siamese.dyndns.org>
References: <1281013217-29577-1-git-send-email-Matthieu.Moy@imag.fr>
 <AANLkTinWvJvNOj6Ga7LgTMmEF37GbZN=hQBFJz4EBry5@mail.gmail.com>
 <vpqfwytnh0m.fsf@bauges.imag.fr>
 <AANLkTi=P4iinacNXgPN8ZCtjiggBEj-OzF8TkKG5pZgU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 22:16:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh6s1-0000qe-DY
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 22:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933545Ab0HEUQh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 16:16:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933391Ab0HEUQg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 16:16:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C8A4FCA83F;
	Thu,  5 Aug 2010 16:16:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GuTbUk6QBvZ5
	lqUBE7XsshGfYJA=; b=WptTOqKYYbqBT1ZbR/X1U6d01O0G0PtKqWpKxUpmXFzW
	COuS2J0H+Y/N69EtkZsz1KXbEFB12+Dft6MiXFLAYZw/vgwfSLydSPgZ3qyDtQ1w
	1lQ4hTHdvD/8/LRSu2rN83Vx5GqKdfYZq7TWGcZCsHvutd1VfjLA0I/JS1mtOow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NlvCul
	AIuiNMvyTVYjxXOf5walopSNR1azHLkGCOAL3dgEF7mdF5Y6gZDqiTYvZFrmkUbV
	9qsuXyQv7L38GsllWUt0KO0WzPerYA9KES5vKotDgboKt0jMx32tME2cZQMvDDVR
	7vaC20yik69dNFlCRf+vvKwiXHR1hEKnyZ1qM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 82CE4CA83D;
	Thu,  5 Aug 2010 16:16:31 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8956CA837; Thu,  5 Aug
 2010 16:16:26 -0400 (EDT)
In-Reply-To: <AANLkTi=P4iinacNXgPN8ZCtjiggBEj-OzF8TkKG5pZgU@mail.gmail.com>
 (Jacob Helwig's message of "Thu\, 5 Aug 2010 11\:37\:40 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 563EF49E-A0CE-11DF-B3E3-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152710>

Jacob Helwig <jacob.helwig@gmail.com> writes:

> On Thu, Aug 5, 2010 at 09:47, Matthieu Moy <Matthieu.Moy@grenoble-inp=
=2Efr> wrote:
>> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason <avarab@gmail.com> writes:
>>
>>>> +in `$SHELL`, or the default shell if `$SHELL` is not set), so you=
 can
>>>> +use usual shell commands like "cd". The command is run from the
>>>
>>> I think that needs a definite article: ".. use the usual ..".
>> ...
> You could probably just drop "usual" entirely: ..., so you can use
> shell commands like "cd".

Sounds sane.  Will do, unless a native speaker stops me from doing so.
