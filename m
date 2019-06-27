Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1DA1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 17:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfF0RTS (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 13:19:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57056 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0RTS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 13:19:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8FB9F69C2A;
        Thu, 27 Jun 2019 13:19:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RlaCry+Xb54YXa1Naw8gwlFMfPI=; b=fhjZqG
        9uPsMhEiz70PhlCOZcflvN+bppD1veN0TGkowVRJ7YBnzrDhPk2IAto15k1XRKa1
        kSfhPzJchaDhXt1N0QYB5+jo4bAUaD0a603mgT+aT22d9VYXNzY6iT99VtH2Dm9e
        WjVsYONyAo6dAJOakCyKEaY3FyT9g3lN4MYIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cuQvmqbv/+WHo0ZtFbGm7FK3jyp+XO2p
        mj2AdeQuiKMS0hn2Pg4k+5UVXA4wG5MLuvSfX0ceTALNWAJyH4nK77xtz6xz0NR5
        E3bnypoaAnw8T08C5nyYZKLOZYEZux6dhRxbbIqkHC9JCUufPSKu0rfb8RjTAuDf
        TxIHFXVPs+o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8834669C29;
        Thu, 27 Jun 2019 13:19:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9B43169C24;
        Thu, 27 Jun 2019 13:19:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/3] sequencer: always allow tab after command name
References: <pull.275.git.gitgitgadget@gmail.com>
        <pull.275.v2.git.gitgitgadget@gmail.com>
        <a5bede1cf9cba89c354779e559e19d7a2fffa1eb.1561644762.git.gitgitgadget@gmail.com>
Date:   Thu, 27 Jun 2019 10:19:11 -0700
In-Reply-To: <a5bede1cf9cba89c354779e559e19d7a2fffa1eb.1561644762.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Thu, 27 Jun 2019 07:12:44
        -0700 (PDT)")
Message-ID: <xmqqlfxnaquo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF4ABDC4-98FF-11E9-993A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The code that parses the todo list allows an unabbreviated command name
> to be followed by a space or a tab, but if the command name is
> abbreviated it only allows a space after it. Fix this inconsistency.

Makes sense.

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index f88a97fb10..919e3153f5 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2100,7 +2100,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>  		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
>  			item->command = i;
>  			break;
> -		} else if ((bol + 1 == eol || bol[1] == ' ') &&
> +		} else if ((bol + 1 == eol || bol[1] == ' ' || bol[1] == '\t') &&
>  			   *bol == todo_command_info[i].c) {
>  			bol++;
>  			item->command = i;
