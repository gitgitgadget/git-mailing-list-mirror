From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: installation issue when building with NO_CURL=YesPlease
Date: Wed, 26 May 2010 21:03:30 +0200
Message-ID: <4BFD7082.1080608@dirk.my1.cc>
References: <5B1E2CF0-4BC4-43FF-A372-EB3582DA6286@aol.com>            <AANLkTimsGdv-La_poLpdrvuGChD6_sAD77fcjqKn5PAd@mail.gmail.com>            <8E0CE121-DB2F-4017-AB46-282562B072FB@aol.com>            <4BFD680E.8000603@dirk.my1.cc> <80typu1ozt.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>,
	Paul Walker <PWalker752@aol.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	git@drmicha.warpmail.net
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Wed May 26 21:03:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHLtD-0002Bs-QA
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 21:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844Ab0EZTDc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 May 2010 15:03:32 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.35]:51514 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836Ab0EZTDb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 15:03:31 -0400
X-Greylist: delayed 2159 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2010 15:03:31 EDT
Received: from [84.176.97.116] (helo=[192.168.2.100])
	by smtprelay01.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1OHLt3-0003hQ-NP; Wed, 26 May 2010 21:03:29 +0200
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <80typu1ozt.fsf@tiny.isode.net>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147820>

Am 26.05.2010 20:45 schrieb Bruce Stephens:
> Dirk S=C3=BCsserott <newsletter@dirk.my1.cc> writes:
>=20
> [...]
>=20
>> I had a similar problem when "make install"ing under AIX. Not with
>> NO_CURL but with some other NO_* option. I forgot which.
>> This yealded to an empty $(REMOTE_***_ALIASES) macro
>> (REMOTE_CURL_ALIASES in your case) which my AIX shell cannot handle.
>>
>> It reads "for p in; do" which makes it unhappy. I solved my problem
>> with the SHELL_PATH environment variable (look at the first few line=
s
>> in the Makefile).
>>
>> $ SHELL_PATH=3D/bin/bash NO_SOMETHING=3DYesPlease make install
>>
>> then worked fine for me.
>=20
> It wouldn't be too horrible to fix the Makefiles, though.  Doing stuf=
f
> like this works portably (judging by what some OpenSSL Makefiles do):
>=20
> 	foo=3D"$(REMOTE_CURL_ALIASES)"; for i in $$foo; do \
>=20
> [...]
>=20

Bruce,

I just saw that Michael posted a patch which tests for the emptyness of=
=20
REMOTE_CURL_ALIASES. Probably that's a more convenient solution.

Dirk
