From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH/RFC] doc: document error handling functions and conventions
 (Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf)
Date: Tue, 17 Feb 2015 16:50:07 +0100
Message-ID: <54E3632F.20907@alum.mit.edu>
References: <20141203050217.GJ6527@google.com>	<20141203051344.GM6527@google.com>	<xmqqzjb4h823.fsf@gitster.dls.corp.google.com>	<20141204030133.GA16345@google.com>	<xmqqy4qnq9m2.fsf@gitster.dls.corp.google.com>	<20141204234147.GF16345@google.com> <20141204234432.GA29953@peff.net>	<CAPc5daW3+8xjG3z3WgOMfqzWJUiPdcN1-FVgVc0fAjH7tgCa4A@mail.gmail.com>	<20141205000128.GA30048@peff.net>	<xmqqfvcuq8nu.fsf@gitster.dls.corp.google.com>	<20141207100755.GB22230@peff.net>	<xmqqk320mzo7.fsf@gitster.dls.corp.google.com> <xmqqd25epw24.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 16:50:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNkPx-0005Sg-Qf
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 16:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbbBQPuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 10:50:23 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61990 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751793AbbBQPuW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 10:50:22 -0500
X-AuditID: 12074413-f79f26d0000030e7-a3-54e36331794c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id CF.48.12519.13363E45; Tue, 17 Feb 2015 10:50:10 -0500 (EST)
Received: from [192.168.69.130] (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HFo7hR029346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 10:50:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <xmqqd25epw24.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqGuU/DjE4MchJouuK91MFg29V5gt
	3t5cwmjxo6WH2WLz5nYWB1aPnbPusnss2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ2z59pi9oIm3ouPQXNYGxilcXYycHBICJhKNx5pZIWwxiQv31rN1MXJxCAlcZpSY/uAe
	K4Rzjkli2YTrLCBVvAKaEl8nnwayOThYBFQlZt8XBAmzCehKLOppZgKxRQWCJA6dfgxVLihx
	cuYTMFtEwE9i/vWbbCA2s0CBxKXjE8BsYYHpjBLvroPZQgLrWSS+r6gAsTkFrCX2vD8KVa8n
	seP6L1YIW15i+9s5zBMYBWYhWTELSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuma
	6+VmluilppRuYoQEuPAOxl0n5Q4xCnAwKvHwWkx4FCLEmlhWXJl7iFGSg0lJlHdt4uMQIb6k
	/JTKjMTijPii0pzU4kOMEhzMSiK8GTFAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTU
	gtQimKwMB4eSBO8vkKGCRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoEiNLwbGKkiK
	B2jvD5B23uKCxFygKETrKUZFKXHePyAJAZBERmke3FhY2nrFKA70pTBvShJQFQ8w5cF1vwIa
	zAQ0eP6fRyCDSxIRUlINjPnruYrbejhtuC55ntmZcZ3jrM7iacv63OPU/8SU+4Y/2DL1Q9Ga
	eB3bRenPLF/Vnloo9rTrjv+toraJAqkFivE94opn70l/i7c8d3Sam0lpT9+Vayrs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263948>

On 02/13/2015 12:08 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> On Fri, Dec 05, 2014 at 10:00:05AM -0800, Junio C Hamano wrote:
>>>
>>>> I am more worried about variable length part pushing the information
>>>> that is given later out to the right, e.g. "error: missing file '%s'
>>>> prevents us from doing X".  Chomping to [1024] is not a good
>>>> strategy for that kind of message; abbreviating %s to /path/name/...
>>>> (again, with literally "...") would be.
> 
> I have this one in my pile of Undecided topics:
> 
>     * jn/doc-api-errors (2014-12-04) 1 commit
>      - doc: document error handling functions and conventions
> 
>      For discussion.
>      What's the status of this one????
> 
> I think we all agree that the early part of the new documentation
> text is good, but the last section that proposes to store more
> detailed errors in caller supplied strbuf in textual form was
> controversial (and I have not convinced myself it is a good idea
> yet).
> 
> I could chuck the last section and then start merging the remainder
> to 'next' to salvage the "obviously good bits".  Or do people want
> to hash its last section a bit more?

Whether or not we decide on a different error-handling convention in the
future, it is a fact of life that a good bit of code already uses the
"strbuf" convention documented by Jonathan's patch. So I think it is OK
to merge it as is. If we change the preferred convention in the future,
one part of the change will be to update this file.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
