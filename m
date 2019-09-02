Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7134D1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 19:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfIBT2R (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 15:28:17 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:38483 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfIBT2R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 15:28:17 -0400
Received: by mail-lj1-f178.google.com with SMTP id h3so6934776ljb.5
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6h27/JvhHYkZj+M2KA+UdMUrXORMadQ8zzhyap/EJEI=;
        b=AbrZykRYIy1DT25giWRkevmSd96udys/+W6C5jbPHe1ACbz/czZ6wV8kb1p3hChVOL
         YsbY8ucpj+5kCXAg35PsSHRxWTMJtn3EcoXmDCE+hPJDZ6BhvvGd5u62Fp6+eI5zxuwg
         raBRa9dhKjAOVKzHJDsI/OHJPIyIfuK98eUr+aG7CcyPpIgpg4yhp6JlkDOVZsJ6+Mf9
         tik+wa/WQzlaXMYyCZcHQpuro6edyWP6Jho51AzaCitan8zum6hcgVBGPvN38AMHIV0K
         95g148itv3BJC6ijbZ68cprBiqpxlmH9CccvsAA1G+CCvl0avY2V2AWbDC1xHi0kkZ9R
         xrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6h27/JvhHYkZj+M2KA+UdMUrXORMadQ8zzhyap/EJEI=;
        b=FLVSz2zKlAJzgKbTL1p70iSEIotLIfa98QNzgpO0fxTHFrrtYlLqVj/9SmFG9sR5wY
         M49JLmGewlniW3S30jZ2S0K8AwHDLr7DzkgV0qf8R1mLC39M+0vKf2qdfUukjv2pe7Tr
         wncpySek8cPq3lOYz9snHWebMIHcBt31saey56C1w4nvmz7fxYZTp1peVhoZRHE2pJOJ
         CRTc3k9RBNHnF69ZKGEO+A/EV9csN3jqTIHVXTIVbnmsaWsvo9dg+zIREini+5vL2N/b
         amWmHrXiKmFekRSMejNDCl7ejBcWz9wneqlr9/rKATpAtTHhgbidfAzlviK+OV/XIc5z
         e7lg==
X-Gm-Message-State: APjAAAW/woFgjQB+INPNTE+9ynoGbD/+leYcAcVPdGVqYCRz67nebyEZ
        qcn5tGnU+wSwdzMexSUP82Mlu7DqqQ+q1NOS5Ng=
X-Google-Smtp-Source: APXvYqybVplLWda6hEXmID/AuRKYlS4yenxOGpbddebAXeFexApOvM1M3rpcw/kBLjipn+2QGVpZ9w/z27GiZoKBVrc=
X-Received: by 2002:a2e:b16d:: with SMTP id a13mr16940316ljm.1.1567452495365;
 Mon, 02 Sep 2019 12:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=+ThYVyZUiU1wnt0yL+MzF1RXvHnbwo9NWyh95cLyhNRQ@mail.gmail.com>
 <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com>
 <CAGr--=+CEX-STDgT_ZwaA=n9UHSrsgcWnxCMY=9tGDA=9XLkew@mail.gmail.com>
 <20190902181213.7jqvoyctdm26g34z@yadavpratyush.com> <CAGr--=JgqjC8FskqVFJTqAnQ5aq8J4z-Wje8s22VwBgVtkBF-Q@mail.gmail.com>
 <20190902184405.bfb5572iia2v2uwi@yadavpratyush.com> <20190902185819.fzf3lop6riiq6zja@yadavpratyush.com>
 <CAKPyHN1GgXLy0+z=JbuyuSvVXsh6u5Po18OXizPNmfLE5AC00g@mail.gmail.com> <CAKPyHN3=QY4+XNhQPq09_PALFwfR5bWBs7q6m6LkfFoW-xeCug@mail.gmail.com>
In-Reply-To: <CAKPyHN3=QY4+XNhQPq09_PALFwfR5bWBs7q6m6LkfFoW-xeCug@mail.gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Mon, 2 Sep 2019 21:28:04 +0200
Message-ID: <CAGr--=JL2+yMqO5Mr19Es+787qJ=eQpzEo77Pco7GOhjvuAa+w@mail.gmail.com>
Subject: Re: git-gui: Long lines in commit message gets hidden, no scrollbar appears
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert,

Works great now. Thanks a lot for fixing this!

Birger
