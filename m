Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F38E3202AA
	for <e@80x24.org>; Fri, 22 Feb 2019 16:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfBVQ2C (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:28:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54935 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfBVQ2B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 11:28:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so2504922wmh.4
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 08:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OtE0dDhWMpUFgJSxExnjjHv96MtALnTrrQhTwxsgsoo=;
        b=uGpbJs+z2sl+Er0ekv9JE3Y+5prsOR+mrnEX720ZbDBuztQ3qFqAxm0bsI/j380GbD
         A4psAGBZPItHvQipT4VinBRD+u+zE3LwQyrN5/Xux05M8yTokPkvScOa1wNQujljzUMp
         1rucoHVTgBbmxCmHgI5n0ZVH0WyZGZR+Mo6ucT7/Hn31QTD+ghtISP2LwpUhdX5EQfeo
         Mx7c+pPDvRJHVTwwiVVRaotG8XOIeQ5f58j8orTeWG2Skr6YlEgAcArSGwt2UpRxL6eZ
         Ya8t9Vhu4yjjMTfg502EKj7gwai34xkeLcmAb9YvnL4LsqtDMyYr0g+8w9NKcsQG+3TP
         eyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OtE0dDhWMpUFgJSxExnjjHv96MtALnTrrQhTwxsgsoo=;
        b=q44iMvXEjGYxhzM4xrOsVPejEJsM+jdhYM420+A4BEIVOXuav4hB6MitSYRNPSgR9k
         U6c5Wf51uS9kbrKeKnKG0D9PHtAyuEDdBiJQfnerl2R77f3TAJvSykBPfYpRBo9We4+H
         0Rg4J8X/W3tFrVwYt55F9oxmwvrXfc0PVWYQ6AE6rqRA83kvpDY/zQyNtqcBwHxdt3Bs
         GRE5hZcnLcl+uIIE1dgVlAwBTHmVY5ZKnbD5wQufeaH0E6SjWqGuvr5cdD3OSnSeth74
         482qpuVN9hQ/uA8eq5zNGxJi7yMEdcquRhv7XYqqpletTy4sZ9LtyjvR5rIDuLpStEqC
         Cu8g==
X-Gm-Message-State: AHQUAuYZAy2J9LqrtJ5NCt5+LxCg/TU+lBK9bK5PNMnAA1E0JHQGcDBD
        BEvEVmkM6kwkvm8DpsCpYrHQQkv94nU5/8aLK34Vhg==
X-Google-Smtp-Source: AHgI3IYYTMU9Rwsk0S+57BqWCTyjwF0ffijtVqRg5sdKY7qTmftTk6YPU7u3LumyeUr/Kws2zipJBRVfX9x2cgyckgs=
X-Received: by 2002:a7b:c14f:: with SMTP id z15mr3110752wmi.3.1550852880050;
 Fri, 22 Feb 2019 08:28:00 -0800 (PST)
MIME-Version: 1.0
References: <CAL21BmnVkKtYWa1cRL1EJAwtchGcVUzhu0136AuV8uXAi5Kuew@mail.gmail.com>
 <CAPig+cSDtU1pbuzCvNPf+nmwS5LLKPm5RSY7wYxWg=s1e53enw@mail.gmail.com>
In-Reply-To: <CAPig+cSDtU1pbuzCvNPf+nmwS5LLKPm5RSY7wYxWg=s1e53enw@mail.gmail.com>
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
Date:   Fri, 22 Feb 2019 19:19:23 +0300
Message-ID: <CAL21Bmmwr=F+-sTNFcHxk3kdCE3ahV2eQzTNCDteb=7vZVB2aw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/20] cat-file: start using formatting logic from ref-filter
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D0=BF=D1=82, 22 =D1=84=D0=B5=D0=B2=D1=80. 2019 =D0=B3. =D0=B2 19:09, Eric =
Sunshine <sunshine@sunshineco.com>:
>
> On Fri, Feb 22, 2019 at 10:58 AM Olga Telezhnaya
> <olyatelezhnaya@gmail.com> wrote:
> > I also have a question about site https://git-scm.com/docs/
> > I thought it is updated automatically based on Documentation folder in
> > the project, but it is not true. I edited docs for for-each-ref in
> > December, I still see my patch in master, but for-each-ref docs in
> > git-csm is outdated. Is it OK?
>
> If you look at https://git-scm.com/docs/git-for-each-ref, you'll find
> a pop-up control at the top of the page which allows you to select
> documentation for a particular release of Git (say, 2.19.1). Your
> change to git-for-each-ref.txt may be in "master" but is not yet in
> any official final release. It will be in 2.21.0, but that release is
> still in the RC stage, thus doesn't appear at
> https://git-scm.com/docs/git-for-each-ref.

Oh, thank you, I missed that.
