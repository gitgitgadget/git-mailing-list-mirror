Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C263CC433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16B160C51
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhJYV27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 17:28:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62167 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhJYV2l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 17:28:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62839F9566;
        Mon, 25 Oct 2021 17:26:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GSxy71LCy53R
        fFuvt2V8+wSTuCvXeFh8/ztPtPzZlOw=; b=wucJqaKzDq9Gn5xuZ0U1YYN8DRup
        RUuWJoxPhCQMBdX/mjLuTsl7je0Jmy+GwVMrWSU4KSpmf1xGZMHgu4vwsIXxSpvs
        3HxktJR7YCrmm5ypCziiMWj4c6TDR8cVwTYkWi0SN5hixGHYpL7QMoGx6vRFajoz
        EnU0Yt1626IMEN8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A898F9565;
        Mon, 25 Oct 2021 17:26:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C61FAF9564;
        Mon, 25 Oct 2021 17:26:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 01/10] command-list.txt: sort with "LC_ALL=C sort"
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
        <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
        <patch-v2-01.10-96885282988-20211022T193027Z-avarab@gmail.com>
        <xmqqfssp0xge.fsf@gitster.g>
        <211025.861r483ij9.gmgdl@evledraar.gmail.com>
Date:   Mon, 25 Oct 2021 14:26:13 -0700
In-Reply-To: <211025.861r483ij9.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 25 Oct 2021 23:22:09 +0200")
Message-ID: <xmqqv91kzthm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2EF0EAFC-35DA-11EC-9BC0-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Also, I am not sure where that "led to believe" comes from---do we
>> have a test that checks the output from generate-cmdlist somehow?
>
> We end up unsorting the categories we bitwise-OR together. I.e. the
> CAT_* on a line like this:
>
>         { "git-whatchanged", N_("Show logs with difference each commit =
introduces"), 0 | CAT_ancillaryinterrogators | CAT_complete },
>
> But we'll still sort the actual command list, and spew it out as-is in
> some places "git" and "help" output. So having it be unsorted or
> shuffled wouldn't be nice.

The last paragraph would be a good replacement sentence for the part
of the proposed log message that made me ask the question, I would
think.

Thanks.
