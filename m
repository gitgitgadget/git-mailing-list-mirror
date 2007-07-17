From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Installation failure caused by CDPATH environment variable
Date: Tue, 17 Jul 2007 21:07:37 +0200
Message-ID: <2D8FF91A-02B0-44AF-8B7C-5C46DD6AF352@wincent.com>
References: <9693D8E9-6F11-4AA1-AFCA-7E8456FA6420@wincent.com> <7vejje3a4k.fsf@assigned-by-dhcp.cox.net> <20070717114024.GA12215@informatik.uni-freiburg.de> <7vhco2ancg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 21:08:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAsPA-0000Ch-PP
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 21:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757074AbXGQTIM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Jul 2007 15:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756426AbXGQTIL
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 15:08:11 -0400
Received: from wincent.com ([72.3.236.74]:55842 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756179AbXGQTIK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 15:08:10 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l6HJ82Lx007273;
	Tue, 17 Jul 2007 14:08:03 -0500
In-Reply-To: <7vhco2ancg.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52790>


El 17/7/2007, a las 20:37, Junio C Hamano escribi=F3:

> Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de> writes:
>
>> Junio C Hamano wrote:
>>> We could write it as "$(TAR) Ccf blt - ." if we can rely on the
>>> 'C' option, but I suspect it is a GNU extension.  Does anybody
>>> have POSIX.1 handy?
>> I don't have POSIX.1 handy, but on Solaris 10, you need to say:
>>
>> 	tar cf - -C blt .
>>
>> (That is, Solaris' tar has the 'C' option, which is quite a good
>> indication, that it's included in POSIX :-)
>
> Oh, I cannot resist ;-)
>
> Solaris has unlink(2) capable of removing a directory, but I do
> not think it is included in POSIX.

I'd say the answer is "no", "C" isn't in the POSIX tar specification.

The latest, Version 3, says "the Shell and Utilities volume of IEEE =20
Std 1003.1-2001 no longer contains the tar utility" (<http://=20
www.opengroup.org/onlinepubs/009695399/basedefs/tar.h.html>).

And Version 2, which does contain tar, does not list "C" as an option =20
(<http://www.opengroup.org/onlinepubs/7990989775/xcu/tar.html>).

In fact, the example they give for moving directory hierarchies is =20
exactly this:

   (cd fromdir; tar cf - . ) | (cd todir; tar xf -)

Cheers,
Wincent
