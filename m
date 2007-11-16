From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [BUG] t9101 (master) busted on Leopard
Date: Fri, 16 Nov 2007 11:17:03 +0100
Message-ID: <EBFD3ABD-CD7F-4B9C-AB9D-F440C368AB61@wincent.com>
References: <D68F81D3-5833-460B-BC7A-98C7E1D8B3E4@wincent.com> <BB9A8E3F-DC19-4844-80E1-6AEAADF926CD@silverinsanity.com> <041C0054-5E50-483C-9779-B2FE1AE6947C@wincent.com> <8B2E66EB-22C7-4C08-9947-C0D6A755309F@pp.inet.fi> <E20C625B-100C-44B0-9AF3-7342DAF9B2A7@wincent.com> <4207CF02-36BD-4733-9861-17B0C4DB9D94@pp.inet.fi>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
X-From: git-owner@vger.kernel.org Fri Nov 16 11:17:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsyGQ-0007Ze-75
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 11:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756131AbXKPKRO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2007 05:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755685AbXKPKRN
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 05:17:13 -0500
Received: from wincent.com ([72.3.236.74]:41616 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755157AbXKPKRN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2007 05:17:13 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAGAH661016484;
	Fri, 16 Nov 2007 04:17:06 -0600
In-Reply-To: <4207CF02-36BD-4733-9861-17B0C4DB9D94@pp.inet.fi>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65211>

El 16/11/2007, a las 9:59, V=E4in=F6 J=E4rvel=E4 escribi=F3:

> On Nov 16, 2007, at 10:37, Wincent Colaiuta wrote:
>
>> Strange. I've looked in the environment and there is nothing =20
>> suspicious; in fact, running the tests with a totally clean =20
>> environment (env -i ./t9101-git-svn-props.sh) produces exactly the =20
>> same result.
>>
>> This was with commit 039bc64e (HEAD of master yesterday). I just =20
>> tested the commit you mention (HEAD of next) and get the same =20
>> failure; this is the procedure I'm using to test:
>>
>> git fetch
>> git checkout -b next_test origin/next
>> git describe # (v1.5.3.5-1780-gca2b71c)
>> git clean
>> make clean && make
>> cd t
>> env -i ./t9101-git-svn-props.sh
>>
>> So really, not sure what could be causing this.
>
> Did you forget to install the newly compiled version? Or does the =20
> test system use git from the source tree?

I didn't install the newly compiled version because, as far as know, =20
the test system uses the built copy in the source tree (I can't =20
actually recall *any* Makefile-based open source projects that didn't =20
work like that).

$ git --version
git version 1.5.3.5
$ /usr/local/bin/git --version
git version 1.5.3.5
$ ./git --version # (from inside the source tree)
git version 1.5.3.5.1780.gca2b
$ env -i git --version
env: git: No such file or directory

So the test run above *must* be using the just-built copy in the =20
source tree otherwise *none* of the tests would pass.

Cheers,
Wincent
