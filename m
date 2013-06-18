From: =?UTF-8?Q?Mathieu_Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
Subject: Re: [PATCH] send-email: allow use of basic email list in --cc --to  and --bcc
Date: Tue, 18 Jun 2013 12:54:05 +0200
Message-ID: <0ad4bd4930efddcbaa5ed958c6758894@ensibm.imag.fr>
References: <1371549079-19291-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
 <CALkWK0=vytkxM3yzVaed+i3Q+RpvH=tSLndf=vUmiYC=sn=nFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>, <git@vger.kernel.org>,
	<gitster@pobox.com>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 12:54:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UotYF-0005bo-LF
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 12:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542Ab3FRKyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 06:54:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53759 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285Ab3FRKyK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 06:54:10 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5IAs4lC009173
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Jun 2013 12:54:04 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5IAs5sv011007;
	Tue, 18 Jun 2013 12:54:05 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r5IAs5oS015816;
	Tue, 18 Jun 2013 12:54:05 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r5IAs5GX015815;
	Tue, 18 Jun 2013 12:54:05 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to mathieu.lienard--mayor@ensimag.fr using -f
In-Reply-To: <CALkWK0=vytkxM3yzVaed+i3Q+RpvH=tSLndf=vUmiYC=sn=nFg@mail.gmail.com>
X-Sender: mathieu.lienard--mayor@ensimag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 18 Jun 2013 12:54:04 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228192>

Le 2013-06-18 12:47, Ramkumar Ramachandra a =C3=A9crit=C2=A0:
> Jorge-Juan.Garcia-Garcia@ensimag.imag.fr wrote:
>> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
>> index 9f46f22..87641bc 100755
>> --- a/t/t9001-send-email.sh
>> +++ b/t/t9001-send-email.sh
>> @@ -1349,4 +1349,39 @@ test_expect_success $PREREQ=20
>> 'sendemail.aliasfile=3D~/.mailrc' '
>>         grep "^!someone@example\.org!$" commandline1
>>  '
>>
>> -test_done
>> +test_expect_success $PREREQ 'setup expected-list' '
>> [...]
>> +test_expect_success $PREREQ 'use email list in --cc --to and --bcc'=
=20
>> '
>
> What is the meaning of this test?  It looks like you've run git
> send-email twice in exactly the same way, and compared their outputs
> (after smudging the unstable headers).
The first one uses one flag per email address, just like we had to do=20
so far.
The second one uses one email-list per flag, which is the new feature=20
we're introducing.
Then we compare the output of the two, and expect it to be exactly the=20
same.

Shouldn't

$ git send-email --cc 'foo@example.com' --cc 'bar@example.com'

and

$ git send-email --cc 'foo@example.com, bar@example.com'

have the exact same effect ?
--=20
Mathieu Li=C3=A9nard--Mayor,
2nd year at Grenoble INP - ENSIMAG
(+33)6 80 56 30 02
