From: Timo Sirainen <tss@iki.fi>
Subject: Re: Buffer overflows
Date: Fri, 31 Aug 2007 00:08:22 +0300
Message-ID: <7D84F3C7-129D-4197-AAF1-46298E5D0136@iki.fi>
References: <1188502009.29782.874.camel@hurina> <alpine.LFD.0.999.0708301340470.25853@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-3--252494367"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 30 23:08:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQrFy-0006VP-Nz
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 23:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762742AbXH3VI2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 17:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762729AbXH3VI1
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 17:08:27 -0400
Received: from dovecot.org ([82.118.211.50]:60198 "EHLO dovecot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760799AbXH3VI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 17:08:26 -0400
Received: from [192.168.10.217] (82-203-162-146.dsl.gohome.fi [82.203.162.146])
	by dovecot.org (Postfix) with ESMTP id 7C83DFA895F;
	Fri, 31 Aug 2007 00:08:24 +0300 (EEST)
In-Reply-To: <alpine.LFD.0.999.0708301340470.25853@woody.linux-foundation.org>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57072>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-3--252494367
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On 30.8.2007, at 23.46, Linus Torvalds wrote:

> On Thu, 30 Aug 2007, Timo Sirainen wrote:
>>
>> Looks like nothing has happened since my last mail about this
>> (http://marc.info/?l=git&m=117962988804430&w=2).
>
> Perhaps because your patch was using a totally nonstandard and slow
> interface, and had nasty string declaration issues, as people even  
> pointed
> out to you.

Slow?

> If you were to send in a patch that simply just fixed some random case
> without introducing the other stuff in forms that nobody is used to,
> people would probably react more.

The problem is that the git code is full of these random cases. It's  
simply a huge job to even try to verify the correctness of it. Even  
if someone did that and fixed all the problems, tomorrow there would  
be new ones because noone bothers to even try to avoid them. So there  
really isn't any point in trying to make git secure until the coding  
style changes.

The code should be easy to verify to be secure, and with some kind of  
a safe string API it's a lot easier than trying to figure out corner  
cases where strcpy() calls break.

> Especially since:
>
>> I sure hope no-one's using git-mailinfo to do any kind of  
>> automated mail
>> processing from untrusted users.
>
> Obviously nobody would do that. Not because of any email buffer  
> overflows,
> but because people wouldn't want to apply untrusted patches in the  
> first
> place!

And anyone who uses git-mailinfo for anything else than manually  
applying trusted patches to their own tree deserve what they get, I  
suppose? For example if I decided to use it to automatically extract  
patches and their descriptions out of received emails and put them in  
a queue somewhere where I could look at them more easily.

--Apple-Mail-3--252494367
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (Darwin)

iD8DBQFG1zHKyUhSUUBViskRArHrAJ9jzlvBE0mVhSt6WkqPFRinzoILIgCaA9jq
pdv2qbDQ/rkx4vDw5FR9zI8=
=4S4s
-----END PGP SIGNATURE-----

--Apple-Mail-3--252494367--
