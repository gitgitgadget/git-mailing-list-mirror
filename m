From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Makefile: move "Platform specific tweaks" above
 LIB_{H,OBJS}
Date: Sun, 14 Nov 2010 11:12:05 -0800
Message-ID: <7vr5en1zzu.fsf@alter.siamese.dyndns.org>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
 <1289745857-16704-2-git-send-email-avarab@gmail.com>
 <20101114172331.GA26459@burratino>
 <AANLkTinaDhXQjPC6s1eFb8HwEReW7P-ObmwRn2Hpb=O4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 20:12:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHi0H-0000I5-JD
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 20:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121Ab0KNTMT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 14:12:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103Ab0KNTMS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Nov 2010 14:12:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 15D6937CF;
	Sun, 14 Nov 2010 14:12:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KvrGykwZydvI
	nonkZjC161RyAzA=; b=JpxcaRIeM65UMs3yvYNHqJ0IVwi9Kn0Li+EXROWBuN0v
	vvbW6cYoRLVPmS8v4yYgi+fsHWL7lRLgq/4mr+Nv+/LnMSfgkrewQKPvMr09V5J/
	PZaRMyhYRoXa5sqR/uNTCmzHjdxeG6lvuckoN4k1k8CoWBTOqFh1G0aKfrzZFoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Hh0Js6
	BQ03Ipfg8NG26a084d2EIQLbgAz2tUj4e3chqm5Vf/ydJzcYpAT5hLCIHxSdwOKZ
	C87y58bnVlfN9ZJKUX6ehwPQ7FSqA79aqCRae4WnOF4C/SMaqDfV+EDlcO3d2vRU
	RAkvAlUwIBMjKJeOrpmvYGQFHMTWSlBbFssho=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CC57837C8;
	Sun, 14 Nov 2010 14:12:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6A8EB37C7; Sun, 14 Nov 2010
 14:12:13 -0500 (EST)
In-Reply-To: <AANLkTinaDhXQjPC6s1eFb8HwEReW7P-ObmwRn2Hpb=O4@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun\, 14 Nov
 2010 18\:51\:26 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1A2B9BB6-F023-11DF-A26E-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161434>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> This doesn't motivate the patch all all to me. =C2=A0Is changing the=
 list
>> of LIB_OBJS in section C1 really an ugly hack? =C2=A0It is where
>> configuration-specific things go and how BLK_SHA1, PROGRAM_OBJS, etc
>> work already.
>
> Yeah, because if it hadn't come before A8 it would have been *not*
> assigned to in the first place like we do everywhere else. Moving A8
> before A5 enables us to do that.

Hmm, in the existing platform specific tweaks section, we set BLK_SHA1
based on $(uname_S) and that symbol is used to control what is added to
LIB_H and LIB_OBJS.  Why is your gettext.o any different?
