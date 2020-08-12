Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71CBC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 21:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C75207F7
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 21:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PFcKREAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgHLVC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 17:02:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54223 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgHLVC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 17:02:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 11C70D3BE8;
        Wed, 12 Aug 2020 17:02:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9x2yuznqWe7ExvWf/DKQMBh3vEY=; b=PFcKRE
        AWJJ9M/cXiOz2AKzKW9t+vUkMGpwNgLp/DsUVVqDSXEwZvGVfVXu6eP+JDMsZx4p
        vWQboSbfxfvmGIsjcELV29uVKYh3yrt8tdu1UlJR30jr0HYKDFfI9FdwfPHKH8vX
        Q80vTW6+QakveoEFfSwFmdF22WQBiybsLp+sY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F2gN3ZP5gafwya/AKbYFNXjp3STL8Skq
        rPAt/rD1YnE+YoWID7zWZ+zf5qJhSfEhAtEy/DGN/oMWSuQSmaHNBd5qbyaJVh/B
        dgmIzukcJkvX1oyl9YyRG/FpiOkTofwozJlBQ1oxlSy+IF6XWp6rDiJ43XzbCpm9
        X8yRQLUYluQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 08673D3BE7;
        Wed, 12 Aug 2020 17:02:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 53E0AD3BE6;
        Wed, 12 Aug 2020 17:02:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/4] t7401: change test_i18ncmp syntax for clarity
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
        <20200812192737.13971-1-shouryashukla.oo@gmail.com>
        <20200812192737.13971-3-shouryashukla.oo@gmail.com>
        <xmqq1rkb60ql.fsf@gitster.c.googlers.com>
Date:   Wed, 12 Aug 2020 14:02:21 -0700
In-Reply-To: <xmqq1rkb60ql.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 12 Aug 2020 13:57:38 -0700")
Message-ID: <xmqqwo234lya.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E5F27EE-DCDF-11EA-962A-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
>
>> Change the test_i18ncmp syntax from 'test_i18ncmp actual expected' to
>> 'test_i18ncmp expected actual' to align it with the convention followed
>> by other tests in the test script.
>> ...
>> @@ -285,7 +285,7 @@ EOF
>>  
>>  test_expect_success '--for-status' "
>>  	git submodule summary --for-status HEAD^ >actual &&
>> -	test_i18ncmp actual - <<EOF
>> +	test_i18ncmp - actual <<-EOF
>>  * sm1 $head6...0000000:
>>  
>>  * sm2 0000000...$head7 (2):
>
> This one does more than what the proposed log message explains, but
> it does not do enough at the same time.  
>
> If "actual vs expected order" is what this commit wants to fix, then
> "<<EOF" vs "<<-EOF" is outside the scope of it.
>
> Personally, I think it is a good idea to update the end-of-heredoc
> marker to "<<-EOF", ...

It seems that the theme of your [3/4] is exactly about fixing the
"end-of-heredoc marker is prefixed with dash, but the heredoc is not
indented for readability", so perhaps you'd want to stop this step
at turning the line to

>> -	test_i18ncmp actual - <<EOF
>> +	test_i18ncmp - actual <<EOF

i.e. "compare expected vs actual in this order", and then in the
next patch [3/4], edit the line further to

	test_i18ncmp - actual <<-EOF

*and* indent the here-doc at the same time?

