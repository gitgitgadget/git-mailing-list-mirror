Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D4241F462
	for <e@80x24.org>; Thu, 30 May 2019 18:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfE3S7H (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 14:59:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44529 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfE3S7H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 14:59:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id b8so10528118edm.11
        for <git@vger.kernel.org>; Thu, 30 May 2019 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=CCMo66QDQR6nXo7GbcRI7s6wEZurrBPp8GvSE9QkyKU=;
        b=Id1LHtQ1veUWJBTITOy2TADKdMedVI/LgKWd83x6pYDi5vaiUlYG9jPoWL/P0/h6jo
         eK3GcxR+q9IMqzyF++1/hYB6xSbQkLUzWvh2oPo4fjSTOT/dg/FYO5pXkrXhpGW2Bg/9
         RK7Em3Cwekj3Bfn7JLoxsQwQcmbOm7u7igFJRvAo0W5moEZiEKw4+/F9Eighomg4uJUP
         Qzd6zfb1AOWdXdNea27a9ceVxBtSJSPi3gIXH61zcT05ZjKwpDzLOnjH+XtNH1OpQYWR
         lt/qQ3HvLo/SiHt1ssmzxzicBI4Tb18pAF2Lu55iiSCbp+7oDbU4qyEj2pFZeD6pOobD
         XQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=CCMo66QDQR6nXo7GbcRI7s6wEZurrBPp8GvSE9QkyKU=;
        b=QnrBDEcBdhTI9k3KvnTo3nWYEwKTH52nyU/ZwJ4wxptaekdcLumL5REpTgJEbdEAGj
         fvkFemgI3fOTIpznG6lz4HwADd5Vt7FFxRW64f3Kb3JFPQpeKwEl1DX6CsiYvl2ChWlm
         2laD8BFX+CegeR6WSn/UbfGG+pZRYZqZrenwAIuE4NlDYm2yASqdrqW/9hK1NOuEIsbu
         bsH4T3xixG05nt1c+3cyXniaursp4qYpVVoC+lMiLda0GabKc0w+iW4f1GaEToitqzse
         L7lL6iMSgVXXgnBgkyJCuZy5iyKu4VzMHwYOSkxXKVvOw0QJJPiDvlXJdiv8fH8oZWAc
         GILA==
X-Gm-Message-State: APjAAAVQbVpYZzlMJj4iLEDf5H/Fz9K95ZPRMKkltd3cNPHiSmm7H6Ww
        X15CfjOXCFXFHOH+hy1murM=
X-Google-Smtp-Source: APXvYqyImNKPt+iueGp8Z7tVTmB78GGUQZlUxnadVwuI8bHZbGRaLUw+dxcdiAlC/geOd2OcZEh7DA==
X-Received: by 2002:a17:906:5008:: with SMTP id s8mr5127868ejj.308.1559242745900;
        Thu, 30 May 2019 11:59:05 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id y16sm577231ejj.2.2019.05.30.11.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 11:59:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] userdiff: two simplifications of patterns for rust
References: <20190520170403.16672-1-marcandre.lureau@redhat.com>
        <e1c4c2ab-927d-fff9-b9e7-13943cba2273@kdbg.org>
        <CAMxuvay3ynFuP3fu57T0f9NEhjbCfM2hCUrdBHvxw-d1Jj54FA@mail.gmail.com>
        <xmqqtvde4jxv.fsf@gitster-ct.c.googlers.com>
        <a7d42d82-7d84-bf25-55ce-5c57a7ce70e9@kdbg.org>
        <CAMxuvaxW9fc4ft=aERSUt4+n237bdtDpKJMvyKq=H7yz-VLWbg@mail.gmail.com>
        <2d32b107-9278-faa0-4fea-afe662031272@kdbg.org>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <2d32b107-9278-faa0-4fea-afe662031272@kdbg.org>
Date:   Thu, 30 May 2019 20:59:04 +0200
Message-ID: <875zprn4zr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 30 2019, Johannes Sixt wrote:

> - Do not enforce (but assume) syntactic correctness of language
>   constructs that go into hunk headers: we only want to ensure that
>   the keywords actually are words and not just the initial part of
>   some identifier.
>
> - In the word regex, match numbers only when they begin with a digit,
>   but then be liberal in what follows, assuming that the text that is
>   matched is syntactially correct.

I don't know if this is possible for Rust (but very much suspect so...),
but I think that in general we should aim to be more forgiving than not
with these patterns.

Because, as the history of userdiff.c shows, new keywords get introduced
into these languages, and old git versions survive for a long time. If
the syntax is otherwise fairly regular perhaps we don't need to hardcode
the list of existing keywords?
