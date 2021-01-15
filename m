Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D83C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 19:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D52CD23A56
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 19:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbhAOT6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:58:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61795 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbhAOT6t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 14:58:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E327BB7370;
        Fri, 15 Jan 2021 14:58:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fd5IENWWrGrj4C9C75KrY6ywYnk=; b=w4XIZS
        e6rC7GZHtOvFTkB0JzbqV1/5qtczZYS5eCrAs1O7RvyO8KfxJZPzKxiDhGoyZsSX
        DCMMI9lHtkOlguEBbpmhuLYQv5UBDPMScxXyEUnzWwuDCg2SBtFyCk+7SubYhnHu
        LI1X946tG804Vsr4SCmsV6cKhiQI6Xje3NAfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RZbJIFiJzatUWvnMW75rYA3hIrELs+fE
        26Qei/DS8eX24aN8WV8XpqlbyXbOTRIJfPxxfo2sHkoYTqLPtRTtLtxpAJRhtW2+
        SYhnju6ovjRKbYPDq3rh7eZBNaLRqeN0cIaeYqjUTHDZJ9LebfbgiB1fH13K1Vq/
        AQF4uujBfzM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4722B736F;
        Fri, 15 Jan 2021 14:58:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4EA99B736D;
        Fri, 15 Jan 2021 14:58:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 09/11] GETTEXT_POISON=rot13: do compare the output in
 `test_i18ncmp`
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
        <4669ccbb1ae40f0c58a2d8e3c8b3a34d82176c7a.1610441263.git.gitgitgadget@gmail.com>
        <xmqqeeiq3pkf.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2101151643410.52@tvgsbejvaqbjf.bet>
Date:   Fri, 15 Jan 2021 11:58:02 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2101151643410.52@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 15 Jan 2021 16:44:18 +0100 (CET)")
Message-ID: <xmqqlfcurn05.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FAB4D19C-576B-11EB-BD4E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 12 Jan 2021, Junio C Hamano wrote:
>
>> > +static size_t unrot13(char *buf)
>> > +{
>> > +	char *p = buf, *q = buf;
>> > +
>> > +	while (*p) {
>> > +		const char *begin = strstr(p, "<rot13>"), *end;
>>
>> AFAIR from my reading of [02/11], the encoding side did not special
>> case the payload that has <ebg13> or </ebg13>; if we want to make it
>> reversible conversion (which is excellent improvement over the
>> current "# GETTEXT_POISON #" obfuscation), we'd need to do something
>> about it, I think.
>
> Do you expect any message to be translated _twice_?

Not at all.

But what I had in mind, when I wrote the above, was that the
programmers are entitled to expect that they are allowed to say:

	die(_("message with <ebg13/>, <ebg13> and <rot13> in it"));

This will be rot13'd, and the entire thing will be enclosed inside
"<rot13>...</rot13>"; I would expect that somewhere inside "..." the
receiving end that attempts to parse it by relying on these markers
will be confused.

>> But on second thought, nobody can prevent a caller to die(_("%s", msg));
>> to have "<rot13>" in the msg part, so perhaps punting like this
>> series does is sufficient.  I dunno.

And this comment still stands.
