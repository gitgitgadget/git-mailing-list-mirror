From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] ls-remote: print URL when no repo is specified
Date: Thu, 20 May 2010 06:27:29 -0700
Message-ID: <7v632i8zzy.fsf@alter.siamese.dyndns.org>
References: <1273416140-5044-1-git-send-email-rctay89@gmail.com>
 <1273598423-3156-1-git-send-email-rctay89@gmail.com>
 <7veihh8y8b.fsf@alter.siamese.dyndns.org>
 <AANLkTinxm8hwX53LE9_7rDPoKs9UnGAyFFfVcoh-WGxE@mail.gmail.com>
 <20100514161743.GA1957@progeny.tock>
 <AANLkTimTKiGxpVelj9rVV_BV-f8NiKlQHpov38ojlfFq@mail.gmail.com>
 <20100515162002.GA2592@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 20 15:27:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF5ms-00011y-Pe
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 15:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459Ab0ETN1m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 May 2010 09:27:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab0ETN1l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 May 2010 09:27:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BF85DB46CB;
	Thu, 20 May 2010 09:27:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=Sh/x/ywNffOVqzfTIbbcfMUbn
	MY=; b=ya7u47VVYGBCh0kB7KuU+H69gN+NxO368WdOkKnRuU+63jSvyaaV/e5gf
	CFOz8XbPg7pSO7zvryLSXumdIrB/oeit8lULxTVmxjjPWrFSPkHnXyWIopAiYteu
	3kvpoTUuH+EOHyUp4e6gKTKbYK1qbCylEKP1QWCGs9+7abOcbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=I2JQa88hqq0Vf1TJ/nf
	jeG+Waplyjop/If8YhZftfBCnqEscAHhPuTs7gP6zvWM8u3scyZr+U3EmRdjhVOC
	qVp3FOK+5RP2+ABMhvvC42990C/JbIKpFcrkyD5JIM/HzEhSkdFl9D7TZxotPBAN
	8HRTWUsJ8mNKNj4QvQaCA9uM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 880A8B46C7;
	Thu, 20 May 2010 09:27:36 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9050CB46C3; Thu, 20 May
 2010 09:27:31 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 746E6028-6413-11DF-8489-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147387>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Tay Ray Chuan wrote:
>> On Sat, May 15, 2010 at 12:17 AM, Jonathan Nieder <jrnieder@gmail.co=
m> wrote:
>
>>> I think I see what you are saying, and for scripts, that really wou=
ld
>>> be the most useful thing. =C2=A0Then the script could use something=
 like
>>>
>>> =C2=A0if test -z "$remote"
>>> =C2=A0then
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0remote=3D$(git branch --get-remote --cur=
rent)
>>> =C2=A0fi
>>> =C2=A0git ls-remote "$remote"
>>
>> Just curious - when did git-branch learn "--get-remote"? Or "--curre=
nt"?
>
> It didn=E2=80=99t.  I was just saying that it should (or we should pr=
ovide some
> commands to that effect).  What do you think?

I think you said what I meant to say much more clearly.  Thanks.
