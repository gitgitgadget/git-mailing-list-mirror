From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] test: skip test with COLUMNS=1 under mksh
Date: Sat, 28 Apr 2012 13:09:18 +0200
Message-ID: <4F9BCFDE.1090103@in.waw.pl>
References: <20120426223422.GC22261@camk.edu.pl> <1335518725-19728-1-git-send-email-zbyszek@in.waw.pl> <xmqqehr99mz3.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org,
	Lucian Poston <lucian.poston@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 29 19:18:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOXlM-0004Sc-BN
	for gcvg-git-2@plane.gmane.org; Sun, 29 Apr 2012 19:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364Ab2D2RSQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Apr 2012 13:18:16 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35706 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754354Ab2D2RSP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 13:18:15 -0400
Received: from ip-37-209-130-26.free.aero2.net.pl ([37.209.130.26])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SOXlF-0000Mz-FU; Sun, 29 Apr 2012 19:18:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <xmqqehr99mz3.fsf@junio.mtv.corp.google.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196512>

On 04/27/2012 06:08 PM, Junio C Hamano wrote:
> Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:
>=20
>> mksh does not allow $COLUMNS to be set below 12. Quoting mksh(1)
>> $COLUMNS is "always set, defaults to 80, unless the value as reporte=
d
>> by stty(1) is non-zero and sane enough". This applies also to settin=
g
>> it directly for one command:
>>
>> $ COLUMNS=3D30 python -c 'import os; print os.environ["COLUMNS"]'
>> 30
>> $ COLUMNS=3D20 python -c 'import os; print os.environ["COLUMNS"]'
>> 20
>> $ COLUMNS=3D10 python -c 'import os; print os.environ["COLUMNS"]'
>> 98
>=20
> I'd hate to say this, but that shell is broken.
Yes.

>> Let's test if we can set COLUMNS=3D1, and if not, skip the tests tha=
t
>> want to use that. A prereq is added, which is set if $COLUMNS can be
>> set.
>=20
> And I think that is a sensible workaround, even though COLUMNS_CAN_BE=
_1
> might not be the best name for it.
>=20
>> +( COLUMNS=3D1 && test $COLUMNS =3D 1 ) && test_set_prereq COLUMNS_C=
AN_BE_1
>=20
> This is different from what you wrote in your log message, but I trus=
t
> that it will fail under the problematic shell?
Yes.

> Will queue; thanks.
Cool.

Zbyszek
