From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 09/13] refs: introduce an iterator interface
Date: Fri, 3 Jun 2016 13:48:20 +0200
Message-ID: <57516E84.6020007@alum.mit.edu>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
 <89634d216544d1102dafd5d18247bff2581d48a8.1464537050.git.mhagger@alum.mit.edu>
 <CAPig+cSjzZGUjdgkz1y7brGNb1M2gHfW0UG-wgBc00beNDQmnA@mail.gmail.com>
 <574D4448.5020004@alum.mit.edu>
 <CAPig+cQte++ngtXdQmpjei9sr+KPKi7qs+vHgijU+Gj1eHDUXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 13:48:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8naX-0003cj-O3
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 13:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbcFCLs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 07:48:26 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:55326 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751793AbcFCLsZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 07:48:25 -0400
X-AuditID: 1207440e-ef3ff700000008c5-3c-57516e87d79c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 61.19.02245.78E61575; Fri,  3 Jun 2016 07:48:23 -0400 (EDT)
Received: from [192.168.69.130] (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53BmKY1003577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 07:48:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <CAPig+cQte++ngtXdQmpjei9sr+KPKi7qs+vHgijU+Gj1eHDUXQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqNuRFxhu8LGJyWL+phOMFl1Xupks
	GnqvMFt0T3nLaPGjpYfZ4sybRkYHNo+ds+6yezzr3cPocfGSssfiB14eC57fZ/f4vEkugC2K
	2yYpsaQsODM9T98ugTtj3qVJrAVTBStW/+xmamB8xtvFyMkhIWAisfb+N5YuRi4OIYGtjBLP
	D9xkhHDOMUnsmLaVGaRKWMBB4u7nJhYQW0RAW+LDhk1QRTuYJDbPeMAM4jALvGaUeHO1mR2k
	ik1AV2JRTzMTiM0L1PFw0kGwOIuAisSq93/AJokKhEicX7eVFaJGUOLkzCdAcQ4OToFAiRsf
	ZUHCzALqEn/mXWKGsOUltr+dwzyBkX8Wko5ZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5
	MS8vtUjXWC83s0QvNaV0EyMkwPl2MLavlznEKMDBqMTDy7A4IFyINbGsuDL3EKMkB5OSKO/5
	s0AhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIryeOYHhQrwpiZVVqUX5MClpDhYlcV61Jep+QgLp
	iSWp2ampBalFMFkZDg4lCd7duUCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aCo
	jC8GxiVIigdo732Qdt7igsRcoChE6ylGRSlx3j8gBwmAJDJK8+DGwtLWK0ZxoC+FeU1A2nmA
	KQ+u+xXQYCagwQWP/EEGlyQipKQaGLdK9vHarhZz6hZ/93jq0f1Bfxe7rb34/Yt33POgw6I1
	B3yXHfR6c+Ke3PnOO4crL08IuxZ1/N8nk4PbRWOXTbNSNqzL/6O+3b9gh8eJ4/cb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296304>

On 06/01/2016 01:12 AM, Eric Sunshine wrote:
> On Tue, May 31, 2016 at 3:59 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 05/31/2016 07:29 AM, Eric Sunshine wrote:
>>> On Mon, May 30, 2016 at 3:55 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>>> +struct ref_iterator *empty_ref_iterator_begin(void);
>>>> +
>>>> +/*
>>>> + * Return true iff ref_iterator is an empty_ref_iterator.
>>>> + */
>>>> +int is_empty_ref_iterator(struct ref_iterator *ref_iterator);
>>>
>>> I can see that you used this function as an optimization or
>>> convenience in overlay_ref_iterator_begin(), but do you expect it to
>>> be generally useful otherwise? Is it worth publishing? Do you have
>>> other use-cases in mind?
>>
>> It is only "published" within the refs module, in refs/refs-internal.h.
>> This header file is not meant to be used by code outside of the refs module.
> 
> Ah, I forgot about that. In that case, it's probably less of an issue.
> 
>> My thinking was that it might be useful to other reference backends. The
>> function is pretty safe for anybody to call, though I admit that it is
>> not very general.
>>
>> I don't have a strong feeling either way. If nobody else chimes in, I'll
>> remove it from the header file as you suggested. We can always add it
>> back if somebody needs it.
> 
> I don't feel strongly about it either.

OK then, I'll leave it as-is.

>>> Also, can you explain why the merge iterator doesn't also perform the
>>> optimization/convenience of checking if one iterator is an empty
>>> iterator?
>>
>> That's because the merge iterator doesn't know what its select function
>> will do. For example, you could imagine an "intersect" select function
>> that only lets through references that were in *both* sub-iterators. In
>> that case, your suggested "optimization" would be incorrect.
> 
> Makes sense. Thanks for explaining. I wonder if this deserves a
> comment somewhere in code or commit message to make the situation
> clear to a future developer who might think it a good idea to promote
> the "optimization" to the merge iterator.

Good idea. I'll add a comment.

> [...]

Thanks,
Michael
