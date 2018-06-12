Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C97571F403
	for <e@80x24.org>; Tue, 12 Jun 2018 21:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933941AbeFLVtP (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 17:49:15 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:36444 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933793AbeFLVtO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 17:49:14 -0400
Received: by mail-ot0-f178.google.com with SMTP id c15-v6so611258otl.3
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 14:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q8vIbOdWVidMOLSnEsm4hWUMPKC1Du9gp9PC8Jewj4Q=;
        b=XFm/nBnr94hBWsvi81K2hoMRkv6XtQfLAmZiQveFz41uevH4Hc/jYzpzOJyQH9gKnZ
         xtM4HDjb+UrWMumFJYSSm4KBNAMHi3ETANZ3ndQPO7RCBi+71LmXp/Ye5F0C4ndmzzGs
         zrwlX9EYWdLiOHsKxCHy2PXwd983Grax2FfUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q8vIbOdWVidMOLSnEsm4hWUMPKC1Du9gp9PC8Jewj4Q=;
        b=ApGs3dDxXKBiQvrpA+ZuA/x197+RoGZ71QgaD4hbtf/QNf/HeYcVS2dGsy0E9Uh2J4
         aAD+1PVP+vqme6YvUiZ4okPxado13J0dJzGDd1hZ4KpYf09EyN/jXhnFIWI0G+VO4jq6
         8zbZVnhEk5nadugWpKxfGU4wq/CWACeZpctOeY1mXtyj4wQ171nWJupgaZYOkB2DSmpt
         YT7JVu6f8HES//6V2oOK9GkzjfCuxybBBA5rDgLbiO+RqGeLgwPm8xm9484ttEZtCetD
         4NbGpdwAnAAqo0GRSpclGUKoNZRktiJIeWQW4gqkK1j3l6enHUWyMKUvjEnCfKBs5OmW
         D0ww==
X-Gm-Message-State: APt69E1AW1W2wQGPlfYOHcMD7UKSNL0D6FaKSzFSjTXzb5PaAPwe7CmN
        MnFzAJfKvsAPrO/SFZagjwxh8Tn1QcNZ8jcr0HlrXQ==
X-Google-Smtp-Source: ADUXVKIvCXbn+330pKZAKEcfuSXzUmwFvAKX4L22h9piaKIB8S2Na7WsDbckJAPsaXB868inLqZpCwdamMsm3V+hc8I=
X-Received: by 2002:a9d:5250:: with SMTP id q16-v6mr1358486otg.229.1528840154319;
 Tue, 12 Jun 2018 14:49:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2f8e:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 14:49:13
 -0700 (PDT)
In-Reply-To: <xmqq7en38z8o.fsf@gitster-ct.c.googlers.com>
References: <20180608203248.16311-1-luke@diamand.org> <xmqqo9gg9bi3.fsf@gitster-ct.c.googlers.com>
 <CAE5ih7_ZDzg9h8BEGDWyg_jBG1rj=_eW1Kg7JO7oKiF6Q2+37w@mail.gmail.com> <xmqq7en38z8o.fsf@gitster-ct.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 12 Jun 2018 22:49:13 +0100
Message-ID: <CAE5ih79NoTpbkU50tts2GgLJ7Wy9WyBUgJncm3KXPLxuy0P0hQ@mail.gmail.com>
Subject: Re: [PATCHv2 0/6] git-p4: some small fixes updated
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Merland Romain <merlorom@yahoo.fr>,
        Git Users <git@vger.kernel.org>,
        Eric Scouten <eric@scouten.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12 June 2018 at 22:35, Junio C Hamano <gitster@pobox.com> wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>> On 12 June 2018 at 18:10, Junio C Hamano <gitster@pobox.com> wrote:
>>> Luke Diamand <luke@diamand.org> writes:
>>>
>>>> This is an updated version of the set of changes I posted recently,
>>>> following comments on the list:
>>>>
>>>> disable automatic sync after git-p4 submit:
>>>>     https://marc.info/?l=git&m=152818734814838&w=2
>>>>
>>>> better handling of being logged out by Perforce:
>>>>    https://marc.info/?l=git&m=152818893815326&w=2
>>>>
>>>> adapt the block size automatically on git-p4 submit:
>>>>    https://marc.info/?l=git&m=152819004315688&w=2
>>>>
>>>> - Spelling corrections (Eric)
>>>> - Improved comments (Eric)
>>>> - Exception class hierarchy fix (Merland)
>>>> - test simplification (Eric)
>>>>
>>>
>>> That reminds me of one thing.
>>>
>>> This 6-patch series depends on the rm/p4-submit-with-commit-option
>>> that came without and still waiting for a sign-off by the original
>>> author.  Also I do not think the original patch reached the public
>>> list, so I'm attaching the patch to make sure people know which
>>> patch I am talking about.
>>>
>>> Romain, can we get your sign-off on the patch you sent earlier?
>>
>> Wasn't it already sent in this message:
>>
>> https://marc.info/?l=git&m=152783923418317&w=2
>>
>> Luke
>
>
> Thanks for a pointer.  Will replace and requeue.

Thanks. While on the subject of git-p4, I thought I should mention
that I've been looking at getting git-p4 to work with Python3.

I've got some low risk easy (mostly automated) changes which get it to
the point where it compiles. After that I have to figure out how to
fix the byte-vs-string unicode problem that Python3 brings. Having
been playing around with it, I think it should be possible to make the
same git-p4.py script work with 2.7, 3.6 and probably 2.6, although
I'm still some way from making this last bit work.

Luke
