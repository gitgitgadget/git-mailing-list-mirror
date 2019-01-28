Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM,URIBL_RED shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2F8C1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 21:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfA1VdQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 16:33:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41539 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfA1VdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 16:33:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so19748872wrs.8
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 13:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZrgkgBvszGsBhQdTo13vIrGLyI8vrmRuCn/iUQg18TE=;
        b=IDHjCAaO6WnovuLeKXK/FXMsUroYLKs8fNYJo67wLXO2lYZ7oCUwn3n5Gn7/2B91TD
         rxwloQtw1TbucfN4pZiJmSTh5UywuYrxipM6pKYyNfyhVLbDYjmh9D5eItkkUAaSzY8V
         cI+jQrPw9QYSuUC+CqVX/59wcFgpizCQQtMQloA9asUc+w1yyJdyO7AgjHYC3Ipg4/JP
         Eb5G8lmoolmfASzStQ5JnTJCyiKy/mdgNNg/3tQjHbGko0gubwXBNoOqCy6Wh+ca5k9U
         8zhQosnM+2Xfn1vm04CC4D25CP7C/semJS+ZiLBt/3I7qwR7Y5gFFqAtovmyuKkhNHo3
         6Uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZrgkgBvszGsBhQdTo13vIrGLyI8vrmRuCn/iUQg18TE=;
        b=hh4FERbC4LLwE0EVXkn0EBuGbmINWBIng1xC9gsYPFQ2snUlzwIy1iPwSqRNAPfA9F
         CE0CKVASimbVa6DpNLpC9xlHuXoZpfYwtD52TLlvRD+Lu7qzcskrqdudUxoEI837Fc8n
         dBWCQU+s6uPqREi26wUku6BpmwjC99hxEZjvjZPSL9m+wRBY684MNNKRUNHzzRK9wKIy
         +dbKrIQEbGpx0HqmIWJk/Omm9UbuZTbIAUqxOtdM6CYcZtbhpwtrjjm5ycr3SVyrp9la
         Dz3gDl54XzcE2RzQB7zwjf8EuOrttvDUZiZDeO7nSrgoYjAtWHisY8q8+JNwPt16Jd1Y
         RWaQ==
X-Gm-Message-State: AJcUukebj5hy3HyZbmPGvzSnL9lMepHge5P6fZT7kNJv2sYspKfZSxIZ
        QZVI5AWPDJ7LpqGCh1teE2k=
X-Google-Smtp-Source: ALg8bN4DPvbS2Bo2znHDTFzr34di83P+b7BYmCliXoMIzaotWuYPccErrp9qyEqLIaju197x3Ya6gA==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr22393889wrn.157.1548711194174;
        Mon, 28 Jan 2019 13:33:14 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c1sm647563wmb.14.2019.01.28.13.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 13:33:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     William Hubbs <williamh@gentoo.org>, git@vger.kernel.org,
        chutzpah@gentoo.org
Subject: Re: [PATCH v2 1/2] config: allow giving separate author and committer idents
References: <20190125215955.30032-1-williamh@gentoo.org>
        <20190125215955.30032-2-williamh@gentoo.org>
        <877ees4a65.fsf@evledraar.gmail.com>
        <20190128185817.GA28155@whubbs1.gaikai.biz>
        <871s4w4khs.fsf@evledraar.gmail.com>
Date:   Mon, 28 Jan 2019 13:33:12 -0800
In-Reply-To: <871s4w4khs.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 28 Jan 2019 21:04:15 +0100")
Message-ID: <xmqqmunka2nb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I'm happy to help if you'd like. I had a thinko with "table", and I
> think our asciidoc dialect doesn't support it (maybe I'm wrong), but
> thinking about it again we could just describe these variables all in
> the same documentation. As in this hunk (which you could squash in):
>
> BEGIN QUOTE
> diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
> index 18e1ec3c1b..ad3c43cf47 100644
> --- a/Documentation/config/user.txt
> +++ b/Documentation/config/user.txt
> @@ -1,39 +1,20 @@
> +user.name::
> +user.email::
>  author.name::
> +author.email::
>  committer.name::
> +committer.email::
> +	The `user.name` and `user.email` variables determine what ends
> +	up in the `author` and `committer` field of commit
> +	objects. These config variables will be overridden by
> +	`GIT_COMMITTER_NAME` and `GIT_COMMITTER_EMAIL`,

You forgot to list two more obvious ones here.

> ++
> +Most users should have no reason to set the `author.*` and
> +`committer.*` variables, but can do so to e.g. set different a
> +different E-Mail for the `committer` field. Like the `user.name` and
> +`user.email` variables, these can be overridden in the environment
> +with `GIT_AUTHOR_NAME`, `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME` and
> +`GIT_COMMITTER_EMAIL`.

I do not see a strong reason to say "most users should have no
reason", especially without arguing why (and I do not think this is
a place to make such an argument, either).

    The `user.*` variables can be used to set both author and committer
    names and e-mail addresses to the same value; users who want to set
    the committer and author identities differently can use the
    `author.*` and `committer.*` variables.

or something along that line, perhaps?

