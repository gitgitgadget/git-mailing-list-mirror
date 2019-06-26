Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531281F461
	for <e@80x24.org>; Wed, 26 Jun 2019 17:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfFZR6m (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 13:58:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54516 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZR6m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 13:58:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 84D39620EB;
        Wed, 26 Jun 2019 13:58:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zLz8N3eo6l8q32FD/zxFj9Y+GMY=; b=S0Vdkp
        /TXzmJv7/Mpy9f6OClxywZe0mpssETqBqZmkOIinPlZPOaSUxfQN7IdBCfHt+uug
        oU6TDfwop/UL9Ln1ofn4v9hxQBj1L5bCV5O2aoZYHm5ts8AhIb1tALEsgNAWBAqV
        ophgsU27NiRFTSLLUgtaPWh0IkZD/qeOXPbwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pTyRV5sPMgI00OxaP59PynlIHkNa4KcZ
        +qiiqRCXTLj+2WISrywRbkPlMlxioHTjSJP0qn+HXEC2oAk25wOF+fIXGhhOsD/W
        ltPnzdD6URlKd3u7yCwbjlFqLjGcyVbwgNbEER0+MYR2V/+r4XlclYO7Li0hW+AE
        JAuoyNANb0o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7CEF4620EA;
        Wed, 26 Jun 2019 13:58:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9B1FF620E6;
        Wed, 26 Jun 2019 13:58:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dimitriy <dimitriy.ryazantcev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5] l10n: localizable upload progress messages
References: <20190625062540.88973-2-dimitriy.ryazantcev@gmail.com>
        <xmqqzhm5e8p9.fsf@gitster-ct.c.googlers.com>
        <CAPUT4mR7B1nS8x=S0UW6PQmw0XjjxvJ8nxsXz2n77fodBPaurw@mail.gmail.com>
Date:   Wed, 26 Jun 2019 10:58:35 -0700
In-Reply-To: <CAPUT4mR7B1nS8x=S0UW6PQmw0XjjxvJ8nxsXz2n77fodBPaurw@mail.gmail.com>
        (Dimitriy's message of "Wed, 26 Jun 2019 11:59:06 +0300")
Message-ID: <xmqq1rzgdy9g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05EEE4F8-983C-11E9-8379-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dimitriy <dimitriy.ryazantcev@gmail.com> writes:

> Seems it can extract plural forms only from Q_ (ngettext() call) and
> cannot from _N (gettext_noop() call) in current configuration[0].
> Maybe in this case we can try to forward already translated string
> to strbuf_humanise():
>
> static void strbuf_humanise(struct strbuf *buf, off_t bytes, struct
> human_format *fmt)
> {
> ....
>         } else {
>                 strbuf_addf(buf, fmt->byte, (unsigned)bytes);
> ....
> }
>
> void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
> {
>         struct human_format bytes_fmt = {
>                 .giga = _("%u.%2.2u GiB"),
>                 .mega = _("%u.%2.2u MiB"),
>                 .kilo = _("%u.%2.2u KiB"),
>                 .byte = Q_("%u byte", "%u bytes", (unsigned)bytes),
>         };
>         strbuf_humanise(buf, bytes, &bytes_fmt);
> }
>
> What do you think?

Well, I was trying to avoid making Q_() call when we did not have
to, but if we are running with gettext, we cannot avoid calling Q_()
every time this helper is called, as .byte field has to depend on
the value of bytes, so...


