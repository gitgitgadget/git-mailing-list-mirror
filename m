From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [RFC/PATCH] i18n of multi-line messages
Date: Thu, 22 Dec 2011 12:56:36 +0100
Message-ID: <m2r4zw4y6j.fsf@igel.home>
References: <7vr4zxeaz5.fsf@alter.siamese.dyndns.org>
	<4EF2D436.3080303@viscovery.net>
	<7vaa6ldpk6.fsf@alter.siamese.dyndns.org> <4EF30907.8070101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
	<avarab@gmail.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 22 12:56:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdhGS-0007z8-5s
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 12:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab1LVL4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Dec 2011 06:56:43 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:37051 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1LVL4m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2011 06:56:42 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 33B7E1800601;
	Thu, 22 Dec 2011 12:56:37 +0100 (CET)
X-Auth-Info: DBVVsbYsa3aZ7J+7PnW6QvhgMMTuZySNScoIzx/qrRk=
Received: from igel.home (ppp-88-217-105-217.dynamic.mnet-online.de [88.217.105.217])
	by mail.mnet-online.de (Postfix) with ESMTPA id 89C791C00107;
	Thu, 22 Dec 2011 12:56:37 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 19BEACA29C; Thu, 22 Dec 2011 12:56:37 +0100 (CET)
X-Yow: ..  So, if we convert SUPPLY-SIDE SOYBEAN FUTURES into
 HIGH-YIELD T-BILL INDICATORS, the PRE-INFLATIONARY risks
 will DWINDLE to a rate of 2 SHOPPING SPREES per EGGPLANT!!
In-Reply-To: <4EF30907.8070101@gmail.com> (Chris Packham's message of "Thu, 22
	Dec 2011 23:40:07 +1300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187607>

Chris Packham <judge.packham@gmail.com> writes:

> Hi Junio,
>
> On 12/22/2011 08:38 PM, Junio C Hamano wrote:
>> +	for (cp = buf.buf; *cp; cp = np) {
>> +		np = strchrnul(cp, '\n');
>> +		/*
>> +		 * TRANSLATORS: the format is designed so that in RTL
>> +		 * languages you could reorder and put the "prefix" at
>> +		 * the end instead of the beginning of a line if you
>> +		 * wanted to.
>> +		 */
>> +		strbuf_addf(&line,
>> +			    _("%s: %.*s\n"),
>> +			    prefix,
>> +			    (int)(np - cp), cp);
>> +		emit(&line, cb_data);
>> +		strbuf_reset(&line);
>> +		if (*np)
>> +			np++;
>> +	}
>
> Forgive my ignorance if I've missed something, but how is this going to
> work for RTL languages? Translators can change the format string but
> they can't change the order of parameters passed to strbuf_addf.

Translations can select the parameters to use with the n$ specification,
eg. "%3$.*2$s: %$1s\n"

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
