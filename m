Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3F721F859
	for <e@80x24.org>; Fri, 19 Aug 2016 18:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755470AbcHSS1d (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 14:27:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62808 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752088AbcHSS1c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 14:27:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5C8F34797;
        Fri, 19 Aug 2016 14:27:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZB2F9EhkepSaRUK6X9VqaQKq0cs=; b=knj9vc
        qWZelLYjme1vijVLDSvzzYK/6ZIYo7z+RgT1ETB2yOhgIKO7l+I1I3E+zZtQogzw
        iifHHcwtDITfsGDj7HxGoGMOTSwzz+Gme3m9mfM957Z5i6NpIZLVopRRLe+JtfNv
        5kcaSCAAq0WfVgxG62VF9BvAG2C5Z8l/425vo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OpDXxh6xIQ+L3DCXfHWTpxQUbHFWWh6y
        6W8O7IGZFG17LZRhDWfbpo0gwtGzdckgMb+MYVk3qPRsyl3fN3OyJfj7MSsjsGDR
        s9lIT6FDYdbD+BAYOz7+eGzt1v6GD8C0BsrCTWIMHv4w4EJmqwZf81HZz6+qi5PQ
        4r55XM8DxeA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBC8D34796;
        Fri, 19 Aug 2016 14:27:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 555CB34795;
        Fri, 19 Aug 2016 14:27:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brian Henderson <henderson.bj@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, e@80x24.org
Subject: Re: [PATCH v3 3/3] diff-highlight: add support for --graph output.
References: <20160819170812.1676-1-henderson.bj@gmail.com>
        <20160819145123.73hf7ffysy53l3kz@sigill.intra.peff.net>
        <20160819170812.1676-4-henderson.bj@gmail.com>
Date:   Fri, 19 Aug 2016 11:27:28 -0700
In-Reply-To: <20160819170812.1676-4-henderson.bj@gmail.com> (Brian Henderson's
        message of "Fri, 19 Aug 2016 10:08:12 -0700")
Message-ID: <xmqq8tvs397z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96B0315E-663A-11E6-89ED-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brian Henderson <henderson.bj@gmail.com> writes:

> diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
> index 3b3c831..b88174e 100755
> --- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
> +++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
> @@ -185,7 +185,7 @@ test_expect_failure 'diff-highlight highlights mismatched hunk size' '
>  
>  # TODO add multi-byte test
>  
> -test_expect_failure 'diff-highlight works with the --graph option' '
> +test_expect_success 'diff-highlight works with the --graph option' '
>  	dh_test_setup_history \
>  		"aaa\nbbb\nccc\n" \
>  		"aaa\n0bb\nccc\n" \

Yup, the standard "describe what we want and document a bug to be
fixed with _failure, and flip it to _success when you fix the bug"
pattern makes it very easy to understand what is going on.

