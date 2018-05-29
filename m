Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2D881F51C
	for <e@80x24.org>; Tue, 29 May 2018 10:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932827AbeE2Kah (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 06:30:37 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38168 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932629AbeE2Kag (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 06:30:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id b74-v6so3616465pfl.5
        for <git@vger.kernel.org>; Tue, 29 May 2018 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kAC/Qz6O8pJCcz52AIkgOUduvmf/mR+jnSL2KJd3fF4=;
        b=AWqTm9J+4TCTHHI7/1k9iNa10dHIuD2cjiMKXmCVSvZcB8Nwx+oKoClazns4b15sTn
         9TfOopM28R0OSRkFxyOutWu0Pn+iY9onepzk0S6/DvAh+IOBAFWrhrOjWPVD2JwcX2/z
         4RP+inMJvsFyFaaJ4NBlJqUfLGREs90YQSbmv7h3nRKiQC4QAUvh9uHt02kobK7nSm/D
         CXFLZNnPAjyIqzruo6B7GBQ4tYONkM1yTIplEsNBCggzc9LuaY3GhUCCasfPE3otwnLI
         93U+o6aIgQ0XY3GqqN96cb/5Lfgl8arR0fhcULkAK21i7lqIcL2nOQIOuZF8nPFCalKf
         Lz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kAC/Qz6O8pJCcz52AIkgOUduvmf/mR+jnSL2KJd3fF4=;
        b=h1TE2QjElmM57qXg9dhUMs2PjO2gdQNzdbdQQOWLO61LPwlGT9Kc8Fwp9aOONO2W73
         SqXmzRxnOA/Hku4yOhKiHRkrxIr7tv3tc7UvjxxBLbDyey50fi0CyIS2LANo1zc+e97k
         xeGCzJzFry34C61BdYqWhkYc0ME7w6iRYcNASeOXigNBgReE23yHNFOB9cKcNvp+TUou
         YWhg9nZ3FUI21aSRgC6Nn7p8jmbUfTIWdL94DtLExSvyk4SPYFIjq87lANnEbcVvp741
         P4v2eUYZuanhjZf36Vb1UTAECYFEcyrOC/x7P/3aF6GH/oBGa66Jf5MGICTswsMbhaaE
         239Q==
X-Gm-Message-State: ALKqPwcmecMRssUazclRUj2CpJkyoQCwHWyWmBxSGJOeUYqGLutmpUUh
        j84hqo6WQAjajlO7Iq+TwzavRFhjpX4WqdMmKXY=
X-Google-Smtp-Source: ADUXVKJYQG7Z/NkEfwmDqGxvitsV3X6xHx71I47u2O4IFKHEnOZvXhEqR5SsdcUEhTxPmi7K75W4GgRpyOHUwvCz67s=
X-Received: by 2002:a62:d8c1:: with SMTP id e184-v6mr12544218pfg.161.1527589836020;
 Tue, 29 May 2018 03:30:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:bb8b:0:0:0:0 with HTTP; Tue, 29 May 2018 03:30:35
 -0700 (PDT)
In-Reply-To: <xmqqtvqrggdt.fsf@gitster-ct.c.googlers.com>
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com> <cover.1527279322.git.martin.agren@gmail.com>
 <ef5b4e28e00ad0c95dbe625d2e7305957f9fe5ba.1527279322.git.martin.agren@gmail.com>
 <xmqqin78jfnl.fsf@gitster-ct.c.googlers.com> <CACsJy8CgzDfbES2jC+Rv+bKj_JAk8dzEDCm89JMuBFQmyGg9Gw@mail.gmail.com>
 <xmqq8t83ihd7.fsf@gitster-ct.c.googlers.com> <CAN0heSq1y3XibCFDYsae5b6jmzZOzcLHT4atCZ+KCb4dL5As0g@mail.gmail.com>
 <xmqqtvqrggdt.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 29 May 2018 12:30:35 +0200
Message-ID: <CAN0heSry9ncTTzjw2fB=wxTAo3YPyQq-wbONpXCsfi_Syxfj-A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] usage: prefix all lines in `vreportf()`, not just
 the first
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29 May 2018 at 07:50, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>>>  - allow callers to align 1st prefix (e.g. "error: ") with the
>>>    leading indent for the second and subsequent lines by passing the
>>>    second prefix with appropriate display width.
>>
>> I suspect this second prefix would always consist of
>> strlen(first_prefix) spaces? We should be able to construct it on the
>> fly, without any need for manual counting and human mistakes.
>
> I wouldn't be so bold to claim that, given especially that we are
> talking about i18n/l10n where byte count, character count and
> display width are all different even on a terminal with fixed-width
> font.

You are of course correct. I should have my morning tea before typing.

About the _("\t")-approach that you mentioned up-thread. It would allow
a translator to adjust all the indentations for a particular language.
To be clear, what you mean is _("         " /* 9 spaces */) to align
nicely with "warning: ", which is the longest English string. Then the
translator would translate the nine spaces and all of "fatal:   " and
others to padded strings, all of the same length (not necessarily nine).
Correct?

That approach seems a bit shaky, if nothing else because we may one day
similarly want to use nine "translated" spaces in some other context. Or
maybe this is actually i18n-best-practices.

It also means that shorter prefixes are somewhat arbitrarily padded,
just because there exists a longer prefix that some other code path may
want to use. OTOH, if a "warning: " is followed by an "error:   ", both
lines/blocks would have the same indentation, which might perhaps be
(slightly) preferable.

Martin
