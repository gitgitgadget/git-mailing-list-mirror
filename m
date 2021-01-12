Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B85C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 19:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E60207A3
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 19:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392184AbhALTiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 14:38:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50723 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbhALTiW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 14:38:22 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 920E0AAB7D;
        Tue, 12 Jan 2021 14:37:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bQNZZC/sziQqrJ+pXO8bKYvBY+U=; b=WNvpDe
        2Hicljz/I/YkVelV4cwF2hIn3WVBztroB3xWmwNkV25Pcu/Fh7vZ07YDCk/tnQqL
        MBnTc7RQQLJkGIRi+cWbZ15g0fEzzS18qJFcjNQdW8W/tYK03csQN2ZgHDkwL2sz
        EviL5gOb1vpn7DxLm4D9796bOY0sTnkaPcqgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Bv7Xk3K7amNQV2eVM5/T5Vl/K+MGBsQ3
        vaVPs4XMzNsnvEtzWlW5BFHRJVwbHSM6vOU1HvH9MbTkAZY5MQCET3wLWRZYKOBF
        wdmgh9Rnb/MIRwIzjAuVuzXEuXOarhSaxdBBsZcHqvmCSUwL4mU2CTkzImmmAg3R
        Ilcze6n6nmA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 87661AAB7C;
        Tue, 12 Jan 2021 14:37:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 02223AAB7B;
        Tue, 12 Jan 2021 14:37:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 02/11] Support GIT_TEST_GETTEXT_POISON=rot13
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
        <ab7832fc7ac783bc8f8c10014fc9747128fc37bc.1610441263.git.gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 11:37:37 -0800
In-Reply-To: <ab7832fc7ac783bc8f8c10014fc9747128fc37bc.1610441263.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 12 Jan 2021
        08:47:33 +0000")
Message-ID: <xmqqmtxe3q0u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A07B54AE-550D-11EB-99EA-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +const char *gettext_maybe_rot13(const char *msgid)
> +{
> +...
> +	while (*msgid) {
> +		const char *p = strchrnul(msgid, '%'), *spec;
> +
> +		while (*p && p[1] == '%')
> +			p = strchrnul(p + 2, '%');

We are at '%', and while the next is '%' (i.e. a literal '%' is
asked), we skip these two bytes and then we go back to the
equivalent of the initialization of 'p'.  Effects?  We leave the
loop when we are at the end of the string, or at '%' that is not
followed by a '%'.

It would have been easier to understand what is going on in the loop
if there weren't duplicated strchrnul() call, perhaps

	const char *p = msgid;
	while (*(p = strchrnul(p, '%')) == '%' && p[1] == '%')
        	p += 2;

That reads "find '%' and if the next char is also '%', skip these
two and redo the loop", which would be equivalent.  And it would be
much easier to follow the logic.

> +		if (p != msgid) {

And if 'p' is different (actually we know p is the same as, or
always ahead of, msgid, so "if (msgid < p)" would be easier to
follow for readers) ...

> +			strbuf_addstr(buf, "<rot13>");
> +			while (p != msgid)

Ditto.

> +				strbuf_addch(buf, do_rot13(*(msgid++)));
> +			strbuf_addstr(buf, "</rot13>");

... we add a section of obfuscated output enclosed with an xml
looking marker.

> +		}
> +
> +		if (!*p)
> +			break;

And if we are at the end, we are done.

> +		spec = strpbrk(p + 1, "diouxXeEfFgGaAcsCSpnm%");
> +		if (!spec)
> +			BUG("Unrecognized format string: %s", p);

It is a bit surprising that things like "%.*d" and "%.7f" do not
appear in our translatable strings (or perhaps this is one of the
places why the series is marked RFH and is not complete?).

> +		strbuf_add(buf, p, spec + 1 - p);
> +		msgid = spec + 1;
> +	}
> +
> +	return buf->buf;
> +}

Anyway, thanks for a fun reading.

