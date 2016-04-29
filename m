From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 19/29] refs: don't dereference on rename
Date: Fri, 29 Apr 2016 12:57:29 +0200
Message-ID: <57233E19.4000200@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
 <27f8b223e42dcf1cf3c010833e0aff7baa4559c2.1461768690.git.mhagger@alum.mit.edu>
 <xmqqy47y98zx.fsf@gitster.mtv.corp.google.com>
 <57230F71.2020401@alum.mit.edu>
 <xmqqvb3023v0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 13:04:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw6E7-0005FV-H5
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 13:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbcD2LEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 07:04:45 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53509 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752465AbcD2LEo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2016 07:04:44 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Apr 2016 07:04:44 EDT
X-AuditID: 1207440e-f07ff700000008c5-ed-57233e1e50bf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 2D.20.02245.E1E33275; Fri, 29 Apr 2016 06:57:34 -0400 (EDT)
Received: from [192.168.69.130] (p548D6182.dip0.t-ipconnect.de [84.141.97.130])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3TAvT8U021164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 29 Apr 2016 06:57:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <xmqqvb3023v0.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqCtnpxxusOmaocX8TScYLbqudDNZ
	NPReYbbonvKW0eJHSw+zxcyr1g5sHjtn3WX3eNa7h9Hj4iVlj/1Lt7F5LHh+n93j8ya5ALYo
	bpukxJKy4Mz0PH27BO6M9rNNrAU9ohXft55kbWD8KNDFyMkhIWAisXfdB6YuRi4OIYGtjBKz
	vveyQzjnmSQW7DjCBlIlLGAjsafvCjuILSKgJjGx7RALRFEPk8TOpdfZQBxmgfuMEnP/d7GC
	VLEJ6Eos6mlmArF5BbQlHs1sA7NZBFQlFlzpBasRFQiR2LbuGytEjaDEyZlPWEBsTgFriRPT
	nzKC2MwCehI7rv9ihbDlJba/ncM8gZF/FpKWWUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4
	OTEvL7VI11gvN7NELzWldBMjJMT5djC2r5c5xCjAwajEwzvjnlK4EGtiWXFl7iFGSQ4mJVHe
	q7rK4UJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeN9ZAOV4UxIrq1KL8mFS0hwsSuK8akvU/YQE
	0hNLUrNTUwtSi2CyMhwcShK8erZAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGg
	uIwvBkYmSIoHaG8USDtvcUFiLlAUovUUo6KUOO8vG6CEAEgiozQPbiwscb1iFAf6Uph3MUgV
	DzDpwXW/AhrMBDRYYJMiyOCSRISUVAPjYvllUoo3H8ZWHTi3aInkns5dGxZFG7zwuJP9aKrk
	4mls55ObbW7ufVh36MTuo1s2GJ05PT+95X1cJRuz0tkpsum9VnvKehtf73j/6tmR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292985>

On 04/29/2016 10:53 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>>> Could you explain s/sha1/NULL/ here in the proposed log message?
>>
>> Good question.
>>
>> Passing sha1 to delete_ref() doesn't add any safety, because the same
>> sha1 was just read a moment before, and it is not used for anything
>> else.
> 
> "... and it is guaranteed that no other process in the meantime
> wanted to update the ref we are trying to delete because it wants to
> see the ref with its updated value." is something I expected to see
> at the end.
> 
>> So the check only protects us from a concurrent update to
>> newrefname between the call to read_ref_full() and the call to
>> delete_ref(). But such a race is indistinguishable from the case that a
>> modification to newrefname happens just before the call to
>> read_ref_full(), which would have the same outcome as the new code.
> 
> In other words, when a transaction that contains a deletion of a ref
> races with another one that updates the ref, the latter transaction
> may come after the former one, but the ref may not survive in the
> end result and can be left deleted?
> 
> Puzzled...

Remember, we're talking about rename_ref() only, not reference deletion
in general. rename_ref() is not very robust anyway--it doesn't happen in
a single transaction, and it is vulnerable to being defeated by
simultaneous reference updates by other processes. It *does* wrap the
deletion of newrefname in a transaction; the only question is whether an
old_sha1 is supplied to that transaction.

So, suppose that newrefname starts at value A, and there are two updates
running simultaneously:

1. An update of reference newrefname from A -> B

2. A rename of reference oldrefname to newrefname, which includes
   a. read_ref_full("newrefname") and
   b. delete_ref("newrefname").

It is not possible for (1) to happen after (2b) because the former's
check of the old value of newrefname would fail. So there are two
possible interleavings:

* 1, 2a, 2b
* 2a, 1, 2b

With the new code, both of these interleavings end up with newrefname
deleted.

With the old code, the second interleaving would fail.

But the only difference is the relative order of the read-only operation
(2a), whose SHA-1 result is never used. So neither process actually
cares which of those two interleavings occurred, and it is legitimate to
treat them the same.

Note that the first transaction *did* successfully set newrefname to
value B in both cases and indeed knows for sure that the update was
successful. It's just that newrefname was deleted immediately afterwards.

Michael
