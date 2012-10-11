From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/3] grep: stop looking at random places for .gitattributes
Date: Thu, 11 Oct 2012 09:04:52 +0200
Message-ID: <50766F94.4020104@alum.mit.edu>
References: <7vk3uzfp3p.fsf@alter.siamese.dyndns.org> <1349868894-3579-1-git-send-email-pclouds@gmail.com> <1349868894-3579-4-git-send-email-pclouds@gmail.com> <5075615B.8020702@viscovery.net> <CACsJy8BG0HJNePG-j27SrfEenEkZ5a5nCdMEuDGn=qXxq=VzhA@mail.gmail.com> <50756646.5060505@viscovery.net> <7vy5jeaz81.fsf@alter.siamese.dyndns.org> <50765F34.1070108@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 11 09:05:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMCpQ-0007Be-PO
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 09:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523Ab2JKHE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 03:04:57 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:61276 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754978Ab2JKHE4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 03:04:56 -0400
X-AuditID: 12074411-b7fa36d0000008cc-c6-50766f97340c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 92.71.02252.79F66705; Thu, 11 Oct 2012 03:04:55 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9B74qtm007079
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 11 Oct 2012 03:04:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <50765F34.1070108@viscovery.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsUixO6iqDs9vyzAYPEJaYuuK91MFg29V5gt
	Vv6sseie8pbR4kdLD7MDq8fOWXfZPZ717mH0uHhJ2ePzJjmPu/93MgWwRnHbJCWWlAVnpufp
	2yVwZ3Rs2M1UcIez4syrSSwNjN/Zuxg5OSQETCQ2vTjJBGGLSVy4t56ti5GLQ0jgMqPE9mvT
	GSGc40wSX2c0sYBU8QpoS9zYMBWsg0VAVWLm7l6wOJuArsSinmawuKhAmMS7X0dZIeoFJU7O
	fAJWIyKgIbH7dC87yFBmgUmMEhNeHmYESQgL+EucePybFWLbRyaJs5eXgd3HCTT11bydYN3M
	AjoS7/oeMEPY8hLb385hnsAoMAvJkllIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1
	SNdULzezRC81pXQTIyTMBXcwzjgpd4hRgINRiYf3x87SACHWxLLiytxDjJIcTEqivJPyygKE
	+JLyUyozEosz4otKc1KLDzFKcDArifDOTgLK8aYkVlalFuXDpKQ5WJTEefmWqPsJCaQnlqRm
	p6YWpBbBZGU4OJQkeAWB8SwkWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rX+GJg
	xIKkeID2MoK08xYXJOYCRSFaTzEacxx9M/chI8fHxnkPGYVY8vLzUqXEee+DnC8AUppRmge3
	CJbgXjGKA/0tzHsLpIoHmBzh5r0CWsUEtEpmUgnIqpJEhJRUAyPPgVyvBV3xLGqrdmnsf321
	yr+7gMdqefCq03/0gyvaXHm0z5iwtN9wObK2VfXaj6OnRbxdsm66z2Ms1Vnxb/+f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207466>

On 10/11/2012 07:55 AM, Johannes Sixt wrote:
> Am 10/10/2012 21:44, schrieb Junio C Hamano:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>
>>> Is there already an established definition which the "correct"
>>> .gitattributes are?
>>
>> No, and it is deliberately kept vague while waiting for us to come
>> up with a clear definition of what is "correct".
> ...
>> Very often, people
>> retroactively define attributes to correct earlier mistakes.
> 
> Absolutely. I have Windows resource files that are Shift-JIS encoded
> checked in long ago, and I want to retoactively declare them with
> "encoding=Shift-JIS" because I prefer to see Japanese script in gitk
> rather than gibberish.

Maybe I'm being too much of a purist, but I don't think that git should
retroactively reinterpret history on its own initiative in a way that
might not be correct (e.g., maybe your encoding changed from ASCII to
Shift-JIS sometime in the past).  It would be more appropriate for this
to happen only if explicitly requested by the user.  For example, why
don't you override the incorrect historical attributes via
.git/info/attributes?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
