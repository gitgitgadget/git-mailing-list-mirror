Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88E551F404
	for <e@80x24.org>; Mon,  9 Apr 2018 01:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756612AbeDIBq2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 21:46:28 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:33594 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756610AbeDIBqY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 21:46:24 -0400
Received: by mail-ot0-f182.google.com with SMTP id 23-v6so6924439otj.0
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 18:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i+gW5Ca+Fc/Vl/bhw89s2rbKpyiyqXO/L43eu83JcT4=;
        b=I8cHLD/pUoQvCcl+niSNUQr8c7CsGsC24e97fxB9Vl/J611Zf4/3IE66CsV1D8tioY
         hqYu/sv8/c+0klF+uSeM9g9DGSF1OXGcNzEFLHHTWjsyu7bds9+IA8AXI540qCrM0FAt
         /jytu9MNKGxw0NUo7tdzt+IefJkDQ/0ZiOBbqPCOBetAZ+kdBOACAz3CZtUiWSKlKSDa
         dduhj5tnCKcCmKaOBc35yWEeQbwQA3nRDJ+YDD3p7RK0itFLE+q5C7F3Ktu2CKqdeKq3
         wYjQHTFFO1C8BCY8mKx4i/APeBDtZurzziaGnCMIr/24PKPqBrFX8cZz6B2b13rx8S5t
         +rWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i+gW5Ca+Fc/Vl/bhw89s2rbKpyiyqXO/L43eu83JcT4=;
        b=GOcQyzoKe5Lri2uQZyrOxnM28v7UcAQS0S2pqBF2uBLjq9q15/2zZrEivcaH4M1prA
         R23H5THuCT/zp1gELYsDrzEawUZZs9+RLlKvMruVSw71ChEnd1SqktDqrZf+XjNKgcxX
         eZmhfN+bE74jvxtS/m5pOehH8xjnD+Y80mDmfOfyp082dAzY52LEhZ19vMX4FSpn8pMd
         p9uaSFa8cmj4BtWtSrkzCUC6rJBl8zbhBAIzbgfAJwi36XCLUZZEaG2heEyLkfreZWFP
         Rt5XiOlzhvv3cQuALMr0+70xCEf0rYLTjZ55bEzrusmLT9ljQ2qTC5bTSC73XZy56m9h
         QdKQ==
X-Gm-Message-State: AElRT7GFvsg6v1QcdGCkC1krNw3kjla2+g+bvDnW+wdTLX3JuXxDbsAK
        jNiqwJF2OpkOsmgNqsFrl3zMXss7G5EJgw0RTLEGLhIW
X-Google-Smtp-Source: AIpwx48UU/z8cag5jS91ZASHx3/A22n82FfClOz1qhK5PLjj+jLa1iynUfa+A+Eb5CjWTRZSyKJP/xcNTjItBmxigYY=
X-Received: by 2002:a9d:6258:: with SMTP id i24-v6mr18018093otk.239.1523238383902;
 Sun, 08 Apr 2018 18:46:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.68.194 with HTTP; Sun, 8 Apr 2018 18:45:43 -0700 (PDT)
In-Reply-To: <xmqqin916vu6.fsf@gitster-ct.c.googlers.com>
References: <20180408235815.36582-1-haraldnordgren@gmail.com>
 <20180402005248.52418-1-haraldnordgren@gmail.com> <20180408235815.36582-4-haraldnordgren@gmail.com>
 <xmqqin916vu6.fsf@gitster-ct.c.googlers.com>
From:   Harald Nordgren <haraldnordgren@gmail.com>
Date:   Mon, 9 Apr 2018 03:45:43 +0200
Message-ID: <CAHwyqnU-hyRboVDG8BBRJU_uURRdoh4UPg7=PjsJ+V9YPwqYcw@mail.gmail.com>
Subject: Re: [PATCH v13 4/4] ls-remote: create '--sort' option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 2:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> With the update since v12, I think "because `ls-remote` deals only
> with remotes," can be dropped entirely, and still convey what needs
> to be told: "Be aware some keys that needs access to objects that
> are not here won't work".
>
> Instead, it is probably a better idea to spend that half-line worth
> of characters to describe in what way they do not work (do they try
> to deref a NULL pointer and dump core?  do they notice we need
> missing objects and give an error?).

Updated the docs again. The specific error we get on commiterdate is

    fatal: missing object f0d0fd3a5985d5e588da1e1d11c85fba0ae132f8 for
refs/pull/10/head

So no core dump. But a fatal error with a possibly confusing message.
