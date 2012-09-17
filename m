From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 05/14] Change fetch_pack() and friends to take string_list
 arguments
Date: Mon, 17 Sep 2012 14:24:26 +0200
Message-ID: <5057167A.6040403@alum.mit.edu>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu> <1347171589-13327-6-git-send-email-mhagger@alum.mit.edu> <7vipblmwaq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 14:24:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDaNU-0008Mh-5H
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 14:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab2IQMYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 08:24:31 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:49696 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755969Ab2IQMYa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2012 08:24:30 -0400
X-AuditID: 1207440f-b7fde6d00000095c-e5-5057167d61b5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id D4.44.02396.D7617505; Mon, 17 Sep 2012 08:24:29 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8HCOQhh014058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 17 Sep 2012 08:24:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vipblmwaq.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqFsrFh5gsG6/rEXXlW4mi4beK8wW
	P1p6mC06p8o6sHgsX7qO0eNZ7x5Gj4uXlD0+b5ILYInitklKLCkLzkzP07dL4M6Y+HgHa8ER
	4YqFazqYGxhX83cxcnJICJhIXNywkAnCFpO4cG89WxcjF4eQwGVGiR8bG9hAEkICx5kk+ndo
	gti8AtoS5w/tBGtgEVCV2HXjFiuIzSagK7GopxksLioQIjHj8mRmiHpBiZMzn7CA2CICahIT
	2w6B2cwCiRL/Fj0G6xUWiJW4eHAvC8Su5YwSC97UgNicAmYSX/a/gKrXkXjX94AZwpaX2P52
	DvMERoFZSFbMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Jnq5mSV6qSmlmxgh
	wcy/g7FrvcwhRgEORiUeXsNJYQFCrIllxZW5hxglOZiURHmf8oYHCPEl5adUZiQWZ8QXleak
	Fh9ilOBgVhLhvS0AlONNSaysSi3Kh0lJc7AoifOqL1H3ExJITyxJzU5NLUgtgsnKcHAoSfCu
	FgVqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFanwxMFZBUjxAe6eDtPMWFyTm
	AkUhWk8x6nLc/bjiPqMQS15+XqqUOG8lSJEASFFGaR7cCljqesUoDvSxMMQoHmDag5v0CmgJ
	E9CSiidhIEtKEhFSUg2Mau8X2j3ZcldakXtPtoPkceMQi6eG++7EnmI96Dr99oy2iBchs2UN
	XuvKHi8XDWvoONCsp6rXsk44PJWTtX7VDTPlOzqXJ3vN35n07+3V8ydMvD3W9sdG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205680>

On 09/10/2012 10:56 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> diff --git a/fetch-pack.h b/fetch-pack.h
>> index 1dbe90f..a6a8a73 100644
>> --- a/fetch-pack.h
>> +++ b/fetch-pack.h
>> @@ -1,6 +1,8 @@
>>  #ifndef FETCH_PACK_H
>>  #define FETCH_PACK_H
>>  
>> +#include "string-list.h"
>> +
>>  struct fetch_pack_args {
>>  	const char *uploadpack;
>>  	int unpacklimit;
>> @@ -21,8 +23,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
>>  		       int fd[], struct child_process *conn,
>>  		       const struct ref *ref,
>>  		       const char *dest,
>> -		       int nr_heads,
>> -		       char **heads,
>> +		       struct string_list *sought,
>>  		       char **pack_lockfile);
> 
> This is a tangent, but I _think_ our header files ignore the dogma
> some other projects follow that insists on each header file to be
> self sufficient, i.e.
> 
> 	gcc fetch-pack.h
> 
> should pass.  Instead, our *.c files that include fetch-pack.h are
> responsible for including everything the headers they include need.
> So even though fetch-pack.h does not include run-command.h, it
> declares a function that takes "struct child_process *" in its
> arguments.  The new "struct string_list *" falls into the same camp.
> 
> Given that, I'd prefer to see the scope of this patch series shrunk
> and have the caller include string-list.h, not here.
> 
> Updating the headers and sources so that each to be self sufficient
> is a different topic, and I do not think there is a consensus yet if
> we want to go that route.

The include line can just be deleted, because the three files that
include it already get string-list.h from somewhere:

* builtin/clone.c, builtin/fetch-pack.c
  includes builtin.h
  includes notes.h
  includes string-list.h

* transport.c
  includes string-list.h

Patch forthcoming.

But how far should this policy be taken?  It seems to me that strict
adherence to the policy would dictate that *.h files should *never*
include other git project files.

For example, while working on this, I noticed that notes.h includes
string-list.h and also contains a forward declaration for "struct
string_list".  Obviously, the latter could be deleted.  Alternatively,
both could probably be deleted by ensuring that the relevant *.c files
include string-list.h before including notes.h.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
