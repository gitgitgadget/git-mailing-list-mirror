Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87E0A1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 18:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbdA0S5m (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 13:57:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59471 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750798AbdA0S45 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 13:56:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFBF06201D;
        Fri, 27 Jan 2017 13:53:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9Ok/+OtQmyEazg/GvTt/fQUHQwE=; b=mk0I8x
        EOsg8WkPN8Nscd/qjBGhXr9haQH+IUiMpNIHjQBs14EzVqFB+ppYMmFGaTqlWlfi
        3oiVQIo9Qs/tKT+23wmvG+6YIBhiO1TgVKXm+4jEtTMb9NDUlbxXAm2jpykNNptD
        HsVl7ciwOI09FrcFYjenXAaoyXp2LjFl54YXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YrNQzFtUtVPf274Ui/hd1Vs4/lHOsxCJ
        qeGp+9wwSBECAYz0bz0t/kig/99E5sHfMbaRSC/6DrRfHcdZC1/tEv2o5OmXOd/S
        E3FZTBVzL0eU+X+8e0P7nh1cHgIp+Q8mwZvxaoUaC8MTY1O6oLl4CkzKotJkWNiT
        1EqBcEzXZ6I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7F7E6201C;
        Fri, 27 Jan 2017 13:53:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 234B16201A;
        Fri, 27 Jan 2017 13:53:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Sverre Rabbelier <srabbelier@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4] t/Makefile: add a rule to re-run previously-failed tests
References: <85044791cfcba35c1ad3d8138051f3f075cb0646.1485526641.git.johannes.schindelin@gmx.de>
        <0563f07117e828c072ba542c1a57441e2e8efb81.1485537593.git.johannes.schindelin@gmx.de>
Date:   Fri, 27 Jan 2017 10:53:18 -0800
In-Reply-To: <0563f07117e828c072ba542c1a57441e2e8efb81.1485537593.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 27 Jan 2017 18:21:30 +0100
        (CET)")
Message-ID: <xmqq4m0kz65d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEFBF6CC-E4C1-11E6-844E-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This patch automates the process of determining which tests failed
> previously and re-running them.
> ...
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

I stored both versions in files and compared them, and it seems the
single word change in the proposed commit log message is the only
difference.  I would have written "Automate the process...", though.

If you are resending, touching up to cover all points raised by a
reviewer and doing nothing else, having "Reviewed-by: Jeff King
<peff@peff.net>" would have been nicer.  

Will queue.  Thanks.

> ---
> Published-As: https://github.com/dscho/git/releases/tag/failing-tests-v4
> Fetch-It-Via: git fetch https://github.com/dscho/git failing-tests-v4
>
>  t/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/t/Makefile b/t/Makefile
> index d613935f14..1bb06c36f2 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -35,6 +35,12 @@ all: $(DEFAULT_TEST_TARGET)
>  test: pre-clean $(TEST_LINT)
>  	$(MAKE) aggregate-results-and-cleanup
>  
> +failed:
> +	@failed=$$(cd '$(TEST_RESULTS_DIRECTORY_SQ)' && \
> +		grep -l '^failed [1-9]' *.counts | \
> +		sed -n 's/\.counts$$/.sh/p') && \
> +	test -z "$$failed" || $(MAKE) $$failed
> +
>  prove: pre-clean $(TEST_LINT)
>  	@echo "*** prove ***"; $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
>  	$(MAKE) clean-except-prove-cache
>
> base-commit: 4e59582ff70d299f5a88449891e78d15b4b3fabe
