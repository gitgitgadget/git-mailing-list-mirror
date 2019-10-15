Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D1CB1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 02:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfJOCQl (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 22:16:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50856 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfJOCQl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 22:16:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB8522924B;
        Mon, 14 Oct 2019 22:16:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EScdM5QGDnAqFu0m++S6Ps9I9IQ=; b=YMxI+N
        BaL8BAmZD4K7R21F3oAegHMTiXCMgt0Zm3Qs9DmJBfg7DaXftKl/JoEVBPfxheMW
        nOI2Z1w3770yV298O/hFb+ICbZGue2C/KrbW/+e4iF3K3aeBEvj6GniioQIFwfHO
        4WYg7sB5udUzEqLedsYFGGVDEfD+pPK/OlBoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hws6+4uhZRLIMUlKcEfweTEH1az2k5wx
        5I+0NbyVE1BNe8yyLzcO+JqA48G9/OrLWH7rEnHflFFUCwZ7DVd4RhZ6IS62M5F9
        JmTN4bynDo+jfih9MJfJLE7CC7Q7OOVppG691zWsXrt94EaemOeMQp/BsRywPXzp
        MA8yiig51G0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A27E62924A;
        Mon, 14 Oct 2019 22:16:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4F7929246;
        Mon, 14 Oct 2019 22:16:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v5 1/3] format-patch: change erroneous and condition
References: <cover.1570821015.git.liu.denton@gmail.com>
        <cover.1571085952.git.liu.denton@gmail.com>
        <56fb230ad271dc9aa91c0f43ac8e4e7085c15775.1571085952.git.liu.denton@gmail.com>
Date:   Tue, 15 Oct 2019 11:16:35 +0900
In-Reply-To: <56fb230ad271dc9aa91c0f43ac8e4e7085c15775.1571085952.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 14 Oct 2019 13:46:59 -0700")
Message-ID: <xmqqeezeda7w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0D34E3C-EEF1-11E9-AB6C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> .... Since this
> seems to be a Python-ism that's mistakenly leaked into our code, convert

The conclusion is OK, but as the inventor of format-patch and a
non-pythonista, I do not think the above claim is correct, and even
if Thomas thought it was a good idea to follow Python style in
30984ed2 ("format-patch: support deep threading", 2009-02-19), which
I doubt he did, I do not think there is much point in speculating.

Both the log message and the patch text in the previous round were
better than this round, I would have to say.

Thanks.



> diff --git a/builtin/log.c b/builtin/log.c
> index 44b10b3415..351f4ffcfd 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -835,7 +835,7 @@ static int git_format_config(const char *var, const char *value, void *cb)
>  			thread = THREAD_SHALLOW;
>  			return 0;
>  		}
> -		thread = git_config_bool(var, value) && THREAD_SHALLOW;
> +		thread = git_config_bool(var, value) ? THREAD_SHALLOW : THREAD_UNSET;
>  		return 0;
>  	}
>  	if (!strcmp(var, "format.signoff")) {
