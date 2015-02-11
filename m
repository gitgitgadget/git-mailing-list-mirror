From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 10/11] ref_transaction_verify(): new function to check
 a reference's value
Date: Wed, 11 Feb 2015 17:11:35 +0100
Message-ID: <54DB7F37.7030206@alum.mit.edu>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>	<1423412045-15616-11-git-send-email-mhagger@alum.mit.edu> <CAGZ79kZqsCmhzw9mW4Bxyzd-+XRuzh5aYFnp5GLZwjGj9SW_LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 17:18:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLa06-0008OX-16
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 17:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003AbbBKQSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2015 11:18:50 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:50064 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753995AbbBKQSt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2015 11:18:49 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Feb 2015 11:18:48 EST
X-AuditID: 12074413-f79f26d0000030e7-45-54db7f393e0a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 8D.2A.12519.93F7BD45; Wed, 11 Feb 2015 11:11:37 -0500 (EST)
Received: from [192.168.69.130] (p4FC9687D.dip0.t-ipconnect.de [79.201.104.125])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1BGBZCM016470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 11 Feb 2015 11:11:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <CAGZ79kZqsCmhzw9mW4Bxyzd-+XRuzh5aYFnp5GLZwjGj9SW_LQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqGtZfzvE4P8XdYuuK91MFg29V5gt
	3t5cwmjRPeUto0Vv3ydWi82b21kc2Dx2zrrL7rFgU6nHxUvKHp83yQWwRHHbJCWWlAVnpufp
	2yVwZyx52sRc8JSv4sj1DawNjBe5uxg5OSQETCR63ixgg7DFJC7cWw9kc3EICVxmlNi0bxcz
	hHOBSaJv0jlGkCpeAW2Jax++s4PYLAKqEgu3HmMBsdkEdCUW9TQzgdiiAkESh04/ZoGoF5Q4
	OfMJmC0ioCYxc9VssA3MAvOYJK60/wRbLSyQIHF711Oo1YcZJeaePQm2jVMgUOJwx3GwbmYB
	dYk/8y4xQ9jyEtvfzmGewCgwC8mSWUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI
	11wvN7NELzWldBMjJMyFdzDuOil3iFGAg1GJh/fDplshQqyJZcWVuYcYJTmYlER5natuhwjx
	JeWnVGYkFmfEF5XmpBYfYpTgYFYS4eXPAsrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGan
	phakFsFkZTg4lCR41eqAGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJB8RpfDIxY
	kBQP0F5TkHbe4oLEXKAoROspRkUpcd4ftUAJAZBERmke3FhY8nrFKA70pTBvB0g7DzDxwXW/
	AhrMBDS4oOAGyOCSRISUVAOj5HaVHbfmeFsLHjsfM2mi1JyINQwv5n7cW3M/VI31ceH8KsUM
	i5dMX4WdxWbz/dxZuPXv9jsaIeZsejWr+F3Za00Uf5R9zNIqrthS5BI6hz3Y943b 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263682>

On 02/09/2015 07:50 PM, Stefan Beller wrote:
> On Sun, Feb 8, 2015 at 8:14 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>  /*
>> - * Add a reference update to transaction.  new_sha1 is the value that
>> - * the reference should have after the update, or null_sha1 if it should
>> - * be deleted.  If old_sha1 is non-NULL, then it the value
>> - * that the reference should have had before the update, or null_sha1 if
>> - * it must not have existed beforehand.
>> - * Function returns 0 on success and non-zero on failure. A failure to update
>> - * means that the transaction as a whole has failed and will need to be
>> - * rolled back.
>> + * Add a reference update to transaction. new_sha1 is the value that
>> + * the reference should have after the update, or null_sha1 if it
>> + * should be deleted. If new_sha1 is NULL, then the reference is not
>> + * changed at all. old_sha1 is the value that the reference must have
>> + * before the update, or null_sha1 if it must not have existed
>> + * beforehand. The old value is checked after the lock is taken to
>> + * prevent races. If the old value doesn't agree with old_sha1, the
>> + * whole transaction fails. If old_sha1 is NULL, then the previous
>> + * value is not checked.
>> + *
>> + * Return 0 on success and non-zero on failure. Any failure in the
>> + * transaction means that the transaction as a whole has failed and
>> + * will need to be rolled back.
> 
> Do we need to be explicit about having to rollback everything in each
> ref_transaction_* function documentation?

Thanks for the suggestion.

I just added a new commit that moves this (and more) information to the
introductory comment above these four functions' declarations, so that
it doesn't have to be repeated for each function. It will be in the re-roll.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
