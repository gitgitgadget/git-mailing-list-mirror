From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5551: do not use unportable sed '\+'
Date: Mon, 13 May 2013 11:36:33 -0700
Message-ID: <7vhai6n2vi.fsf@alter.siamese.dyndns.org>
References: <201305111525.53130.tboegi@web.de>
	<7vwqr5wdqm.fsf@alter.siamese.dyndns.org>
	<7vobchwbax.fsf@alter.siamese.dyndns.org> <518EA351.8000603@web.de>
	<7v8v3lwa5p.fsf@alter.siamese.dyndns.org> <518EAB7C.3010508@web.de>
	<7vsj1svqi7.fsf@alter.siamese.dyndns.org>
	<7vr4hbu818.fsf_-_@alter.siamese.dyndns.org> <51910418.2070904@web.de>
	<7vtxm6n8pj.fsf@alter.siamese.dyndns.org> <51912FEC.6020909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon May 13 20:36:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubxc2-0003Lp-I8
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 20:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab3EMSgg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 May 2013 14:36:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467Ab3EMSgf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 May 2013 14:36:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 214FF1EA7D;
	Mon, 13 May 2013 18:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sUNS5kRjie0A
	GXn4AwWLbEiFzyQ=; b=APIAEJGCpgcFeVcz3vLhrRGjJF+H8h9k7f23KkZdc+og
	pYBV+6dL7qjvIGAK38cgsHEzxCzFZvM4OYoXA51W28B9GGPULF6A2Pru4NR0aDTp
	LrkfJQpVRZlsd47xE1MLzoh+zXIQAsTcT/zVnL3tvKUHkeOhOUloo1kYWOY0HTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gUXuXp
	4eLsgJjzw1dbE9jrWOv8zA/wnhSmv55xtpiH+hTOTAKIAhaBg5hxq+WQXa7b06JS
	Yqsrf8cJ6c3qiLCkOS0uMlWyqnaapCMQ45Tg824PqBMSfhRzbNx/Kut+PncynSRd
	vxnvGnlS3faeouaq87qpYZRtfbd0FUq4bSU9g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 190031EA7C;
	Mon, 13 May 2013 18:36:35 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73CB51EA79;
	Mon, 13 May 2013 18:36:34 +0000 (UTC)
In-Reply-To: <51912FEC.6020909@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Mon, 13 May 2013 20:24:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09C8C4CC-BBFC-11E2-8915-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224187>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2013-05-13 18.30, Junio C Hamano wrote:
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>=20
>>> On 2013-05-13 00.50, Junio C Hamano wrote:
>>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>>> ---
>>>>  t/t5551-http-fetch.sh | 8 ++++++--
>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>> Thanks, works like a charm, tested on Mac OS.
>>> /torsten
>>=20
>> Thanks; I take it that you reverted the "sed fix" part and saw the
>> updated "clone" check fail with the platform "sed"?
> In my first test with the fix the test case passed.
> Then the sed expression was only manipulated to verify that the TC fa=
iles.
> And now I took even the original expression and have verfied it is fa=
iling.
>
> The short version: Yes

Thanks.
