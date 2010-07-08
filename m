From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] grep: Don't pass a TODO test if REG_STARTEND is supported
Date: Thu, 08 Jul 2010 23:58:35 +0200
Message-ID: <4C364A0B.2020909@lsrfire.ath.cx>
References: <1278549735-19278-1-git-send-email-avarab@gmail.com>	<7viq4ppxt9.fsf@alter.siamese.dyndns.org> <AANLkTikuGY4LVrCB6UoGFhxthoI8MgvAXCwCbiXhwq_d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 23:58:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWz7M-0002tH-Qz
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 23:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758638Ab0GHV6r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 17:58:47 -0400
Received: from india601.server4you.de ([85.25.151.105]:35230 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757178Ab0GHV6q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 17:58:46 -0400
Received: from [10.0.1.100] (p57B7D046.dip.t-dialin.net [87.183.208.70])
	by india601.server4you.de (Postfix) with ESMTPSA id ACDF82F8075;
	Thu,  8 Jul 2010 23:58:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.4) Gecko/20100608 Thunderbird/3.1
In-Reply-To: <AANLkTikuGY4LVrCB6UoGFhxthoI8MgvAXCwCbiXhwq_d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150615>

Am 08.07.2010 22:09, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> On Thu, Jul 8, 2010 at 19:40, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> +if git grep ile a
>>> +then
>>> +     test_expect_success 'git grep ile a' 'git grep ile a'
>>> +else
>>> +     test_expect_failure 'git grep ile a' 'git grep ile a'
>>> +fi
>>
>> So if command "X" is known to succeed, we run it inside expect_succe=
ss
>> and if not we run it inside expect_failure?
>>
>> What kind of idiocy is that, I have to wonder...
>=20
> Well, the point is to normalize the test suite so that we never have
> passing TODO tests if everything's OK.

In this particular case the tested functionality is not provided accros=
s
all platforms supported by git.  It would be better to fix the actual
issue, namely that the fallback regex lib we provide doesn't support
REG_STARTEND.

Ren=C3=A9
