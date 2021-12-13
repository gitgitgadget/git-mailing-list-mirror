Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290EAC433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 22:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243517AbhLMWNS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 17:13:18 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61588 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240321AbhLMWNS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 17:13:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0C7D15E6A2;
        Mon, 13 Dec 2021 17:13:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qPcWw+WalqoH
        gB1VGADaIjJc4tkv2n2YHHhObCsv43g=; b=mN8NGnO08Cxeu6jaSx2MPqMP4mDt
        dKqD5+zeOJ4cwWAyetBmpkyorFaV7IS/PGQ9bZOcvmpn1jxSKA1R+aLN3H+42r6C
        GQARNivpsujdJoNgei2N1Ny/tWbygGfqC4gxS2XVautrVXME0jPGtClFn/SKAARC
        UyfWrY9erndqDyA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D92FF15E6A1;
        Mon, 13 Dec 2021 17:13:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4330C15E69F;
        Mon, 13 Dec 2021 17:13:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 08/11] reftable: order unittests by complexity
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
        <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
        <9dce18d7349fe2a27859c224068fb5a386f263f1.1639411309.git.gitgitgadget@gmail.com>
        <211213.86h7bc8o9i.gmgdl@evledraar.gmail.com>
Date:   Mon, 13 Dec 2021 14:13:12 -0800
In-Reply-To: <211213.86h7bc8o9i.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 13 Dec 2021 17:25:23 +0100")
Message-ID: <xmqqv8zs9mrr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DDB5FC64-5C61-11EC-AFF8-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>  int cmd__reftable(int argc, const char **argv)
>>  {
>> +	// test from simple to complex.
>
> A C99 comment, which I don't mind, but is explicitly forbidden by the
> style guide (and when I mentioned recently that we didn't have any
> portability reasons not to use these, there wasn't much/any interest in
> changing that...).

Unlike the decl-after-statement thing, I personally do not mind
something that does not upset compilers and does not hurt human
readability greatly, like the use of "//".  But I do not care about
it deeply enough to find it worth my time to raise it as a separate
topic and update the guideline.

