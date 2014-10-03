From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] init - Honour the global core.filemode setting
Date: Fri, 03 Oct 2014 10:07:16 -0700
Message-ID: <xmqqegupm69n.fsf@gitster.dls.corp.google.com>
References: <CAE1pOi0zhnUNNdHsrq+4H_6LiFnr-qoY-owrcJquy6dyG+Mk4g@mail.gmail.com>
	<5427F68E.5030003@web.de>
	<CAE1pOi1dAO7XFZtrgZyNm-eLVKQx=KpeejbGmF8khCofAppDLg@mail.gmail.com>
	<xmqqy4szpvfv.fsf@gitster.dls.corp.google.com>
	<542D33E1.6080709@web.de>
	<xmqqzjdeo16d.fsf@gitster.dls.corp.google.com> <542ED4B8.40603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Oct 03 19:07:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa6KP-0002Xb-8V
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 19:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165AbaJCRHY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Oct 2014 13:07:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65504 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbaJCRHW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Oct 2014 13:07:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B2673C8A9;
	Fri,  3 Oct 2014 13:07:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=r/hjru3DZlmL
	Ay6HWoJ3YdZaDgM=; b=SKQQsto/W9++t12uDvvZbhl057E9kSAysFYEZUwtrWCg
	r6MQAYr76VNuCwTX/f8Lct+pfT5X0Nc2niyGts6RDxJQpocXnoUjeJPkL30UnITL
	/3JPFEg4hx4WiluitzweAHpkzYN0wjEzno+jg+CCxSYN4fH4mNR6Ic/eWypImBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uUJenb
	5FzhvbQLGpqtZyWZeUaRyOvg2obyzQGF4AjA5fMSbKro5bNyoPt1W1T0/mOS6g0/
	CxaDyzafgwhkb0vGKuZVt+Dn6yuPhpXLQtIFMNI1XlkgoAl0/u2VwXkw9LygKWk5
	/mGQzUXKu36wfnuP7EE3bnNBGUyDKcKgS0oRo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5FE003C8A8;
	Fri,  3 Oct 2014 13:07:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7EDCF3C8A2;
	Fri,  3 Oct 2014 13:07:18 -0400 (EDT)
In-Reply-To: <542ED4B8.40603@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of
	"Fri, 03 Oct 2014 18:54:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BB3C6DB8-4B1F-11E4-B010-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257841>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> The first sentence says what happens, as it should.
>>=20
>> But it is not directly clear what makes the executable bit differ
>> and when it is a useful thing to ignore the differences, so the
>> second sentence that says "This may be useful" does not give the
>> reader very much.
>>=20
> Clearly a major improvement.
>
> Does this (still) include the original line
> "See linkgit:git-update-index[1]"
>
> which helps the user to add *.sh files "executable" to the index, eve=
n if
> core.filemode is false ?

Thanks for catching; I omitted the reference by accident.

Perhaps end that sentence like this instead?

	... may be necessary to set this variable to `false`, and
	maintain the executable bit with `git update-index --chmod`
	(see linkgit:git-update-index[1]).
