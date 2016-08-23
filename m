Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FF2E1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 18:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754733AbcHWSJw (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 14:09:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53357 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754241AbcHWSJv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 14:09:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2839036979;
        Tue, 23 Aug 2016 14:02:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=98LWbIB9yWlhFicVmUn0iH+ROfQ=; b=rLge7e
        xXrgQCYPCR+wVdniXPkZhTtDllaP0l0MGDBMyYdhswku77VcIkPL0Ma2ux+vv6RT
        +9/wCfbJVW3VAT3eiE2qI/M5rbHgjP/jsBV7avZjnqI89MxzZQc7SnWtR2yh2k+t
        y0gFeOtsW8wp4TZRtK09CwF8ZqMyhHL3rieNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UsJPItF+J/2OPdkyvB2+AtAQVGQHWWfK
        byAevWUdl0/Mjhw8NA68IF3/Maa+F+SxG+8h801abr+1W8qyaRW9Nt3h+FxMm/lS
        HGyI/Aq6fVGdfAZdHLmLZxb1sLZ5yLBsBIJZTAe2PRPMQSUObzJxDCN+mcpoje2I
        bqNXUmzqC2I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F29B36978;
        Tue, 23 Aug 2016 14:02:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8BCE736976;
        Tue, 23 Aug 2016 14:02:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Glasser <glasser@davidglasser.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: mention `git -c` in git-config(1)
References: <CAN7QDo+S21T=1zjBEM7rq3epzvVx7GhmTZ5+sgV0BPvNYhvvUg@mail.gmail.com>
Date:   Tue, 23 Aug 2016 11:02:53 -0700
In-Reply-To: <CAN7QDo+S21T=1zjBEM7rq3epzvVx7GhmTZ5+sgV0BPvNYhvvUg@mail.gmail.com>
        (David Glasser's message of "Tue, 23 Aug 2016 10:33:21 -0700")
Message-ID: <xmqqd1kzwegi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D14DEC2E-695B-11E6-B60D-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Glasser <glasser@davidglasser.net> writes:

> Signed-off-by: David Glasser <glasser@davidglasser.net>
> ---
>  Documentation/git-config.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index f163113..83f86b9 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -263,6 +263,9 @@ The files are read in the order given above, with
> last value found taking

No need to resend but the above context line somehow got line-wrapped.

>  precedence over values read earlier.  When multiple values are taken then all
>  values of a key from all files will be used.
>
> +You may override individual configuration parameters when running any git
> +command by using the `-c` option. See linkgit:git[1] for details.
> +

This is not a new (as linkgit:git[1] also has it) but "override" is
a white lie, and may invite nitpickers.  The -c var=val given from
the "git" command line is merely tacked at the end of the search
order, so it would "override" when the variable is used as a
single-valued variable, but when it is used as multi-valued one, it
does not.

That might be something we want to fix up further in later patches;
the change we see in this patch is good regardless.

Thanks.

>  All writing options will per default write to the repository specific
>  configuration file. Note that this also affects options like `--replace-all`
>  and `--unset`. *'git config' will only ever change one file at a time*.
