From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 12/19] fsck: Disallow demoting grave fsck errors to
 warnings
Date: Fri, 19 Jun 2015 23:09:29 +0200
Organization: gmx
Message-ID: <4e523e191f979706eca5d6ddcd221553@www.dscho.org>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <c87d71326fc75773f137eee0ef6a8964645f0b74.1434720655.git.johannes.schindelin@gmx.de>
 <xmqqa8vv78ld.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 23:09:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z63Xj-0004TS-L1
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 23:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932959AbbFSVJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 17:09:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:59044 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932691AbbFSVJe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 17:09:34 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MMGWH-1ZBqpo3TBN-0085PC; Fri, 19 Jun 2015 23:09:29
 +0200
In-Reply-To: <xmqqa8vv78ld.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:H4YtV+Tuzq3uJGFRZM9op8hxkDnnLhrpSry0+67XO9h8xwQT0Ux
 Nu4gdtcTamniaX3up9sf9xav4LM5z2yTCR8wr0JxGJDLfTq/stLoPJXZYNO3LZ9ZCB2HCcU
 NtacOczUq9QhDfNdpTggxvtsbbhzL/t+xYRP5cMh9ivRrjQCKlRx/DGSxYCKIIOKgtiYpRX
 xcBVadX2vivWN2qIcsk4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QmTPTVO9mhM=:ERyG0dbBs+veVIz+8dT/xG
 JVkSjAMmDJYG0MJn+uvsQpOstq3HynrlCStvyOqtM2zpM1QbafJ3jIU373l08XVtBLRoGOXMk
 MQo0xKvj7iHHUOgNhG+c4PAZDdpsGHuWh8XlXorBgH93S+qOddJjuM9MI4+t0h1Ty7rsIZl5k
 pBgXxj6NIdIrmL3ZtkRGBrpx5diOgQ+/jqwiLvSOIkendKPHB3uqpqZsUcxRbde0d5t3jwpe7
 kamC2rd8hVh/vZBrGe/Wzfn1dRj3/sArr4X53olV1cNgywxLpyRo8GZrU5oWJ2Mw+HB3lFoWs
 QcYTqKcKvqppG7hDqsBnh4m/VmA1HWeNI2PqfFuJMflm6k4jhNzUKscq3TSO+GrNgq1Ou4sg+
 ddq3eKantObFzW0LbQCjVHlq+/nN6Qh5fjdsmWbatNHDF+9MlTVSP3Y33P8AaKtDm944H2f41
 TVq75dl2T2oGSvP04vvsEAaYgCT0VUS2U4LxmarxYh8GXPX/sQOukukIwsjoseX4IytzDbALS
 9rNVsfOjaJcMjat3lCkIWIMHDnLq6pBbVwy+K4Dc0sFJPBTBX1I6ti9O+tLO51V8lZp7ksxqf
 EJsUrdCUlxgH4G9iMFV+XQi7cswr2WBNJo0k2euFL0eovJfQBmUcoEhOWE87AImnh31Myt8xV
 Ajrx45RBZkJYX0n45uPEVytD7rSK2ShlexzQUo0aqxn1BLzPW74W/OVsfA5ot+ILsgYQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272210>

Hi Junio,

On 2015-06-19 22:21, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> Some kinds of errors are intrinsically unrecoverable (e.g. errors while
>> uncompressing objects). It does not make sense to allow demoting them to
>> mere warnings.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  fsck.c                          | 14 ++++++++++++--
>>  t/t5504-fetch-receive-strict.sh | 11 +++++++++++
>>  2 files changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/fsck.c b/fsck.c
>> index 21e3052..a4fbce3 100644
>> --- a/fsck.c
>> +++ b/fsck.c
>> @@ -9,7 +9,12 @@
>>  #include "refs.h"
>>  #include "utf8.h"
>>
>> +#define FSCK_FATAL -1
>> +
>>  #define FOREACH_MSG_ID(FUNC) \
>> +	/* fatal errors */ \
>> +	FUNC(NUL_IN_HEADER, FATAL) \
>> +	FUNC(UNTERMINATED_HEADER, FATAL) \
>>  	/* errors */ \
>>  	FUNC(BAD_DATE, ERROR) \
>>  	FUNC(BAD_DATE_OVERFLOW, ERROR) \
>> @@ -39,11 +44,9 @@
>>  	FUNC(MISSING_TYPE, ERROR) \
>>  	FUNC(MISSING_TYPE_ENTRY, ERROR) \
>>  	FUNC(MULTIPLE_AUTHORS, ERROR) \
>> -	FUNC(NUL_IN_HEADER, ERROR) \
>>  	FUNC(TAG_OBJECT_NOT_TAG, ERROR) \
>>  	FUNC(TREE_NOT_SORTED, ERROR) \
>>  	FUNC(UNKNOWN_TYPE, ERROR) \
>> -	FUNC(UNTERMINATED_HEADER, ERROR) \
> 
> I think the end result very much makes a good sense, but why didn't
> this list enumerate the errors in the above "final" order from the
> beginning in 02/19?

Because they are alphabetically ordered, within message type categories, that is; this helped me develop with more ease (you do not want to know how many hundreds of times I ran an interactive rebase on all of these patches...).

And from the point of a development story (which a patch series is), it would puzzle me, as a reader, if those two out of all the others were in front in 02/19, when they are no different from the others at that stage.

Ciao,
Dscho
