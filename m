From: SungHyun Nam <goweol@gmail.com>
Subject: Re: t9200-git-cvsexportcommit.sh failed on CYGWIN
Date: Fri, 29 Dec 2006 08:42:19 +0900
Message-ID: <4594565B.3090804@gmail.com>
References: <459338AA.8000407@gmail.com> <en0b47$bjm$3@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 29 00:42:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H04tQ-0000jA-72
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 00:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbWL1XmZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 28 Dec 2006 18:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbWL1XmZ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 18:42:25 -0500
Received: from relaygw1.kornet.net ([61.74.75.196]:36906 "EHLO
	relaygw1.kornet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbWL1XmY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 18:42:24 -0500
Received: from [211.48.62.137] ([211.48.62.137]) 
          by relaygw1.kornet.net ([61.74.75.196]) 
          with ESMTP id 2006122908:42:21:835889.19779.12258224
          Fri, 29 Dec 2006 08:42:21 +0900 (KST) 
Received: from [211.221.139.50] ([211.221.139.50]) 
          by relay9.kornet.net ([211.48.62.137]) 
          with ESMTP id 2006122908:42:21:307685.26377.66169776
          Fri, 29 Dec 2006 08:42:21 +0900 (KST) 
User-Agent: Thunderbird 2.0b1 (Windows/20061223)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <en0b47$bjm$3@sea.gmane.org>
X-Enigmail-Version: 0.94.1.2
OpenPGP: id=8509C67F
X-TERRACE-SPAMMARK: NOT spam-marked.                              
  (by Terrace)                                            
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35566>

Jakub Narebski wrote:
> [Cc: git@vger.kernel.org]
>=20
> SungHyun Nam wrote:
>=20
>> Below is the test messages.
>>
>> BTW, I hope I can define 'NO_CVS_TESTS' to skip this test.
> [...]
>> *   ok 7: Update file with spaces in file name
>> * FAIL 8: File with non-ascii file name
>>         mkdir -p
>=20
> What filesystem? Some filesystems are just broken...

NTFS (no FAT32 here).

Anyway, I test it step by step manually, and then...

$ cd tmp; mkdir t; cd t
$ ls -l
total 0
$ mkdir -p =C3=85/goo
mkdir: cannot create directory `=C3=85/goo': No such file or directory
$ ls -l
total 0
$ mkdir =C3=85
mkdir: cannot create directory `=C3=85': File exists
$ ls -l
total 0

I can create directory which contains Hangul (multibyte) characters.

$ mkdir ko_=ED=95=9C=EA=B8=80_lang
$ ls -l
total 0
drwxr-xr-x+ 2 namsh staff 0 Dec 29 08:41 ko_=ED=95=9C=EA=B8=80_lang/

Does it depend on Windows version? I use Korean version of Windows Home
Edition. I also test it with 'CYGWIN=3Dcodepage:ansi' without luck.

Thanks,
namsh
