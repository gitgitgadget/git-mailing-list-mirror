Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 629D220756
	for <e@80x24.org>; Tue, 10 Jan 2017 22:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756259AbdAJW7w (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 17:59:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65475 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751894AbdAJW7v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 17:59:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 782E85EC0D;
        Tue, 10 Jan 2017 17:59:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EnBPOIu8AEdLMQpL4qsVn67hRO0=; b=twp6jP
        ettvDYIWxHRGJyr/A3uXLSyNntD8K0JxfPc+mf0Z2beD+OoG9AtPCEJvR8x7YvDE
        x7Gmh4ryHWIzcSWykpmHlEqHLssxu7H7dBuD/YGrFQLmAS06G/ZaIMYF/ixF94hK
        lLIhflpAg4GCkK3NYw+hPCCg13f+aCP0+bFek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DnRGXSmJhu/HDn4rH5OlgV3okHlhXWKo
        7siYktMNsjv2HXv+7HEYtV09wI7ybv/xNEkEiTdh6lo6n0a751fuBzeDrbfVvNA7
        LkvTtHVTC+yQ8LcfV+h6EWb77nagoEYNOBAGETV5jPsYaNlKyLDaTk5uwDvsxFwB
        nOwCH305BTk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 705D55EC0B;
        Tue, 10 Jan 2017 17:59:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A70375EC08;
        Tue, 10 Jan 2017 17:59:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?66eI64iE7JeY?= <nalla@hamal.uberspace.de>
Subject: Re: [PATCH 1/2] asciidoctor: fix user-manual to be built by `asciidoctor`
References: <cover.1483373021.git.johannes.schindelin@gmx.de>
        <3c160f81a88cf8697f2459bb7f2a3e27fb3e469c.1483373021.git.johannes.schindelin@gmx.de>
        <20170104080852.bmlmtzxhjx4qt74f@sigill.intra.peff.net>
        <1D7C66EA-E87A-4154-ACAC-8045D28477D2@gmail.com>
        <20170105164556.b3bzeqqzx4pvni4z@sigill.intra.peff.net>
        <20170107220834.uge5ksdr66asw27q@genre.crustytoothpaste.net>
Date:   Tue, 10 Jan 2017 14:59:48 -0800
In-Reply-To: <20170107220834.uge5ksdr66asw27q@genre.crustytoothpaste.net>
        (brian m. carlson's message of "Sat, 7 Jan 2017 22:08:34 +0000")
Message-ID: <xmqqmveyplln.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D365194-D788-11E6-BBB1-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> [1] I think we've also traditionally considered asciidoc to be the
>>     definitive toolchain, and people using asciidoctor are free to
>>     submit patches to make things work correctly in both places. I'm not
>>     opposed to changing that attitude, as it seems like asciidoctor is
>>     faster and more actively maintained these days. But I suspect our
>>     build chain would need some improvements. Last time I tried building
>>     with AsciiDoctor it involved a lot manual tweaking of Makefile
>>     variables. It sounds like Dscho is doing it regularly, though. It
>>     should probably work out of the box (with something like
>>     USE_ASCIIDOCTOR=Yes) if we expect people to actually rely on it.
>
> Yes, that would probably be beneficial.  I'll see if I can come up with
> some patches based on Dscho's work.

Thanks.
