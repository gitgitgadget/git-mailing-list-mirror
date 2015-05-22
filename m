From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 01/18] t1404: new tests of ref D/F conflicts within
 transactions
Date: Sat, 23 May 2015 00:47:53 +0200
Message-ID: <555FB219.3090300@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>	<1431357920-25090-2-git-send-email-mhagger@alum.mit.edu>	<xmqqlhgu3nyl.fsf@gitster.dls.corp.google.com>	<5551BA88.3090900@alum.mit.edu>	<CAPc5daVQEMv-QPDpyNVGzcjrjrw20QLzm8dkC0ZYAX=Y4zGaBQ@mail.gmail.com>	<5553B1E0.9080008@alum.mit.edu> <xmqqr3qj857t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 00:48:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvvjl-0000jp-88
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 00:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756959AbbEVWsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 18:48:12 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:52528 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756896AbbEVWsL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 18:48:11 -0400
X-AuditID: 12074411-f796c6d000000bc9-e7-555fb21c621b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id F9.02.03017.C12BF555; Fri, 22 May 2015 18:47:56 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3AFA.dip0.t-ipconnect.de [93.219.58.250])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4MMlrYB005251
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 22 May 2015 18:47:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqr3qj857t.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqCuzKT7U4PA7UYuuK91MFg29V5gt
	frT0MFts3tzOYnHmTSOjA6vHgk2lHs969zB6XLyk7LH4gZfH501yAaxR3DZJiSVlwZnpefp2
	CdwZLY9sCy5yVbQe2c3ewLiLo4uRk0NCwESi91orE4QtJnHh3nq2LkYuDiGBy4wS7X1rmUES
	QgLnmSQunSsAsXkFtCWefZrADmKzCKhKfGq7DFbDJqArsainGWyQqECQROu1qYwQ9YISJ2c+
	YQGxRQTUJCa2HWIBWcAssIRR4vb/eawgCWGBSInbM/8zQmx+wCRx4dVPNpAEp4C1xM9ZM8Gm
	MgvoSey4/osVwpaXaN46m3kCo8AsJEtmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy8
	1CJdU73czBK91JTSTYyQABfcwTjjpNwhRgEORiUeXoODcaFCrIllxZW5hxglOZiURHlXrYgP
	FeJLyk+pzEgszogvKs1JLT7EKMHBrCTCG9ENlONNSaysSi3Kh0lJc7AoifPyLVH3ExJITyxJ
	zU5NLUgtgsnKcHAoSfCybARqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFanwx
	MFpBUjxAe7VB2nmLCxJzgaIQracYFaXEeeVAEgIgiYzSPLixsLT1ilEc6Eth3hSQKh5gyoPr
	fgU0mAlo8KoJsSCDSxIRUlINjLoWPJF8d/OKb27zDf9iekT3gOeRrOfZwpXpjz8xTTpwny1+
	sYBYgXe7x80FJxjT+sxvKz/sK9jizbpn/vIrpo/377RLkp0ZaLIkdifrr5KLm20F 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269768>

On 05/14/2015 07:00 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>>> But there is a i18n markings test, for which test-i18ngrep was invented for.
>>
>> Thanks for the info. I wasn't aware of that facility.
>>
>> So if I understand correctly, s/grep/test_i18ngrep/ will address your
>> concern? That's fine with me.
> 
> Thinking about it again, should these messages ever be translated,
> or are they plumbing messages that should never get translated?
> 
> If the latter, then 'grep' is the right thing to do; in fact, it
> would be a bug in the test if we used test_i18ngrep.
> 
> 	Side note: besides, I think gettext-poison tests have bitrot
> 	and are no longer very useful (if they ever were, that is).

I don't really know how to decide which messages should be translatable
and which not.

Obviously 'update-ref' is a plumbing command, but these same error
messages can be emitted by any reference transaction, such as when a
push fails, in which case they are visible to the user.

Some other errors that can result from ref transaction failures are
tested in t1400 with 'grep'.

I think using 'grep' is OK for now, and if they are internationalized in
the future the breakage will be pretty obvious and straightforward to fix.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
