From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Thu, 12 Apr 2012 16:26:23 -0700
Message-ID: <7vzkag3528.fsf@alter.siamese.dyndns.org>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s2Ug91_sQ-XR3ck2k+x+eQRt9PNRRBOUnkrnNRhY6fEpw@mail.gmail.com>
 <7vmx6g6e2i.fsf@alter.siamese.dyndns.org>
 <CAMP44s37znvnw+n3NsFj+ZVuxwPhrordJA0ko0LV9udPS+i3aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 01:26:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SITPL-00013s-EM
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 01:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934965Ab2DLX00 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 19:26:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62846 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934959Ab2DLX00 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 19:26:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 520397D33;
	Thu, 12 Apr 2012 19:26:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=v3q00EmfxNpZ
	dM9ieH5JrwK0mMw=; b=QrMznVi9o2lZngAsaekrjZ2rAZHI8ozcNq1sUai8YPrd
	pDb97uVQ9tmNbxKrcmFUL7SSRqED9ImBnUqGl/JFQXyFj6lEDvZFPg8yk8XiCcVX
	8YvIUIvDqL2ME4Fc2eeVbSansMgDXH4biGRmn/BZwuifH4EJrjd0upfX00lBkiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=b4SyGV
	HMbqAgnVGLCxgNtMs6aPZkb4mmmTUKyv1NRrJe0wfU+2s/GIpXTvKJVz/gneQVKO
	ZfDuyedJt549PvKIbQgZs1GCtTE2Z+UZ9k/cjG75UGoggjRyZ4Cs1NkIzEJUZO/G
	sLiOVkL5Ystk/ctZ3DamgNpPhIFDmYIhEMfKk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 488B47D32;
	Thu, 12 Apr 2012 19:26:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2DF37D2D; Thu, 12 Apr 2012
 19:26:24 -0400 (EDT)
In-Reply-To: <CAMP44s37znvnw+n3NsFj+ZVuxwPhrordJA0ko0LV9udPS+i3aQ@mail.gmail.com> (Felipe
 Contreras's message of "Fri, 13 Apr 2012 02:18:45 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB90FBC4-84F6-11E1-B2CD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195388>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Apr 12, 2012 at 8:43 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> On Thu, Apr 12, 2012 at 12:57 AM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>
>>>> +test_expect_success 'double dash' '
>>>> + =C2=A0 =C2=A0 =C2=A0 cat >expected <<-\EOF &&
>>>> + =C2=A0 =C2=A0 =C2=A0 --paginate
>>>> + =C2=A0 =C2=A0 =C2=A0 --no-pager
>>>> + =C2=A0 =C2=A0 =C2=A0 --git-dir=3D
>>>> + =C2=A0 =C2=A0 =C2=A0 --bare
>>>> + =C2=A0 =C2=A0 =C2=A0 --version
>>>> + =C2=A0 =C2=A0 =C2=A0 --exec-path
>>>> + =C2=A0 =C2=A0 =C2=A0 --html-path
>>>> + =C2=A0 =C2=A0 =C2=A0 --work-tree=3D
>>>> + =C2=A0 =C2=A0 =C2=A0 --namespace=3D
>>>> + =C2=A0 =C2=A0 =C2=A0 --help
>>>> + =C2=A0 =C2=A0 =C2=A0 EOF
>>>> + =C2=A0 =C2=A0 =C2=A0 test_completion "git --"
>>>
>>> There's a mistake here ^.
>>
>> Yeah, good eyes! =C2=A0... ah, wait, it is your bug ;-)
>
> Not my eyes, further tests =3D/
>
> Do I need to resend the patch?

Not necessarily.  If you can eyeball what is queued on 'pu' and gave me=
 an
Ack (or send a replacement with "You stupid, you amended it wrong!") th=
at
should be sufficient.

Thanks.
