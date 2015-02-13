From: Dilyan Palauzov <dilyan.palauzov@aegee.org>
Subject: Re: [PATCH] Remove duplicate #include
Date: Fri, 13 Feb 2015 22:57:27 +0100
Message-ID: <54DE7347.3000107@aegee.org>
References: <1423838859-15413-1-git-send-email-git-dpa@aegee.org> <xmqqegptms1r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 22:57:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMOEy-0002Fq-1r
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 22:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802AbbBMV5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 16:57:32 -0500
Received: from mailout-aegee.scc.kit.edu ([129.13.185.235]:33033 "EHLO
	mailout-aegee.scc.kit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbbBMV5b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 16:57:31 -0500
Received: from smtp.aegee.org (aegeepc1.aegee.uni-karlsruhe.de [129.13.131.81])
	by scc-mailout-02.scc.kit.edu with esmtp (Exim 4.72 #1)
	id 1YMOEr-0002lL-CZ; Fri, 13 Feb 2015 22:57:29 +0100
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.10.0 smtp.aegee.org t1DLvUGe024645
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
	t=1423864650; i=dkim+MSA-tls@aegee.org;
	bh=TeWISS+MBEy/OcgD8/Nmi6m5pVK3xPzSTAU/9Pdr79o=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=SaCzw3F8GnZkOQ2oAmpo1txTcQghrPjABUb2oerSCH0200aquq6xqG4SBe45FlKcZ
	 ccdP76rCUhBrA6B9L7a7JfO7pufgpB8Q4mw/1e6lSc7kzn7v9/H0FZHfOab8SvCb9Y
	 qz/jDujiCOakvrQC4ntPHkhl75K0+MoMNhPA8uYzNSWMn2dcsJcUUXHxuuGA2WE/0O
	 Y1guWaSVdTHNlnZmaZyhlEFhVJaMdd5SO+7SbhmynxCirMZvizi+R7tYz2Hrd4mEmB
	 SmaIIQhfqAOkKr/3MfNc5rWl9aI54ADxhReur4/ri6pLd7UwNWccWbgSpLONjJN9W9
	 h0Jeetc7tqjS1DKYyuvuBtt2Grz65Eo3lBFrq/bKvo4M8Xf46doqV18/BI3dNkwos/
	 V7KEk1wMYLTZm5iUBvaAQnv3MlJv3PGgIWLN6305absmhAjORsBDi4HTDSBtP6GrcC
	 ZE3nP1rkoFJpifW7njqzUM600m+ZEvmUmznoFsO6O0qkGHB3JiTCGIKYx1mxJdQqrG
	 kp8iSrPR/Emjlq39RV/hRDJ0ufjbdkavCQe3ncHi9oMcTKz8PurB696w3FQlCeoAqY
	 MJPEhd4iuLJigaPsDa6Tibrt2aYy8LOSdwMUeu+QL+Ru1l4Ksyln08zGSK2Mbe 
Received: from [192.168.0.16] (zuhause [212.202.110.243])
	(authenticated bits=0)
	by smtp.aegee.org (8.15.1/8.14.5) with ESMTPSA id t1DLvUGe024645
	(version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Fri, 13 Feb 2015 21:57:30 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqegptms1r.fsf@gitster.dls.corp.google.com>
X-Virus-Scanned: clamav-milter 0.98.6 at aegeeserv
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263841>

Hello Junio,

in theory it speeds up, because the preprocessor has less work to do.
In practice I don't know how much and this seems also irrelevant
criterion for accepting this patch.

Greetings
  Dilyan

On 13.02.2015 22:15, Junio C Hamano wrote:
> Дилян Палаузов  <git-dpa@aegee.org> writes:
> 
>> deheader (git://gitorious.org/deheader/deheader.git) found out that
>> some .c files #include twice one and the same header file.
>>
>> This patch removes such occurrences and hence speeds up the compilation.
> 
> Does it speed up?  By how much?  Any numbers?
> 
> I do not see any reason to reject this change.  Removing repeated
> inclusions of the same header is a good thing by itself [*1*].
> 
> Thanks.
> 
> [Footnote]
> 
> *1* If things break when repeated inclusions are removed, that would
> mean the headers were wrong in the first place.  I do not think
> transport.h, string-list.h, quote.h and cache.h have any reason why
> they need to be included twice to work correctly, and in fact they
> are designed to be no-op when included twice.
> 
>> Signed-off-by: Дилян Палаузов <git-dpa@aegee.org>
>> ---
>>   builtin/fetch.c    | 1 -
>>   trailer.c          | 1 -
>>   transport-helper.c | 1 -
>>   userdiff.c         | 1 -
>>   4 files changed, 4 deletions(-)
>>
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 7b84d35..75a55e5 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -11,7 +11,6 @@
>>   #include "run-command.h"
>>   #include "parse-options.h"
>>   #include "sigchain.h"
>> -#include "transport.h"
>>   #include "submodule.h"
>>   #include "connected.h"
>>   #include "argv-array.h"
>> diff --git a/trailer.c b/trailer.c
>> index 623adeb..05b3859 100644
>> --- a/trailer.c
>> +++ b/trailer.c
>> @@ -1,7 +1,6 @@
>>   #include "cache.h"
>>   #include "string-list.h"
>>   #include "run-command.h"
>> -#include "string-list.h"
>>   #include "commit.h"
>>   #include "trailer.h"
>>   /*
>> diff --git a/transport-helper.c b/transport-helper.c
>> index 0224687..3652b16 100644
>> --- a/transport-helper.c
>> +++ b/transport-helper.c
>> @@ -5,7 +5,6 @@
>>   #include "commit.h"
>>   #include "diff.h"
>>   #include "revision.h"
>> -#include "quote.h"
>>   #include "remote.h"
>>   #include "string-list.h"
>>   #include "thread-utils.h"
>> diff --git a/userdiff.c b/userdiff.c
>> index fad52d6..2ccbee5 100644
>> --- a/userdiff.c
>> +++ b/userdiff.c
>> @@ -1,6 +1,5 @@
>>   #include "cache.h"
>>   #include "userdiff.h"
>> -#include "cache.h"
>>   #include "attr.h"
>>   
>>   static struct userdiff_driver *drivers;
