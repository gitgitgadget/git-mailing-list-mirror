From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] fix t1504 on Windows
Date: Fri, 06 Feb 2009 22:45:23 +0100
Message-ID: <498CAF73.6050409@lsrfire.ath.cx>
References: <498A1E1E.8010901@lsrfire.ath.cx> <498B3F6B.5080002@lsrfire.ath.cx> <498C3328.70804@viscovery.net> <498C70C8.1080009@lsrfire.ath.cx> <498C8E43.8010108@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Feb 06 22:47:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVYXl-0006sv-CO
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 22:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767AbZBFVpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2009 16:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753593AbZBFVpb
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 16:45:31 -0500
Received: from india601.server4you.de ([85.25.151.105]:59949 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757276AbZBFVpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 16:45:25 -0500
Received: from [10.0.1.101] (p57B7E1CE.dip.t-dialin.net [87.183.225.206])
	by india601.server4you.de (Postfix) with ESMTPSA id A1F1D2F8056;
	Fri,  6 Feb 2009 22:45:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <498C8E43.8010108@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108790>

Johannes Sixt schrieb:
> Ren=C3=A9 Scharfe schrieb:
>> Johannes Sixt schrieb:
>>> -GIT_CEILING_DIRECTORIES=3D"foo:$TRASH_ROOT/sub"
>>> +GIT_CEILING_DIRECTORIES=3D"/foo:$TRASH_ROOT/sub"
>>>  test_fail second_of_two
>>>
>>>  GIT_CEILING_DIRECTORIES=3D"$TRASH_ROOT/sub:/bar"
>>>  test_fail first_of_two
>>>
>>> -GIT_CEILING_DIRECTORIES=3D"foo:$TRASH_ROOT/sub:bar"
>>> +GIT_CEILING_DIRECTORIES=3D"/foo:$TRASH_ROOT/sub:/bar"
>>>  test_fail second_of_three
>>
>> I don't, which makes me uneasy -- the tests shouldn't depend on deta=
ils
>> in our setup. :-/
>=20
> I updated my msysgit to the current master this moment, and I still n=
eed
> these two changes. Do you use an older msysgit? With 31d5dfeb0
> (2008-06-08) Steffen changed path mangling so that a text without a
> leading / or . is not converted. That's exactly what we see here.

Oh, yes, good idea.  I never updated the msys part of my installation.

My "uneasiness" doesn't mean that I'm against your changes above, in an=
y
case.

>>> That said, I'm in the process of preparing a series that includes y=
our
>>> patch and that does the proper cleanup and code moving that you aga=
in
>>> didn't do :-/ But it turns out that this is non-trivial because of
>>> bash's
>>> (MSYS's) I-know-better-what-is-a-path-and-what-not behavior. It wil=
l
>>> take
>>> some time...

> Johannes Sixt (4):
>       Make test-path-utils more robust against incorrect use
>       Move sanitary_path_copy to path.c (and rename to
>         normalize_path_copy)
>       Test and fix normalize_path_copy()
>       Remove unused normalize_absolute_path()

Yeah, OK.  I was aiming for a quick short fix, deferring cleanups to
when I have more time.  I wonder what patches one and three do, though.

Ren=C3=A9
