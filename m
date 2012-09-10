From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/4] Add a new function, string_list_remove_duplicates()
Date: Mon, 10 Sep 2012 11:15:06 +0200
Message-ID: <504DAF9A.4030202@alum.mit.edu>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu> <1347169990-9279-4-git-send-email-mhagger@alum.mit.edu> <7vfw6rsf64.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 11:15:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB05O-0003LB-Hg
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 11:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163Ab2IJJPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 05:15:09 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:47952 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752758Ab2IJJPI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 05:15:08 -0400
X-AuditID: 1207440c-b7f616d00000270b-d7-504daf9b3a72
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 69.7F.09995.B9FAD405; Mon, 10 Sep 2012 05:15:07 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8A9F6Wr021198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Sep 2012 05:15:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vfw6rsf64.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqDt7vW+AwcfPZhZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFLdNUmJJWXBmep6+XQJ3xrorRQUbFSsenf/J1MD4WaqLkZNDQsBEov/e
	NxYIW0ziwr31bF2MXBxCApcZJVb9PscMkhASOM4kceqcCojNK6Atcft5PyOIzSKgKjFxww+w
	ZjYBXYlFPc1MILaoQIjEjMuTmSHqBSVOznwCViMioCYxse0QkM3BwSwgLtH/DywsLOAjcWbZ
	Z6i9SxklXq7oBpvDKWAm8fDJYXYQm1lAR+Jd3wNmCFteYvvbOcwTGAVmIVkxC0nZLCRlCxiZ
	VzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaUbmKEBCnPDsZv62QOMQpwMCrx8Dbp
	+gYIsSaWFVfmHmKU5GBSEuXVXwcU4kvKT6nMSCzOiC8qzUktPsQowcGsJMIr0geU401JrKxK
	LcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ8GqBDBUsSk1PrUjLzClBSDNxcIIM
	55ISKU7NS0ktSiwtyYgHxWl8MTBSQVI8QHs9Qdp5iwsSc4GiEK2nGHU57n5ccZ9RiCUvPy9V
	SpzXBaRIAKQoozQPbgUsJb1iFAf6WJhXAaSKB5jO4Ca9AlrCBLTE18MHZElJIkJKqoGxXWh2
	T2jE+ph/ipsyfBs3+CyWqrioz1NyKDT758XgyBk7+gWW6fCqPJa9eK5Xw2vLk6NaH32Y10+s
	erL1qx37jeiPzNoP+NPLt4bOta7u+PJuaW97rUGEt82ehE8GBrO2Bqx4vI0j7kDr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205114>

On 09/09/2012 11:45 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  Documentation/technical/api-string-list.txt |  4 ++++
>>  string-list.c                               | 17 +++++++++++++++++
>>  string-list.h                               |  5 +++++
>>  3 files changed, 26 insertions(+)
>>
>> diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
>> index 15b8072..9206f8f 100644
>> --- a/Documentation/technical/api-string-list.txt
>> +++ b/Documentation/technical/api-string-list.txt
>> @@ -104,6 +104,10 @@ write `string_list_insert(...)->util = ...;`.
>>  	Look up a given string in the string_list, returning the containing
>>  	string_list_item. If the string is not found, NULL is returned.
>>  
>> +`string_list_remove_duplicates`::
>> +
>> +	Remove all but the first entry that has a given string value.
> 
> Unlike the previous patch, free_util is not documented?

Fixed.

> It is kind of shame that the string list must be sorted for this
> function to work, but I guess you do not have a need for a version
> that works on both sorted and unsorted (yet).  We can introduce a
> variant with "unsorted_" prefix later when it becomes necessary, so
> OK.

Not only that; for an unsorted list it is not quite as obvious what a
caller would want.  Often lists are used as a poor man's set, in which
case the caller would probably not mind sorting the list anyway.  There
are two operations that one might conceive of for unsorted lists: (1)
remove duplicates while preserving the order of the remaining entries,
or (2) remove duplicates while not worrying about the order of the
remaining entries.  (Admittedly the first is not much more expensive
than the second.)  These are more complicated to program, require
temporary space, and are of less obvious utility than removing
duplicates from a sorted list.

>>  * Functions for unsorted lists only
>>  
>>  `string_list_append`::
>> diff --git a/string-list.c b/string-list.c
>> index 72610ce..bfef6cf 100644
>> --- a/string-list.c
>> +++ b/string-list.c
>> @@ -92,6 +92,23 @@ struct string_list_item *string_list_lookup(struct string_list *list, const char
>>  	return list->items + i;
>>  }
>>  
>> +void string_list_remove_duplicates(struct string_list *list, int free_util)
>> +{
>> +	if (list->nr > 1) {
>> +		int src, dst;
>> +		for (src = dst = 1; src < list->nr; src++) {
>> +			if (!strcmp(list->items[dst - 1].string, list->items[src].string)) {
>> +				if (list->strdup_strings)
>> +					free(list->items[src].string);
>> +				if (free_util)
>> +					free(list->items[src].util);
>> +			} else
>> +				list->items[dst++] = list->items[src];
>> +		}
>> +		list->nr = dst;
>> +	}
>> +}
>> +
>>  int for_each_string_list(struct string_list *list,
>>  			 string_list_each_func_t fn, void *cb_data)
>>  {
>> diff --git a/string-list.h b/string-list.h
>> index 84996aa..c4dc659 100644
>> --- a/string-list.h
>> +++ b/string-list.h
>> @@ -38,6 +38,7 @@ int for_each_string_list(struct string_list *list,
>>  void filter_string_list(struct string_list *list, int free_util,
>>  			string_list_each_func_t fn, void *cb_data);
>>  
>> +
>>  /* Use these functions only on sorted lists: */
>>  int string_list_has_string(const struct string_list *list, const char *string);
>>  int string_list_find_insert_index(const struct string_list *list, const char *string,
>> @@ -47,6 +48,10 @@ struct string_list_item *string_list_insert_at_index(struct string_list *list,
>>  						     int insert_at, const char *string);
>>  struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
>>  
>> +/* Remove all but the first entry that has a given string value. */
>> +void string_list_remove_duplicates(struct string_list *list, int free_util);
>> +
>> +
>>  /* Use these functions only on unsorted lists: */
>>  struct string_list_item *string_list_append(struct string_list *list, const char *string);
>>  void sort_string_list(struct string_list *list);


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
