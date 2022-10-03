Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDC5C433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 16:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJCQlN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 12:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiJCQkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 12:40:16 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47249B861
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 09:40:14 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f193so10156312pgc.0
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 09:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGMqEApJ6V30CQ3HcBW3tBBegEhFdTmaXQzfsor6TfA=;
        b=C00KUWrtVxMReI4TEeD/FiDrpNkPNL0j08eC3B4exV356veQLdOZVkYGzwUrZ4E7us
         r/0LOEejFFKGqAhDiTu2kWNLLFq2+ZmTUjs8bZyyjliiI6Ql4NzaskUzatEkQtxjUO3g
         /0AjUYb1DUrLsFUFnENXRRVkxqXmbQ4DqHk1KoPJlGfte/YAC0EJEeqTUtBD6kgSyKCC
         qxRGxmHK83nQolxFVyrs74fDfu50e4Q0a1AlyWqiJBtgpWEUo2tN0/6Jgvy2RISglMRc
         chhwFy3fYRd16EyA4mlzZBbRPGdnpe0TScgrO6dpMjSfXuTrFOgAdHLav08ItR8vGLRr
         IbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jGMqEApJ6V30CQ3HcBW3tBBegEhFdTmaXQzfsor6TfA=;
        b=CnCHEBghnX0UCYbBvSBr1bnzE81bArdnsm+bc/8Z3qW2Upf21U3yWDCgGln39kopmA
         R7T9xTQq8SvKKw33sIOOSLzPcP2gBR4ov8g8glMnDE2w44/glt6RGUuqNTNCnt8OW2Rw
         HO4AtBJKqRVOGjHWNMzCTt8yeosd/afOzw4o27bffR6x02vkJu02DUDsPiO8N7H1p4/p
         DwSecIu7ELTW5G7G/ITn6Kgp152n1l5drcJ7OWxcGgC4VttB5MQKfYRALsrxp260QzTz
         Yv43vaM6UM8gxPMQ4UVMzrWHIdl3UZBAEONwl83jkDSiJ8t/BNdb6wQtt+WQj8A6V7oB
         zMLQ==
X-Gm-Message-State: ACrzQf0qjk6KMXkGe4KItWoGOw7HrLlG7StUeSvLXkH+UhAlnm55JBzb
        76w1QZQhTDtzQuvV7X83Fko=
X-Google-Smtp-Source: AMsMyM7aoCCoo3mz6AXei/TwvPkyWPlV31dac9+vj3a2JtyvNQjAMMt2ZBgp7uvIjpz4jgC49PlzCw==
X-Received: by 2002:a65:4508:0:b0:43c:e3c6:d1c2 with SMTP id n8-20020a654508000000b0043ce3c6d1c2mr19209473pgq.582.1664815213718;
        Mon, 03 Oct 2022 09:40:13 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o41-20020a17090a0a2c00b00202df748e91sm6634921pjo.16.2022.10.03.09.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 09:40:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-reflog.txt: add an EXAMPLES section
References: <20221003084654.183966-1-gitter.spiros@gmail.com>
        <221003.86o7uttfxg.gmgdl@evledraar.gmail.com>
        <CA+EOSBkp7xUPOa1uJcSi1MBYqUG6r7KQmDjAWDLqLXJwwQ0djA@mail.gmail.com>
Date:   Mon, 03 Oct 2022 09:40:12 -0700
In-Reply-To: <CA+EOSBkp7xUPOa1uJcSi1MBYqUG6r7KQmDjAWDLqLXJwwQ0djA@mail.gmail.com>
        (Elia Pinto's message of "Mon, 3 Oct 2022 15:53:06 +0200")
Message-ID: <xmqqy1twvp1v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> The examples included are based on an email exchange done here between
> a user and a git developer, maybe Junio, I don't remember. The user
> found the explanation useful, as he had a hard time understanding how
> git-reflog worked with branches. I agree that better could be done,
> for example by entering how to recover lost commits, but that was not
> the goal at the moment. Later this is something that it is  always
> possible to do. It is also true that the examples in practice show
> what should already be known with gitrevisions however obviously many
> users cannot find the link between the two, I must imagine

Geez.  I did find the examples, especially the use of "4" as a
random number pulled out of thin air, vaguely familiar.  You seem
to mean https://lore.kernel.org/git/xmqqo7xuif46.fsf@gitster.g/
