From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: Don't pass a TODO test if REG_STARTEND is
 supported
Date: Thu, 15 Jul 2010 10:47:52 -0700
Message-ID: <7vtyo0vdpz.fsf@alter.siamese.dyndns.org>
References: <1278549735-19278-1-git-send-email-avarab@gmail.com>
 <7viq4ppxt9.fsf@alter.siamese.dyndns.org>
 <AANLkTikuGY4LVrCB6UoGFhxthoI8MgvAXCwCbiXhwq_d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 19:48:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZSXY-0000AJ-7j
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 19:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933929Ab0GORsE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jul 2010 13:48:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933961Ab0GORsA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jul 2010 13:48:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6242EC46A2;
	Thu, 15 Jul 2010 13:47:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aMyYZAJ0Zziu
	SeX8tyGrtXm92pc=; b=a4S0BaJoJWDFb32yZih7EQJnKDap6oFLsC+koMh+AvJM
	DGLIwsUWUdqwoFtYGLGHJDoUnMchB2aZ7+w+vZf7Zpq3gwLU2rMTu1K/5qgN6hwi
	KaX61QvB01sjhbfRsTzXs8dhbrA29O4xnNxTfOFh9Jw5D5W33Z885Tg4MNYxzOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kk+mYn
	HpFKTl+3j/sujw6Wjmje1xaZu0RFeoAVdb4nJrUjwa3DPda9AuNZQv2dBCdFOnRP
	s6gy0FtUtAtoOeFc7R9bndAu1tLuBbF/xMVqOrJLHn8uaUC5AUcfirkUPw5lWIXf
	bBh30ylF885wh22WZvMZZsF/Om2LD2+knvIcA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CDA2C469E;
	Thu, 15 Jul 2010 13:47:57 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 704ABC469D; Thu, 15 Jul
 2010 13:47:54 -0400 (EDT)
In-Reply-To: <AANLkTikuGY4LVrCB6UoGFhxthoI8MgvAXCwCbiXhwq_d@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu\, 8 Jul
 2010 20\:09\:17 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1A38DD98-9039-11DF-ABFD-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151101>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Jul 8, 2010 at 19:40, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> writ=
es:
>>
>>> +if git grep ile a
>>> +then
>>> + =C2=A0 =C2=A0 test_expect_success 'git grep ile a' 'git grep ile =
a'
>>> +else
>>> + =C2=A0 =C2=A0 test_expect_failure 'git grep ile a' 'git grep ile =
a'
>>> +fi
>>
>> So if command "X" is known to succeed, we run it inside expect_succe=
ss
>> and if not we run it inside expect_failure?
>>
>> What kind of idiocy is that, I have to wonder...
>
> Well, the point is to normalize the test suite so that we never have
> passing TODO tests if everything's OK.

I do not consider a test that passes under some condition but doesn't
under some other condition "everything is OK".  Marking the test as
"expect failure" as Ren=C3=A9 originally did makes a lot of sense to me=
=2E

The quoted patch is even worse as it will _actively_ prevent you from
catching a new error you just introduced while futzing "git grep" on a
platform that used to work.  Your "if" statement will say "ah, grep is
broken", and you will use expect-failure, not because your platform doe=
s
not support REG_STARTEND, but because you broke "git grep".

The point of having tests is to help you catch your bugs while you
develop.  A test that turns itself off when the feature it is testing i=
s
broken helps nobody.

So forget about "passing TODO tests", whatever a "TODO test" is.  The
change in question is actively _wrong_.
