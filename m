From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [BUG] t9101 (master) busted on Leopard
Date: Fri, 16 Nov 2007 09:37:55 +0100
Message-ID: <E20C625B-100C-44B0-9AF3-7342DAF9B2A7@wincent.com>
References: <D68F81D3-5833-460B-BC7A-98C7E1D8B3E4@wincent.com> <BB9A8E3F-DC19-4844-80E1-6AEAADF926CD@silverinsanity.com> <041C0054-5E50-483C-9779-B2FE1AE6947C@wincent.com> <8B2E66EB-22C7-4C08-9947-C0D6A755309F@pp.inet.fi>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
X-From: git-owner@vger.kernel.org Fri Nov 16 09:38:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IswiV-0003aG-MA
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 09:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbXKPIiH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2007 03:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbXKPIiG
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 03:38:06 -0500
Received: from wincent.com ([72.3.236.74]:41444 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752548AbXKPIiF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2007 03:38:05 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAG8buPE013651;
	Fri, 16 Nov 2007 02:37:57 -0600
In-Reply-To: <8B2E66EB-22C7-4C08-9947-C0D6A755309F@pp.inet.fi>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65204>

El 16/11/2007, a las 5:25, V=E4in=F6 J=E4rvel=E4 escribi=F3:

> On Nov 15, 2007, at 18:11, Wincent Colaiuta wrote:
>
>> I don't use Darwin Ports or Fink, and this is a clean Leopard =20
>> install (ie. nothing installed in /usr/local apart from git and a =20
>> very small number of other tools that aren't related to Subversion).
>>
>> This is the output of "/usr/bin/svn --version":
>>
>> svn, version 1.4.4 (r25188)
>>  compiled Sep 23 2007, 22:32:34
>>
>> Perhaps then it is something in the environment.
>
> I cannot reproduce this on Leopard (not yet updated to 10.5.1). I =20
> tested this with self-compiled GIT from commit id ca2b71c
>
> svn version is the same as yours, I do use Fink, and I have used =20
> Fink to install Perl SVN bindings.

Strange. I've looked in the environment and there is nothing =20
suspicious; in fact, running the tests with a totally clean =20
environment (env -i ./t9101-git-svn-props.sh) produces exactly the =20
same result.

This was with commit 039bc64e (HEAD of master yesterday). I just =20
tested the commit you mention (HEAD of next) and get the same failure; =
=20
this is the procedure I'm using to test:

git fetch
git checkout -b next_test origin/next
git describe # (v1.5.3.5-1780-gca2b71c)
git clean
make clean && make
cd t
env -i ./t9101-git-svn-props.sh

So really, not sure what could be causing this.

Cheers,
Wincent
