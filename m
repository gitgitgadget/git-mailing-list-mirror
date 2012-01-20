From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT
 defined
Date: Fri, 20 Jan 2012 11:35:39 -0800
Message-ID: <7vsjjadv5g.fsf@alter.siamese.dyndns.org>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 <7vfwfclf4v.fsf@alter.siamese.dyndns.org> <4F17C294.6010004@viscovery.net>
 <7vhazrk0jx.fsf@alter.siamese.dyndns.org>
 <CACBZZX7iiF2um11FvD+MBz=rZb7RrHtCJp3PqexLnSp3-Cbqug@mail.gmail.com>
 <CALxABCZWBtgX736Acoy-CCAz8RJb0EKnHf+7g72dOdVS+BOhSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 20:35:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoKFW-0007SR-R1
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 20:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755105Ab2ATTfn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 14:35:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49009 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753659Ab2ATTfm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2012 14:35:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98E7B7A49;
	Fri, 20 Jan 2012 14:35:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/MEPKSk7VtC6
	rOcibS55kG+Uhrg=; b=q42LBNRH+V0Kn1sS2RwBuOlgcBmuUaFFWA0tANNeO3Ct
	rs9R1x4hhXDddrCX0Oot/UkOQGMQrVJC6biEORoMaccq4t7fn7PzW2eo36hbeaxl
	fH2iCYjYOxpyteimMHC1Zw5g1Ay8DFr0ng6UqTbMR/mfg1/ishv7ABwrDbCfELY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=W7vII/
	W7u5OZse+OKBp3TeECBssFMw2mG6n9a7y13pBT2ZTJ4DJuXPZHQbBDHvPD/dN4Xr
	/35MOR9oeettB0fin+weSzRz6Iv/1V9TzpyYu2I8D9QC0iv6sxokW1UTBfSACV42
	YxlyW30ZtntUrB+GaZ1Irq6q0kS7rVwQvG8H4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E8E97A48;
	Fri, 20 Jan 2012 14:35:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22B4C7A46; Fri, 20 Jan 2012
 14:35:41 -0500 (EST)
In-Reply-To: <CALxABCZWBtgX736Acoy-CCAz8RJb0EKnHf+7g72dOdVS+BOhSw@mail.gmail.com> (Alex
 Riesen's message of "Fri, 20 Jan 2012 11:40:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EFE55F16-439D-11E1-8350-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188896>

Alex Riesen <raa.lkml@gmail.com> writes:

>> And then a --version for whatever programs that function uses,
>> e.g. here:
>>
>> =C2=A0 =C2=A0$ envsubst --version
>
> Nothing. Exit code 127.

Interesting.

    $ wonbsubst --version; echo $?
    bash: wonbsubst: command not found
    127

Perhaps your distro lacks a necessary package dependencies between gett=
ext
and envsubst?

> I believe gettext (the binary) just doesn't start at all here. Maybe
> some Cygwin library wrong or missing library. Happens all the time
> here,...

Aha.

I guess we either leave it broken for broken installation or add an ext=
ra
"MY_GETTEXT_IS_BROKEN" option; in either way, it does not sound like a
serious enough issue that is widespread to be urgently fixed during the
feature freeze.
