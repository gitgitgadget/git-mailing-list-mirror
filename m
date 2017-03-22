Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CEFA20323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbdCVWEi (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:04:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63046 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750867AbdCVWEg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:04:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CCB737CEB0;
        Wed, 22 Mar 2017 18:04:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hjLEDNOj/rkwCSl6jDXeId8prk8=; b=VxtkbK
        NqzeSrGR6+H5sWqfwsI9f4pyw5+g7Crwo9ZoR/je9XXYisE9+JMiNSZ2KpLKfYq5
        Rd7/J9YE0dxB2BDvkanG8M9LK9xSaGllMlHQ9Y7YKpAMV5am3u2bGfYZ9HglsaIE
        OLTNtyRIDRKjdJOvXrvO8lha2qBYQuJKi8xt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c4We4fX7+uhBJkIdH4jsnXFGiIY0184k
        +Z4q9hZqtyyeoDo64nxb/Ks1l4BhcAWctlG1/Qz0F8bL9fzCX/7bnezgvx7wXiQ7
        6L0sJ3F26M82m2wlyNF2XUWbJWsiNiv0TZUP9uTSY1Dnp+bLKl9tG8lYULaqTbkz
        PmBo9PbSRXA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C52EA7CEAF;
        Wed, 22 Mar 2017 18:04:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1FF9A7CEAE;
        Wed, 22 Mar 2017 18:04:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 3/3] t7004, t7030: fix here-doc syntax errors
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
        <20170322200805.23837-1-gitster@pobox.com>
        <20170322200805.23837-4-gitster@pobox.com>
        <20170322211003.b52cql3iwig2xqcd@sigill.intra.peff.net>
Date:   Wed, 22 Mar 2017 15:04:32 -0700
In-Reply-To: <20170322211003.b52cql3iwig2xqcd@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 22 Mar 2017 17:10:03 -0400")
Message-ID: <xmqq8tnxhssv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88478FA8-0F4B-11E7-AEE0-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Mar 22, 2017 at 01:08:05PM -0700, Junio C Hamano wrote:
>
>> From: Jan Palus <jan.palus@gmail.com>
>> 
>> These all came as part of an earlier st/verify-tag topic that was
>> merged to 2.12.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> 
>>  * This should be applied on top of 4fea72f4 ("t/t7004-tag: Add
>>    --format specifier tests", 2017-01-17)
>> 
>>  t/t7004-tag.sh        | 8 ++++----
>>  t/t7030-verify-tag.sh | 8 ++++----
>>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> Like 2/3, this one also produces test failures for me. It looks like
> "verify-tag" does not show a tag which has been forged. I'm not sure if
> that's intentional (and the test is wrong) or a bug.  +cc Santiago

It appears that the test expected a broken one to be shown, and my
reading of its log message is that the change expected --format= to
be used with %G? so that scripts can tell between pass and fail?  

So if I have to judge, the code becoming silent for a tag that does
not pass verification is not doing what the commit wanted it to do.

