From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] t3703, t4208: add test cases for magic pathspec
Date: Sun, 29 May 2011 13:31:36 -0700
Message-ID: <7v1uzhp7tj.fsf@alter.siamese.dyndns.org>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
 <1305006678-4051-1-git-send-email-gitster@pobox.com>
 <1305006678-4051-10-git-send-email-gitster@pobox.com>
 <BANLkTimQ7H7SLbA=mREOSK_bQVN5Yo1oiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	pclouds@gmail.com
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 29 22:31:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQmeN-0007Xa-Ty
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 22:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282Ab1E2Ubr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 May 2011 16:31:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab1E2Ubq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2011 16:31:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3F2EE5DB6;
	Sun, 29 May 2011 16:33:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zpCjb11FzIBA
	HkIvVjr/cJMmbmU=; b=kRCFYyJx2tDUBxXFlTyVQ1X/23gpF+zepIqNSOI6VsNW
	ecPVQArt3wxoBcqAJrBrQpcgjlMRi/KoWR4Z4yvoTv0qyXAS26wGpgYKmE2ZujnO
	x22gB518jcwSQuARkK6xrPUh7WD/6egBpwnc4LuqSctfTlqcfve+Zci/4FPcIi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bA6bhD
	KNzJcCvKHXeEx8ZdfLjaS5uCpkrpwyeiAnlFpBu7UOuRQv0MHF4XCTDXqnaXcmP4
	PYegZulnA+tfVMEpkbQMl7An7Iwte7vXgXMqCinDl6gP4FvQYHhqe1ekkvucekle
	k1/Lk/4Ekqgbwop6QPUTDU15OQXuPRXc0DGeY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F1025DB4;
	Sun, 29 May 2011 16:33:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BE4D55DB0; Sun, 29 May 2011
 16:33:45 -0400 (EDT)
In-Reply-To: <BANLkTimQ7H7SLbA=mREOSK_bQVN5Yo1oiQ@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 29 May
 2011 20:29:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F68181DA-8A32-11E0-A61B-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174705>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, May 10, 2011 at 07:51, Junio C Hamano <gitster@pobox.com> wro=
te:
>
>> +test_expect_success 'add :/' "
>> + =C2=A0 =C2=A0 =C2=A0 cat >expected <<-EOF &&
>> + =C2=A0 =C2=A0 =C2=A0 add 'anothersub/foo'
>> + =C2=A0 =C2=A0 =C2=A0 add 'expected'
>> + =C2=A0 =C2=A0 =C2=A0 add 'sub/actual'
>> + =C2=A0 =C2=A0 =C2=A0 add 'sub/foo'
>> + =C2=A0 =C2=A0 =C2=A0 EOF
>> + =C2=A0 =C2=A0 =C2=A0 (cd sub && git add -n :/ >actual) &&
>> + =C2=A0 =C2=A0 =C2=A0 test_cmp expected sub/actual
>> +"
>
> This needs to use test_i18ncmp.

I don't think so (at least not yet).

Doesn't it come from read-cache.c::add_to_index()?
