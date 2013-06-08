From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v3 2/2] read-cache: plug a few leaks
Date: Sat, 08 Jun 2013 17:56:04 +0200
Message-ID: <51B35414.1090101@lsrfire.ath.cx>
References: <1370644168-4745-1-git-send-email-felipe.contreras@gmail.com> <1370644168-4745-3-git-send-email-felipe.contreras@gmail.com> <51B31651.6020307@lsrfire.ath.cx> <CAMP44s2Bp5p1211e6Utdch4B+v3J83GCY0_ucG7duakswkb+pg@mail.gmail.com> <51B32FFD.5070302@lsrfire.ath.cx> <CAMP44s3K=VtkeCoKqnU9To9YbfO7vph9MsMWtgLWw0n=cYyq5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 17:56:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlLUz-0001iU-Lo
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 17:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855Ab3FHP4J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 11:56:09 -0400
Received: from india601.server4you.de ([85.25.151.105]:58960 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab3FHP4I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 11:56:08 -0400
Received: from [192.168.2.105] (p579BEA5D.dip0.t-ipconnect.de [87.155.234.93])
	by india601.server4you.de (Postfix) with ESMTPSA id 75339239;
	Sat,  8 Jun 2013 17:56:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CAMP44s3K=VtkeCoKqnU9To9YbfO7vph9MsMWtgLWw0n=cYyq5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226837>

Am 08.06.2013 16:04, schrieb Felipe Contreras:
> On Sat, Jun 8, 2013 at 8:22 AM, Ren=C3=A9 Scharfe
> <rene.scharfe@lsrfire.ath.cx> wrote:
>> Am 08.06.2013 14:15, schrieb Felipe Contreras:
>
>>> Why leave it out? If somebody makes the mistake of doing the above
>>> sequence, would you prefer that we leak?
>>
>> Leaking is better than silently cleaning up after a buggy caller bec=
ause it
>> still allows the underlying bug to be found.
>
> No, it doesn't. The pointer is replaced and forever lost. How is
> leaking memory helping anyone to find the bug?

Valgrind can tell you where leaked memory was allocated, but not if you=
=20
free it in the "wrong" place.

Ren=C3=A9
