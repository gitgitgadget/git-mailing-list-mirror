From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v3 2/2] headers: include dependent headers
Date: Sun, 07 Sep 2014 12:01:00 +0100
Message-ID: <540C3AEC.7080908@ramsay1.demon.co.uk>
References: <1410082617-59230-1-git-send-email-davvid@gmail.com> <540C350F.3080906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 07 13:01:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQaDf-00069C-9Y
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 13:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbaIGLBH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Sep 2014 07:01:07 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:37619 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752305AbaIGLBF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2014 07:01:05 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id A92EE400BE1;
	Sun,  7 Sep 2014 12:00:57 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 66F67400A99;
	Sun,  7 Sep 2014 12:00:57 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Sun,  7 Sep 2014 12:00:56 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <540C350F.3080906@web.de>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256620>

On 07/09/14 11:35, Ren=C3=A9 Scharfe wrote:
> Am 07.09.2014 um 11:36 schrieb David Aguilar:
>> Add dependent headers so that including a header does not
>> require including additional headers.
>>
>> This makes it so that "gcc -c $header" succeeds for each header.
>=20
>> diff --git a/cache.h b/cache.h
>> index 4d5b76c..8b827d7 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1,7 +1,6 @@
>>   #ifndef CACHE_H
>>   #define CACHE_H
>>
>> -#include "git-compat-util.h"
>>   #include "strbuf.h"
>>   #include "hashmap.h"
>>   #include "advice.h"
>=20
> Oh, that's a new change and worth mentioning in the commit message.

Hmm, does this not break git? Unless you also change each '.c' file whi=
ch
includes cache.h to also include git-compat-util.h first, then I suspec=
t
(if nothing else) file I/O may be broken. (see _FILE_OFFSET_BITS).

Also, see Documentation/CodingGuidelines (lines 331-333).

ATB,
Ramsay Jones
