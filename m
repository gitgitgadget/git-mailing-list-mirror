Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EF731F424
	for <e@80x24.org>; Wed, 25 Apr 2018 00:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750853AbeDYANc (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 20:13:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33963 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbeDYANb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 20:13:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id w2so2493370wmw.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 17:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6reiD+OdGy8B9eKnG0rwjYrxK3UY1LhByBDoehAaK68=;
        b=AxSJUq5YO0koKyNpHfhFBaKFo6RMX56pYHZ0P81vD4/E37XskDGzjyUuPln+bCH6Y5
         ARyugAgi5iqbIuHRTgYdxiVKVUyIprGXA7XK9W5mABMw1Sa75SVRCO7Gu2mOmFqyS7v8
         55r5uQBS7mWx8IZ3PIrN8UA2+8ZXmQW49UCeYmKJxrL6W1/HDFOhyErZZk5vupO1sJC+
         L2GJ5teXNlUDAVJJ2HhneDRLS2GjUtHNMAWhrS0cgqRNtw6hLov2h49EVDRuYJD4Wgny
         G6wZYR44kJFKvVY+1xrUGg6OPGWJ6re8crlklEMficGdI8rwoIuHdEcha5TFLcHL16SA
         nTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6reiD+OdGy8B9eKnG0rwjYrxK3UY1LhByBDoehAaK68=;
        b=JZ84q1g/NcGMPYpgbvsUCM0Ms0AlXrjbO+PsTk2sAWpZv/jg0RpuoUhNRBdSYHHmlc
         5t9ayjmEE8NjN9yZIh0v7xvDcIWR60kYJnbB5zIdLnBYp1wUxlHoHnj5tlNI7a6O4oe/
         lsRkQTkaiT1UxEKNfJeDXXHmJTZskkshobN5UITSI8qN3FelXS/TyY2o7S2UZAwCX36R
         UlJe5rx0ytqEGTVSyZMClI9Iru+/BASr0iIW6iOWa9q2fNxNLwQunTT9a+H+fy8kYRmM
         zsD32+zBM0zF9JQQuqgmGz1HIMWfobQ+97mi5rhao/NmNFGtecHoSehykVC80Eqeg+ud
         I1fw==
X-Gm-Message-State: ALQs6tCNCpgzJIO9q1nfFlCALy/JZd2pM3V92VPTX6uAc0ymdCfmFt+3
        DzAlf62rgMnyzabLYx2HjKk=
X-Google-Smtp-Source: AB8JxZqEMEBnvTPBhJ+CtviKTM1F6FZUP682PvwxCKSJD4QgKPK2BJcpClYSPjnsuTfsl3Qt1xyJUA==
X-Received: by 10.28.210.18 with SMTP id j18mr3306950wmg.29.1524615209588;
        Tue, 24 Apr 2018 17:13:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g7-v6sm13865930wrb.60.2018.04.24.17.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 17:13:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "newren\@gmail.com" <newren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "vmiklos\@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin\@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass\@googlemail.com" <eckhard.s.maass@googlemail.com>
Subject: Re: [PATCH v2 0/2] add additional config settings for merge
References: <20180420133632.17580-1-benpeart@microsoft.com>
        <20180424171124.12064-1-benpeart@microsoft.com>
Date:   Wed, 25 Apr 2018 09:13:28 +0900
In-Reply-To: <20180424171124.12064-1-benpeart@microsoft.com> (Ben Peart's
        message of "Tue, 24 Apr 2018 17:11:39 +0000")
Message-ID: <xmqqd0yo5ejb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

>  diff.renameLimit::
>  	The number of files to consider when performing the copy/rename
> -	detection; equivalent to the 'git diff' option `-l`.
> +	detection; equivalent to the 'git diff' option `-l`. This setting
> +	has no effect if rename detection is turned off.

You mean "turned off via diff.renames"?

This is not meant as a suggestion to rewrite this paragraph
further---but if the answer is "no", then that might be an
indication that the sentence is inviting a misunderstanding.

>  diff.renames::
>  	Whether and how Git detects renames.  If set to "false",
> diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
> index 5a9ab969db..38492bcb98 100644
> --- a/Documentation/merge-config.txt
> +++ b/Documentation/merge-config.txt
> @@ -39,7 +39,8 @@ include::fmt-merge-msg-config.txt[]
>  merge.renameLimit::
>  	The number of files to consider when performing rename detection
>  	during a merge; if not specified, defaults to the value of
> -	diff.renameLimit.
> +	diff.renameLimit. This setting has no effect if rename detection
> +	is turned off.

Ditto.  If your design is to make the merge machinery completely
ignore diff.renames and only pay attention to merge.renames [*1*],
then it probably is a good idea to be more specific here, by saying
"... is turned off via ...", though.

>  merge.renames::
>  	Whether and how Git detects renames.  If set to "false",

[Footnote]

*1* ...which I do not think is such a good idea, by the way.  I'd
personally expect merge.renames to allow overriding and falling back
to diff.renames, just like the {merge,diff}.renameLimit pair does.
