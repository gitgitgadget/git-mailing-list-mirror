From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 19/29] refs: don't dereference on rename
Date: Sat, 30 Apr 2016 05:48:50 +0200
Message-ID: <57242B22.4050202@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
 <27f8b223e42dcf1cf3c010833e0aff7baa4559c2.1461768690.git.mhagger@alum.mit.edu>
 <xmqqy47y98zx.fsf@gitster.mtv.corp.google.com>
 <57230F71.2020401@alum.mit.edu> <1461972108.4123.43.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 05:49:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awLu8-0002nI-QD
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 05:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbcD3DtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 23:49:04 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:64339 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752384AbcD3DtD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2016 23:49:03 -0400
X-AuditID: 1207440c-c53ff70000000b85-e0-57242b26132b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 58.C5.02949.62B24275; Fri, 29 Apr 2016 23:48:54 -0400 (EDT)
Received: from [192.168.69.130] (p548D634F.dip0.t-ipconnect.de [84.141.99.79])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3U3mpPI008321
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 29 Apr 2016 23:48:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <1461972108.4123.43.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqKumrRJucL1N2WL+phOMFl1Xupks
	GnqvMFt0T3nLaPGjpYfZYuZVawc2j52z7rJ7POvdw+hx8ZKyx/6l29g8Fjy/z+7xeZNcAFsU
	t01SYklZcGZ6nr5dAnfGuo0zWAvOiVTcO/icuYHxokAXIyeHhICJxM4Jz9i7GLk4hAS2Mko8
	7FnAAuGcY5JYd+AKC0iVsICNxJ6+K+wgtohAhMSSyftYIYramSTWvOkGc5gFdjBK3HrYxQZS
	xSagK7Gop5kJxOYV0JZYPKGTGcRmEVCV6Hp8nhHEFhUIkdi27hsrRI2gxMmZT8C2cQpYSKz6
	uhjMZhZQl/gz7xIzhC0vsf3tHOYJjPyzkLTMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJ
	iXl5qUW6hnq5mSV6qSmlmxghIc6zg/HbOplDjAIcjEo8vDPuKYULsSaWFVfmHmKU5GBSEuWt
	WKQcLsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE95uGSrgQb0piZVVqUT5MSpqDRUmcV3WJup+Q
	QHpiSWp2ampBahFMVoaDQ0mC94wmUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8
	KC7ji4GRCZLiAdorpQWyt7ggMRcoCtF6ilFRSpy3HmSuAEgiozQPbiwscb1iFAf6Upg3FKSd
	B5j04LpfAQ1mAhossEkRZHBJIkJKqoExQHf5rZNCAk2px9IXLZ9ju3GG6oMtzPuZAzKupF+0
	e3LIyHSxws0w87aKh/M+nxYJ3MG+gN91T+LSF6JFD7g5Ge/aTGyI3XtQte5oy8nD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293121>

On 04/30/2016 01:21 AM, David Turner wrote:
> On Fri, 2016-04-29 at 09:38 +0200, Michael Haggerty wrote:
>> On 04/27/2016 08:55 PM, Junio C Hamano wrote:
>>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>>
>>>> @@ -2380,8 +2381,8 @@ int rename_ref(const char *oldrefname,
>>>> const char *newrefname, const char *logms
>>>>  		goto rollback;
>>>>  	}
>>>>  
>>>> -	if (!read_ref_full(newrefname, RESOLVE_REF_READING,
>>>> sha1, NULL) &&
>>>> -	    delete_ref(newrefname, sha1, REF_NODEREF)) {
>>>> +	if (!read_ref_full(newrefname, resolve_flags, sha1,
>>>> NULL) &&
>>>> +	    delete_ref(newrefname, NULL, REF_NODEREF)) {
>>>
>>> Could you explain s/sha1/NULL/ here in the proposed log message?
>>
>> Good question.
>>
>> Passing sha1 to delete_ref() doesn't add any safety, because the same
>> sha1 was just read a moment before, and it is not used for anything
>> else. So the check only protects us from a concurrent update to
>> newrefname between the call to read_ref_full() and the call to
>> delete_ref(). But such a race is indistinguishable from the case that
>> a
>> modification to newrefname happens just before the call to
>> read_ref_full(), which would have the same outcome as the new code.
>> So
>> the "sha1" check only adds ways for the rename() to fail in
>> situations
>> where nothing harmful would have happened anyway.
>>
>> That being said, this is a very unlikely race, and I don't think it
>> matters much either way. In any case, the change s/sha1/NULL/ here
>> seems
>> orthogonal to the rest of the patch.
>>
>> David, you wrote the original version of this patch. Am I overlooking
>> something?
> 
> I think I might have been handling some weird case related to symbolic
> refs, but I don't recall the details.  Your argument seems right to me.

Doh, of course. I should have just changed it back to `sha1` and run the
test suite, then I would have seen the failure...

The point is that `read_ref_full()` is now called with
`RESOLVE_REF_NO_RECURSE` turned on. So if `newrefname` is a symbolic
reference, then `read_ref_full()` sets `sha1` to zeros. But the
pre-check for `delete_ref()` compares `old_sha1` to the recursively
resolved value of the reference, so that check would fail. (In fact,
`ref_transaction_delete()` refuses even to add the deletion to the
transaction if `old_sha1` is zeros, so it doesn't even get that far.)

So for shallow technical reasons we can't pass `sha1` to `delete_ref()`
anymore, and for the deeper reasons discussed in this thread that's not
a problem.

I'll document this in v2 of this patch.

Michael
