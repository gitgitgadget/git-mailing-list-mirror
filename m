Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 307D21F453
	for <e@80x24.org>; Fri, 26 Oct 2018 15:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeJ0AXF (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 20:23:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35420 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeJ0AXD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 20:23:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id e2-v6so1704549edn.2
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=EeUrDcZItkJsQRqEFlpfAk1ydp9Hv2bdLdzHqOb6NPY=;
        b=sbY/Le+N+J6Xnxtr5p/h9RnOnvqNIMnp0wUuiP1/LNi0XDAJkod6RwTp64rgOFG4Yb
         2kp1jro1o9dnJ8EuD9VEt8aKvlXcLtAumnl8GauO53oFjs0JuloqhcfdqwAk6JolIn4R
         0E158yvF+HX6WwcnmUeCjaWUoVTqle3ueFZG7+8YHl2aO+sdLrZdMRGbyOYrUv3QTwPJ
         GJnTF4AjZIlgjSRRt0XXdAa3agFeuXaVZsGE8gkhr7Sv4ettUTx58yipdpALa48oYLe3
         geN7L1RpVQd9B8xABUMUtSxVndlHsYGpupRoacbFWF++w3Dh9i8uqy+HmSWzcISeAP+R
         hhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=EeUrDcZItkJsQRqEFlpfAk1ydp9Hv2bdLdzHqOb6NPY=;
        b=Sas4G8r950jXD3CZwYX89yDeBpoErHU3moipBnhTE/CSKAQ3vobyoioGqtmIw8uL8y
         jP7zZ+pqbecuxwwkCfa+wilcqbbHhNrXqaODks3mr26GhYcv3Dy4U54GDEm39lvgZ2Di
         a3HQs16ZvIVKB6Iz7tzQIHZlIAYdMcWf9pso2kDSOkDnMFYX0LLvGS91UIpLsRHvE0eX
         vSzK4Ky6fcn8196BaLJ9lUAu+5ZpfGhrwxUhzTJemZ0DpOvnCrxzjegWoUIQQfSKV9zW
         80kf0KSbXbQtnlwx3BoLSQa/MNZabJUSUUA65E29GGjFLVMNTiepIlz6t7zcIL9eriXE
         ARog==
X-Gm-Message-State: AGRZ1gKn+1g/GuXcEFOXEf7ryiQ0AYwsBPk/Nc1R4UgU6yZ6y0ZHnYHH
        3XZFID+mrxaxrgQGLOsHNbumkdxN
X-Google-Smtp-Source: AJdET5d8Irj/SvRp5p24wAt9DDzSfOWQ63KSslTJ+dZhX9VSOkp/yO8PqjkDL1fV0daWztBddiRv2w==
X-Received: by 2002:a17:906:6054:: with SMTP id p20-v6mr2884974ejj.40.1540568729774;
        Fri, 26 Oct 2018 08:45:29 -0700 (PDT)
Received: from evledraar ([2a02:a450:3911:1:fd59:dbfe:7c38:41f0])
        by smtp.gmail.com with ESMTPSA id w57-v6sm2264760edw.88.2018.10.26.08.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 08:45:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] push: add an advice on unqualified <dst> push
References: <20181010104145.25610-1-avarab@gmail.com> <20181010104145.25610-3-avarab@gmail.com> <20181010205505.GB12949@sigill.intra.peff.net> <87r2gxebsi.fsf@evledraar.gmail.com> <xmqq5zy8f6gr.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqq5zy8f6gr.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 26 Oct 2018 17:45:27 +0200
Message-ID: <87r2gclnjc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 11 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Oct 10 2018, Jeff King wrote:
>>
>>> This is much better, and I love the customized behavior based on the
>>> object type.
>>>
>>> I wonder if we could reword the first paragraph to be a little less
>>> confusing, and spell out what we tried already. E.g., something like:
>>> ...
>>
>> Yeah that makes sense. I was trying to avoid touching the existing
>> wording to make this more surgical, but you came up with it, and since
>> you don't like it I'll just change that too.
>
> OK, for now I'll mark these two patches "read" in my inbox and
> forget about them, expecting that a reroll of 2/2 with improved
> messages would appear not in too distant future.

I was going to submit an update to this, as an additional improvement
can anyone think of a reason not to always infer that we'd like a new
branch if the LHS of the refspec starts with refs/remotes/* ?

    u git (push-advice-on-unqualified-src-2 $>) $ ./git-push avar refs/remotes/origin/master:newbranch -n
    To github.com:avar/git.git
     * [new branch]            origin/master -> newbranch
    u git (push-advice-on-unqualified-src-2 $>) $ git diff
    diff --git a/remote.c b/remote.c
    index 5b679df02d..949a9bd079 100644
    --- a/remote.c
    +++ b/remote.c
    @@ -969,7 +969,8 @@ static char *guess_ref(const char *name, struct ref *peer)
            if (!r)
                    return NULL;

    -       if (starts_with(r, "refs/heads/"))
    +       if (starts_with(r, "refs/heads/") ||
    +           starts_with(r, "refs/remotes/"))
                    strbuf_addstr(&buf, "refs/heads/");
            else if (starts_with(r, "refs/tags/"))
                    strbuf_addstr(&buf, "refs/tags/");

Maybe we need to be really paranoid here and also check if it's a
"commit", i.e. you could setup a refspec like:

    fetch = +refs/tags/*:refs/remotes/origin-tags/*
