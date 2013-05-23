From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 04/17] builtin_diff_tree(): make it obvious that function
 wants two entries
Date: Thu, 23 May 2013 09:19:00 +0200
Message-ID: <519DC2E4.7070102@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu> <1368995232-11042-5-git-send-email-mhagger@alum.mit.edu> <7v8v38p7jx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 09:19:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfPnr-00054V-Lw
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 09:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894Ab3EWHTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 03:19:05 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:65079 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751330Ab3EWHTE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 May 2013 03:19:04 -0400
X-AuditID: 12074412-b7f216d0000008d4-8d-519dc2e7d8fe
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 82.74.02260.7E2CD915; Thu, 23 May 2013 03:19:03 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4N7J1Xl007424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 May 2013 03:19:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7v8v38p7jx.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsUixO6iqPv80NxAgzu3RCy6rnQzWTT0XmG2
	mHd3F5PFj5YeZgcWj0svv7N5POvdw+hx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGbt+bmcv
	eMxdceLLTJYGxiWcXYycHBICJhJPn7xggrDFJC7cW8/WxcjFISRwmVHi9IxLzBDONSaJnnMH
	2UCqeAW0Jd7ub2AFsVkEVCVW9DxmBLHZBHQlFvU0g00SFQiTeL9sKitEvaDEyZlPWEBsEQE1
	iYlth8BsZoE4iZ2dq8DqhQUSJf79e8kEsWw5o8StE4/AijgFzCRm73vFBtGgI/Gu7wEzhC0v
	sf3tHOYJjAKzkOyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfRyM0v0UlNK
	NzFCQlpoB+P6k3KHGAU4GJV4eA/emBMoxJpYVlyZe4hRkoNJSZTX5eDcQCG+pPyUyozE4oz4
	otKc1OJDjBIczEoivJt7gHK8KYmVValF+TApaQ4WJXHen4vV/YQE0hNLUrNTUwtSi2CyMhwc
	ShK8rsDYFRIsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHRWt8MTBeQVI8QHv9Qdp5
	iwsSc4GiEK2nGI057nyb/I6RY8YPICnEkpeflyolzlsDUioAUppRmge3CJbMXjGKA/0tzNsF
	UsUDTIRw814BrWICWrX01ByQVSWJCCmpBsZ9v1eezdwd25658NCyfwH8/avsVDXezzaWe733
	ZH3OWZfN9yYlZ2iovCwuOm7/M91kU3zlCksO6diglHRpqeRG3QN1X03FzybFShZv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225220>

On 05/21/2013 07:27 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Instead of accepting an array and using exactly two elements from the
>> array, take two single (struct object_array_entry *) arguments.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  builtin/diff.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/builtin/diff.c b/builtin/diff.c
>> index 8c2af6c..ba68c6c 100644
>> --- a/builtin/diff.c
>> +++ b/builtin/diff.c
>> @@ -153,7 +153,8 @@ static int builtin_diff_index(struct rev_info *revs,
>>  
>>  static int builtin_diff_tree(struct rev_info *revs,
>>  			     int argc, const char **argv,
>> -			     struct object_array_entry *ent)
>> +			     struct object_array_entry *ent0,
>> +			     struct object_array_entry *ent1)
>>  {
>>  	const unsigned char *(sha1[2]);
>>  	int swap = 0;
>> @@ -161,13 +162,13 @@ static int builtin_diff_tree(struct rev_info *revs,
>>  	if (argc > 1)
>>  		usage(builtin_diff_usage);
>>  
>> -	/* We saw two trees, ent[0] and ent[1].
>> -	 * if ent[1] is uninteresting, they are swapped
>> +	/* We saw two trees, ent0 and ent1.
>> +	 * if ent1 is uninteresting, they are swapped
>>  	 */
> 
> "While you are touching this comment" is a perfect time to fix the
> existing style violation.

Yes.  Will fix in next version.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
