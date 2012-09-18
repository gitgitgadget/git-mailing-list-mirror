From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] string_list API: document what "sorted" means.
Date: Tue, 18 Sep 2012 10:55:56 +0200
Message-ID: <5058371C.8060209@alum.mit.edu>
References: <1347895267-5054-1-git-send-email-mhagger@alum.mit.edu> <7vy5k8s622.fsf@alter.siamese.dyndns.org> <505829AB.8000506@alum.mit.edu> <7vmx0noi8s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:56:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDtbI-0000ad-FB
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 10:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145Ab2IRI4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 04:56:01 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:52214 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755929Ab2IRI4A (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2012 04:56:00 -0400
X-AuditID: 12074412-b7f216d0000008e3-66-5058371f43e0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id E1.DE.02275.F1738505; Tue, 18 Sep 2012 04:55:59 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8I8tvg0000738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 18 Sep 2012 04:55:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vmx0noi8s.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsUixO6iqCtvHhFg8GGnuEXXlW4mi4beK8wO
	TB4XLyl7fN4kF8AUxW2TlFhSFpyZnqdvl8CdcbpzPmvBP9GK81fOMTYwXhTsYuTkkBAwkVj8
	dxMbhC0mceHeejBbSOAyo8StQ2pdjFxA9nEmidPTHrOAJHgFtCXe7tgPVMTBwSKgKnFwqSZI
	mE1AV2JRTzMTiC0qECIx4/JkZohyQYmTM5+AtYoIqElMbDvEAtLKLCAu0f8PzBQWcJY4/TYW
	YtN2Rokjr1+ClXMKmEn86f3ICmIzC+hIvOt7wAxhy0tsfzuHeQKjwCwkG2YhKZuFpGwBI/Mq
	RrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0zvdzMEr3UlNJNjJAQFdrBuP6k3CFGAQ5GJR7eivTw
	ACHWxLLiytxDjJIcTEqivCGmEQFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHh9pYFyvCmJlVWp
	RfkwKWkOFiVx3p+L1f2EBNITS1KzU1MLUotgsjIcHEoSvGdBhgoWpaanVqRl5pQgpJk4OEGG
	c0mJFKfmpaQWJZaWZMSDojS+GBinICkeoL35IO28xQWJuUBRiNZTjMYcs2+uuM/IcfcjkBRi
	ycvPS5US57UAKRUAKc0ozYNbBEtOrxjFgf4W5t0BUsUDTGxw814BrWICWlXxJAxkVUkiQkqq
	gdFXvHfhgqbvCmV3GY2NK+VZ7A7IHLOJ6hHVPdjDeXHTqzD9d3tbnvBXBVudaf3b3XtxQfGJ
	+L8CltHu5U0fI634v7DrLOS6mjC5pDvMUv5j5n+pKaqZdqunGVQ4C121lH1e7my4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205815>

On 09/18/2012 10:19 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> 1. Document that string_list sorts entries according to their strcmp()
>> order, as proposed in this patch.  Then fetch can rely on this ordering.
>>  If somebody wants a different ordering in the future, it is easy to
>> make the sort order a parameter.
>>
>> 2. Leave string_list's "default" sort order unspecified, but already
>> implement a way to let string_list users specify a particular sort
>> order.  Change the fetch machinery to specify a strcmp()-based ordering
>> explicitly.  This approach has the advantage of letting the default sort
>> order of string_list to be changed, though I don't really see how this
>> would be helpful.
>>
>> 3. Change fetch back to doing its own sorting again, rather than relying
>> on sort_string_list().  This isn't a lot of work (inline the one line of
>> sort_string_list(), then either make string-list.c:cmp_items() public or
>> duplicate that function too).
> 
> I haven't looked at non-users of string-list API, but my gut feeling
> has been that lack of 2. made the API less useful for current
> non-users, possible callers that could benefit from something like
> string-list that lets them specify their own sort order.
> 
> Also, I actually am more worried about us wanting to change the
> order in which ref-list is sorted, rather than somebody randomly
> deciding to change the default (and only) order string-list is
> sorted on.  When that happens, we would have even less useful
> string-list left behind, with a documented invariant that is not
> helping anybody if we choose to do 1 now.

If another sort order is needed, then we will either have to audit
existing string_list users to make sure that they don't rely on strcmp()
ordering, or we will have to implement strcmp() ordering *plus* the new
ordering.  In that case the simplest approach would be to convert all
existing users to explicit strcmp() ordering and only use the new
ordering in places where there is a specific need for it.  This process
would be no more difficult if we document strcmp() ordering now.
When/if we reach that bridge, we can easily change the documentation from

    A "sorted" list is one whose entries are sorted by string value in
    `strcmp()` order.

to

    A "sorted" list is one whose entries are sorted according to the
    configured `compare()` function.  The default `compare()` function
    orders entries in the `strcmp()` order of their string values.

It's not that I'm unwilling to implement 2; it's just that I still don't
see any advantage to doing so before there is a demonstrated need for it.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
