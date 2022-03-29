Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97861C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 18:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbiC2Swt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 14:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbiC2Swr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 14:52:47 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E809E1EA5C9
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 11:51:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 36C6C195C57;
        Tue, 29 Mar 2022 14:51:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/if842pofCyTNr3CWpvOv6dqYSGvsM0XUcLxNE
        nu2fs=; b=NTw1cW6/rYQZ6M/WeFXdZ7M9qd3Gd2lmIxgIbaNIvfuS7T1J0xyZ/F
        meJKmlN0zxconb2naQFqVjetqT7d4fBoetDvzcRxez+v4Y/QRhRYC4PgkPM5SEkJ
        8NWCiUnPd3DhRIMbuQK7fAkGsyWr2krciTyer7Q52Jxz91otqwXTQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 302AD195C56;
        Tue, 29 Mar 2022 14:51:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9115F195C51;
        Tue, 29 Mar 2022 14:51:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v4 11/13] t/perf: add iteration setup mechanism to perf-lib
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
        <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <ee7ecf4cabeff14cc64c979aa77fbb2597a9f986.1648514553.git.gitgitgadget@gmail.com>
        <CANQDOdfjRcTB4=mq869NZrNAk+gapR5i8XHFnBhfH1eONzP0BA@mail.gmail.com>
Date:   Tue, 29 Mar 2022 11:50:58 -0700
In-Reply-To: <CANQDOdfjRcTB4=mq869NZrNAk+gapR5i8XHFnBhfH1eONzP0BA@mail.gmail.com>
        (Neeraj Singh's message of "Tue, 29 Mar 2022 10:14:45 -0700")
Message-ID: <xmqqilrwtwx9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D42D054-AF91-11EC-B746-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> On Mon, Mar 28, 2022 at 5:42 PM Neeraj Singh via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>>  test_wrapper_ () {
>> -       test_wrapper_func_=$1; shift
>> +       local test_wrapper_func_=$1; shift
>> +       local test_title_=$1; shift
>
> local with assignment seems to be a bash-ism.  I'll fix this.

Thanks.
