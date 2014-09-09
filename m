From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [RFC PATCH 2/2] headers: include dependent headers
Date: Tue, 09 Sep 2014 21:44:40 +0200
Message-ID: <540F58A8.7000500@web.de>
References: <1410031211-14599-1-git-send-email-davvid@gmail.com>	<1410031211-14599-2-git-send-email-davvid@gmail.com>	<540B7AA3.1090201@web.de> <xmqqfvg2ngrn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 21:45:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRRLv-0002XM-Bs
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 21:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbaIITpQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Sep 2014 15:45:16 -0400
Received: from mout.web.de ([212.227.15.4]:56815 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034AbaIITpK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 15:45:10 -0400
Received: from [192.168.178.27] ([79.253.149.57]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MKJAE-1XPnSI2WyE-001f7k; Tue, 09 Sep 2014 21:45:04
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <xmqqfvg2ngrn.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:vXW/2qHyoCIjmVhsy3ha2dkGGdo26SJ49ArM7NShSgS2MLWpKTI
 4M2PtaqAezcQKN0mNe/hMWGa8V6fBvt/x5dvrsHOB83wCGs1tyEoaWGMkEqvyWd21P/4X4V
 IOAO0+b7Z1s7tH80cmXLEoLFjoiQjc1IyW2YeCgf5bM33WuW7bo3zeJeDFQHEwI3+Fya2kV
 hsJeU6NfbSFb+HiwWK08g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256708>

Am 08.09.2014 um 19:50 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Am 06.09.2014 um 21:20 schrieb David Aguilar:
>>> Add dependent headers so that including a header does not
>>> require including additional headers.
>>>
>>> This makes it so that "gcc -c $header" succeeds for each header.
>>>
>>> Signed-off-by: David Aguilar <davvid@gmail.com>
>>> ---
>>
>>> diff --git a/branch.h b/branch.h
>>> index 64173ab..a61fd1a 100644
>>> --- a/branch.h
>>> +++ b/branch.h
>>> @@ -3,6 +3,9 @@
>>>
>>>    /* Functions for acting on the information about branches. */
>>>
>>> +#include "cache.h"
>>> +#include "strbuf.h"
>>
>> cache.h includes strbuf.h, so the line above isn't necessary.
>
> True, but is "gcc -c $header" something we want to please in the
> first place (not an objection, but request for opinions)?

It *sounds* useful, but we did without that feature so far.  Hmm.  It=20
would make it easier to use headers -- any dependency to other files ar=
e=20
already taken care of.  Since we have less .h files than .c files this=20
seems to make sense.

Would it perhaps also make using precompiled headers easier (or possibl=
e=20
in the first place)?  Do we care?

Ren=C3=A9
