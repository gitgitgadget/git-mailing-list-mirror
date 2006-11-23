X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: sizeof(struct ...)
Date: Thu, 23 Nov 2006 16:19:14 +0000
Message-ID: <4565CA02.20602@shadowen.org>
References: <20061123101609.1711.qmail@8b73034525b1a6.315fe32.mid.smarden.org> <45659781.5050005@lsrfire.ath.cx> <4565A46C.6090805@lsrfire.ath.cx> <4565A866.8020201@shadowen.org> <4565C205.8050300@lsrfire.ath.cx> <20061123155431.GD6581@harddisk-recovery.com> <4565C8F4.6000606@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 23 Nov 2006 16:19:30 +0000 (UTC)
Cc: Erik Mouw <erik@harddisk-recovery.com>,
	Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
In-Reply-To: <4565C8F4.6000606@lsrfire.ath.cx>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32148>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnHIL-000125-NB for gcvg-git@gmane.org; Thu, 23 Nov
 2006 17:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755970AbWKWQTX convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006 11:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757403AbWKWQTX
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 11:19:23 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:51471 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1755970AbWKWQTW
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 11:19:22 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GnHHT-0000sH-Lv; Thu, 23 Nov 2006 16:18:31 +0000
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org

Ren=E9 Scharfe wrote:
> Erik Mouw schrieb:
>> On Thu, Nov 23, 2006 at 04:45:09PM +0100, Ren=E9 Scharfe wrote:
>>>  Is there really a compiler that inserts padding between arrays of
>>> unsigned chars?
>> Yes, that compiler is called "gcc".
>>
>> #include <stdio.h>
>>
>> struct foo {
>>         unsigned char a[3];
>>         unsigned char b[3];
>> };
>>
>> int main(void)
>> {
>>         printf("%d\n", sizeof(struct foo));
>>         return 0;
>> }
>>
>> On i386 that prints 6, on ARM it prints 8.
>=20
> Does it add 1 byte after a and and 1 after b or two after b?
> I suspect it's the latter case -- otherwise Gerrit's patch,
> which started this thread, wouldn't help solve his problem.
> Or the pad sizing follows complicated rules that I do not
> understand at the moment.
>=20
> Time to look for an ARM emulator, it seems.

Perhaps we can look and see what a portable application like gzip or
bzip2 do in this situation.  They must have the same problem.

