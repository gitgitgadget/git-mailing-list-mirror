From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v3] MSVC: fix t0040-parse-options crash
Date: Sat, 29 Mar 2014 23:17:11 +0100
Message-ID: <53374667.3080605@web.de>
References: <1396008298-1434-1-git-send-email-marat@slonopotamus.org>	<1396123762-28673-1-git-send-email-marat@slonopotamus.org> <87ha6gpu2t.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Andreas Schwab <schwab@linux-m68k.org>,
	Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Sat Mar 29 23:17:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WU1ZO-0006Zw-NI
	for gcvg-git-2@plane.gmane.org; Sat, 29 Mar 2014 23:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbaC2WRh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Mar 2014 18:17:37 -0400
Received: from mout.web.de ([212.227.17.12]:55685 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775AbaC2WRg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2014 18:17:36 -0400
Received: from [192.168.178.27] ([79.253.156.171]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LuuSf-1XBqoO3j9N-0106mB; Sat, 29 Mar 2014 23:17:34
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <87ha6gpu2t.fsf@igel.home>
X-Provags-ID: V03:K0:WOvaOXzfsmEiNxtLrooZma+axU+Vb2FgVwQfQd35fcWIkYXR7RD
 26b5fHpuiB5A5z4sZoo0hTIsEej/rmlU2W00Xonq4ZZqXQXp0yn1UTZOo9jEnMPpyLON6QO
 I/vOMVpdzeYBN57F5oI0412QB9bMZeZym/c8R4t0ktBPZ0pDAdpZrp1RsEvZqlcfkQFc2k9
 9m4uJX6G0/zhKI36QlGhw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245442>

Am 29.03.2014 22:34, schrieb Andreas Schwab:
> Marat Radchenko <marat@slonopotamus.org> writes:
>
>> diff --git a/test-parse-options.c b/test-parse-options.c
>> index 434e8b8..6f6c656 100644
>> --- a/test-parse-options.c
>> +++ b/test-parse-options.c
>> @@ -60,7 +60,7 @@ int main(int argc, char **argv)
>>   		OPT_STRING('o', NULL, &string, "str", "get another string"),
>>   		OPT_NOOP_NOARG(0, "obsolete"),
>>   		OPT_SET_PTR(0, "default-string", &string,
>> -			"set string to default", (unsigned long)"default"),
>> +			"set string to default", (intptr_t)"default"),
>
> Why doesn't OPT_SET_PTR take a pointer?

Good question.  Here's another: OPT_SET_PTR (and OPTION_SET_PTR) has=20
only ever been used by test-parse-options; can we remove it?

Ren=E9
