Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9340F1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 18:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeAWSWw (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 13:22:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56220 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbeAWSWv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 13:22:51 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A797C577B;
        Tue, 23 Jan 2018 13:22:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ev02T6JaHmRRco426PV++lE5jwo=; b=AIL1rN
        6TMUUkx9SCEBEJiTbQ6hfS4NQLspjv8gpE4bRGlqQBoF7V9LDtOsyXtqS7WbOBgv
        7f4GsB6TvZG1Sz/fpEw+9nLJu4d5gVcQzjNCamiHI7twC78zjcLCy8EogD4acG6T
        mM1Lktz8z6aT3aGiQNm8uc1xzBmqNa7r7todQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hb+1nV5+V76p9Xz/QJvtcJ/wwTde5Zf3
        CZfztemzdRL0qVkyWIDa0WXptXrL3Q44wi+g+T7SVYxau8jm8ZFe8XnXgWo60cce
        d3InO4P07CeZcVk0XD2wW+XyUXNjaDhB3G5V07iHl3iU3FwSxmGew2YzNbwjO/P1
        9jw63SVEHyI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 21C3BC577A;
        Tue, 23 Jan 2018 13:22:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E5CDC5777;
        Tue, 23 Jan 2018 13:22:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] sequencer: mark a file local symbol as static
References: <43b60294-0e8f-0f6e-1b9a-8a2779777513@ramsayjones.plus.com>
Date:   Tue, 23 Jan 2018 10:22:49 -0800
In-Reply-To: <43b60294-0e8f-0f6e-1b9a-8a2779777513@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 22 Jan 2018 00:30:51 +0000")
Message-ID: <xmqqlggoigee.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B914DCA-006A-11E8-B744-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Phillip,
>
> If you need to re-roll your 'pw/sequencer-in-process-commit' branch, could
> you please squash this into the relevant patch (commit da96adcf5a,
> "sequencer: run 'prepare-commit-msg' hook", 2018-01-19).
>
> Thanks.

Thanks; as the commit is sitting at the tip of the topic not yet in 'next',
let me just squash it in.

>
> ATB,
> Ramsay Jones
>
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 79579ba11..5bfdc4044 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -893,7 +893,7 @@ void commit_post_rewrite(const struct commit *old_head,
>  	run_rewrite_hook(&old_head->object.oid, new_head);
>  }
>  
> -int run_prepare_commit_msg_hook(struct strbuf *msg, const char *commit)
> +static int run_prepare_commit_msg_hook(struct strbuf *msg, const char *commit)
>  {
>  	struct argv_array hook_env = ARGV_ARRAY_INIT;
>  	int ret;
