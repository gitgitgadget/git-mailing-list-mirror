Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 002E320960
	for <e@80x24.org>; Mon, 20 Mar 2017 22:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755648AbdCTWte (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 18:49:34 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50462 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754788AbdCTWtd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 18:49:33 -0400
X-AuditID: 1207440d-029ff70000003721-9d-58d05c5d1466
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id CF.0F.14113.D5C50D85; Mon, 20 Mar 2017 18:49:02 -0400 (EDT)
Received: from [192.168.69.190] (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KMmwgY032465
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 18:48:59 -0400
Subject: Re: [PATCH 00/20] Separate `ref_cache` into a separate module
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
 <xmqqk27jtw8w.fsf@gitster.mtv.corp.google.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <d2f8af06-1f0f-835e-2535-ce4f754370b1@alum.mit.edu>
Date:   Mon, 20 Mar 2017 23:48:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqk27jtw8w.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42IRYndR1I2LuRBhsHMdn0XXlW4mi4beK8wW
        Sx6+ZrbonvKW0eJHSw+zA6vHzll32T262o+weTzr3cPocfGSssfnTXIBrFFcNimpOZllqUX6
        dglcGZN3ORXc5Kv4dXIlYwNjJ08XIyeHhICJxNzLuxm7GLk4hAR2MEmsatjHAuFcYJL4cuAX
        K0iVsICbxJd1K1lAbBEBNYmJbYfAbCGBDInGRysYQWxmgXWMEvse64LYbAK6Eot6mplAbF4B
        e4nFv+8yg9gsAqoSi7p72UBsUYEQiTkLHzBC1AhKnJz5BGgmBwengLXEkjeJECP1JHZchziB
        WUBeYvvbOcwTGPlnIemYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfRyM0v0
        UlNKNzFCwph3B+P/dTKHGAU4GJV4eFdcOR8hxJpYVlyZe4hRkoNJSZS3yvdChBBfUn5KZUZi
        cUZ8UWlOavEhRgkOZiUR3loPoBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxW
        hoNDSYLXOBqoUbAoNT21Ii0zpwQhzcTBCTKcB2Q4SA1vcUFibnFmOkT+FKMux6+eY2+YhFjy
        8vNSpcR5nUCKBECKMkrz4ObA0s8rRnGgt4R5U0GqeICpC27SK6AlTEBLlt04A7KkJBEhJdXA
        mB5z51SVbEtkbmHdF7vUA+dj3C9r8+QtPuIpGhZwuTl7h/WscwXiDdcnKayY7vwhhW2lwbe+
        a7ayKVXbnl03aD5+aq2E6CuRu0/2s2i8PK4s/6HQoP6mTo5feOvXvhwFi5bXbs4a1zTPr9KI
        YRGsj1/qssV5x5M++1c9S3eVx/XLFpk2GggqsRRnJBpqMRcVJwIAz1t7uxoDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/20/2017 11:32 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Michael Haggerty (20):
>>   get_ref_dir(): don't call read_loose_refs() for "refs/bisect"
>>   refs_read_raw_ref(): new function
>>   refs_ref_iterator_begin(): new function
>>   refs_verify_refname_available(): implement once for all backends
>>   refs_verify_refname_available(): use function in more places
>>   Rename `add_ref()` to `add_ref_entry()`
>>   Rename `find_ref()` to `find_ref_entry()`
>>   Rename `remove_entry()` to `remove_entry_from_dir()`
>>   refs: split `ref_cache` code into separate files
>>   ref-cache: introduce a new type, ref_cache
>>   refs: record the ref_store in ref_cache, not ref_dir
>>   ref-cache: use a callback function to fill the cache
>>   refs: handle "refs/bisect/" in `loose_fill_ref_dir()`
>>   do_for_each_entry_in_dir(): eliminate `offset` argument
>>   get_loose_ref_dir(): function renamed from get_loose_refs()
>>   get_loose_ref_cache(): new function
>>   cache_ref_iterator_begin(): make function smarter
>>   commit_packed_refs(): use reference iteration
>>   files_pack_refs(): use reference iteration
>>   do_for_each_entry_in_dir(): delete function
> 
> These mostly seem to be ref-cache but there is one mention of "refs
> cache", and also the topic cover says ref_cache.  Which one is the
> canonical one?  I'd assume it is "ref-cache" (or "ref cache").
> 
> The reason I am asking is because I wanted to give the three
> "Rename" ones an "<area>:" prefix, and then noticed that the
> shortlog output looked somewhat incoherent.

It's meant to be "ref-cache", short for "reference cache", which seems
more natural than "references cache". But I admit that I often type it
wrong because of muscle memory trained on other things named "refs_blah".

Thanks for noticing.

Michael

