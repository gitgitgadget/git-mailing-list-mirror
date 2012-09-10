From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/4] Add a new function, filter_string_list()
Date: Mon, 10 Sep 2012 10:58:29 +0200
Message-ID: <504DABB5.7090401@alum.mit.edu>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu> <1347169990-9279-3-git-send-email-mhagger@alum.mit.edu> <7vk3w3sfe9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 10:59:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAzpf-0000YB-4Z
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 10:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756504Ab2IJI6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 04:58:37 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:48370 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755489Ab2IJI6e (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 04:58:34 -0400
X-AuditID: 12074413-b7f786d0000008bb-29-504dabb9dd89
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 94.64.02235.9BBAD405; Mon, 10 Sep 2012 04:58:33 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8A8wVYx020613
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Sep 2012 04:58:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vk3w3sfe9.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqLtztW+AwY8efouuK91MFg29V5gd
	mDwuXlL2+LxJLoApitsmKbGkLDgzPU/fLoE748H6Z4wFE+Uqjl9bwd7A2C7RxcjBISFgIvH2
	v0gXIyeQKSZx4d56NhBbSOAyo8TfPr0uRi4g+ziTxLP1LWAJXgFtidbJl5lBbBYBVYn+mZcY
	QWw2AV2JRT3NTCC2qECIxIzLk5kh6gUlTs58wgJiiwioSUxsO8QCspdZQFyi/x9YWFjAUWLh
	pwXMELuWMkrMvHcUbBengJnEmV2z2UFsZgEdiXd9D5ghbHmJ7W/nME9gFJiFZMUsJGWzkJQt
	YGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrpebWaKXmlK6iRESpMI7GHedlDvEKMDBqMTD
	26zrGyDEmlhWXJl7iFGSg0lJlPffSqAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEV6RPqAcb0pi
	ZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCd/0qoEbBotT01Iq0zJwShDQT
	ByfIcC4pkeLUvJTUosTSkox4UJzGFwMjFSTFA7T3CEg7b3FBYi5QFKL1FKMux92PK+4zCrHk
	5eelSolDFAmAFGWU5sGtgKWkV4ziQB8L814EqeIBpjO4Sa+AljABLfH18AFZUpKIkJJqYOTb
	PM8i4v3ZU6Z7xeN9XvKGRdbsmiJok+U7sdB7GgtjUVGSdome4qUnrRtbpadKmr2cIminfMuF
	i22fkuO3b7vtVZ9mMf7c+fDHQcYDqb2hE+dwfwxpuKWvHVNuoMK/7fq7xyffzI26 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205113>

On 09/09/2012 11:40 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  Documentation/technical/api-string-list.txt |  8 ++++++++
>>  string-list.c                               | 17 +++++++++++++++++
>>  string-list.h                               |  9 +++++++++
>>  3 files changed, 34 insertions(+)
>>
>> diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
>> index 3b959a2..15b8072 100644
>> --- a/Documentation/technical/api-string-list.txt
>> +++ b/Documentation/technical/api-string-list.txt
>> @@ -60,6 +60,14 @@ Functions
>>  
>>  * General ones (works with sorted and unsorted lists as well)
>>  
>> +`filter_string_list`::
>> +
>> +	Apply a function to each item in a list, retaining only the
>> +	items for which the function returns true.  If free_util is
>> +	true, call free() on the util members of any items that have
>> +	to be deleted.  Preserve the order of the items that are
>> +	retained.
> 
> In other words, this can safely be used on both sorted and unsorted
> string list.  Good.

Preserving order (while retaining performance) is the main reason for
this function.  Otherwise, unsorted_string_list_delete_item() could be
used in a loop.

>>  `print_string_list`::
>>  
>>  	Dump a string_list to stdout, useful mainly for debugging purposes. It
>> diff --git a/string-list.c b/string-list.c
>> index 110449c..72610ce 100644
>> --- a/string-list.c
>> +++ b/string-list.c
>> @@ -102,6 +102,23 @@ int for_each_string_list(struct string_list *list,
>>  	return ret;
>>  }
>>  
>> +void filter_string_list(struct string_list *list, int free_util,
>> +			string_list_each_func_t fn, void *cb_data)
>> +{
>> +	int src, dst = 0;
>> +	for (src = 0; src < list->nr; src++) {
>> +		if (fn(&list->items[src], cb_data)) {
>> +			list->items[dst++] = list->items[src];
>> +		} else {
>> +			if (list->strdup_strings)
>> +				free(list->items[src].string);
>> +			if (free_util)
>> +				free(list->items[src].util);
>> +		}
>> +	}
>> +	list->nr = dst;
>> +}
>> +
>>  void string_list_clear(struct string_list *list, int free_util)
>>  {
>>  	if (list->items) {
>> diff --git a/string-list.h b/string-list.h
>> index 7e51d03..84996aa 100644
>> --- a/string-list.h
>> +++ b/string-list.h
>> @@ -29,6 +29,15 @@ int for_each_string_list(struct string_list *list,
>>  #define for_each_string_list_item(item,list) \
>>  	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
>>  
>> +/*
>> + * Apply fn to each item in list, retaining only the ones for which
>> + * the function returns true.  If free_util is true, call free() on
>> + * the util members of any items that have to be deleted.  Preserve
>> + * the order of the items that are retained.
>> + */
>> +void filter_string_list(struct string_list *list, int free_util,
>> +			string_list_each_func_t fn, void *cb_data);
>> +
>>  /* Use these functions only on sorted lists: */
>>  int string_list_has_string(const struct string_list *list, const char *string);
>>  int string_list_find_insert_index(const struct string_list *list, const char *string,
> 
> Having seen that the previous patch introduced a new test helper for
> unit testing (which is a very good idea) and dedicated a new test
> number, I would have expected to see a new test for filtering
> here.

I thought that the code was too trivial to warrant a test, especially
considering that the memory handling aspect of the function can't be
tested very well.  But you've correctly shamed me into adding tests for
this and also for patch 3/4, string_list_remove_duplicates().

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
