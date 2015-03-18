From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer
 parsing
Date: Wed, 18 Mar 2015 10:47:40 +0100
Message-ID: <550949BC.1020500@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu> <CACsJy8AiHHKBD4vV5aJec9CGzBqfSCNU6-j=LjDhsp2VrC55+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 10:47:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYAZr-0007Cz-P3
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 10:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107AbbCRJrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 05:47:47 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:43712 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754074AbbCRJrp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2015 05:47:45 -0400
X-AuditID: 1207440f-f792a6d000001284-79-550949bed787
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 6D.72.04740.EB949055; Wed, 18 Mar 2015 05:47:42 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96AE4.dip0.t-ipconnect.de [79.201.106.228])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2I9leI0008721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 18 Mar 2015 05:47:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <CACsJy8AiHHKBD4vV5aJec9CGzBqfSCNU6-j=LjDhsp2VrC55+A@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqLvPkzPU4OsZZYuuK91MFg29V5gt
	uqe8ZbT40dLD7MDisXPWXXaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE749e5J0wF
	jwUqTvQ+ZmxgvMfbxcjJISFgIrH7zQlWCFtM4sK99WxdjFwcQgKXGSUmHG4HSwgJXGCS+LQg
	C8TmFdCW2PjsCROIzSKgKjH5x11mEJtNQFdiUU8zWFxUIEji5a2/jBD1ghInZz5hAbFFBJQk
	3nRsA6tnFiiS2H38E1iNsEC4xNJ7s5kgdnUwSrTeDQWxOQUCJTZ1TmKHqFeX+DPvElSvvETz
	1tnMExgFZiFZMQtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zro5WaW6KWmlG5i
	hIQz/w7GrvUyhxgFOBiVeHgLrnOECrEmlhVX5h5ilORgUhLl/ePKGSrEl5SfUpmRWJwRX1Sa
	k1p8iFGCg1lJhDeXGyjHm5JYWZValA+TkuZgURLnVV+i7ickkJ5YkpqdmlqQWgSTleHgUJLg
	bfAAahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHRWp8MTBWQVI8QHvbQNp5iwsS
	c4GiEK2nGBWlxHlLQRICIImM0jy4sbAk9YpRHOhLYd7nIFU8wAQH1/0KaDAT0OCWdjaQwSWJ
	CCmpBsYatQpOG6P0cE9h4V4uO85JW69Zl992fRS2Wu3Tgw3JKc+VF+xYOv3wst8XZbqylu3c
	f443QMnnZlTjvQc/1l008Ds/o3IiX9I0Jmb3dduPdcXHfDLcdUmaa8/UXTp/dF6m 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265701>

On 03/18/2015 12:05 AM, Duy Nguyen wrote:
> On Tue, Mar 17, 2015 at 11:00 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Michael Haggerty (14):
>>   numparse: new module for parsing integral numbers
>>   cacheinfo_callback(): use convert_ui() when handling "--cacheinfo"
>>   write_subdirectory(): use convert_ui() for parsing mode
>>   handle_revision_opt(): use skip_prefix() in many places
>>   handle_revision_opt(): use convert_i() when handling "-<digit>"
>>   strtoul_ui(), strtol_i(): remove functions
>>   handle_revision_opt(): use convert_ui() when handling "--abbrev="
>>   builtin_diff(): detect errors when parsing --unified argument
>>   opt_arg(): val is always non-NULL
>>   opt_arg(): use convert_i() in implementation
>>   opt_arg(): report errors parsing option values
>>   opt_arg(): simplify pointer handling
>>   diff_opt_parse(): use convert_i() when handling "-l<num>"
>>   diff_opt_parse(): use convert_i() when handling --abbrev=<num>
> 
> Thank you for doing it. I was about to write another number parser and
> you did it :D Maybe you can add another patch to convert the only
> strtol in upload-pack.c to parse_ui. This place should accept positive
> number in base 10, plus sign is not accepted.

If the general direction of this patch series is accepted, I'll
gradually try to go through the codebase, replacing *all* integer
parsing with these functions. So there's no need to request particular
callers of strtol()/strtoul() to be converted; I'll get to them all
sooner or later (I hope).

But in case you have some reason that you want upload-pack.c to be
converted right away, I just pushed that change (plus some related
cleanups) to my GitHub repo [1]. The branch depends only on the first
patch of the "numparse" patch series.

By the way, some other packet line parsing code in that file doesn't
verify that there are no trailing characters on the lines that they
process. That might be another thing that should be tightened up.

Michael

[1] https://github.com/mhagger/git.git, branch "upload-pack-numparse"

-- 
Michael Haggerty
mhagger@alum.mit.edu
