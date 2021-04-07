Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81036C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F56611C1
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355849AbhDGUC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 16:02:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50146 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348996AbhDGUCy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 16:02:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B4EFC21C1;
        Wed,  7 Apr 2021 16:02:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=n47q1e6IoSK4
        xLt9og2BEfH/YTI=; b=a9rIzfTtrnHTEN/S2TGYa2tpYIpl2hNaXXMY1hkUZIfU
        zGQZkSVLTUyODV/GB3NUYnw4fHIuUgx8AxV9iFrji19MtjnEmz6hLQ7CB6VRNyPH
        ZDE76Bs9m5nNtGE4SyM1KFDT0YIdTRLD09DbpriZLcGh6CH4xEbTlMqYd5jXEZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jLJUIC
        Lc4ptlFRh3wxGm+Sb5XWaZmOQBXOGQ5f286IlSmLoTGWApOGUC0HZhTQ1gz1JDPI
        10ZwepuT+dHKyQFgYJARDlYj2BXYhjg9IYra3fL2vtJ1mx0dbphjohVsm9UHaXQA
        F9TRbrwKxI4SNPEYfCD3zc1Dxc/n/u99P03B4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26A09C21C0;
        Wed,  7 Apr 2021 16:02:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 779B1C21BF;
        Wed,  7 Apr 2021 16:02:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Albert Cui <albertqcui@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] hooks: propose project configured hooks
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
        <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
        <ec031dc8-e100-725b-5f27-d3007c55be87@gmail.com>
        <CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9kJ_oWO__qw@mail.gmail.com>
        <YGzrfaSC4xd75j2U@camp.crustytoothpaste.net>
        <87tuoijzsy.fsf@evledraar.gmail.com>
        <9af3770f-204b-253b-d7f2-c9d5e7cf2fdb@gmail.com>
        <CAMbkP-QDzCQbekBf7tdN6zccDU8xnXdYFAuSZSbsdS6hSumghA@mail.gmail.com>
Date:   Wed, 07 Apr 2021 13:02:42 -0700
In-Reply-To: <CAMbkP-QDzCQbekBf7tdN6zccDU8xnXdYFAuSZSbsdS6hSumghA@mail.gmail.com>
        (Albert Cui's message of "Wed, 7 Apr 2021 11:40:34 -0700")
Message-ID: <xmqqh7khzwv1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 36EE1C30-97DC-11EB-9593-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Albert Cui <albertqcui@gmail.com> writes:

>> Here are the hard lines I draw:
>>
>> 1. This should not happen in "git clone" (other than maybe a message
>>    over stderr that hooks are available to be configured through a
>>    different command).
>>
>> 2. Hooks should not update in "git checkout" (other than a message
>>    that hooks have updated).
>>
>
> To =C3=86var's point, maybe it would help to separate the two user base=
s of
> project configured hooks.
> (1) Employee working at BigCorp. They are cloning from a trusted
> remote on company machines where the company controls what gets
> installed and how Git is configured. Their motivation is to make
> changes to their local clone and submit changes to a central
> repository.

Hmph.

If the assumption is that their configuration is controlled by
BigCorp when they arrive at their desk, why do you even need any
change to upstream Git, especially with Emily's "configuration file
tells Git what hook scripts to run" in sight?

Wouldn't it be just a matter of the BigCorp installing
/etc/gitconfig on their BigCorpLinux installations?

