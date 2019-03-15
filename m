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
	by dcvr.yhbt.net (Postfix) with ESMTP id D3D2620248
	for <e@80x24.org>; Fri, 15 Mar 2019 12:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfCOM4L (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 08:56:11 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:40966 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfCOM4L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 08:56:11 -0400
Received: by mail-ed1-f47.google.com with SMTP id a25so290259edc.8
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 05:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=VGIZPq6aTiaE7488tTix/PK5dSz6j99pjw//JJ8QR7E=;
        b=q0mziPGAh1gqylcUcdr9PmT46mnErjuj2nktZI69scqSQmJvr1qFq3JD0P3gbREmw8
         u+reB4gTX/PglG+TlWUVbBrxUFHfouq71smGNzWeN1faWl8uF64ViskOGdxUt2Rj+6jl
         uVrIGfJhKFCa/wqeBy2W5yfED1WvR6ARj40bUCNMh1aaXR4ZPQM0PA+EgOtKIfH5oIQQ
         MUSMHDKgubnaGav5S1PD6LwPntTrVeS8FYAv0A/6khGOO8c71l+OBy3uFUhyGkprqScF
         F1zuq8qB+4MmnOp+fdvD8opovr0E0F1Oqn89p2P2RyktHfQdC87mse9INWi4fGwhLDFe
         zioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=VGIZPq6aTiaE7488tTix/PK5dSz6j99pjw//JJ8QR7E=;
        b=eG2cptUMh6CkgnQozKnJsZwNQ7xvdde4tmYrcxCfHj9BlEnaBhJ0vV0ITB20bTOUTQ
         2Rhxcrm++p8L9WYR/hWn9E9HZqkWFvCuHmMcn6MNE0wPeer1B2/zkrzGUVd4mqkfWVN9
         ltq4EeQ6NjcgEsOU1FjnKD/D/3xswFiLLpykLD/YfpQjtsbxh38EBY+4NZ1eeTzIaCDQ
         iHZsysHnTMGF70ezB09DkBhMExxGlYWeTbhleEV0WY5npu/mR08Mi+bmw/bEoRs0oeCD
         USlbld4C1crevX7rQbk4xDXx9L6NodOwiB5kc6oQDhY/ZAuxEMrZuODRlLU9rCkSPrCn
         HVuw==
X-Gm-Message-State: APjAAAVniHUeMzSD55c+48KZSDDd7BaSvqvM1zTU9eB70PfkZN3PqiJM
        IB6YjnZeuYIOzQ1zBYOf5qc7H5SzL1E=
X-Google-Smtp-Source: APXvYqyRg+FfV96eKt1jIH/7Lx30Y2pRx+3nOZWjDOiYR9cCZxZXSCvTkodmBfwLPBtz17/8abEDjg==
X-Received: by 2002:a50:ec03:: with SMTP id g3mr2678586edr.263.1552654568936;
        Fri, 15 Mar 2019 05:56:08 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id t10sm618150eds.3.2019.03.15.05.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 05:56:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC] Microproject: Add more builtin patterns for userdiff
References: <CAMknYEMgJ88zWsebxBqsLq8LUwYzg0vN3RpsWVpbqvncrd5dGQ@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAMknYEMgJ88zWsebxBqsLq8LUwYzg0vN3RpsWVpbqvncrd5dGQ@mail.gmail.com>
Date:   Fri, 15 Mar 2019 13:56:07 +0100
Message-ID: <8736nob8k8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 15 2019, Kapil Jain wrote:

> Hi,
>
> for the microproject: creating diff function support for different languages.
> i wrote one for shell script, have tested it outside of git and it works fine.
>
> query regarding accommodating the pattern in:
> 1) userdiff.c, it uses - #define PATTERNS(name, pattern, word_regex),
> for defining patterns to locate functions.
> what is the use of pattern and word_regex parameters ? i am guessing
> that pattern parameter is the actual pattern to spot functions in a
> file,

Yes, except "functions". More like "logical start of
stuff". E.g. "package" statements for Perl etc.

So whatever makes the most sense to put in the "@" context line for diff
to give the user an idea of what "function" this is changing, in the
loosest possible sense of "function".

> and word_regex is used to get function name. is that correct ?
> please let me know.

No, it's whatever counts as a "token" in the language for the purpose of
"diff --word-diff". So it needs to match e.g. operators as one unit.
