X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: sizeof(struct ...)
Date: Thu, 23 Nov 2006 17:14:44 +0100
Message-ID: <4565C8F4.6000606@lsrfire.ath.cx>
References: <20061123101609.1711.qmail@8b73034525b1a6.315fe32.mid.smarden.org> <45659781.5050005@lsrfire.ath.cx> <4565A46C.6090805@lsrfire.ath.cx> <4565A866.8020201@shadowen.org> <4565C205.8050300@lsrfire.ath.cx> <20061123155431.GD6581@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 23 Nov 2006 16:15:29 +0000 (UTC)
Cc: Andy Whitcroft <apw@shadowen.org>, Gerrit Pape <pape@smarden.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <20061123155431.GD6581@harddisk-recovery.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32146>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnHER-0008Ui-MX for gcvg-git@gmane.org; Thu, 23 Nov
 2006 17:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757400AbWKWQPV convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006 11:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757404AbWKWQPU
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 11:15:20 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de
 ([217.172.187.230]:11904 "EHLO neapel230.server4you.de") by vger.kernel.org
 with ESMTP id S1757400AbWKWQPT (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23
 Nov 2006 11:15:19 -0500
Received: from [10.0.1.4] (p508E51A7.dip.t-dialin.net [80.142.81.167]) by
 neapel230.server4you.de (Postfix) with ESMTP id BF98C3C010; Thu, 23 Nov 2006
 17:15:17 +0100 (CET)
To: Erik Mouw <erik@harddisk-recovery.com>
Sender: git-owner@vger.kernel.org

Erik Mouw schrieb:
> On Thu, Nov 23, 2006 at 04:45:09PM +0100, Ren=E9 Scharfe wrote:
>>  Is there really a compiler that inserts padding between arrays of
>> unsigned chars?
>=20
> Yes, that compiler is called "gcc".
>=20
> #include <stdio.h>
>=20
> struct foo {
>         unsigned char a[3];
>         unsigned char b[3];
> };
>=20
> int main(void)
> {
>         printf("%d\n", sizeof(struct foo));
>         return 0;
> }
>=20
> On i386 that prints 6, on ARM it prints 8.

Does it add 1 byte after a and and 1 after b or two after b?
I suspect it's the latter case -- otherwise Gerrit's patch,
which started this thread, wouldn't help solve his problem.
Or the pad sizing follows complicated rules that I do not
understand at the moment.

Time to look for an ARM emulator, it seems.

Thanks,
