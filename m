Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E630C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 19:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE68F20786
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 19:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M9VcuMb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgHKTYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:24:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64645 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKTYF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 15:24:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EBC1FF297A;
        Tue, 11 Aug 2020 15:24:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X8yTl/CZSjqmsvGYLhdxzUg+Hm0=; b=M9VcuM
        b0VCN7ub0zRffUfUzsvfufWL4ccVWrNuSdeEWqpkRG5A/lS1cbfwmJCyIjxTMsAb
        z58ru12190ENP7Lzpm/SqK+mg9B0zHdxYPYpvlXSK3oFWeXyjPi6zj+DLYjL3/ZV
        4zx1vLahVTKp18HZs7SIlQUWghqce/+u8HNRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ot2bzkKLQAA5eSKgB+akyK3br1bgZine
        +RHCABRvLTJR3F7imllCDj5ECI2Mc0hfWoEi311ggWQ0Ekuxx1sq8QYwUbOgffeZ
        Pbb5wI0ze0kCgrkr4D/nHhAXKSBzsUnUdyevbtz/e1TNW6AjzXm7ZBMzN1xARsmH
        7HtZQwWxZq4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E5E2DF2979;
        Tue, 11 Aug 2020 15:24:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3B1ACF2975;
        Tue, 11 Aug 2020 15:24:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #02; Mon, 10)
References: <xmqqsgcub811.fsf@gitster.c.googlers.com>
        <874kp9biho.fsf@osv.gnss.ru>
Date:   Tue, 11 Aug 2020 12:23:59 -0700
In-Reply-To: <874kp9biho.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        11 Aug 2020 13:10:43 +0300")
Message-ID: <xmqq7du59eb4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3607AC9A-DC08-11EA-A7B2-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
> [...]
>
>> * jk/log-fp-implies-m (2020-07-29) 7 commits
>>   (merged to 'next' on 2020-08-03 at 39fefa6b82)
>>  + doc/git-log: clarify handling of merge commit diffs
>>  + doc/git-log: move "-t" into diff-options list
>>  + doc/git-log: drop "-r" diff option
>>  + doc/git-log: move "Diff Formatting" from rev-list-options
>>  + log: enable "-m" automatically with "--first-parent"
>>  + revision: add "--no-diff-merges" option to counteract "-m"
>>  + log: drop "--cc implies -m" logic
>>
>>  Originally merged to 'next' on 2020-08-01
>>
>>  "git log --first-parent -p" showed patches only for single-parent
>>  commits on the first-parent chain; the "--first-parent" option has
>>  been made to imply "-m".  Use "--no-diff-merges" to restore the
>>  previous behaviour to omit patches for merge commits.
>>
>>  On hold a bit.
>>  cf. <20200804200018.GB2014743@coredump.intra.peff.net>
>
> I believe I've submitted resolution for that.
>
> <20200805220832.3800-1-sorganov@gmail.com>
>
> Do you expect anything from me to push all this further?

I was waiting for a reroll of the "resolution" with just one extra
test I mentioned in <xmqq3650n2rc.fsf@gitster.c.googlers.com> in the
thread.  With that everything would be good to go, I would think.

