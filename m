Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FB251F404
	for <e@80x24.org>; Tue, 30 Jan 2018 22:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753666AbeA3W6s (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 17:58:48 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:38411 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753473AbeA3W6r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 17:58:47 -0500
Received: by mail-yw0-f196.google.com with SMTP id m84so6081536ywd.5
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 14:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MkxngYjHh45ZPId4WtLNS5UCxGKjclLxQP0f7wA7C48=;
        b=cKSNNuLadhD942mHxH7SH12QGmTpIMVKQ+4kseqm2u2PEZUeNz4/BPLNNsYCxbREWk
         x40izWA5jCwJNHKoW+gUqhO1nSeQ+UBIco3iVYTQjhxB1x2YNRLE5c4mv8BLZG8kGcU8
         HyfGxIoqP5uVCMIlMV6Is4PAmmF27nhwWoqdpb6/uiwKhCvfYpDoav8f8ayDvzS5qUta
         wtrxiSWE0ZrH0BNYdnIMwftcyVE+dHkd/MMRF7u7iSw5YN0TjePMDtA7T+zHzPxcReyp
         S2SyhTfSURZAxie12X4bNLvD1BzJgQWu0cLjp7lRDuDbXAJnMSENj4Jsa0HyKTyvNNts
         Gc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MkxngYjHh45ZPId4WtLNS5UCxGKjclLxQP0f7wA7C48=;
        b=kB0l92jSEVocfcvN84XiPAvZ9+gmcZ8dPXefnRGTj0ZnFeA6zWF0cVQdDicFr2yxdO
         bGai0wYdFL+afPaWSVm57m8oMWeTXt6cuXhhYHbls5xVxl91gX9Kdo+hki07j5aQb2BT
         W1voBVRaPvNNJ8mAhUZYGnmqGCHUmd1hxyY168m2K8tw8IgNHGJdY5WSv81VCklmAa/m
         MOnkuLRxqFtdL3a4IHBOhkRMHGFsGGe+SQNzXkIxZbEXZ6WJwCvwViIi39P7cuXX49G4
         kMVbskSTceGH2QQsI8H95ARNcxtHof9XHyPXJ48r/iU9lvTiUh/7XdeEB38yv0VQMJW4
         Suqw==
X-Gm-Message-State: AKwxytdlQtqUpvax5eKANiFSrcmRO+vySGPIyrV1NgJpCiPTXgapJTlk
        qE1CruhLI3MCa13BlipO4HokS8AHWE5LSEqX4Uq4ag==
X-Google-Smtp-Source: AH8x227Hle0LDhSEeB5bH6StqnTPmGDDACPn4JdDC5KwqviUQW7V8CCd8iNTx7SUy7F992UOkmWQRl0MdiRFgVNoTMA=
X-Received: by 10.129.119.131 with SMTP id s125mr20120767ywc.166.1517353126775;
 Tue, 30 Jan 2018 14:58:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 30 Jan 2018 14:58:46 -0800 (PST)
In-Reply-To: <20180129223728.30569-38-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180129223728.30569-38-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 Jan 2018 14:58:46 -0800
Message-ID: <CAGZ79kYwOc3vMsj8DWyNtudM-OBzyw8iTEfKK3nnOJM23GF78A@mail.gmail.com>
Subject: Re: [PATCH 37/37] replace: rename 'new' variables
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 29, 2018 at 2:37 PM, Brandon Williams <bmwill@google.com> wrote:
> Rename C++ keyword in order to bring the codebase closer to being able
> to be compiled with a C++ compiler.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/replace.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 42cf4f62a..e48835b54 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -284,7 +284,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
>  {
>         char *tmpfile = git_pathdup("REPLACE_EDITOBJ");
>         enum object_type type;
> -       struct object_id old, new, prev;
> +       struct object_id old, new_oid, prev;

new is a keyword that often comes with a counterpart, here `old`.
So while at it, also rename old to old_oid ?
Do we care about the symmetry enough to warrant additional churn for this?

Stefan
