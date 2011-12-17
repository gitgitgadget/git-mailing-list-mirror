From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Fix an "variable might be used uninitialized" gcc warning
Date: Sat, 17 Dec 2011 11:22:07 +0100
Message-ID: <m2iplffqgg.fsf@igel.home>
References: <4EEBC9D6.6010204@ramsay1.demon.co.uk>
	<20111216235908.GA5858@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 17 11:22:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbrPF-000338-Pf
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 11:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901Ab1LQKWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 05:22:14 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:51611 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab1LQKWN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 05:22:13 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id CB2CB1802EEA;
	Sat, 17 Dec 2011 11:22:07 +0100 (CET)
X-Auth-Info: WDv0kt2/SSHhSWi9YH9Z+DJCkE7w35fnWyoTAfS8d10=
Received: from igel.home (ppp-88-217-116-174.dynamic.mnet-online.de [88.217.116.174])
	by mail.mnet-online.de (Postfix) with ESMTPA id 094E81C0006E;
	Sat, 17 Dec 2011 11:22:08 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 59B1DCA29C; Sat, 17 Dec 2011 11:22:07 +0100 (CET)
X-Yow: I will establish the first SHOPPING MALL in NUTLEY, New Jersey...
In-Reply-To: <20111216235908.GA5858@elie.hsd1.il.comcast.net> (Jonathan
	Nieder's message of "Fri, 16 Dec 2011 17:59:08 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187369>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramsay Jones wrote:
>
>>         CC builtin/checkout.o
>>     builtin/checkout.c: In function `cmd_checkout':
>>     builtin/checkout.c:160: warning: 'mode' might be used uninitialized \
>>         in this function
> [...]
>> [Note that only 2 out of the 3 versions of gcc I use issues this
>> warning]
>
> Which version of gcc is that?  Is gcc getting more sane, so we won't
> have to worry about this after a while, or is the false positive a
> new regression that should be reported to them?

The regression is that the function has been changed in a way that makes
it impossible to infer the intended flow.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
