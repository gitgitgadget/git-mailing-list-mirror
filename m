Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4D4C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 18:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiKUSKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 13:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKUSK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 13:10:29 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B8A942F9
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 10:10:27 -0800 (PST)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oxBFR-000BhI-8v;
        Mon, 21 Nov 2022 18:10:26 +0000
Message-ID: <055a0072-ff65-0eea-ed58-bb1c7051dc8a@iee.email>
Date:   Mon, 21 Nov 2022 18:10:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Looking for a review (pretty-formats, hard truncation), was
 What's cooking in git.git (Nov 2022, #04; Fri, 18))
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <Y3g95OYdwzq2OP3z@nand.local>
 <8791cb85-cf4a-4302-5c1a-54a7e7766cfb@iee.email> <xmqqedtxywg0.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqedtxywg0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 21/11/2022 00:37, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> Ping, Hopefully an easy single patch review for someone on-list.
>>
>> Potential review points:
>>
>> Is the commit message sufficient?
>> Are the tests: Sufficient, Complete, Correct ?
>> Is `qz_to_tab_space` conversion applied correctly?
> Is the feature and the design sensible?
>
> Are the tests checking interesting cases?  The underlying mechanism
> uses strbuf_utf8_replace() because there are character strings whose
> display columns do not match their byte length (otherwise you can
> just use strlen() and chomp at byte boundary), so a test whose
> result would be different if strbuf_utf8_replace() were replaced
> with a more naive strbuf_splice() would be valuable and meaningful.

The tests do include those  utf8 cases. They are in the existing t/txxxx
tests that specifically cover the utf8 non-English characters. I did
check how they were constructed and what they were doing to confirm
expectations.

Were you thinking that an extra comment would be useful in the commit
message to confirm the completeness of the existing tests?

--
Philip
