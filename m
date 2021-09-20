Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB29C433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6132F60EE2
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242032AbhITPxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:53:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58922 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238500AbhITPxE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 11:53:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39BB7ED6E6;
        Mon, 20 Sep 2021 11:51:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4kFEYPXhEmcZ
        +8hUmuWhQ7sSrTOeRX8f8KHCerN1vMo=; b=E9lYSVv+F/E7Oado35eC2tu5Tstl
        HmR6CeDTobajamM0X7tnJQXZMHywVSfPALHyubXFMTLWA40vq2PPITEX4yJvDkO0
        WCU3KuuMg2n0dva52u4CHjM/qG9CkAa2FmxcldYWidfOP5RV56NrWHb54K6eJUEF
        DzqDHZotFTY7dUs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30581ED6E5;
        Mon, 20 Sep 2021 11:51:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8DD52ED6E4;
        Mon, 20 Sep 2021 11:51:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 3/7] simple-ipc: move definition of ipc_active_state
 outside of ifdef
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
        <7de207828caa9e50906f39b955e39e9de2c1768f.1631738177.git.gitgitgadget@gmail.com>
        <xmqq5yv1wnuc.fsf@gitster.g>
        <93ebf97b-1282-8f39-6894-90e0ea2dc851@jeffhostetler.com>
Date:   Mon, 20 Sep 2021 08:51:35 -0700
In-Reply-To: <93ebf97b-1282-8f39-6894-90e0ea2dc851@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 17 Sep 2021 12:58:31 -0400")
Message-ID: <xmqqzgs7ckjc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A2EBECAC-1A2A-11EC-BBA3-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 9/15/21 5:06 PM, Junio C Hamano wrote:
>> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>=20
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> From: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
>>>
>>> Move the declartion of the `enum ipc_active_state` type outside of
>>> the SUPPORTS_SIMPLE_IPC ifdef.
>> The second one is not an in-body header since there is already a
>> blank line that signals the end of in-body headers after the first
>> one.
>> This _may_ be a bug in GGG, perhaps?
>
> Maybe.  I'll make a note to ask @dscho when he gets back from vacation.
>
> Credit for the commit should go to Carlo.  I just added it to the serie=
s
> with his "From:" line and it looks like GGG added an extra one before
> it.

Thanks for a clarification.  I'll tweak the authorship when queuing.
