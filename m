From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 23/38] refs: make peel_ref() virtual
Date: Thu, 9 Jun 2016 17:05:44 +0200
Message-ID: <575985C8.9040108@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
 <316f0fed796fd2ed17ea5df4c264a98028d6b98a.1464983301.git.mhagger@alum.mit.edu>
 <xmqqtwh4rjdh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:07:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB1X7-0003tW-7w
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 17:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbcFIPGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 11:06:05 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:63612 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932102AbcFIPGD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2016 11:06:03 -0400
X-AuditID: 12074414-63fff700000008e6-1f-575985cb8b8e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id A8.A1.02278.BC589575; Thu,  9 Jun 2016 11:05:47 -0400 (EDT)
Received: from [192.168.69.130] (p508EAACA.dip0.t-ipconnect.de [80.142.170.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u59F5ihT008389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 9 Jun 2016 11:05:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <xmqqtwh4rjdh.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsUixO6iqHu6NTLcYPZ9YYv5m04wWnRd6Way
	aOi9wmzRPeUto8WPlh5mi5lXrS3OvGlkdGD32DnrLrvHs949jB4XLyl77F+6jc1j8QMvjwXP
	77N7fN4kF8AexW2TlFhSFpyZnqdvl8Cd0fRqGUvBWc6K3UfWMDUwPmbvYuTkkBAwkdj1rBfI
	5uIQEtjKKDHzQwsjhHOeSaJ78TQmkCphAQuJ3Ru+soLYIgJqEhPbDrFAFO1klLg7cz4biMMs
	MItJomPrRUaQKjYBXYlFPc1g3bwC2hIn355gBrFZBFQk/l1rALNFBUIkzq/bygpRIyhxcuYT
	FhCbU8BaYvXL72BzmAX0JHZc/8UKYctLbH87h3kCI/8sJC2zkJTNQlK2gJF5FaNcYk5prm5u
	YmZOcWqybnFyYl5eapGuhV5uZoleakrpJkZI0IvsYDxyUu4QowAHoxIPr0ZKRLgQa2JZcWXu
	IUZJDiYlUV7vkshwIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8ZxqBcrwpiZVVqUX5MClpDhYl
	cd5vi9X9hATSE0tSs1NTC1KLYLIyHBxKErxvW4AaBYtS01Mr0jJzShDSTBycIMO5pESKU/NS
	UosSS0sy4kFxGV8MjEyQFA/Q3mUg7bzFBYm5QFGI1lOMuhxH9t9byyTEkpeflyolzmsBUiQA
	UpRRmge3ApbiXjGKA30szMsITHhCPMD0CDfpFdASJqAly4+EgywpSURISTUwNuxmORR/+Xxc
	e1pe42fNetP9tpFP4j1fzRV4unBJdNiGl7G/Lz04Hzv9v1TQ1H5m7sf/4ktMl/42 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296891>

On 06/07/2016 07:36 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> For now it only supports the main reference store.
> 
> Isn't this comment applicable to a handful of recent changes that
> made other things virtual, too?  Just wondering if I am missing
> something very special with the peel_ref() thing to single it out.

It is true that many (most?) virtual functions can currently only be
used with the main reference store. That is likely to stay the case for
reference-writing functions, because currently there isn't any code that
wants to write references in other submodule. (Or maybe there is, but
it's currently done by invoking a subprocess? I haven't actually looked.)

But peel_ref() is a read-only function, and it seems more plausible to
implement it for other submodules. It just seems like work that can be
put off. And there's the kindof ugly current_ref_iter hack that might go
away if callers are rewritten to use ref_iterators, in which case
implementing this method for other submodules would become even easier.

In other words, the main point of the comment is not "it only supports
the main reference store", but rather "for now".

Michael
