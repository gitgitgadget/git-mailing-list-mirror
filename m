From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/4] Add a function string_list_longest_prefix()
Date: Mon, 10 Sep 2012 12:01:06 +0200
Message-ID: <504DBA62.3080001@alum.mit.edu>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu> <1347169990-9279-5-git-send-email-mhagger@alum.mit.edu> <7vbohfser4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 12:01:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB0nv-0005Ov-LQ
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 12:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917Ab2IJKBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 06:01:11 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:60445 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752299Ab2IJKBK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 06:01:10 -0400
X-AuditID: 12074413-b7f786d0000008bb-86-504dba65b7f4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 79.15.02235.56ABD405; Mon, 10 Sep 2012 06:01:10 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8AA16Mf022818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Sep 2012 06:01:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vbohfser4.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsUixO6iqJu2yzfAYFa6RdeVbiaLht4rzA5M
	HhcvKXt83iQXwBTFbZOUWFIWnJmep2+XwJ0x6WB4wQv5il9fxRsYT0p2MXJySAiYSJz+/4kV
	whaTuHBvPVsXIxeHkMBlRokJG56xQDjHmSSurLoHVsUroC1xddpUFhCbRUBVonPNPjCbTUBX
	YlFPMxOILSoQIjHj8mRmiHpBiZMzn4DViAioSUxsOwRkc3AwC4hL9P8DCwsLuEhsPNrPBLFr
	KaPEhof/wGo4Bcwkfq7gBKlhFtCReNf3gBnClpfY/nYO8wRGgVlINsxCUjYLSdkCRuZVjHKJ
	OaW5urmJmTnFqcm6xcmJeXmpRbrmermZJXqpKaWbGCEBKryDcddJuUOMAhyMSjy8zbq+AUKs
	iWXFlbmHGCU5mJREeTdsBQrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4RXpA8rxpiRWVqUW5cOk
	pDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4N+8EahQsSk1PrUjLzClBSDNxcIIM55IS
	KU7NS0ktSiwtyYgHRWl8MTBOQVI8QHtPg7TzFhck5gJFIVpPMRpzzL654j4jx92PQFKIJS8/
	L1VKnLcLpFQApDSjNA9uESw1vWIUB/pbmHcFSBUPMK3BzXsFtIoJaJWvhw/IqpJEhJRUA2Pm
	H3n/GcVVpi0aU2bcndm+vTAvOHCZqv4SneOum/ctOZVblej69u3tKdU1Czo5Lacf/NXuY7/D
	LK+vzCJ8o5vmL60pe7+cULfMuhTLv+v0vJnH7kh/utz/OfD6c5ZIDQX/ZR/f+1yI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205115>

On 09/09/2012 11:54 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> [...]
>> diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
>> index 9206f8f..291ac4c 100644
>> --- a/Documentation/technical/api-string-list.txt
>> +++ b/Documentation/technical/api-string-list.txt
>> @@ -68,6 +68,14 @@ Functions
>>  	to be deleted.  Preserve the order of the items that are
>>  	retained.
>>  
>> +`string_list_longest_prefix`::
>> +
>> +	Return the longest string within a string_list that is a
>> +	prefix (in the sense of prefixcmp()) of the specified string,
>> +	or NULL if no such prefix exists.  This function does not
>> +	require the string_list to be sorted (it does a linear
>> +	search).
>> +
>>  `print_string_list`::
> 
> This may feel like outside the scope of this series, but since this
> series will be the main culprit for adding many new functions to
> this API in the recent history...
> 
>  - We may want to name things a bit more consistently so that people
>    can tell which ones can be called on any string list, which ones
>    are sorted list only, and which ones are unsorted one only.
> 
>    In addition, the last category _may_ need a bit more thought.
>    Calling unsorted_string_list_lookup() on an already sorted list
>    is not a crime---it is just a stupid thing to do.

Yes, this could be clearer.  Though I'm skeptical that a naming
convention can capture all of the variation without being too cumbersome.

Another idea: in string-list.h, one could name parameters "sorted_list"
when they must be sorted as a precondition of the function.

But before getting too hung up on finery, the effort might be better
invested adding documentation for functions that are totally lacking it,
like

    string_list_clear_func()
    for_each_string_list()
    for_each_string_list_item()
    string_list_find_insert_index()
    string_list_insert_at_index()

While we're on the subject, it seems to me that documenting APIs like
these in separate files under Documentation/technical rather than in the
header files themselves

- makes the documentation for a particular function harder to find,

- makes it easier for the documentation to get out of sync with the
actual collection of functions (e.g., the 5 undocumented functions
listed above).

- makes it awkward for the documentation to refer to particular function
parameters by name.

While it is nice to have a high-level prose description of an API, I am
often frustrated by the lack of "docstrings" in the header file where a
function is declared.  The high-level description of an API could be put
at the top of the header file.

Also, better documentation in header files could enable the automatic
generation of API docs (e.g., via doxygen).

Is there some reason for the current documentation policy or is it
historical and just needs somebody to put in the work to change it?

>  - Why are these new functions described at the top, not appended at
>    the bottom?  I would have expected either an alphabetical, or a
>    more generic ones first (i.e. print and clear are a lot "easier"
>    ones compared to filter and prefix that are very much more
>    specialized).

The order seemed logical to me at the time (given the constraint that
functions are grouped by sorted/unsorted/don't-care):
print_string_list() is only useful for debugging, so it seemed to belong
below the "production" functions.  string_list_clear() was already below
print_string_list() (which I guessed was because it is logically used
last in the life of a string_list) so I left it at the end of its
section.  My preference would probably have been to move
print_string_list() below string_list_clear(), but somebody else made
the opposite choice so I decided to respect it.

That being said, I don't have anything against a different order.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
