From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: run arguments through precompose_argv
Date: Tue, 05 Apr 2016 14:42:23 -0700
Message-ID: <xmqq7fgb20n4.fsf@gitster.mtv.corp.google.com>
References: <1459802325-22056-1-git-send-email-alex@fournova.com>
	<1459802325-22056-2-git-send-email-alex@fournova.com>
	<xmqqzit80yov.fsf@gitster.mtv.corp.google.com>
	<57040EE0.40503@kdbg.org> <570411A6.6060208@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Alexander Rinass <alex@fournova.com>,
	git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 05 23:42:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anYk3-0001ig-IH
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 23:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760281AbcDEVm0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2016 17:42:26 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760182AbcDEVm0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2016 17:42:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EDCA653E39;
	Tue,  5 Apr 2016 17:42:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KhXv7PwqBIzF
	z6CUxk13Sq5y3w8=; b=FShKWAZP7sDN0ueJ3oo1OSeAwjbQQeA+5liDq3nXhfu2
	hAAfnUPRP7v88L6O7vO2fXevEGv+IPaJJxDTNIykEkaDAdnmwZbg1+S6jqJ2tKjw
	PsqkiytEfxrphNFINhixj9Y1FXMwzI8dedYJgr+RI9Eq4aOpV14wNEJN5yoYDYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lCq/NV
	bvz+0yCPJ9jmwwNJKvCkDo57TkJpPR2j6klQk5FPoxVtWX4nCBbAXT3pe6QhDLx1
	vMErDVrCArlvAQS4cuHe/6zle3k9S36Gy+Aabhav2MOgCN/McTuhRfE/5ND+iMn1
	dvia+YgTUHstCUW90Avh/HiSEw02+hsPzb/Cw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E297453E37;
	Tue,  5 Apr 2016 17:42:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 62D6A53E36;
	Tue,  5 Apr 2016 17:42:24 -0400 (EDT)
In-Reply-To: <570411A6.6060208@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 5 Apr 2016 21:27:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 48B5B484-FB77-11E5-A1DD-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290814>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 05.04.16 21:15, Johannes Sixt wrote:
>> Am 05.04.2016 um 19:09 schrieb Junio C Hamano:
>>>> Thanks-to: Torsten Bo=CC=88gershausen <tboegi@web.de>
>>=20
>> I sense NFD disease: The combining diaresis should combine with the =
o, not the g. Here is a correct line to copy-and-paste if you like:
>>=20
>> Thanks-to: Torsten B=C3=B6gershausen <tboegi@web.de>
>>=20
>> -- Hannes
>
> Good eyes.
>
> And thanks to Alexander for doing this patch

Yup.  It is funny that I wrote:

    Thanks.  The log message talks about "such a file path", but
    precompose_argv() applies indiscriminately on any command line
    arguments, so things like -G<string> would also get the same
    treatment, which I think is what most users would want.

but "git log --grep=3D" with your name would not have found the one
that would have resulted from the original e-mail message applied.
