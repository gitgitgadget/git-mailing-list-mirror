From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw: disable Python
Date: Fri, 08 Jan 2010 05:35:34 -0800
Message-ID: <7vpr5kpvmh.fsf@alter.siamese.dyndns.org>
References: <40aa078e1001071400j21900ed1n415394491d469b8c@mail.gmail.com>
 <1262902037-4420-1-git-send-email-kusmabite@gmail.com>
 <4B46E7D6.3080702@viscovery.net>
 <alpine.DEB.1.00.1001081135180.4272@intel-tinevez-2-302>
 <40aa078e1001080249t16b0ee01i5ceb8e7ad2426e70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, msysgit@googlegroups.com,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Jan 08 14:36:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTF0O-00057O-LN
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 14:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055Ab0AHNfw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2010 08:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752943Ab0AHNfw
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 08:35:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875Ab0AHNfv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 08:35:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D867F8EC76;
	Fri,  8 Jan 2010 08:35:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=SD9UIcpxx54lHdq3XKkSBdJaK
	oY=; b=QHC1tqh6z2rlSZf4JH52l9E3PfazYeoPaiPRoCTgda/GYY/B31Etzak+3
	Dku3SHubYC8rmNDRuxt1m5JD7Njy288vtM0Dpa9Qd77o9j+pgEt1dkM7Z2l8Mdzq
	tf3HqZ7nMTZCiO8eQZ/Q6wqtD6PBevO+xbiAZQBqKKto3miGUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=ObsePjK6aB0FdwCtqYf
	dsyBAUFRrqNb5uLM+1I/FWbBPSw6oR5rh31QXjsPjFmdQhEYFSngfNgnzpyYLONu
	kqMAJbIfxPyjGY/iBHsK09QnZ6oP/axRhn/8A5SHREDiBuOIpQEcfof93+jzpN8m
	5jSeocCAkGfPc7J8qCpE+MHQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 756208EC74;
	Fri,  8 Jan 2010 08:35:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D8808EC73; Fri,  8 Jan
 2010 08:35:36 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B781CC72-FC5A-11DE-BFF1-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136433>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

>> On Fri, 8 Jan 2010, Johannes Sixt wrote:
>>
>>> Erik Faye-Lund schrieb:
>>> > Python is not commonly installed on Windows machines, so
>>> > we should disable it there by default.
>>> >
>>> > --- a/Makefile
>>> > +++ b/Makefile
>>> > @@ -1027,6 +1027,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>>> > + =C2=A0 NO_PYTHON =3D YesPlease
>>>
>>> I'm worried that with this solution it is impossible to re-enable P=
ython
>>> in config.mak (how do you undefine a Makefile variable?);
>
>> How about
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0NO_PYTHON=3D
>>
>> in config.mak?
>
> That doesn't work for me, at least not out of the box. NO_PYTHON is
> still defined, it's just defined to an empty string.

I think Dscho is right.  "ifdef FOO" yields (and should yield) false if
=46OO is set to empty.

-- >8 -- cut here and try it for yourself -- >8 --
#!/bin/sh

rm -f config.mk

cat >Makefile <<\EOF
# The default is...
all::
=46ROTZ =3D NITFOL
-include config.mk
ifdef FROTZ
all::
	echo FROTZ is $(FROTZ)
else
all::
	echo FROTZ is not defined
endif
EOF

make
# says "NITFOL"

echo "FROTZ =3D" >config.mk
make
# says "not defined"

exit
-- 8< --
