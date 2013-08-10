From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v4] gc: reject if another gc is running, unless --force is given
Date: Sat, 10 Aug 2013 09:11:33 +0200
Message-ID: <m238qiyq8q.fsf@linux-m68k.org>
References: <1375712354-13171-1-git-send-email-pclouds@gmail.com>
	<1375959938-6395-1-git-send-email-pclouds@gmail.com>
	<CAPrKj1bO1jBsv73beA6LoeN09S-jWq8FYOP+WQ-AFwb1dn4Wsw@mail.gmail.com>
	<CACsJy8D8EHpPGrc8MZnpvmh1j1LDudoZ0OO-zyfuDmhwLJqNsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andres Perera <andres.p@zoho.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 09:12:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V83LD-0001Ww-1w
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 09:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757575Ab3HJHLz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Aug 2013 03:11:55 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:42850 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757511Ab3HJHLy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 03:11:54 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3cBvdD5tZXz3hhpd;
	Sat, 10 Aug 2013 09:11:44 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3cBvdD5grgzbbpC;
	Sat, 10 Aug 2013 09:11:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id G9iY4dkRBd00; Sat, 10 Aug 2013 09:11:43 +0200 (CEST)
X-Auth-Info: jMiK5UO51BqRtLEc4NjWi5BvYzkpwldb95Cw2AnRqyY=
Received: from linux.local (ppp-88-217-120-19.dynamic.mnet-online.de [88.217.120.19])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat, 10 Aug 2013 09:11:43 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id A9A281E52B0; Sat, 10 Aug 2013 09:11:35 +0200 (CEST)
X-Yow: I wonder if I could ever get started in the credit world?
In-Reply-To: <CACsJy8D8EHpPGrc8MZnpvmh1j1LDudoZ0OO-zyfuDmhwLJqNsA@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 10 Aug 2013 07:45:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232074>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Aug 9, 2013 at 11:29 PM, Andres Perera <andres.p@zoho.com> wr=
ote:
>> On Thu, Aug 8, 2013 at 6:35 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>> +       uintmax_t pid;
>>
>> pid_t is always an signed type, therefore unintmax_t does not make
>> sense as a catch all value
>
> I only catch real process id. In practice we don't have processes wit=
h
> negative pid_t, do we? I can't find any document about this, but at
> least waitpid seems to treat negative pid (except -1) just as an
> indicator while the true pid is the positive counterpart.

Negative pids are used for denoting process groups in various
interfaces.  No process can have a negative pid.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
