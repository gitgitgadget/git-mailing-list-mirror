Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A69920248
	for <e@80x24.org>; Mon,  8 Apr 2019 19:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfDHTgX (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 15:36:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36736 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfDHTgX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 15:36:23 -0400
Received: by mail-io1-f66.google.com with SMTP id f6so12139955iop.3
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=So2QftLbZboSy7vPUToyTV6c3ZuvgR4rxtkJvDXwgBM=;
        b=bdMUcI193MGo9UiBUoetJooTzchh9TduDfLh9DCRS/1dj9zgnndsm2HqZ/Dpulolju
         ehEX8Jeim1zZjdZGb8BAAQGcUpW6Arure76sV1XwEuka/Jrz0uPC/JRr+XdvHkYsy+1q
         NUWulvYuJDP6/msbMUiR0Fpfu95391uIspHtBOKb2D1YbJtgrlNra8VtF5Kswl7foGVU
         RguFMZdy19G0T2QoO/Tqdp8CRuboi0Cw6V2VxRjqjkrnOBNjnIXohh2CJcHBxY28y85B
         DtX33f01XGlN5Ood+UJvzyoWAguZvnHTMNJg1qqBYV2CGd2e1jMJrWd9SG0iOLNiusxw
         WbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=So2QftLbZboSy7vPUToyTV6c3ZuvgR4rxtkJvDXwgBM=;
        b=X28cTqRnHCKRfEmJ9OUSmuAutZ3E2Xvx9HGD6lokGijG5PlGmjl7OcHqhIDrVC2l81
         g0CUkcJwb5IdxIJ6AGE+iE0Ck5Ooqcj/3ubNyjOZ5lNQFnQZhwoOAB5/mZB4AVtIyrnA
         5p/eQ7UKT2j6zaNZ4bP1dxiGyJ5QMbxio3gpUgZ9khen4zA7iWdAOFCz/34z1ZDWvyUd
         QzV8zvKmRZhN5sOUyRRRz57VCAx3Wi1kLsgnIIo7mpAzRrqdQhEJmizWupF1mvNh/w1n
         L792/jPZ/r8yO8D8tpjErMGB3Nk/TTAHxxAiwby/GW0JcCIoFFGT0Nve/oJplhm9suOK
         UyZQ==
X-Gm-Message-State: APjAAAWKkq/Zeimj2brlpAA+P9kZk0tqj8lSh6dkDbUvqFiNDHKkteRW
        uvPFnNcJTRjba/QVWCTuSkSmwFrOLbkd9vi2xAIUxA==
X-Google-Smtp-Source: APXvYqwN1t5mx8X37EoYlBYc0IoTO9uh598EMjl7YM5f/8YFQkhxgLEyRoeHBJ3Fl0H4jj3mrhq23LE3OBpj3HNKfLw=
X-Received: by 2002:a5d:81c2:: with SMTP id t2mr17736718iol.183.1554752182448;
 Mon, 08 Apr 2019 12:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7KMrDJ-cyzk63oqW9-QVpag6fKnDp+Mo5bWxg1KfzY3g@mail.gmail.com>
 <CAP8UFD0qeOaS8NBOaMjzDf_tWJrgkYSAOgn8D=4JER2atg3H8g@mail.gmail.com>
 <CACsJy8DxW7ZcSNQBZq4+A6c+9xZopg79sXfi6Na61Xgcoqd6ng@mail.gmail.com>
 <79ecdc5b-2ccf-ae4d-3775-b850641f8c3e@iee.org> <CAHd-oW5PFmj4u2YB-1TcHWNxkokfCEsUq_zB=Rx2Vmdk5Z9eMw@mail.gmail.com>
 <1348d823-9729-a5eb-2104-df7c4a41911d@iee.org>
In-Reply-To: <1348d823-9729-a5eb-2104-df7c4a41911d@iee.org>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 8 Apr 2019 16:36:11 -0300
Message-ID: <CAHd-oW79P+Fq6OkdDa4Ly2mecuCM0tyS7jopON2_2rL-mf9RXQ@mail.gmail.com>
Subject: Re: [GSoC][RFC] Proposal: Make pack access code thread-safe
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 8, 2019 at 4:19 PM Philip Oakley <philipoakley@iee.org> wrote:
>
> Hi Matheus
>
> On 08/04/2019 18:04, Matheus Tavares Bernardino wrote:
> >> Another "32-bit problem" should also be expressly considered during the
> >> GSoC work because of the MS Windows definition of uInt / long to be only
> >> 32 bits, leading to much of the Git code failing on the Git for Windows
> >> port and on the Git LFS (for Windows) for packs and files greater than
> >> 4Gb.https://github.com/git-for-windows/git/issues/1063
>
> > Thanks for pointing it out. I didn't get it, thought, if your
> > suggestion was to also propose tackling this issue in this GSoC
> > project. Was it that? I read the link but it seems to be a kind of
> > unrelated problem from what I'm planing to do with the pack access
> > code (which is tread-safety). I may have understood this wrongly,
> > though. Please, let me know if that's the case :)
> >
> The main point was to avoid accidental regressions by re-introducing
> simple 'longs' where memsized types were more appropriate.
>
> Torsten has already done a lot of work at
> https://github.com/tboegi/git/tree/tb.190402_1552_convert_size_t_only_git_master_181124_mk_size_t

Got it. Thanks, Philip!

> HTH
> Philip
> (I'm off line for a few days)
