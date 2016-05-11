From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: run arguments through precompose_argv
Date: Wed, 11 May 2016 15:08:24 -0700
Message-ID: <xmqqy47gi6xz.fsf@gitster.mtv.corp.google.com>
References: <1459802325-22056-1-git-send-email-alex@fournova.com>
	<1459802325-22056-2-git-send-email-alex@fournova.com>
	<xmqqzit80yov.fsf@gitster.mtv.corp.google.com>
	<57040EE0.40503@kdbg.org>
	<C52E38F0-B0F2-4769-A2C7-798D0CD99B47@fournova.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Alexander Rinass <alex@fournova.com>
X-From: git-owner@vger.kernel.org Thu May 12 00:08:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0cIz-0005QB-9S
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 00:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbcEKWI3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 18:08:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752139AbcEKWI2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2016 18:08:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D8231B417;
	Wed, 11 May 2016 18:08:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Fzix11uq2xlh
	NoBsuViHixZW2JA=; b=pL+I8vkdMeW+TFbZgWxgvfsSa/ApMp3y8EjPmB9CHfaq
	O9Uv7Pd5XiYf678Fk/VQsFlmN/wuW1zMip1O4149NjRqfQZXeeZKlQ6s/xgdvQ6D
	QBUvAF/hNZ43rvA2Onsa3Hb3BQ3E5bqSsHRYXMMQGQ6JdeEqrYLwzRtNHeNyUlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LWmGZB
	g9Tj2b8YwjHvRj4q3sPanOwvmmR6JOfE4XRzKhDlBpH1NXuKYC2Mv5QSumhXNckK
	pxaZk/8aorGU4/N4ZAgUfTKF69euaIDR+d77Hu+B53wFMmJSFcVrm3U8usjXZyVX
	0inv3fobum4PYzM2trndGwlJYaDySFFshRuGE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 93EB41B416;
	Wed, 11 May 2016 18:08:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1955D1B415;
	Wed, 11 May 2016 18:08:26 -0400 (EDT)
In-Reply-To: <C52E38F0-B0F2-4769-A2C7-798D0CD99B47@fournova.com> (Alexander
	Rinass's message of "Wed, 6 Apr 2016 08:51:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E26CC734-17C4-11E6-9583-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294372>

Alexander Rinass <alex@fournova.com> writes:

>> On 05 Apr 2016, at 21:15, Johannes Sixt <j6t@kdbg.org> wrote:
>>=20
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
> Thanks for reviewing and catching the NFD encoding error.
>
> I will send in a patch v2 with the correct NFC encoding.
>
> Would you also like me to alter the commit message as mentioned by Ju=
nio?
>
> I could rewrite the sentence:
>
> =E2=80=9CAs a result, no diff is displayed when feeding such a file p=
ath to the
> diff command.=E2=80=9D
>
> into simply saying:
>
> =E2=80=9CAs a result, no diff is displayed.=E2=80=9D
>
> However, I don't read the original message as it would imply that onl=
y
> file paths are affected by the precompose_argv call.=20
>
> Are there other suggestions on improving the commit message?

I think after this message there were a few suggestions, and then we
heard nothing.  Should we still be waiting for a response from you?

Thanks.
