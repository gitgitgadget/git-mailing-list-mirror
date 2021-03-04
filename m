Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952F9C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 22:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6069B64FF4
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 22:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhCDWSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 17:18:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62695 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhCDWSP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 17:18:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D83497EC4;
        Thu,  4 Mar 2021 17:18:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rEcsj0qpcJL9GsUFyBvZhscOrHs=; b=c7sPn2
        SYPqa06deN6r+oYfwCLO74fSN8yXb2KCBRewk8mMqrpG/XGtmCTImYEISfZsZk0p
        Moyd6I77ksYTwmbJ27FcKE9VfFAoMz0lqPJzXADzGwpuZhs6FJlkAbT1Web1za2p
        yLhF85nar4ba1ClNuG7n9V/VD5X+eyP7xce6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QV3Z/pPY8mB7HhtgO7AlY/maNVn6DDIv
        i4Qw8j+YKS7IRduNxmQA4AlKY6aLV6OrDQiKHbiKTGsQSfOUqtU1f2q4PPhXBMTz
        +QamGdoCMm7epaTALSOQKDyOnuIxiQr7GOaKDAxhWrqFvmEUlW1tCllZELmpS+s5
        0LTqRIGhKs8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93FC497EC3;
        Thu,  4 Mar 2021 17:18:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 21E1897EC2;
        Thu,  4 Mar 2021 17:18:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
References: <20210301084512.27170-1-charvi077@gmail.com>
        <20210301084512.27170-7-charvi077@gmail.com>
        <CAPig+cRvwvT7QrO0-aLZX-2vsBPJSq6WO-O7g5A0OjDMNAYmCQ@mail.gmail.com>
        <CAPSFM5c1zR6yz=gATGxih0wL-W18AWgCHQhL_SPno5SeTzGQGg@mail.gmail.com>
        <CAPig+cRiiQyavaMGzgBkXOoGFPhMBC7GbpB61ziFMrckReFbcQ@mail.gmail.com>
        <xmqqczwfg23t.fsf@gitster.c.googlers.com>
        <CAPSFM5cM4fdyWXD33PkT2bH6kM+3ixkxgAnhjUVYFtjUHgwU5g@mail.gmail.com>
Date:   Thu, 04 Mar 2021 14:18:13 -0800
In-Reply-To: <CAPSFM5cM4fdyWXD33PkT2bH6kM+3ixkxgAnhjUVYFtjUHgwU5g@mail.gmail.com>
        (Charvi Mendiratta's message of "Thu, 4 Mar 2021 14:30:34 +0530")
Message-ID: <xmqqpn0ed0m2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8320A83A-7D37-11EB-BDB1-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

>> no paths, i.e.  If you have --fixup=amend, you can do
>>
>>     $ git commit --fixup=amend:<original> --only
>>
>> and you do not need --fixup=reword:<original> at all, no?
>>
>
> Maybe as an alternative User interface, we can remove the
> `--fixup=reword:<original>`.
>
> But for this patch, as we have kept separate suboption
> `--fixup=reword:<original>` , so if now we do
> `--fixup=amend:<original> --only` then it will return the error as
> below :
> fatal: No paths with --include/--only does not make sense.

Yes, but it is something we can easily fix, just like we made
"--only" without any pathname to work with "--amend" (or with
"--allow-empty").

The reason I brought it up was not because "--fixup=reword" is not
needed as a short-hand for "--only --fixup=amend" (but thinking
about it again, I do not think it is so bad), but primarily in
response to "would it be easier for users if we had reword! insn in
addition to amend! verb in the todo file?" that was raised earlier
in the thread.  If we position "--fixup=reword" as a short-hand
and/or a syntax sugar for "--fixup=amend" and advertise it as such
sufficiently to educate users, it would be easier for users to
understand why they both result in "amend!".
