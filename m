Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DF031F406
	for <e@80x24.org>; Tue, 19 Dec 2017 20:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751013AbdLSUT5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 15:19:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51936 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750737AbdLSUT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 15:19:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F943AF20D;
        Tue, 19 Dec 2017 15:19:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LciR5mkPI3felodpNhCH32aYDkk=; b=TT1qL/
        pVXB6iwWqzPJ7pn/wZGfllBochoM4c8ebgQdYOOgHEpnRPYv8JZrudIxE9nSd84X
        fbO/vEjftkUSaYjQhYTckrDvX5TYOYtJYaW31V9+BKpC4ImMCBlcMQJqAbznjyxR
        cSQuCM6UXb5QIMqeUj+zOUME8vTfzSI9Qcnh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KV3EIh9NIYu+ECr+dRgrA+pBFonKY9VO
        6xvr0GGHwh2atlZnH+ZTw4NUrIQZURMkAT7KGfzpHJaa6XXyq9EMzIBFygLOeiVY
        ZMu1HnA/BdM74M6xtdz/maRFpKFXHl6gc0qIi0o4AJpq0OKVq+N1yQKEnIcKpTtM
        RgbBqWbvuJ8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77A75AF20C;
        Tue, 19 Dec 2017 15:19:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D78EEAF20B;
        Tue, 19 Dec 2017 15:19:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 5/6] fsmonitor: Remove debugging lines from t/t7519-status-fsmonitor.sh
References: <20171219002858.22214-1-alexmv@dropbox.com>
        <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com>
        <0e1b58795c3cfe2a6a64ae8ab0f87f46e5716da4.1513642743.git.alexmv@dropbox.com>
Date:   Tue, 19 Dec 2017 12:19:53 -0800
In-Reply-To: <0e1b58795c3cfe2a6a64ae8ab0f87f46e5716da4.1513642743.git.alexmv@dropbox.com>
        (Alex Vandiver's message of "Mon, 18 Dec 2017 16:28:57 -0800")
Message-ID: <xmqqpo7av5au.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9EAAAE4-E4F9-11E7-A5DC-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Vandiver <alexmv@dropbox.com> writes:

> These were mistakenly left in when the test was introduced, in
> 1487372d3 ("fsmonitor: store fsmonitor bitmap before splitting index",
> 2017-11-09)
>
> Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
> ---
>  t/t7519-status-fsmonitor.sh | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> index eb2d13bbc..19b2a0a0f 100755
> --- a/t/t7519-status-fsmonitor.sh
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -307,9 +307,7 @@ test_expect_success 'splitting the index results in the same state' '
>  	dirty_repo &&
>  	git update-index --fsmonitor  &&
>  	git ls-files -f >expect &&
> -	test-dump-fsmonitor >&2 && echo &&
>  	git update-index --fsmonitor --split-index &&
> -	test-dump-fsmonitor >&2 && echo &&
>  	git ls-files -f >actual &&
>  	test_cmp expect actual
>  '

Hmph, by default the standard output and standard error streams are
not shown in the test output, and it would help while debugging test
failures, so I am not sure if this is a good change.  With the
previous step [4/6], we can lose the "echo", of course, and I do not
think we need >&2 redirection there, either.
