From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v3 2/2] read-cache: plug a few leaks
Date: Sun, 09 Jun 2013 04:11:24 +0200
Message-ID: <51B3E44C.4030304@lsrfire.ath.cx>
References: <1370644168-4745-1-git-send-email-felipe.contreras@gmail.com> <1370644168-4745-3-git-send-email-felipe.contreras@gmail.com> <51B31651.6020307@lsrfire.ath.cx> <CAMP44s2Bp5p1211e6Utdch4B+v3J83GCY0_ucG7duakswkb+pg@mail.gmail.com> <51B32FFD.5070302@lsrfire.ath.cx> <CAMP44s3K=VtkeCoKqnU9To9YbfO7vph9MsMWtgLWw0n=cYyq5g@mail.gmail.com> <51B35414.1090101@lsrfire.ath.cx> <CAMP44s3UYCX+DzgnErB=0GdD3w5k2GkNKjv46ZA_NVHm1Z0YLQ@mail.gmail.com> <51B36849.3030608@lsrfire.ath.cx> <CAMP44s1ffOUd3DkphHAj8ZmovBazPFdMgtvEptR6kW9+ZMLLjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 04:11:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlV6e-0003QP-GJ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 04:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349Ab3FICL3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 22:11:29 -0400
Received: from india601.server4you.de ([85.25.151.105]:59006 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab3FICL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 22:11:29 -0400
Received: from [192.168.2.105] (p579BE82C.dip0.t-ipconnect.de [87.155.232.44])
	by india601.server4you.de (Postfix) with ESMTPSA id 00427239;
	Sun,  9 Jun 2013 04:11:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CAMP44s1ffOUd3DkphHAj8ZmovBazPFdMgtvEptR6kW9+ZMLLjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226868>

Am 08.06.2013 19:27, schrieb Felipe Contreras:
> On Sat, Jun 8, 2013 at 12:22 PM, Ren=C3=A9 Scharfe
> <rene.scharfe@lsrfire.ath.cx> wrote:
>
>> Let's find and fix those leaks by freeing memory in the right places=
=2E
>> Freeing memory just in case in places where we can show that no leak=
 is
>> triggered by our test suite doesn't help.
>
> It helps; it prevents leaks. The real culprit is the bogus API, but I
> don't see that changing anytime soon, so there are two options when
> somebody makes a mistake the API allows; leak or don't leak. And you
> seem to prefer the leak, even though it provides absolutely no
> advantage.

It covers up bugs, which may seem helpful, but isn't, because it's=20
better to fix the actual mistake.

What would be a better API?  Making discard_index free the array is a=20
good first step; what else is bogus?

Ren=C3=A9
