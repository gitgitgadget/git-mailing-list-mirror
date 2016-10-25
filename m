Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5932B2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 22:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754074AbcJYW4S (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 18:56:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52228 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753904AbcJYW4R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 18:56:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E17D4AE02;
        Tue, 25 Oct 2016 18:56:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YVkh1NiB/6jqUgyExrhNhvqz9l0=; b=B9JPGi
        qxVKt+6yxx1LG93Dq/VFU/qL7K6NbYXzNmDAaWevb2bcCVqhg2WCX6zMID4rPXH/
        xGTNbX/kW8Uess/bxFe4CfszJsOdrw6+fPm67/3QAkLLpBvy5s5HjbJtMrAQQpQT
        aXMgqRd4qik52zj+9qEH9EZdjrdOrKaxJTpF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VPkkhKlX2N351I/QJXPrPZaU0iniJKjB
        5y6z/9t5KI0sa9zjORpsNPErvIsFOiadGvSRwP3+ADfL8jdO4aeeScfMlCzemJL5
        ZYHcIgsA3mvSXxHWm/jaBM9xY6tfKzq8yDAN5AkcOZAHgKzNILd3KjDDshz+DoBj
        5h7OfqpMa6s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 130794AE01;
        Tue, 25 Oct 2016 18:56:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85ABE4AE00;
        Tue, 25 Oct 2016 18:56:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 0/3] quick reroll of Lars's git_open() w/ O_CLOEXEC
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
        <20161025181621.4201-1-gitster@pobox.com>
        <A6C42931-835D-42FD-B4D9-7F84921909E2@gmail.com>
Date:   Tue, 25 Oct 2016 15:56:13 -0700
In-Reply-To: <A6C42931-835D-42FD-B4D9-7F84921909E2@gmail.com> (Lars
        Schneider's message of "Tue, 25 Oct 2016 23:48:42 +0200")
Message-ID: <xmqqh980m41e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BC512CC-9B06-11E6-9831-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> heavy CPU/network task in the background now (I can't/don't want to
> stop that ATM).
>
> Here is the relevant part of the log:
>
> ++ rm -f rot13-filter.log
> ++ git checkout --quiet --no-progress .
> + test_eval_ret_=255
> + want_trace
> + test t = t
> + test t = t
> + set +x
> error: last command exited with $?=255
>
> Looks like Git exists with 255. Any idea why that might happen?

Other than "the --quiet above may be hiding it?", I do not
immediately have a useful guess, sorry.

> @Dscho/Johannes: Can you try this on your Windows machines?
>
> Thanks,
> Lars
