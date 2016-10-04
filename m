Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2753420986
	for <e@80x24.org>; Tue,  4 Oct 2016 16:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbcJDQrK (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 12:47:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61814 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752389AbcJDQrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 12:47:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CAE1D42577;
        Tue,  4 Oct 2016 12:47:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QJfsOmkwJpSun/Q67HawFlIr6MI=; b=C7o8NJ
        GOPxR2xCMz+RxUGBNysezKVWYkqDV6jRN2raSLucpmCaYwuAPiTozWaiazqBliD1
        bFGcr9dAS1IZH9s9tq/+oc8gOS2svSGMlOf7U3yIvRyAGYoYd37/jwbHxcjr2mH/
        /cdWaDxQC/IzN8maVVOnZeHkqQFD/XdW0exbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pwEypxsODr/zUuHggt2ZhOC/uYGFj69i
        hj+wfed3K9zDQxsU/w/5uI0O1tB1/QGbiw5LTNlYnxnfLpR+O5nH4WeKqGNMuYmP
        nz4IUJP/qsXl/xvlx6iSSB05fNEdVFJWl1+PhrQoNOlAUg3glmjGN9iOMLld1cbx
        LkXkJ3H49do=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C327942576;
        Tue,  4 Oct 2016 12:47:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1ECD942575;
        Tue,  4 Oct 2016 12:47:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6g?= =?utf-8?Q?ershausen?= 
        <tboegi@web.de>, git <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v8 00/11] Git filter protocol
References: <20160920190247.82189-1-larsxschneider@gmail.com>
        <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com>
        <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com>
        <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de>
        <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
        <1A8A9127-4DF9-44AD-9497-F8A630AB1193@gmail.com>
        <xmqq60pee6rp.fsf@gitster.mtv.corp.google.com>
        <C53500E8-7352-4AAC-9F53-40CCFA7F1418@gmail.com>
        <xmqqvax974dl.fsf@gitster.mtv.corp.google.com>
        <20161004121111.gqilov3colsgzdft@sigill.intra.peff.net>
Date:   Tue, 04 Oct 2016 09:47:05 -0700
In-Reply-To: <20161004121111.gqilov3colsgzdft@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 4 Oct 2016 08:11:11 -0400")
Message-ID: <xmqq4m4svz7a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F9AF634-8A52-11E6-BAE8-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Oct 03, 2016 at 10:02:14AM -0700, Junio C Hamano wrote:
>
>> The timeout would be good for you to give a message "filter process
>> running the script '%s' is not exiting; I am waiting for it".  The
>> user is still left with a hung Git, and can then see if that process
>> is hanging around.  If it is, then we found a buggy filter.  Or we
>> found a buggy Git.  Either needs to be fixed.  I do not think it
>> would help anybody by doing a kill(2) to sweep possible bugs under
>> the rug.
>
> I would argue that we should not even bother with such a timeout. This
> is an exceptional, buggy condition, and hanging is not at all restricted
> to this particular case. If git is hanging, then the right tools are
> "ps" or "strace" to figure out what is going on. I know that not all
> users are comfortable with those tools, but enough are in practice that
> the bugs get ironed out, without git having to carry a bunch of extra
> timing code that is essentially never exercised.

OK.
