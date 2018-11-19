Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 950981F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 05:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbeKSP4H (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 10:56:07 -0500
Received: from mout.web.de ([217.72.192.78]:35541 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeKSP4H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 10:56:07 -0500
Received: from macce.fritz.box ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MTh6a-1fyBMy15Q8-00QPXm; Mon, 19
 Nov 2018 06:33:32 +0100
Subject: Re: [PATCH/RFC v1 1/1] Use size_t instead of unsigned long
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
References: <20181117151139.22994-1-tboegi@web.de>
 <c09938cf-7631-ef89-d8fc-d952f9b121c8@gmail.com>
 <xmqqwopadkf9.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <f0c0e2e8-717d-9973-5533-8b806474e119@web.de>
Date:   Mon, 19 Nov 2018 06:33:30 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqwopadkf9.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HDaw35VvRCCOTd60fhdLVg1Q0ccoMR71fbAyTSoSsCx51VfjzV8
 TBfkclaTTh2UkZMXD31SzyIcqOD0ckzid9ABBg8i5Llc1Nb1uO7WMp8Ww2DaG8CID0SFSdo
 F4R/g7O9HJmMWuU1e287zDPQkEjjWFGJNxNm7GbGF4/2XhU7enKBe55YcB573bljyAuAXN4
 D47YWcMGjFSMZxJarGWbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PdYvd1631sA=:bViwK7rWWZcG25xN6xGTW/
 b6gS1ISq/GpDnPgXG9asxzbSY0mFlpgZYQtL44Ns41WexWeHIyj6DmJ1w8iqzL6Sq9HjX27Jv
 bugv2U2ijz8lOQC3zmEQJETWSOYu3QbkoIei9/dx5znRmffXWYvQ9Ej/QKzkdfVay/0w6Nvuc
 Fo8qHU+1VhgGlnqFryEd4ZCTAEnGki0o8oWq6uXKo14HlsdZ9bJs/xE0cKn1pMT6Do6oCIrwA
 sUL8xeiV4yQ/UkcHCQefFrl4GGg4GhGpvNrgDFj6kGcLyyaf3bW5V3k2OBljfdTi6H0YGmaid
 QztdOT+YVXo69bU8xCQZvDLvoW/CR/TWKuMDH+yRUrw0EaMpBYpb+hUpMKrtP4gzj1eHiQOyj
 MyYHi6f5cLpCBZr61wkS8qpqHcMXp5pGyDAE6IwiQbwjcqHBgoVsvrqL0JXnJ/xGpzwFz9noL
 wg5VfvSDnlQxxM4JONbu6guIwBord40am8eOxRksquBOQZR8atjadKh+PLn5HLBld6MkXoLCS
 7qQTQRvJ41/xu0uwB0W8bn0rgWcVZbbzBw48lIDo52fcRp1NOy/bnSJPYxUFelskvP1J9DOQT
 fMWuWXathVsvqE3X7W6JA6rWhD/ZqnBuQv3FBSVUrKjHLkfEDb/HiBW2Z/x+SY7jsy6PNxHux
 AjHp88bl0nIJYNicVPhlnRIwaVa34MwJL8+KgQMADM/oN3jFbSlWwghCwa/eWr8BN+ZIs0Bd4
 zJzyQkrUlveGoo2gswvNvlOdo8yqn4dajEf3uGPCilfWmua982VXPp96z8rCCttxvT+WUyBWB
 thLhjwfHYXSkdNv2UY2oInKov8ZIKUWqjL+30RyaXG5ussBvWIUb4Nt+ZoXBlyM1ZAo7SFQcJ
 aAJrhtDU6b/xlzhlD86nBDL7Wbh0wZ90BbWjVqbjvywvv6F+9OdJob5SpSarad
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-11-19 00:40, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>> This needs to go on top of pu, to cover all the good stuff
>>>    cooking here.
>>
>> Better to work on top of 'master', as the work in 'pu' will be
>> rewritten several times, probably.
> 
> We may not be able to find any good moment to update some codepaths
> with deep callchains that reaches a basic API function that take
> ulong that way, as things are always in motion, but hopefully a lot
> of areas that need changes are rather isolated.  
> 
> For example, the changes I see around "offset" (which is "ulong" and
> the patch wants to change it to "size_t") in archive-tar.c in the
> patch do not have any interaction with the changes in this patch
> outside that single file, and I do not think any topic in-flight
> would interact with this change badly, either.  I didn't carefully
> look at the remainder of the patches, but I have a feeling that many
> can be separated out into independent and focused set of smaller
> patches that can be evaluated on their own.
> 

The archive-tar.c is actually a good example, why a step-by-step update
is not ideal (the code would not work any more on Win64).

If we look here:

static int stream_blocked(const struct object_id *oid)
{
	struct git_istream *st;
	enum object_type type;
	size_t sz;
	char buf[BLOCKSIZE];
	ssize_t readlen;

	st = open_istream(oid, &type, &sz, NULL);
                                      ^^^^^
	if (!st)
		return error(_("cannot stream blob %s"), oid_to_hex(oid));
	for (;;) {

The sz variable must follow whatever open_istream() uses, so if we start
with archive-tar.c, we must use either size_t or ulong, whatever
open_istream() needs. Otherwise things will break:
archive-tar.c uses ulong, open_istream() size_t, but we are passing pointers
around, and here &ulong != &size_t

If we only update open_istream(), but not archive-tar.c, then
things are not better:
&size_t != &ulong.

I don't have a good idea how to split the patch.
However, "add a coccinelle script" may be a solution.
