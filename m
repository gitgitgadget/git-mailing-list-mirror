Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B3B71F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 17:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933710AbeGIRUT (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 13:20:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44774 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933489AbeGIRUR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 13:20:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so11797746wrt.11
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 10:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WgQvlA8hnGziNXaVKkozrcquc2cPHSLyMSUtjvTJxMw=;
        b=b6h3VmUi7TUamW3LFa6DuZTYA/lR75ryMw2Xqine1xzytYHW/9gz5ugoHkV/RiMJsb
         2CSUCuBXqqs86wnW9gsS71ssMtG7jleJsk4RIyj8aam4bb6XYd2TSKlQIytSQlxRU/Yb
         Em1/htzVidJZ54SqZO4YkXbvAdqZUP1u5hN8kYn5xaCCz7sdUniznidiltyQl8w0x4w/
         /oLuIQTaS+bjvcRmwcow2ETCLHFIEEsDxl9zRZEBYkGYeiJ7RhTc/1Ymqhf+Y6eyULR1
         v6Cc6MoiDFe07Q+HwK3E51p0+GkvhdRLS6FktZTTnYEDp2PtyHHi+lNjpPPyVoNOoxzE
         qqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WgQvlA8hnGziNXaVKkozrcquc2cPHSLyMSUtjvTJxMw=;
        b=tP/efAdEo7Wjrtc++/Qc88dZI97p+MmuOTM1DkragnQDIxrkLnR1nbh7hmEAk3EIWI
         HCPxc8+vbbiNbrU98Aw+e9YVcBOuEhnmSGDzkbEaX6MCrTdiPWpHJoZ1hm+zF7gH7sgC
         BybjYZ94XxCTkT1e3OzLtvsvYNcetrimd1TBztjqvt1g0ZAZWe+EZezNklADZArU2VzM
         tGmS5yqH4pmtb26mUPjOykgiWjLPurtN/EMAtGFIGJnTeCLB6IDo354J/hrfS7Et42hG
         lMVBBpy5EMPCbiOJ+1jYKV7c1YXioVPmqoRkmWa1mzVujfGWwxk4n6qUU1q4a7GY1GWw
         bM4g==
X-Gm-Message-State: APt69E3QXBzCQ6A3lwdmSstxyLlm5vkQMPTGQiDxcNmjM20ePtbUyyKb
        6M55k7B2dqLmRDMU9lE5qWOTJuSofh/ade0DQmqowzJq
X-Google-Smtp-Source: AAOMgpcli4AXHcUcAaQOR9g8Zv7wokAqOZGDjKCVnGwv64PyAXdXg+wCRajiIi64BavkJBRiVwZxIAZKK1IuBtIFb3o=
X-Received: by 2002:adf:b8ad:: with SMTP id i42-v6mr14523144wrf.163.1531156816488;
 Mon, 09 Jul 2018 10:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180628074655.5756-1-predatoramigo@gmail.com>
 <20180708180104.17921-1-predatoramigo@gmail.com> <20180708180104.17921-4-predatoramigo@gmail.com>
 <xmqq8t6kfjic.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8t6kfjic.fsf@gitster-ct.c.googlers.com>
From:   Pratik Karki <predatoramigo@gmail.com>
Date:   Mon, 9 Jul 2018 23:05:05 +0545
Message-ID: <CAOZc8M9HJ86vJ4Cbz5RhP_bd0Ezgp7x+zu5xqhvrxiCGED+NYA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] sequencer: refactor the code to detach HEAD to checkout.c
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 9, 2018 at 10:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Pratik Karki <predatoramigo@gmail.com> writes:
>
> > In the upcoming builtin rebase, we will have to start by detaching
> > the HEAD, just like shell script version does. Essentially, we have
> > to do the same thing as `git checkout -q <revision>^0 --`, in pure C.
> >
> > The aforementioned functionality was already present in `sequencer.c`
> > in `do_reset()` function. But `do_reset()` performs more than detaching
> > the HEAD, and performs action specific to `sequencer.c`.
> >
> > So this commit refactors out that part from `do_reset()`, and moves it
> > to a new function called `detach_head_to()`. As this function has
> > nothing to do with the sequencer, and everything to do with what `git
> > checkout -q <revision>^0 --` does, we move that function to checkout.c.
> >
> > This refactoring actually introduces a slight change in behavior:
> > previously, the index was locked before parsing the argument to the
> > todo command `reset`, while it now gets locked *after* that, in the
> > `detach_head_to()` function.
> >
> > It does not make a huge difference, and the upside is that this closes
> > a few (unlikely) code paths where the index would not be unlocked upon
> > error.
> >
> > Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
> > ---
>
> Here is a place to say "unchanged since v3" for a change like this
> one that changes neither the proposed log message above nor the
> patch below to help reviewers who have seen the previous round (they
> can stop reading here).  Hopefully there are more reviewers than you
> who write new code, so spending a bit more time to help them spend
> less would be an overall win for the project.

Thanks for the review. I'll keep this in mind, the next time.
