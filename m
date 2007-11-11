From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Simplify strchrnul() compat code
Date: Sun, 11 Nov 2007 13:35:47 +0100
Message-ID: <4736F723.60904@op5.se>
References: <4733AEA0.1060602@lsrfire.ath.cx> <473434ED.50002@op5.se>	<47359C44.6090903@lsrfire.ath.cx> <4735BA79.5020102@op5.se> <7v6409f4eh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 13:36:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrC2p-0006si-Cc
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 13:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbXKKMfw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 07:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbXKKMfw
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 07:35:52 -0500
Received: from mail.op5.se ([193.201.96.20]:48146 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752935AbXKKMfv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 07:35:51 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 059E61F0874B;
	Sun, 11 Nov 2007 13:35:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9bwechrgOcv8; Sun, 11 Nov 2007 13:35:49 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id B85C01F0874A;
	Sun, 11 Nov 2007 13:35:48 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <7v6409f4eh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64450>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
>=20
>> Ren=E9 Scharfe wrote:
>>>  -#ifdef NO_STRCHRNUL
>>> +#if !defined(__GLIBC__) && !__GLIBC_PREREQ(2, 1)
>> This will break things for users of glibc-2.1.1 (the first release s=
till
>> available from ftp://sources.redhat.com/pub/glibc/old-releases that
>> includes the strchrnul() function), since __GLIBC_PREREQ() was inven=
ted
>> after strchrnul() was introduced.
>>
>> Replacing __GLIBC__ with __GLIBC_PREREQ (as in the original patch) w=
ill
>> solve it nicely. Users of glibc-2.1.1 will be the odd minority where
>> strchrnul() is available in their libc but not used.
>=20
> Do you mean this on top of Ren=E9's patch?

Yes.

>  Although I do not
> think I saw "the original patch" that did it this way,

My memory seems to be failing. I never committed my proposal to my repo=
,
and the one I sent out was the __GLIBC__ || !__GLIBC_PREREQ thing. My
apologies.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
