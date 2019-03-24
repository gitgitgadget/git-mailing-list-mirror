Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F37A520248
	for <e@80x24.org>; Sun, 24 Mar 2019 18:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfCXS6p (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 14:58:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45485 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfCXS6o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 14:58:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id m16so5645873edd.12
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 11:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=lSuICrju4zuYzBbymtfJ1yxNY94Egg4j1/a64uEI4Qc=;
        b=upZTBxdX1aDhGXEjz+cy98uuPZN+U9feRC/1p4DpifvgvTKdhrrcFaLu9ZHK2POSPr
         ND+D9+6o5Cn5us8Z0zQVwJnLuQc+vsxXdb2b+UI8wQacG001+QlCsYLke336zpvniROw
         lXriFJMdN/xwYDXROPfLPXFYi0le3tMdOoZxUJcQa36eQ58L4pdw7Cg5wNop0gEEkAP0
         Xo40OyIr25PnsC8uCEb2VLcZC3nXU5kecb3DGYAYcZvq00l24ywvyINvSttYgEX9gL2l
         hxkx38yB5BbQPTMfHv0WWSjfx1hRCk1TzBU6azGiJ8/uEs1kE1K40p/pKKyGRZ/RpUJa
         /4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=lSuICrju4zuYzBbymtfJ1yxNY94Egg4j1/a64uEI4Qc=;
        b=OOhKJGii4xnrincm6Cx3TDm9xf+oOvxBefPPgxC1Ok3eNuMHE1NSfYV2ndMJhUBo5W
         cH9P9y39mS3U4b22hBhjBjvo8uq/iY5F5oY6WhqCR4pPKVAC02bAyItnxa7g7Bmrt18k
         26s6OSPFYpbVI2TIuXIdzU9oKzTyTVvstKKxAFm+XOgXUb+0VkG0a35TrDluto5mN5nM
         1NcbJOecb7+1aY6SaSddve1A9O8u9+HLaRhun9RCUcpNC+yEUA2FlXewHvByOZAzXR/p
         Bz7WSiBcAiJyNg0rT7IwoC1KPssQmsnRMLPirGqaYU9TTsTI5cbNtXsj2zB0q1EGKAia
         RMmQ==
X-Gm-Message-State: APjAAAUzdQlvo4EZPVi28z4H/2Ndp/M9Z91xV1Djb12VThuGjUdFbCfb
        KjYjcAswLBvLdvgjuJir2YA=
X-Google-Smtp-Source: APXvYqyhFn3rUM06fe5FG4q/Efx6wG22HW3xeUw55zpRkhe8FYNEfSTpGPHuF8V3bhR+uGuTMJdTCQ==
X-Received: by 2002:a50:91c2:: with SMTP id h2mr13782968eda.54.1553453922941;
        Sun, 24 Mar 2019 11:58:42 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id 35sm4701173edh.43.2019.03.24.11.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 11:58:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] In `git log --graph`, default to --pretty=oneline --abbrev-commit
References: <20190323041332.9743-1-alexhenrie24@gmail.com> <xmqq36ncpgpe.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqq36ncpgpe.fsf@gitster-ct.c.googlers.com>
Date:   Sun, 24 Mar 2019 19:58:41 +0100
Message-ID: <877ecocd5q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 24 2019, Junio C Hamano wrote:

> Alex Henrie <alexhenrie24@gmail.com> writes:
>
>> Having --pretty=medium as the default almost always makes the graph too
>> difficult to follow.
>>
>> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>> ---
>
> I too thought that "--graph" should make "--oneline" the default
> back when I originally accepted the patch series that introduced the
> "--graph" feature, but with frequent use of "--graph" myself, I
> stopped being sure that "--oneline" should be the default long time
> ago.  I find that the default level of prettiness goes reasonably
> well with the "--graph" option.
>
> This would be something that needs a long transition period if
> somebody really wants to force people to adapt to it.  I am not sure
> if the complication is worth it.

Aside from historical/backcompat concerns I think the current rendering
makes sense. One could also argue that e.g. --stat benefits from
--oneline.

We shouldn't have unrelated options implying one another, except stuff
like "--compact-summary" implying "--stat" (makes no sense
otherwise...).

I use --graph without --oneline more frequently than not. It gives you a
glance at how deep in a merge hierarchy some log range is, whereas with
--oneline you're most involved in the shape of that graph to the
exclusion of other things.

But maybe a built-in "git-graph" is in order? E.g. one can imagine that
once we have a dedicated command for that (similar to range-diff) you
could really focus on the UX of that, e.g. going further than --oneline
and truncating a N+ divergence as "...and N more.." or something.
