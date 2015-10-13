From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 25/44] refs.h: document make refname_is_safe and add
 it to header
Date: Tue, 13 Oct 2015 11:18:27 +0200
Message-ID: <561CCC63.8050604@alum.mit.edu>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com> <1444686725-27660-27-git-send-email-dturner@twopensource.com> <561CB3C4.1010208@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 11:19:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlvkS-0003H2-71
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 11:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbbJMJSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 05:18:41 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:52345 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751731AbbJMJSj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2015 05:18:39 -0400
X-AuditID: 12074411-f797e6d000007df3-d5-561ccc65a166
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 3C.72.32243.56CCC165; Tue, 13 Oct 2015 05:18:29 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2603.dip0.t-ipconnect.de [93.219.38.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9D9IRWS021594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 13 Oct 2015 05:18:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <561CB3C4.1010208@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsUixO6iqJt6RibMYOFmBYv5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3BlfjnxkLjjIU/H65hz2BsYXnF2MHBwSAiYS
	r2cbdDFyApliEhfurWfrYuTiEBK4zChxcedBKOcsk8S67o3sIFW8AtoSK65fZQaxWQRUJab9
	3cEEYrMJ6Eos6mkGs0UFgiRWLH/BCFEvKHFy5hMWEFtEwEHi8q6jYL3CAlESO19/YIVYsIxR
	YtrG1WANnAI6EqdWLQWzmQX0JHZc/8UKYctLbH87h3kCI/8sJHNnISmbhaRsASPzKka5xJzS
	XN3cxMyc4tRk3eLkxLy81CJdU73czBK91JTSTYyQkBTcwTjjpNwhRgEORiUe3heRMmFCrIll
	xZW5hxglOZiURHk1dwOF+JLyUyozEosz4otKc1KLDzFKcDArifAmtQDleFMSK6tSi/JhUtIc
	LErivHxL1P2EBNITS1KzU1MLUotgsjIcHEoSvJWngRoFi1LTUyvSMnNKENJMHJwgw7mkRIpT
	81JSixJLSzLiQTEZXwyMSpAUD9BeS5B23uKCxFygKETrKUZFKXFeR5CEAEgiozQPbiws0bxi
	FAf6Upg3G6SKB5ik4LpfAQ1mAhpsxC4FMrgkESEl1cDYGnqkW7mx8OrnLt5tbj7HJ7Rd1rYs
	73Yq+c0e8fDLXGmhibcea52p+a/DmCfzY7nNgWc8p8MPF+UfsZ19qittjcVrzhl+J6yfG0hl
	xC1IT++M+ZOXo9NxOLdowv3UW+6bcjwa3CR+dp7RuvVWJa+F82XGcad5DcLvHJwM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279490>

On 10/13/2015 09:33 AM, Michael Haggerty wrote:
> On 10/12/2015 11:51 PM, David Turner wrote:
>> This function might be used by other refs backends
>>
>> Signed-off-by: David Turner <dturner@twopensource.com>
>> ---
>>  refs.h | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/refs.h b/refs.h
>> index fc8a748..7a936e2 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -348,6 +348,17 @@ int verify_refname_available(const char *newname, struct string_list *extra,
>>  			     struct string_list *skip, struct strbuf *err);
>>  
>>  /*
>> + * Check if a refname is safe.
>> + * For refs that start with "refs/" we consider it safe as long they do
>> + * not try to resolve to outside of refs/.
>> + *
>> + * For all other refs we only consider them safe iff they only contain
>> + * upper case characters and '_' (like "HEAD" AND "MERGE_HEAD", and not like
>> + * "config").
>> + */
>> +int refname_is_safe(const char *refname);
>> +
>> +/*
>>   * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
>>   * REF_NODEREF: act on the ref directly, instead of dereferencing
>>   *              symbolic references.
>>
> 
> The previous commit deleted this comment from where it previously
> appeared in refs-be-files.c. It would make more sense to squash this
> commit onto that one so it's clear that you are moving the comment
> rather than creating a new comment out of thin air.

Also, after this commit the prototype for this function appears twice in
refs.h.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
