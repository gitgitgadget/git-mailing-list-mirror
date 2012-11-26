From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 p1.1 00/14] fast-export and remote-testgit
 improvements
Date: Mon, 26 Nov 2012 15:52:31 -0800
Message-ID: <7v38zvq5vk.fsf@alter.siamese.dyndns.org>
References: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
 <7vd2z0otie.fsf@alter.siamese.dyndns.org>
 <CAMP44s3LR6T6H8z0LPJr7DHXde-JUoN9X4mWhju-5ECvG7wDpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 00:53:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td8Tp-00028s-Ci
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 00:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575Ab2KZXwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 18:52:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35865 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932076Ab2KZXwd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 18:52:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7720C9DF7;
	Mon, 26 Nov 2012 18:52:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SEV8T7tbarORv+XvEqeEW4DmxoA=; b=ihzXNt
	sygaYH/d2jtwJX4aQKYGlBVi9lGu0fYLl9rvEAeolPC/Q+OCkIgT//U7WbRNeLa1
	b6oOlrfkBK1mXXzD7x9hq5jjra1pVTll0Z9zr2sY/k2TRDpel15OW09JBihLyaEQ
	2Wi+D8MAUE+Q2AcfBpfE19UtilsTJNk6Gs/24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=usgoFaev3FniAl5IiXn+8/qtNEZ5FPeZ
	6kgFcbLJylhZ7Z4CO4poELTn7y0K/gfGVbwJriL0xIpdvMRFUoYHCmy6mnO0nlTN
	5sz5V9RjhOtpGNpyrcu43FJlFgRMWZgBYuKr6xUhY/nU8QV+YFon5iCOivv5vINv
	LvasVZhA47Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62DCB9DF5;
	Mon, 26 Nov 2012 18:52:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B85399DF2; Mon, 26 Nov 2012
 18:52:32 -0500 (EST)
In-Reply-To: <CAMP44s3LR6T6H8z0LPJr7DHXde-JUoN9X4mWhju-5ECvG7wDpg@mail.gmail.com> (Felipe
 Contreras's message of "Tue, 27 Nov 2012 00:23:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5869F6E8-3824-11E2-ABA0-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210519>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Nov 27, 2012 at 12:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> I'm rerolling this series with the changes fron Junio, plus a bit more cleanups.
>>>
>>> I dropped the last patch, because I found an issue and a separate patch series
>>> would take care of that. Other than that the main changes remain the same.
>>>
>>> The old remote-testgit is now remote-testpy (as it's testing the python
>>> framework, not really remote helpers). The tests are simplified, and exercise
>>> more features of transport-helper, and unsuprisingly, find more bugs.
>>
>> Thanks.
>>
>> I've queued [v6 p1.1] but not later parts (yet).  The result merged
>> to 'pu' however seems to break t5800.  It could be a stupid and
>> trivial merge error or something, but I didn't look into the
>> details.
>
> Yeah, the last patch triggers that. It should be moved to part2. The
> patch "fast-export: don't handle uninteresting refs" should fix that,
> which is why I believe it should be applied first. Didn't I already
> say that?

You may have, but I am leaky ;-) as I am not 100% focused on this
series alone.

In the meantime, I'll drop the last one, push out the 'pu' branch
after rebuilding, and then revisit it when I queue the part 2.

Thanks.
