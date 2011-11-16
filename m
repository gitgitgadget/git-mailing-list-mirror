From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] ll-merge: initialize default_opts const
Date: Tue, 15 Nov 2011 23:49:07 -0800
Message-ID: <7vd3csqzgs.fsf@alter.siamese.dyndns.org>
References: <1321376379-31750-1-git-send-email-artagnon@gmail.com>
 <1321376379-31750-4-git-send-email-artagnon@gmail.com>
 <7vty65t1qp.fsf@alter.siamese.dyndns.org>
 <CALkWK0mVxxq0345B_OJQwejpTBD=evOU_iAv39CvXv4mAi=09A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 08:49:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQaFA-0007D1-2q
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 08:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769Ab1KPHtL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 02:49:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51987 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754675Ab1KPHtK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 02:49:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1AA73530;
	Wed, 16 Nov 2011 02:49:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=A1NAmuCDiIbe
	3RLJB1HMK0m83q0=; b=vLZyIpEQlIHZSXh1uCbLlUCE4EvYJfysZuMm3AROr+Tb
	cArMAjdfVznZ/dfiRKbhcw4/BQAlWQzit9a9vnRrdTso6Hk5RyiJRfDqR22JPrc9
	u6Nj0+JvxwQhrIA7iCVG8PbnzRP85fTcQK0No3Sa5ErJ1qnODBLuk0XN846gB7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=B3xmrE
	nveVVVWCSAVagv3mraFn063v9BuDyo5KhaCmmUMB0msPaDOTDxZxhmI2ni+wGvVV
	FTEyc9uwQVu+WUbcFLIzUT7zCOYDp4lAJBxCKCz9dNuYnbJy0+o7kUIwMq2YFbjf
	2ekGnjQAtbcTE5aPQ2tf795bQKlZosC5aM7EU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6B59352F;
	Wed, 16 Nov 2011 02:49:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B09B352C; Wed, 16 Nov 2011
 02:49:08 -0500 (EST)
In-Reply-To: <CALkWK0mVxxq0345B_OJQwejpTBD=evOU_iAv39CvXv4mAi=09A@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Wed, 16 Nov 2011 11:36:05 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7762EB52-1027-11E1-BCDF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185520>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi Junio,
>
> Junio C Hamano wrote:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>> [...]
>>> - =C2=A0 =C2=A0 static const struct ll_merge_options default_opts;
>>> + =C2=A0 =C2=A0 static const struct ll_merge_options default_opts =3D=
 {0, 0, 0, 0};
>>
>> Doesn't "static" tell us that it will be in BSS, initialized to all =
zero
>> by definition?
>
> I'm uncertain about whether the C89 standard says this explicitly- ic=
c
> is more pedantic than most mainstream compilers.

Actually I take a part of the comment back; as this is "static const", =
it
is entirely plausible for a compiler to tell the linker to put it in ro=
data
instead of bss, to cause any attempt to modify it to segv.

A datum that is implicitly initialized to all zero and not allowed to b=
e
modified might appear suspect to some compiler writers (especially when
they are under influence ;-)), so I am not so surprised if a compiler
issued a warning saying "did you forget to initialize it?".
