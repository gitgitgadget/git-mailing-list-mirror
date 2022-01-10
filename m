Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8D4C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 17:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbiAJRjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 12:39:04 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60821 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238481AbiAJRjC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 12:39:02 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B673E1855AD;
        Mon, 10 Jan 2022 12:39:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=N9VTUdLwTf32
        KoB2rHM+NUPuihQc0SUBxxpoUWWj4RE=; b=e/UH0sjFYbCiiPHhf/kZh/DsyPTp
        uI8TK2kQmU7i4loDnkNmav7Ei6geFem2FmjnYHDRivkB8O8N/klTNAD2GOKtcMN6
        oij485CMYd9q4EkLWTdXLVMKCpQhWNcz22rtYQE1J3V95GH+uKnfbQNdekw6dH6q
        VRA+PoAaePYzs8s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF9281855AC;
        Mon, 10 Jan 2022 12:39:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 26C381855A9;
        Mon, 10 Jan 2022 12:38:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Cai <johncai86@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 1/2] name-rev: deprecate --stdin in favor of
 --annotate-stdin
References: <pull.1171.v6.git.git.1641423600.gitgitgadget@gmail.com>
        <pull.1171.v7.git.git.1641425372.gitgitgadget@gmail.com>
        <153f69ea9b6cfc3fff47c91fa237cf97efd6bfae.1641425372.git.gitgitgadget@gmail.com>
        <56FFAD1E-D081-4D13-A12E-DD6807375B69@gmail.com>
Date:   Mon, 10 Jan 2022 09:38:58 -0800
In-Reply-To: <56FFAD1E-D081-4D13-A12E-DD6807375B69@gmail.com> (John Cai's
        message of "Sat, 08 Jan 2022 08:47:30 -0500")
Message-ID: <xmqqo84j1oel.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 314384D8-723C-11EC-A044-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai <johncai86@gmail.com> writes:

> Hi Junio,
>
> ...

Please trim quotes that are irrelevant for understanding what you
want to say in your message to save recipient's time to find what
you wrote.

>> +		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text fr=
om stdin")),
>>  		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `unde=
fined` names (default)")),
>
> I=E2=80=99ve changed this back to a non hidden bool. I believe this sho=
uld be the last thing needed on this one.
> Let me know if anything else needs adjustment, thanks!

As I said, my mention of hidden vs non-hidden was not my preferrence
of non-hidden over hidden, but was soliciting opinions from others,
so I was a bit surprised to see a reroll to change only that thing
and nothing else so soon.

But if it is your preference to leave it unhidden for now, that is
fine as well.  I have no strong preference over the matter either
way.

I see only Dscho on the CC list, but I have this feeling that he
wasn't the one who suggested to hide the old option.  Whoever it
was, if we can get an ack from them, that would be nicer.

Thanks for working on this.
